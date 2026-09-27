1- if you have file3 and file4 and you wrote mv file4 file3 -> originla file3 is deleted and file4 name is changed to file3
2- if you have file1,file2 and file3 you can use rm file* to delete all
3- to make it ask interactively to delete each file use -i > rm -i file* -> answer is y(yes) or n(no
)
4- alias rm='rm -i' , can be inspected using alias rm for bash , type rm for fish 
also you can use alias -save rm='rm -i' to save in fish config file
5- use line after or before with grep to show search result linme with n lines after grep -A1 case_stmt.sh , grep -B1 case_stmt.sh or both usimg -C1 c stands for context
6- grep -i for case insenestive searching -> grep -i
7- pattern search using -o and only the matched part will be shown 
 8- use grep with chained pipline (|) for step by step filtering
2026-09-25 20:37:48 cat gsch.txt | grep -io d | grep  '^D'
2026-09-25 20:37:44 cat gsch.txt | grep -io d | grep  '^d'
2026-09-25 20:37:41 cat gsch.txt | grep -o d | grep  '^d'
2026-09-25 20:37:37 cat gsch.txt | grep -o d | grep  '^D.*$'
2026-09-25 20:37:28 cat gsch.txt | grep -i d | grep  '^D.*$'
2026-09-25 20:37:22 cat gsch.txt | grep -i d | grep  '^D*e$'
2026-09-25 20:37:19 cat gsch.txt | grep -i d | grep  '^D.*e$'
2026-09-25 20:37:14 cat gsch.txt | grep -i d | grep  '^D..e$'
2026-09-25 20:37:06 cat gsch.txt | grep -i d | grep  '^D.e$'
2026-09-25 20:36:46 cat gsch.txt | grep -i d | grep  'e$'
2026-09-25 20:36:42 cat gsch.txt | grep -i d | grea  'e$'
2026-09-25 20:36:22 cat gsch.txt | grep -i d
2026-09-25 20:35:52 cat gsch.txt | grep 'd'

9- using less and more eithert like less file or cat file | less
10- for buiuld in to bash functions like history we use 'help' not 'man' becuase its built to shell not external command so which history returns nothing but which history doesnt work
s speciall case is echo ehich has 2 versions echi bash builin and external echo and rm is the same 

11- access builtins in bash using compgen -b and using builtin -n ion fishg shell 
12 - use translate (tr) to find and replkace a text in string like 
❯ echo $PATH | tr ' ' '\n'
/usr/local/sbin
/usr/local/bin
/usr/bin
/usr/bin/site_perl
/usr/bin/vendor_perl
/usr/bin/core_perl
13- pwd = echo $PWD , whoami = echo $USER -> examples of variables vs external commands
14- in bash shell if you have var1="h     w" if you echo $var1 it will be "h w" if yoou need the spacing you shopuld use echo "$var1" which is the best practice , however in other shells like fish echo $var1 = echo "$var1"

15- system info commands : whomai -> user , uname -> sys name , uname -a -> sys name , device name and os version , upwer -e -> show you power supply hw in your system (BAT0 or BAt1) is your battery which you can check status using upower -i path/to/BAT -> used personally to check for battery health buyih a dos used laptop

16- var2=$(upower -e) assign a cvommand output to a var in bash , use set var1 $(upower -e) for fish shell

17- bash syntax check using the bash -n file
18- $? is return code of bash script but its $status in fish shell

19- use -z flag to check if an argument is empty -> [ -z $1 ] , -n to check its non empty 

20- pipeline to pipe dave in greet.sh -> echo dave | ./greet.sh if greet uses a read arg inside but it doesnt work for input arguments like $1 and so on.
21- yes commmand to spam y in new lines infintte loop
22- $@ -> array of all given args
23- in functions use local keyword to keep the variables local scoped to the function and dont override global ones 
24 bat is better than cat previewing files in modern highlighted format , same for micro instead of nano
25- functins support te return argumnent
26- -f flag tocheck if a file exists
27- use (()) for math mode like c style for loops
for ((i=0;i<max;i++));do
	echo "$i"
done

28- use 'echo -n' tp not add a new line after each echo 
29- use echo hello | xxd to see hex characters of hello 
30- 'echo err >$2' -> stderr , echo text -> stdout  
31- in case statents you can use cond1 | cond2 ) command;; to oring to equality similar to [[ $i == cond1 || $i == cond2  ]]
32- in case stmts ;; === break but ;;& === break so even it matched one branch it checks other branches, the unlogical one is the ;& which is no break and implement the below branches without checking may be useful for shrinking the code but not ther best practice 
33- access first element in array ${arr[0]} , lase element index in -1
34- best practice to loop over an array use quotes and @ sign -> "${arr[@]}"
35-"${arr[*]}" used to stringify the array elements

36- copy array = mkaing a new empty array and add the old ones items to it
new_arr=("${arr[@]}")
37- also += for appending to arr
new_arr+=("new element")
38- bash supports sparse arrays so you can declare -> sp_arr=([0]="asd" [1]="adf" [77]="dad")
39- you can use declare -a array = instead of array =  , also you can declare with no value -> declare -a array.
40- you can also inxpect an indexed array using decalre -p arr in bash
41- to get number of elements in an array "${#arr[@]}", to get length of third element "${#arr[2]}"
42- associative arrays (dicts) is relatively new to bash so it can sometimes not work on older systems so you can wrap it in an if condition and check declaration exit code.
43- declare -A is necessary to decalre associative arrrays
44- use ! to acces keys not vvlaues in associative arrays "S{!arr[@]}".
45- IFS== internal foeld seperator the default seperator used for seperator stringified arrays -> "${arr[*]}",
but you can change it to smth like IFS=, and now if arr=(e1 e2 e3) then "${arr[*]}"=e1,e2,e3 then you can easilt unset it so it returns to the default using unset IFS.
you can use $(command) for command substitutiion and nest commnads as you want like:
-echo $(whoami)
-echo $(echo $(whoami))
-echo $(echo $(echo $(whoami)))
46- command substituatin runs in a subshell using new diff env than what are you are so if you want to use global vars you either pass them or dont use comm sub
47- in a 2025 bash update a new comm sub is introduced which use your main shell not a sub one its syntax is as follows -> res=${ my_func() } 
48- '((' in arith expresiion do all sort of math but treat any non-number as 0 
49- you can see all math supported in bash using help let
50- in mth expr 0 inside double parantheseis is conddered False or a failure that actually return a code of 1 like (( 2-2 ))
51- using set -e so that bash exits after an error code returned and having smth like (( 2-2 )) or i=0 , (( i++ )) which is a post increment result in script exiting
52- bash deals with leading zero integers as octals so trying to eval  i=08 in a math expression will lead to an error
53 - processs ubstitutu=ion is cool cuz it allows straming input and perform the logic rather than saving it into memory , using <(path/to/file) can make this file input 
54- using shift arg to shift input args so you can deal with other args without the first one like prg.sh fun1 foo bar baz , saving cmd=$1 then shift then args=("S@")
55- in for loop if yu dont specify what to loop on the program gonna loop on the input args
56- on the fly contents eciting view tools like tr old_char new_char and cut -d dlimeter -f field number or desc is super useful 
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f 1
/usr/local/sbin
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f -1
/usr/local/sbin
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f 2
/usr/local/bin
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f 3
/usr/bin
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f 5
/usr/bin/vendor_perl
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f -5
/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl
/mnt/data/main/BS ❯ echo $PATH | cut -d : -f 1
/usr/local/sbin
/mnt/data/main/BS ❯ 


