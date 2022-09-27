---
layout: post
title: "How to write safe shell scripts"
date:  2019-11-13 15:52:57
categories: script bash
tags: script bash best-practices
image: /assets/article_images/2019-11-13-write-safe-shell-scripts/terminal.jpg
description: Bash script best practices - How to write safe shell scripts
---
## Good Practices in bash scripts


### Shebang (#!)

It is called a shebang or a "bang" line. It is nothing but the absolute path to the Bash interpreter. It consists of a number sign and an exclamation point character (#!), followed by the full path to the interpreter such as /bin/bash. All scripts under Linux execute using the interpreter specified on a first line.
This ensures that the correct interpreter will be used to interpret the script, even if it is executed under another shell.

### set -e

this will make the shell script exit as soon as any line in the bash script fails.
for example, a shell file like below will execute every line
{% gist 501d903a4db01b5bcbf4e59e7ecae7c2 %}

{% highlight bash %}
arun@home:~$ ./set_e_without.sh 
true
true
false
true
{% endhighlight %}

After adding set -e, it will stop executing after the line that fails, in this case the one that returns false.
{% gist 9d841d3cc79224faf16f8fc602799372 %}

{% highlight bash %}
arun@home:~$ ./with_set_e.sh 
true
true
{% endhighlight %}

### Ignore failure in scripts
if we don't want the script to fail after certain failing statements, we can append these certain statements with || true.

{% gist 1531d5db9b2bd6f0b3aa98c7d73cd044 %}

{% highlight bash %}
arun@home:~$ ./with_set_e_and_ignore_fail.sh           
true
true
failing foo was ignored
true
{% endhighlight %}

### set -x

this will make the shell print each line before execution. Combining this with previous set statement and same example, it will look like
{% gist a9c92e43f02fd4c65514bb63fb05dce4 %}

{% highlight bash %}
arun@home:~$ ./with_set_x.sh           
++ true
++ echo true
true
++ true
++ echo true
true
++ false
{% endhighlight %}

### set -u

The following example has variable *b* which is not set. The run of the script will be successful.
{% gist a9b2414088f39537cbd6e168e9e716f6 %}
{% highlight bash %}
arun@home:~$ ./without_set_u.sh 
++ a=0
++ echo 0
0
++ echo 0
0
++ echo

++ echo 0
0
{% endhighlight %}

But adding *-u* to the same script will force bash to treat unset variables as an error and exit immediately.
{% gist ca24e436660a986cbd58d9b22f113ce2 %}

{% highlight bash %}
arun@home:~$ ./with_set_u.sh 
++ a=0
++ echo 0
0
++ echo 0
0
./with_set_u.sh: line 5: b: unbound variable
{% endhighlight %}

### set -o pipefail

bash usually looks at the exit code of the last command in a pipeline. This can cause a problem for -e option as it will only consider the leftmost command's exit code in a pipeline.
This particular option sets the exit code of pipeline commands to that of the rightmost command to exit with a non-zero status or 0 if all exit successfully.

{% gist 5df45b0e6c32925c6ffd927c77b16900 %}

{% highlight bash %}
arun@home:~$ ./without_pipefail.sh 
./test.sh: line 3: a: unbound variable
++ echo 'pipe chain failed'
pipe chain failed
++ echo 'but I execute'
but I execute
{% endhighlight %}

{% gist c3016ad398b86686d737f042298aac80 %}
{% highlight bash %}
arun@home:~$ ./with_pipefail.sh 
./test.sh: line 3: a: unbound variable
++ echo 'pipe chain failed'
pipe chain failed

arun@home:~$ echo $?
1
{% endhighlight %}

the echo $? is a special variable in bash that shows the exit code of last run command.




