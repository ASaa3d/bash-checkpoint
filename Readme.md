# Bash Scripting Fundamentals

My personal Bash checkpoint: everything I've learned from a course and several crash courses, plus the practice scripts I wrote along the way.

This repo has two jobs:

1. **A revision sheet.** When I forget a rule, I come back here and find it with a short explanation and a working script.
2. **A proof of skill.** Every topic below has hands-on code, not just notes.

> **Environment:** Linux, Bash 5.x. Some features need a recent Bash (flagged with ⚠️ where it matters). I mostly use Bash as my interactive shell.

---

## Table of Contents

- [Repo Structure](#repo-structure)
- [How to Run the Scripts](#how-to-run-the-scripts)
- [Scripts Index](#scripts-index)
- [Topics and Notes](#topics-and-notes)
  1. [Shell basics and commands](#1-shell-basics-and-commands)
  2. [Variables, quoting and IFS](#2-variables-quoting-and-ifs)
  3. [Input, output and redirection](#3-input-output-and-redirection)
  4. [Conditionals](#4-conditionals)
  5. [Loops](#5-loops)
  6. [Functions and sourcing](#6-functions-and-sourcing)
  7. [Arrays](#7-arrays)
  8. [Expansions](#8-expansions)
  9. [Text-processing tools](#9-text-processing-tools)
  10. [Debugging and safety](#10-debugging-and-safety)
  11. [Processes, signals and pipes](#11-processes-signals-and-pipes)
  12. [Terminal and interactive tricks](#12-terminal-and-interactive-tricks)
- [Common Pitfalls](#common-pitfalls)
- [Quick Reference Cheat Sheet](#quick-reference-cheat-sheet)
- [Resources](#resources)

---

## Repo Structure

```text
.
├── README.md        # this file
├── notes.md         # my raw notes
├── lib/
│   └── greetings.sh # reusable functions, meant to be sourced
├── scripts/         # one script per concept (see index below)
├── hidden_files/    # hidden-file practice
└── other/           # miscellaneous files
```

---

## How to Run the Scripts

Run everything **from the repo root**, because some scripts use relative paths (`./lib`, `input.txt`).

```bash
chmod +x scripts/*.sh          # make all scripts executable (once)
./scripts/case_stmt.sh apple   # run directly
bash scripts/arrays.sh         # or through bash explicitly
bash -n scripts/arrays.sh      # syntax check only, nothing runs
```

Scripts that need arguments or extra files:

| Script | Needs |
|---|---|
| `file_exists.sh` | a path as `$1` |
| `get_shell.sh` | a username as `$1` (reads `/etc/passwd`) |
| `case_stmt.sh` | a word as `$1` (`apple`, `fruit`, `fried`, anything else) |
| `char_by_char.sh` | a string as `$1` |
| `say_hi.sh` | optional lib version folder as `$1` |
| `init.sh` | a script name as `$1` (uses the `micro` editor) |
| `loops.sh` | an `input.txt` file in the working directory |
| `ps_sub.sh` | a `gsch.txt` file in the working directory |
| `pipe_chat.sh` | nothing; creates a `./pipe` FIFO, stop it with `Ctrl+C` |
| `git_commit.sh` | `ollama` with the `qwen2.5-coder:7b` model, `systemd`, `sudo`, and a staged change |

---

## Scripts Index

| Script | Topic | What it shows |
|---|---|---|
| [`lib/greetings.sh`](lib/greetings.sh) | Functions, libraries | `greet` and `goodbye` functions, stderr vs stdout, "am I being sourced?" guard |
| [`scripts/arrays.sh`](scripts/arrays.sh) | Arrays | Indexed arrays, copying, appending, sparse arrays, `declare -p` |
| [`scripts/arth_expr.sh`](scripts/arth_expr.sh) | Arithmetic | `$(( ))`, `(( ))`, compound assignment (`<<=`) |
| [`scripts/associative_arrs.sh`](scripts/associative_arrs.sh) | Associative arrays | `declare -A`, iterating keys with `${!arr[@]}`, feature check |
| [`scripts/case_stmt.sh`](scripts/case_stmt.sh) | Conditionals | `case` with patterns and a default `*)` branch |
| [`scripts/char_by_char.sh`](scripts/char_by_char.sh) | Strings, loops | `${1:?msg}`, `${#var}`, `${var:i:1}`, C-style `for` |
| [`scripts/comm_sub.sh`](scripts/comm_sub.sh) | Command substitution | `$(...)` and nesting |
| [`scripts/curly_br_exp.sh`](scripts/curly_br_exp.sh) | Brace expansion | Combining several `{a,b}` groups into a path list |
| [`scripts/file_exists.sh`](scripts/file_exists.sh) | Conditionals | `[[ -n $1 && -f $1 ]]` |
| [`scripts/first.sh`](scripts/first.sh) | Input | `read` a path, then `ls` it |
| [`scripts/for_loop.sh`](scripts/for_loop.sh) | Loops | Range `{1..5}`, word list, `"$@"` |
| [`scripts/get_shell.sh`](scripts/get_shell.sh) | Parsing, assoc arrays | `while IFS=: read -r ...` over `/etc/passwd` |
| [`scripts/git_commit.sh`](scripts/git_commit.sh) | Real-world project | Local-LLM commit message generator: `sed` cleanup, `ollama`, validation with fallback, `git commit` and `push` |
| [`scripts/greeter.sh`](scripts/greeter.sh) | Functions | `local` variables, looping over `"$@"` |
| [`scripts/greet.sh`](scripts/greet.sh) | Basics | Greeting from an argument or a prompt |
| [`scripts/if_else.sh`](scripts/if_else.sh) | Conditionals | `read -p`, `if / elif / else`, `while` with a command list as the condition |
| [`scripts/init.sh`](scripts/init.sh) | Utility | Scaffolds a new script (shebang plus `chmod +x`), countdown function with `\033[0K\r` |
| [`scripts/input.sh`](scripts/input.sh) | Input | Reading input |
| [`scripts/loops.sh`](scripts/loops.sh) | Loops, input | `while read ... done < input.txt` |
| [`scripts/outfile.sh`](scripts/outfile.sh) | Redirection | Appending to a file with `>>` |
| [`scripts/param_exp.sh`](scripts/param_exp.sh) | Parameter expansion | Required argument with `${1:?msg}` |
| [`scripts/pipe_chat.sh`](scripts/pipe_chat.sh) | Processes, IPC | `mkfifo`, background jobs, `$!`, `trap` cleanup |
| [`scripts/ps_sub.sh`](scripts/ps_sub.sh) | Process substitution | `done < <(grep ...)` so the loop runs in the current shell |
| [`scripts/regex_bash.sh`](scripts/regex_bash.sh) | Regex | `[[ $s =~ $re ]]` and `BASH_REMATCH` |
| [`scripts/say_hi.sh`](scripts/say_hi.sh) | Sourcing | `source -p` to load a library, `|| exit 66` on failure |
| [`scripts/trap_sig.sh`](scripts/trap_sig.sh) | Traps, debugging | `trap ... EXIT` and `trap ... DEBUG`, `$BASH_COMMAND`, `printf %(...)T` |
| [`scripts/while_loop.sh`](scripts/while_loop.sh) | Loops | `while [ ... ]` with `((i+=1))` |

---

## Topics and Notes

### 1. Shell basics and commands

**Script header and syntax check**

```bash
#!/bin/bash          # shebang: which interpreter runs this file
```

- `bash -n file.sh` checks syntax without running the script.
- **Spaces matter** in Bash: `[ -z "$x" ]`, `a=1` (no spaces around `=`), and so on.
- `$?` holds the return code of the last command (`$status` in Fish).
- Return codes are 8-bit integers, **0 to 255**. `0` means success.

**Builtin vs external commands**

- Builtins live inside the shell (`history`, `cd`, `echo` has both versions). Get help for them with `help <cmd>`, not `man`. `which history` finds nothing because it isn't an external program.
- `compgen -b` lists all Bash builtins (`builtin -n` in Fish).
- `echo` and `rm`-style commands can exist as both builtin and external versions.
- Some values can be a **variable** or a **command**: `pwd` is `echo $PWD`, `whoami` is `echo $USER`.

**File commands I practiced**

- `mv file4 file3` when `file3` already exists **deletes the old `file3`** and renames `file4`.
- `rm file*` deletes all matches. `rm -i file*` asks `y/n` for each one.
- `alias rm='rm -i'` makes that permanent for the session. `alias rm` inspects it (`type rm` in Fish). In Fish, `alias --save rm='rm -i'` writes it to the config.
- `\rm` or `\ls` bypasses an alias for one call.
- `less file` or `cat file | less` for paging.
- Nicer replacements: `bat` instead of `cat`, `micro` instead of `nano`.
- `yes` prints `y` forever (useful for auto-answering prompts).
- `time <cmd>` measures how long the command takes.

**System info commands**

```bash
whoami          # current user
uname           # system name
uname -a        # system name, hostname, kernel/OS info
upower -e       # list power devices (BAT0 / BAT1 is the battery)
upower -i /org/freedesktop/UPower/devices/battery_BAT0   # battery details (I use it to check battery health on used laptops)
```

---

### 2. Variables, quoting and IFS

```bash
name="sa3d"
res=$(upower -e)           # capture command output in a variable (Fish: set res (upower -e))
echo "$name"
```

- `"double quotes"` expand variables, `'single quotes'` do not.
- **Always quote variables.** With `var="h     w"`, `echo $var` prints `h w` (word splitting collapses the spaces), while `echo "$var"` keeps the spacing. In Fish both behave the same, but in Bash quoting is the best practice.
- Inside functions, use **`local`** so variables don't overwrite globals.
- `$@` holds all arguments as separate words. `"$@"` is the safe way to loop over them.
- `$!` is the PID of the last background process.
- `IFS` (Internal Field Separator) controls how `"${arr[*]}"` joins elements and how `read` splits input:

```bash
arr=(e1 e2 e3)
IFS=,
echo "${arr[*]}"    # e1,e2,e3
unset IFS           # back to the default
```

---

### 3. Input, output and redirection

**echo**

- `echo -n` skips the trailing newline.
- `echo -e` interprets escapes like `\n`.
- `echo hello | xxd` shows the raw hex bytes.

**printf (preferred for formatting)**

```bash
printf '%s\n' "$s"                     # safe: tell printf the argument is a string
printf '%s\n' "${arr[@]}"              # one array element per line
printf -v var "hello %s" sa3d          # Bash-only: store result in $var instead of printing
printf "date is %(%Y/%m/%d %H:%M:%S)T\n" -1    # built-in date formatting (-1 = now, -2 = shell start time)
```

**Reading input**

```bash
read usr_path                      # read a line into a variable
read -p "what's your name: " name  # with a prompt
echo dave | ./greet.sh             # piped input works with read, NOT with $1
while read -r line; do ... done < input.txt     # read a file line by line
```

**Redirection and streams**

```bash
echo "normal output"            # stdout (fd 1)
echo "error message" >&2        # send to stderr (fd 2)
echo "text" >> out.txt          # append
my_cmd=$(greet 2>&1)            # capture stderr together with stdout
```

- `mkfifo` creates a named pipe (see [section 11](#11-processes-signals-and-pipes)).

---

### 4. Conditionals

**Test flags**

| Test | Meaning |
|---|---|
| `-z "$x"` | string is empty |
| `-n "$x"` | string is non-empty |
| `-f path` | regular file exists |
| `-p path` | named pipe (FIFO) exists |

```bash
if [[ -n $1 && -f $1 ]]; then
    echo "$1 exists"
else
    echo "file does not exist"
fi
```

For numbers, `[ $n -gt 0 ]` works. `if / elif / else` chains are used as usual (`if_else.sh`).

**case statements**

```bash
case $usr_in in
    "apple" | "fruit") echo "healthy" ;;     # | acts like OR
    "fried")           echo "not healthy" ;;
    *)                 echo "unknown" ;;     # default
esac
```

| Terminator | Behavior |
|---|---|
| `;;` | stop (like `break`) |
| `;;&` | keep testing the following patterns even after a match |
| `;&` | fall through and run the next branch **without testing** (shortens code, but not best practice) |

**Regex matching**

```bash
regex="^(.*) - ([0-9]{4}-[0-9]{2}-[0-9]{2})\..*$"
if [[ $file =~ $regex ]]; then
    name=${BASH_REMATCH[1]}     # first capture group
    date=${BASH_REMATCH[2]}     # second capture group
fi
```

`BASH_REMATCH` is the array of regex matches. Index 0 is the whole match. Keep the regex in a variable to avoid quoting problems.

---

### 5. Loops

```bash
for i in {1..5}; do echo "$i"; done          # range
for thing in foo bar asd; do echo "$thing"; done
for arg in "$@"; do echo "$arg"; done        # loop over arguments
for arg; do echo "$arg"; done                # no "in ..." means loop over the arguments

for (( i=0; i<max; i++ )); do echo "$i"; done   # C-style (math mode)

while [ $i -lt 10 ]; do ((i+=1)); echo "$i"; done

while read -r line; do echo "$line"; done < file     # read a file line by line
```

- A `while` condition can be a **list of commands**. The last command's exit status decides whether it loops (`if_else.sh`: `read` returns failure on EOF, which ends the loop).
- `shift` drops `$1` and moves the others down. Useful for subcommand-style scripts: `cmd=$1; shift; args=("$@")`.
- Parsing `/etc/passwd` (`get_shell.sh`):

```bash
declare -A shells
while IFS=: read -r name enc_passwd uid gid usr_name usr_dir shell; do
    [[ $name == '#'* ]] && continue
    shells[$name]=$shell
done < /etc/passwd
```

---

### 6. Functions and sourcing

**Functions**

```bash
greet() {
    local name=$1            # local keeps it out of the global scope
    echo "Hello $name !!"
}
```

- Functions can `return` a number (0 to 255). To return actual data, `echo` it and capture with `$(...)`.
- Function body brackets decide the execution context:

| Form | Runs in |
|---|---|
| `f() { ...; }` and `{ f; }` | the **current shell** (and `{ cmd1 \| cmd2; }` lets you pipe a whole group) |
| `f() ( ... )` and `( f )` | a **subshell** (variable changes don't leak out) |

**Sourcing libraries** (`lib/greetings.sh` and `say_hi.sh`)

```bash
source lib/greetings.sh || exit 66      # check that sourcing worked
. lib/greetings.sh                      # POSIX synonym; `source` is the common Bash spelling
source -p "./lib/v2" greetings.sh       # ⚠️ search a given directory for the file (needs a recent Bash)
```

- Code at the top level of a sourced file runs in the sourcing script, so use a guard to run demo code only when the file is executed directly:

```bash
if ! (return 2>/dev/null); then
    # we are NOT being sourced, so run the demo
    greet admin
fi
```

  `return` only works inside a function or a sourced file, so if it succeeds we are being sourced.
- `unset -f func_name` removes a function.

---

### 7. Arrays

**Indexed arrays** (`arrays.sh`)

```bash
arr=(foo bar baz 'hello my friend!!')
declare -a arr2                       # declare without values
sparse=([0]="asd" [1]="adf" [77]="dad")   # sparse arrays are allowed

echo "${arr[0]}"       # first element
echo "${arr[-1]}"      # last element
echo "${#arr[@]}"      # number of elements
echo "${#arr[2]}"      # length of the 3rd element
echo "${arr[*]}"       # all elements as ONE string (joined with the first char of IFS)

for item in "${arr[@]}"; do echo "$item"; done     # best practice: quotes + @

new_arr=("${arr[@]}")           # copy
new_arr+=("new element")        # append
declare -p new_arr              # inspect the array
```

**Associative arrays** (`associative_arrs.sh`)

```bash
declare -A arr                  # required for associative arrays
arr[foo]=1; arr[bar]=2

for key in "${!arr[@]}"; do     # ! gives KEYS, not values
    echo "($key -> ${arr[$key]})"
done
```

Associative arrays are newer in Bash and may be missing on very old systems. Guard against that:

```bash
if ! declare -A arr; then echo "associative arrays not supported"; fi
```

---

### 8. Expansions

**Command substitution**: `$(cmd)` runs `cmd` and substitutes its output. It nests freely.

```bash
echo $(echo $(echo $(whoami)))
```

- It runs in a **subshell**, so it sees a copy of the environment and can't change your variables.
- ⚠️ Newer Bash (5.3+) adds a form that runs **in the current shell**: `res=${ my_func; }`.

**Process substitution**: `<(cmd)` presents a command's output as a file. It streams the data instead of saving it to a temp file or memory first, and (unlike a pipe) keeps the loop in the current shell:

```bash
i=0
while read -r word; do echo "$word"; ((i++)); done < <(grep f ./gsch.txt)
echo "found $i matches"       # works; with `grep | while` the counter would be lost
```

**Arithmetic**

```bash
res=$(( 57*2 ))      # arithmetic expansion: gives a value
(( res2 = 57*2 ))    # arithmetic command: does the work, returns a status
(( i <<= 5 ))        # compound assignments work
```

- Non-numeric words inside `(( ))` are treated as `0`.
- `help let` lists every supported operator.
- A result of `0` makes `(( ))` **return 1 (failure)**, e.g. `(( 2-2 ))`.
- Leading zeros mean **octal**: `i=08` is an error in arithmetic.

**Parameter expansion**

| Syntax | Result |
|---|---|
| `${var:-DEF}` | use `DEF` if unset or empty |
| `${var?msg}` | error with `msg` if **unset** (empty is accepted) |
| `${var:?msg}` | error with `msg` if unset **or empty** |
| `${#var}` | length |
| `${var:0:5}` | substring: start 0, 5 chars (works for arrays too) |
| `${var:(-5)}` | last 5 characters |
| `${var/old/new}` | replace the first match |
| `${var//old/new}` | replace all matches (`&` in `new` stands for the match, e.g. `_&_`) |
| `${var^}` / `${var^^}` | uppercase first letter / all letters |
| `${var^d}` / `${var^^d}` | uppercase only a first character that is `d` / every `d` |
| `${var^^[da]}` | uppercase every `d` and `a` |
| `${var,}` / `${var,,}` | lowercase equivalents |
| `${var@U}` | uppercase (transformation) |
| `${var@Q}` | quoted form |

Parameter expansion can replace many uses of `tr` and `sed` without launching an external program.

**Brace expansion**

```bash
arr=(etc/{foo,bar}.sh)            # etc/foo.sh etc/bar.sh
touch {foo,bar}.{sh,jpg,txt}      # create 6 files at once
echo {1..4} {a..e} {1..100..5} {10..5}     # numeric/char ranges, with step, descending
seq 1 5 100                       # external equivalent: FIRST STEP LAST
filenames=(/etc/{foo,bar,baz}/{1,2,3}/.{txt,mov,sh})   # combinations multiply
```

**mapfile / readarray** (synonyms) read a file straight into an array:

```bash
mapfile -t lines < file.txt            # -t strips the trailing newline from each element
mapfile -C callback -c 1 lines < file  # call `callback` every N lines read
```

---

### 9. Text-processing tools

```bash
# grep
grep -i pattern file          # case-insensitive
grep -o pattern file          # print only the matching part
grep -A1 pattern file         # 1 line After the match
grep -B1 pattern file         # 1 line Before
grep -C1 pattern file         # Context: before and after
cat gsch.txt | grep -i d | grep '^D.*e$'     # chain greps to filter step by step

# tr: translate/replace single characters
echo $PATH | tr ':' '\n'      # one PATH entry per line

# cut: pick fields
echo $PATH | cut -d : -f 1    # 1st field
echo $PATH | cut -d : -f -5   # fields 1 to 5
cut -d : -f 1,5,7 /etc/passwd # fields 1, 5 and 7

# sed: replace whole strings (any delimiter works)
sed 's/sa3d/SAAD/'
sed -e 's#sa3d#saad#' -e 's/x/y/'    # -e = one expression each, chain as many as needed

# awk: field-based processing with C-like printf
awk -F: '$1 == "sa3d" { printf("%s - %s\n", $1, $7) }' /etc/passwd
awk -F: '{ printf("%s - %s\n", $1, $7) }' /etc/passwd | sort | uniq -c

# wc: count lines / words / characters
man ls | grep line | wc -l

# find
find . -type f -name '*.txt' -exec echo "found {}" ';'    # {} = the found file name
```

- `tr` swaps **characters**, `sed` rewrites **strings or patterns**.
- Quick way to see invisible bytes: `echo hello | xxd`.

---

### 10. Debugging and safety

| Tool | Purpose |
|---|---|
| `bash -n file` | syntax check only |
| `bash -x file` | trace every command as it runs |
| `set -x` ... `set +x` | trace only a section of the script |
| `PS4="$(date) " bash -x file` | customize the trace prefix (default `+`) |
| `set -u` | error on **undefined variables** |
| `set -e` | exit when a command fails |
| `shellcheck file` | static analysis; more professional linting |
| `$?` | exit code of the last command |
| `${PIPESTATUS[*]}` | exit codes of **every** command in the last pipeline |

- In `cmd1 | cmd2 | cmd3`, `$?` is only the status of `cmd3`. Use `PIPESTATUS` for all of them.
- **`set -e` trap:** `(( 2-2 ))`, `(( i++ ))` when `i=0`, or `i=0` in `(( ))` evaluate to 0, which counts as failure, so the script exits.

---

### 11. Processes, signals and pipes

**Traps** (`trap_sig.sh`)

```bash
cleanup()  { echo "cleaning up"; exit 2; }
debugger() { printf "%(%H:%M)T [DEBUG]: %s\n" -1 "$BASH_COMMAND"; }

trap cleanup EXIT        # runs when the script exits
trap debugger DEBUG      # runs before every command
trap cleanup SIGINT SIGTERM
```

`trap -l` lists the available signals. You can trap any of them plus `EXIT` and `DEBUG`.

**Job control**

- `Ctrl+Z` stops the foreground job.
- `jobs` lists jobs. `bg %1` resumes job 1 in the background. `fg %1` brings it to the foreground. `kill %1` kills it.
- `cmd &` starts in the background. `$!` is its PID.

**Named pipes** (`pipe_chat.sh`)

```bash
[[ -p ./pipe ]] || mkfifo ./pipe        # create a pipe file if missing

client() { while true; do echo "Hi from $1 at $(date +%H:%M:%S)" > ./pipe; sleep 2; done; }
client "sa3d" & client_pids+=($!)       # several writers in the background
...
while read -r line; do echo "$line"; done < ./pipe     # one reader prints everything

trap 'kill "${client_pids[@]}"; rm -f ./pipe' EXIT     # clean up background jobs and the pipe
```

Any number of processes can write to or read from a FIFO.

**Piping into scripts**: `echo dave | ./greet.sh` only works if the script uses `read` (stdin). It does not fill `$1`.

---

### 12. Terminal and interactive tricks

- **Colors with `tput`:** `tput bold; tput setaf 1; echo hi; tput sgr0` (`sgr0` resets).
- **Is the output a terminal?** Use `[[ -t 1 ]]` (true when stdout is a terminal, false when redirected to a file or pipe).
- **Is the shell interactive?** `[[ -n $PS1 ]]` is true in an interactive shell and false inside a script.
- **History:** `history` lists numbered commands, `!123` re-runs command 123, `set +H` turns history expansion off.
- **Escape sequences:** `echo -ne "text\033[0K\r"` clears to end of line and returns the cursor, which is how the countdown in `init.sh` overwrites itself.

---

## Common Pitfalls

- Forgetting quotes: `echo $var` collapses whitespace and splits words. Use `"$var"`.
- Spaces around `=` in assignments, or missing spaces inside `[ ]` and `[[ ]]`.
- `set -e` plus `(( i++ ))` when `i` is 0 exits the script.
- Numbers with a leading zero (`08`) are read as octal.
- `cmd | while read ...` runs the loop in a subshell, so variables set inside are lost. Use `done < <(cmd)` instead.
- `$?` after a pipeline only reflects the last command. Use `PIPESTATUS`.
- Command substitution runs in a subshell and can't change your variables.
- Associative arrays need `declare -A`, and may not exist on old Bash versions.
- Piped stdin does not populate `$1`.
- `mv a b` silently overwrites `b`.

---

## Quick Reference Cheat Sheet

```bash
# Safety header for serious scripts
set -u            # undefined variables are errors
# set -e          # exit on error (mind the (( )) gotcha)

# Arguments
$1 $2 ...         # positional args
"$@"              # all args, each as its own word
$#                # number of args
${1:-default}     # default value
${1:?usage}       # required argument

# Tests
[[ -z $x ]]  [[ -n $x ]]  [[ -f $f ]]  [[ -p $p ]]  [[ $s =~ $re ]]

# Output
echo -n "no newline"      echo "err" >&2      cmd 2>&1
printf '%s\n' "$x"        printf -v var '%s' "$x"

# Arrays
arr=(a b c)  "${arr[@]}"  "${#arr[@]}"  arr+=(d)  "${!assoc[@]}"

# Expansions
$(cmd)   <(cmd)   $(( 1+2 ))   {1..5}   {a,b}.txt   ${var//a/b}

# Debug
bash -n f   bash -x f   shellcheck f   echo "${PIPESTATUS[*]}"
```

---

## Resources

What I learned from:

- [ysap.sh](https://ysap.sh/): the course I took
- [Bash Scripting Tutorial for Beginners (freeCodeCamp)](https://www.freecodecamp.org/news/bash-scripting-tutorial-linux-shell-script-and-command-line-for-beginners/)
- [Bash crash course playlist (YouTube)](https://www.youtube.com/playlist?list=PL-my9REMIFtGgiQAXqKPJ5UrLdSkxcLBT)
- [ANSI escape sequences cheat sheet (GitHub gist)](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797): for terminal colors and cursor control
- [Bash Pitfalls (Wooledge wiki)](https://mywiki.wooledge.org/BashPitfalls): common mistakes and how to avoid them
