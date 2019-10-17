---
layout: post
title:  "How to remove file in linux using regex"
date:   2019-07-20 06:20:00 +0700
categories: [linux, remove, delete, files, rm, regex]
---

####  Deleting older files with names usually having date as prefix/suffix

Generally compressed log files created by utilities contain a date in the filename.
For cleaning such accumulated compressed files we can use `rm` command with regex.

```
$ ls

2013-12-23-nginx.tar.gz                2016-04-29-nginx.tar.gz
2013-12-24-nginx.tar.gz                2016-05-21-nginx.tar.gz
2016-04-19-nginx.tar.gz                2016-05-22-nginx.tar.gz
2016-04-20-nginx.tar.gz                2016-05-23-nginx.tar.gz
2016-04-21-nginx.tar.gz                2016-05-24-nginx.tar.gz
2016-04-22-nginx.tar.gz                2016-05-25-nginx.tar.gz
2016-04-23-nginx.tar.gz                2016-06-11-nginx.tar.gz
2016-04-24-nginx.tar.gz                2016-06-12-nginx.tar.gz
2016-04-25-nginx.tar.gz                2016-06-13-nginx.tar.gz
2016-04-26-nginx.tar.gz                2016-12-24-nginx.tar.gz
2016-04-27-nginx.tar.gz                2019-07-20-nginx.tar.gz
2016-04-28-nginx.tar.gz
```


```$ rm 201[3-6]*```
