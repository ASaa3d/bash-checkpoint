1- if you have file3 and file4 and you wrote mv file4 file3 -> originla file3 is deleted and file4 name is changed to file3
2- if you have file1,file2 and file3 you can use rm file* to delete all
3- to make it ask interactively to delete each file use -i > rm -i file* -> answer is y(yes) or n(no
)
4- alias rm='rm -i' , can be inspected using alias rm for bash , type rm for fish 
also you can use alias -save rm='rm -i' to save in fish config file
