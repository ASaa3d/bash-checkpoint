#!/bin/bash

ollama_run(){
	local usr_command="${1:?'No input given'}"
	local model="qwen2.5-coder:7b"
	sudo systemctl start ollama
	while (sudo systemctl is-failed ollama 1>/dev/null 2>/dev/null);do
		sleep 1
	done
	local prompt_cmd="ollama run $model $usr_command"
	local response=$($prompt_cmd)
	sudo systemctl stop ollama
	sudo systemctl stop ollama.service
	echo "$response" >&1
}

changes="$(git diff --staged | head -c 8000)"
if [[ -z $changes ]];then
	echo "no changes detected"
	exit 1
fi
prompt="You are a git commit message generator. Given a diff, output ONLY a commit message, nothing else — no preamble, no markdown, no explanation. Format: First line must be conventional commit format (feat:/fix:/refactor:/docs:/chore:/test:), imperative mood, max 50 chars. Optionally follow with a blank line then up to 3 short bullet points on what changed. Base it only on what's in the diff."

commit_msg=$(echo "$changes" | ollama_run "$prompt")

git commit -m "$commit_msg"
git push bs_learn main
