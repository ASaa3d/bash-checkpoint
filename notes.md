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

