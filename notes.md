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
30-  'echo err >$2' -> stderr , echo text -> stdout
