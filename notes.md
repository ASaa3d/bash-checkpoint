# Bash Notes

My raw learning notes, cleaned up. They are kept in the order I learned them and grouped by topic. For the polished, topic-by-topic version with scripts, see the [README](README.md).

## Contents

1. [Files and aliases](#1-files-and-aliases)
2. [grep and viewing files](#2-grep-and-viewing-files)
3. [Builtins vs external commands](#3-builtins-vs-external-commands)
4. [Quoting, system info and variables](#4-quoting-system-info-and-variables)
5. [Script basics, tests and output](#5-script-basics-tests-and-output)
6. [case statements](#6-case-statements)
7. [Arrays](#7-arrays)
8. [Command substitution and arithmetic](#8-command-substitution-and-arithmetic)
9. [Process substitution, shift and for loops](#9-process-substitution-shift-and-for-loops)
10. [Text-processing tools](#10-text-processing-tools)
11. [Debugging and pipelines](#11-debugging-and-pipelines)
12. [Sourcing and functions](#12-sourcing-and-functions)
13. [Parameter expansion](#13-parameter-expansion)
14. [printf and brace expansion](#14-printf-and-brace-expansion)
15. [Regex, mapfile and quoting](#15-regex-mapfile-and-quoting)
16. [Signals, jobs and pipes](#16-signals-jobs-and-pipes)
17. [Terminal and interactive tricks](#17-terminal-and-interactive-tricks)

> **Fish vs Bash:** I use Fish interactively, so some notes mention where it differs.

---

## 1. Files and aliases

**1. `mv` overwrites.** If `file3` and `file4` exist and I run `mv file4 file3`, the original `file3` is deleted and `file4` is renamed to `file3`.

**2. Wildcards.** With `file1`, `file2` and `file3`, `rm file*` deletes all of them.

**3. Interactive delete.** `rm -i file*` asks about each file. Answer `y` (yes) or `n` (no).

**4. Aliases.** `alias rm='rm -i'` makes `rm` interactive by default.
- Inspect an alias: `alias rm` in Bash, `type rm` in Fish.
- Save it permanently in Fish: `alias --save rm='rm -i'` (writes to the Fish config).

---

## 2. grep and viewing files

**5. Context lines.** Show lines around a match (`c` stands for *context*):

```bash
grep -A1 pattern file    # 1 line After the match
grep -B1 pattern file    # 1 line Before the match
grep -C1 pattern file    # 1 line before and after
```

**6. Case-insensitive search:** `grep -i`.

**7. Only the matching part:** `grep -o` prints just the matched text, not the whole line.

**8. Chain greps with pipes** to filter step by step. My practice run, in order:

```bash
cat gsch.txt | grep 'd'
cat gsch.txt | grep -i d
cat gsch.txt | grep -i d | grep 'e$'
cat gsch.txt | grep -i d | grep '^D.e$'
cat gsch.txt | grep -i d | grep '^D..e$'
cat gsch.txt | grep -i d | grep '^D.*e$'
cat gsch.txt | grep -i d | grep '^D*e$'
cat gsch.txt | grep -i d | grep '^D.*$'
cat gsch.txt | grep -o d | grep '^D.*$'
cat gsch.txt | grep -o d | grep '^d'
cat gsch.txt | grep -io d | grep '^d'
cat gsch.txt | grep -io d | grep '^D'
```

**9. Paging.** Use `less` or `more`: `less file` or `cat file | less`.

---

## 3. Builtins vs external commands

**10. Builtins use `help`, not `man`.** Functions built into the shell (like `history`) are not external programs, so:
- use `help history`, not `man history`
- `which history` finds nothing, because `which` only searches for external programs (`type history` works)
- special case: `echo` exists in **two versions**, a Bash builtin and an external program (`type -a echo` shows both)

**11. List all builtins:** `compgen -b` in Bash, `builtin -n` in Fish.

**12. `tr` translates characters.** Example: show each `$PATH` entry on its own line:

```bash
❯ echo $PATH | tr ':' '\n'
/usr/local/sbin
/usr/local/bin
/usr/bin
/usr/bin/site_perl
/usr/bin/vendor_perl
/usr/bin/core_perl
```

**13. Variable vs command.** Some things exist as both a variable and a command:
- `pwd` is equivalent to `echo $PWD`
- `whoami` is equivalent to `echo $USER`

---

## 4. Quoting, system info and variables

**14. Quote your variables.** In Bash, with `var1="h     w"`:

```bash
echo $var1      # h w            (word splitting collapses the spaces)
echo "$var1"    # h     w        (spacing preserved: best practice)
```

In Fish (and some other shells), `echo $var1` and `echo "$var1"` behave the same.

**15. System info commands:**

| Command | What it shows |
|---|---|
| `whoami` | current user |
| `uname` | system name |
| `uname -a` | system name, device (host) name, kernel/OS version |
| `upower -e` | lists power devices (`BAT0` or `BAT1` is the battery) |
| `upower -i /path/to/BAT` | battery details; I use it to check battery health when buying a used laptop |

**16. Store command output in a variable:**

```bash
var2=$(upower -e)           # Bash
set var1 (upower -e)        # Fish
```

---

## 5. Script basics, tests and output

**17. Syntax check:** `bash -n file` checks syntax without running the script.

**18. Exit status:** `$?` holds the return code of the last command (`$status` in Fish).

**19. Empty / non-empty tests:**

```bash
[ -z "$1" ]    # true if the argument is empty
[ -n "$1" ]    # true if it is non-empty
```

**20. Piping into a script.** `echo dave | ./greet.sh` works only if the script reads stdin with `read`. It does **not** fill positional arguments like `$1`.

**21. `yes`** prints `y` on new lines in an infinite loop.

**22. `$@`** holds all the arguments given to the script (use `"$@"` to keep each one intact).

**23. `local`.** Inside functions, declare variables with `local` so they stay scoped to the function and don't override globals.

**24. Nicer tools:** `bat` instead of `cat` (syntax-highlighted preview) and `micro` instead of `nano`.

**25. Functions can return** a status code with `return`.

**26. File test:** `-f` checks that a regular file exists.

**27. Math mode `(( ))`** gives C-style syntax, for example in loops:

```bash
for ((i=0; i<max; i++)); do
    echo "$i"
done
```

**28. `echo -n`** doesn't add a newline after the output.

**29. `xxd`** shows raw hex bytes: `echo hello | xxd`.

**30. stdout vs stderr:**

```bash
echo text        # stdout
echo err >&2     # stderr
```

---

## 6. case statements

**31. Multiple patterns** are OR-ed with `|`:

```bash
case $i in
    cond1 | cond2) command ;;
esac
# similar to: [[ $i == cond1 || $i == cond2 ]]
```

**32. Terminators:**

| Terminator | Behavior |
|---|---|
| `;;` | stop, like `break` |
| `;;&` | even after a match, keep checking the other branches |
| `;&` | the odd one: no break, runs the next branch **without checking its pattern**. Can shrink code, but not best practice |

---

## 7. Arrays

**33. Access elements:** `${arr[0]}` is the first element, `${arr[-1]}` the last.

**34. Loop with quotes and `@`** (best practice): `for x in "${arr[@]}"`

**35. Stringify:** `"${arr[*]}"` joins all elements into one string.

**36. Copy an array** by creating a new array from the old elements:

```bash
new_arr=("${arr[@]}")
```

**37. Append** with `+=`:

```bash
new_arr+=("new element")
```

**38. Sparse arrays** are supported:

```bash
sp_arr=([0]="asd" [1]="adf" [77]="dad")
```

**39. `declare -a`.** Use `declare -a array=(...)` instead of plain `array=(...)`. You can also declare with no value: `declare -a array`.

**40. Inspect an array:** `declare -p arr`.

**41. Sizes:**

```bash
"${#arr[@]}"    # number of elements
"${#arr[2]}"    # length of the third element
```

**42. Associative arrays (dictionaries)** are relatively new in Bash and may not work on older systems. Wrap the declaration in an `if` and check its exit code.

**43. `declare -A`** is required to create an associative array.

**44. Keys, not values.** Use `!` to get the keys: `"${!arr[@]}"`.

**45. IFS** (Internal Field Separator) is the separator used when stringifying arrays with `"${arr[*]}"`. Change it, then reset with `unset`:

```bash
arr=(e1 e2 e3)
IFS=,
echo "${arr[*]}"    # e1,e2,e3
unset IFS           # back to the default
```

---

## 8. Command substitution and arithmetic

**46. Command substitution** with `$(command)`, and it can be nested:

```bash
echo $(whoami)
echo $(echo $(whoami))
echo $(echo $(echo $(whoami)))
```

**47. It runs in a subshell** (a separate environment). To use variables from the main script, pass them in or avoid command substitution.

**48. Newer syntax (Bash 5.3, 2025):** a command substitution that runs in the **current shell**, not a subshell:

```bash
res=${ my_func; }
```

**49. `(( ))` does all kinds of math** and treats any non-number as `0`.

**50. See all supported math operators:** `help let`.

**51. Zero means failure.** Inside `(( ))`, a result of `0` is considered false, so the command returns exit code `1`. Example: `(( 2-2 ))`.

**52. `set -e` gotcha.** With `set -e` (exit after any command returns an error), things like `(( 2-2 ))`, or `i=0` followed by `(( i++ ))` (post-increment returns the old value, `0`), will make the script exit.

**53. Leading zeros mean octal.** `i=08` in arithmetic causes an error.

---

## 9. Process substitution, shift and for loops

**54. Process substitution** `<(command)` is useful because it streams the data and lets you process it, instead of saving everything to a file or memory first. It presents the command's output like a file:

```bash
while read -r word; do ...; done < <(grep f file.txt)
```

**55. `shift`** drops the first argument so you can handle the rest. Example for `prg.sh fun1 foo bar baz`:

```bash
cmd=$1
shift
args=("$@")
```

**56. `for` without `in`.** If you don't specify what to loop over, `for` loops over the script's arguments.

---

## 10. Text-processing tools

**57. `tr` and `cut`** are great for quickly viewing edited content: `tr old new` replaces characters, `cut -d delimiter -f field` picks fields.

```bash
❯ echo $PATH | cut -d : -f 1
/usr/local/sbin
❯ echo $PATH | cut -d : -f -1        # same: field 1
/usr/local/sbin
❯ echo $PATH | cut -d : -f 2
/usr/local/bin
❯ echo $PATH | cut -d : -f 3
/usr/bin
❯ echo $PATH | cut -d : -f 5
/usr/bin/vendor_perl
❯ echo $PATH | cut -d : -f -5        # fields 1 to 5
/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl
```

**58. `tr` vs `sed`.** `tr` replaces characters; `sed` replaces whole strings.

```bash
❯ cat /etc/passwd | cut -d : -f 1,5,7 | grep sa3d
sa3d:Ahmed Saad:/bin/bash
❯ cat /etc/passwd | cut -d : -f 1,5,7 | grep sa3d | sed 's/sa3d/SAAD/'
SAAD:Ahmed Saad:/bin/bash
```

- Multiple rules: `sed -e '...' -e '...'` (`-e` = expression).
- The separator can be any character, not just `/`: `sed -e 's#sa3d#saad#'`.

**59. `awk`** works differently. `-F` sets the delimiter of the input; then comes `condition { action }`, with a C-like `printf`:

```bash
</etc/passwd awk -F: '$1 == "sa3d" { printf("%s - %s\n", $1, $7) }'
```

It combines well with `sort` and `uniq`:

```bash
</etc/passwd awk -F: '{ printf("%s - %s\n", $1, $7) }' | sort | uniq -c
```

**60. `wc` (word count)** counts lines, words and characters.

```bash
man ls | grep line | wc -l
```

(Opens the manual page of `ls`, keeps lines containing the word "line", and counts them.)

**61. `find`** searches for files with `-type` and `-name` (patterns like `'*.txt'`), and `-exec` runs a command on each result, where `{}` is the file name:

```bash
find . -type f -name '*.txt' -exec echo "I found {}" ';'
```

---

## 11. Debugging and pipelines

**62. Trace mode.** `bash -x` prints every command as it runs, line by line. To debug only a chunk:

```bash
set -x
# code to debug
set +x
```

`PS4` is the prefix printed before each traced line (default `+`). It can be anything:

```bash
PS4="$(date) " bash -x if_else.sh          # date evaluated once
PS4='$(date) ' bash -x if_else.sh          # single quotes: evaluated for every line
```

**63. `set -u`** (or `bash -u`) errors on undefined variables.

**64. `shellcheck`** is a more advanced external tool for linting scripts. More professional.

**65. Pipeline return codes.** In `cmd1 | cmd2 | cmd3`, `$?` is the return code of the **last** command (`cmd3`). To get the codes of **all** of them, use the `PIPESTATUS` array:

```bash
echo "${PIPESTATUS[*]}"
```

**66. `time`** shows how long it took to run the command written right after it.

---

## 12. Sourcing and functions

**67. Importing functions from another file:** `source path/to/file` or `. path/to/file`. The dot form is the POSIX one and can behave differently in other shells; `source` is the most common in Bash.

**68. Handle a missing file** by using `source` in an `if`, or by OR-ing it with `exit`:

```bash
source lib/file || exit 1
```

**69. `source -p`** searches a directory path for the file:

```bash
source -p ./lib lib1.sh
```

**70. Sourced code runs in the sourcing script.** Top-level calls inside a sourced file are executed by any file that sources it.

**71. Detect whether I'm being sourced:**

```bash
if ! (return 2>/dev/null); then
    # running directly, not sourced
fi
```

`return` only succeeds in a function or sourced file. If it works (result `0`), we are sourced; negating it with `!` gives "not sourced".

**72. Subshell vs current shell for functions:**

```bash
f() { ...; }        # runs in the current shell
f() ( ... )         # parentheses: runs in a separate subshell
( f )               # calling in parentheses: separate subshell
{ f; }              # group call: current shell
```

**73. Groups support pipelines:** `{ cmd1 | cmd2 | cmd3; }`. One benefit of `{ ...; }` is that you can pipe the output of the whole group.

**74. Return codes** are 8-bit integers, limited to 0-255.

**75. Redirect stderr to stdout** (e.g. to capture error messages):

```bash
my_cmd=$(greet 2>&1)
```

**76. Spaces matter** in Bash syntax.

---

## 13. Parameter expansion

**77. Uppercase:**

| Syntax | Effect |
|---|---|
| `"${var^}"` | capitalize the first letter |
| `"${var^^}"` | capitalize all letters |
| `"${var^d}"` | capitalize the first character only if it is `d` |
| `"${var^^d}"` | capitalize every `d` |
| `"${var^^[da]}"` | capitalize every `d` and `a` |

**78. Lowercase:** `"${var,}"` and `"${var,,}"` work like `^` and `^^` but lowercase.

**79. Default value:** `${1:-DEF}` is the first parameter, or `DEF` if it is not given.

**80. Required parameter:**

```bash
${1?err-msg}     # errors if not given, but accepts an empty string
${1:?err-msg}    # errors if not given OR empty
```

**81. Replace without `tr` or `sed`:**

```bash
${str/old/new}     # replace the first match
${str//old/new}    # replace all matches
```

`new` can use `&` for the matched text, e.g. `_&_` gives `_old_`.

**82. Substrings:**

```bash
${str:0:5}      # start position 0, 5 characters
${str:(-5)}     # last 5 characters
```

This works for arrays too.

**83. Length:** `${#str}`.

**84. Transformations with `@`:**

```bash
"${str@U}"    # uppercase
"${str@Q}"    # quoted
```

---

## 14. printf and brace expansion

**85. Print array elements line by line:**

```bash
printf "%s\n" "${arr[@]}"
```

**86. Brace expansion:**

```bash
arr=(etc/{foo,bar}.sh)    # same as (etc/foo.sh etc/bar.sh)
```

**87. Generate many files with braces:**

```bash
touch {foo,bar}.{sh,jpg,txt}
```

**88. Numeric and character ranges:**

```bash
{1..4}   {a..e}   {1..100..5}   {10..5}
seq 1 5 100        # external command: seq FIRST STEP LAST
```

**89. `printf` format string.** `printf "$s"` works if you're sure `s` is a plain string, but the best practice is the C way, telling `printf` to format `s` as a string:

```bash
printf '%s' "$s"
```

**90. `printf -v`** (Bash-specific) saves the result into a variable instead of printing:

```bash
printf -v var "hello %s" sa3d    # var="hello sa3d"
```

**91. Built-in date formatting.** This replaces the external `date +'%Y/%m/%d %H:%M:%S'`:

```bash
printf "date is %(%Y/%m/%d %H:%M:%S)T\n"
```

**92. Time argument.** `-1` means the current time (the default), `-2` means the time the shell session started:

```bash
printf "date is %(%Y/%m/%d %H:%M:%S)T\n" -1
```

---

## 15. Regex, mapfile and quoting

**93. `BASH_REMATCH`** is the array of regex matches after `[[ $str =~ $regex ]]`.

**94. `mapfile`** reads a file line by line into an array. `-t` trims the trailing newline from each element (`line\n` becomes `line`).

**95. `mapfile` callbacks:**

```bash
mapfile -C callback_func -c 1 var < file
# -c = how many lines are read between callback calls
```

**96. `mapfile` and `readarray`** are synonyms. They are the same command.

**97. Quotes:** `"double"` expands variables, `'single'` does not.

---

## 16. Signals, jobs and pipes

**98. `trap`:**

```bash
trap func SIGNAL
```

You can trap any signal from `trap -l`, plus `DEBUG` and `EXIT`.

**99. Job control:**
- `Ctrl+Z` stops the foreground process and puts it in the background (stopped)
- `jobs` lists them
- `bg %N` continues job number `N` in the background
- `fg %N` brings it to the foreground
- `kill %N` kills it

**100. Named pipes:** `mkfifo path` creates a pipe file that any number of processes can write to or read from.

**101. `$!`** holds the PID of the last background process.

---

## 17. Terminal and interactive tricks

**102. Colors with `tput`:**

```bash
tput bold; tput setaf 1; echo hi; tput sgr0    # sgr0 resets the formatting
```

**103. Is the output a terminal?** Check whether output goes to a terminal and not to a log file or another program. In Bash: `[[ -t 1 ]]`.

**104. History:** `history` shows the indexed list of past commands. Run one again with `!idx`. `set +H` turns this feature off.

**105. Interactive or not:** if the `PS1` variable is set, the shell is **interactive**. In a normal script it is not set:

```bash
if [[ -n $PS1 ]]; then echo "interactive"; fi
```

**106. Bypass aliases** with a backslash. If `alias ls='ls --color=always --group-directories-first'`, then `\ls` runs the plain `ls`.

**107. Remove a function:** `unset -f func_name`.
