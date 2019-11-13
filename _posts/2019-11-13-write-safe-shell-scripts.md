---
layout: post
title: "How to write safe shell scripts"
date:  2019-11-13 15:52:57
categories: shell
---

#### Shebang (#!)

It is called a shebang or a "bang" line. It is nothing but the absolute path to the Bash interpreter. It consists of a number sign and an exclamation point character (#!), followed by the full path to the interpreter such as /bin/bash. All scripts under Linux execute using the interpreter specified on a first line.
This ensures that Bash will be used to interpret the script, even if it is executed under another shell.

#### set -e

this will make the shell script exit as soon as any line in the bash script fails.
for example, a shell file like below will execute every line
```
arun@home:~$ cat test.sh 
true
echo "true"
true
echo "true"
false
echo "false"
true
echo "true"

arun@home:~$ ./test.sh 
true
true
false
true
```
After adding set -e, it will stop executing after the line that fails, in this case the one that returns false.
```
arun@home:~$ cat test.sh 
set -e
true
echo "true"
true
echo "true"
false
echo "false"
true
echo "true"
arun@home:~$ ./test.sh 
true
true
```
if we don't want the script to fail after certain failing statements, we can append these certain statements with || true.
```
arun@home:~$ cat test.sh           
set -e
true
echo "true"
true
echo "true"
false || true
echo "false was ignored"
true
echo "true"
arun@home:~$ ./test.sh           
true
true
false was ignored
true
```

#### set -x

this will make the shell print each line before execution. Combining this with previous set statement and same example, it will look like
```
arun@home:~$ cat test.sh           
set -xe
true
echo "true"
true
echo "true"
false
echo "false"
true
echo "true"
arun@home:~$ ./test.sh           
++ true
++ echo true
true
++ true
++ echo true
true
++ false
```

#### set -u

this option will force bash to treat unset variables as an error and exit immediately.
```
arun@home:~$ cat test.sh 
set -xe
a=0
echo $a
echo $a
echo $b
echo $a
arun@home:~$ ./test.sh 
++ a=0
++ echo 0
0
++ echo 0
0
++ echo

++ echo 0
0

arun@home:~$ cat test.sh
set -xeu
a=0
echo $a
echo $a
echo $b
echo $a
arun@home:~$ ./test.sh 
++ a=0
++ echo 0
0
++ echo 0
0
./test.sh: line 5: b: unbound variable
```

#### set -o pipefail

bash usually looks at the exit code of the last command in a pipeline. This can cause a problem for -e option as it will only consider the leftmost command's exit code in a pipeline.
This particular option sets the exit code of pipeline commands to that of the rightmost command to exit with a non-zero status or 0 if all exit successfully.
```
arun@home:~$ cat test.sh 
set -xeu
echo $a || echo "pipe chain failed"
echo "but I execute"
arun@home:~$ ./test.sh 
./test.sh: line 3: a: unbound variable
++ echo 'pipe chain failed'
pipe chain failed
++ echo 'but I execute'
but I execute

arun@home:~$ cat test.sh           
set -xeuo pipefail
echo $a || echo "pipe chain failed"
echo "but I execute"
arun@home:~$ echo $?
0
arunvarghese@kreatio:~$ ./test.sh 
./test.sh: line 3: a: unbound variable
++ echo 'pipe chain failed'
pipe chain failed
arun@home:~$ echo $?
1
```
the echo $? is a special variable in bash that shows the exit code of last run command.




