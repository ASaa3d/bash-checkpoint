#!/bin/bash

changes=$(git diff --staged | head -c 8000)
if [[ -z $changes ]];then
	(echo "no changes detected">&2)
	exit 1
fi

commit_msg=$("$changes" |  "/ollama/run" "You are a git commit message generator. Given a diff, output ONLY a commit message, noth
ing else — no preamble, no markdown, no explanation.

Format:
- First line: conventional commit format (feat:/fix:/refactor:/docs:/chore:/test:), imperative mood, max 50 chars.
- Optional body: blank line, then up to 3 short bullet points on what changed.
- Base it only on what's in the diff.")

git commit -m "$commit_msg"
git push bs_learn main
