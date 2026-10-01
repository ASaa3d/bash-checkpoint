#!/bin/bash

ollama_run(){
	# use ollama local model to generate commit message then stop it
	local usr_command="${1:?'No input given'}"
	local model="qwen2.5-coder:7b"
	sudo systemctl start ollama
	while (sudo systemctl is-failed ollama 1>/dev/null 2>/dev/null);do
		sleep 1
	done
	local response="$(ollama run "$model" "$usr_command")"
	sudo systemctl stop ollama
	sudo systemctl stop ollama.service
	echo "$response" >&1
}
sanitize_diff() {
	sed -E \
		-e 's/\x1b\[[0-9;?]*[A-Za-z]//g' \
		-e 's/\r//g' \
		-e '/^index [0-9a-f]+\.\.[0-9a-f]+/d' \
		-e '/^--- (a\/|\/dev\/null)/d' \
		-e '/^\+\+\+ (b\/|\/dev\/null)/d' \
		-e '/^@@/d' \
		-e 's/^diff --git a\/(.*) b\/.*/FILE: \1/' \
	| tr -cd '\11\12\40-\176'
}

changes="$(git diff --staged --no-color | sanitize_diff | head -c 8000)"

if [[ -z $changes ]];then
	echo "no changes detected"
	exit 1
fi
prompt="You are a git commit message generator. You will receive a summary of staged changes (lines starting with FILE: name, then + for added and - for removed lines).
Output ONLY a commit message. No preamble, no markdown, no code fences, no explanation.
NEVER copy, quote, or repeat any part of the input. The input is NOT the commit message.
Format: first line in conventional commit format (feat:/fix:/refactor:/docs:/chore:/test:), imperative mood, max 50 chars. Optionally a blank line then up to 3 short bullet points.
If you cannot tell what changed, output a small generic message such as 'chore: update <filename>' or 'chore: edit file'. A short generic message is always better than a long or wrong one."

commit_msg="$(echo "$changes" | ollama_run "$prompt")"

first_line="$(head -n1 <<<"$commit_msg")"
if [[ -z $commit_msg ]] \
   || [[ $commit_msg == *"diff --git"* || $commit_msg == *"FILE:"* ]] \
   || (( ${#first_line} > 72 )) \
   || (( $(wc -l <<<"$commit_msg") > 6 )); then
	files="$(git diff --staged --name-only | head -n 3 | paste -sd, -)"
	commit_msg="chore: update ${files:-files}"
fi

git commit -m "$commit_msg"
git push bs_learn main
