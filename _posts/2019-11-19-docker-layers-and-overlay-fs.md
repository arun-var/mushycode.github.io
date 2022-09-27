---
layout: post
title: "Understanding docker layers and overlay filesystem"
date:  2019-11-19 12:47:46
categories: docker
tags: docker docker-layers overlay
image: /assets/article_images/2019-11-19-docker-layers-and-overlay-fs/docker1.jpg
description: Docker layers explained - A docker image consists of layers. Each layer is an instruction in the Dockerfile. A container is an image with a writable(or readable) layer or top of other read only layers. This is where an overlayfs comes in to picture.
---

## What are docker layers and overlay filesystems
A docker image consists of layers. Each layer is an instruction in the Dockerfile. A container is an image with a writable(or readable) layer or top of other read only layers. This is where an overlayfs comes in to picture.
This was one of the things that I wanted to understand better - What exactly is an overlay file system and how is docker using it.
From archlinux wiki definition
"Overlayfs allows one, usually read-write, directory tree to be overlaid onto another, read-only directory tree. All modifications go to the upper, writable layer."

An apt example is a linux live CD. 

Lets get down to how this overlay file system works

### Overlays and docker

It consists of three layers for the sake of simplicity.

- Lower Read Only Layer
- Upper Layer that allows read and write
- The Overlay layer itself that gives the user entire view of the filesystem and from where user actually reads a file or writes to them. 

#### Lower Layer
The read only layer where base files of the filesystem are stored. It can be visualized as the base image of our docker image or root of a live CD example.

#### Upper Layer
Any changes made in the overlay layer gets stored in the upper layer. Whenever a process reads a file from the overlay layer, it is checked in upper layer first, if not available it is read from the lower layer.

#### Overlay
This is the consolidated or union view of lower and upper layers and where the user works on. Whenever any changes are made to a file, overlay layer presents the union of upper and lower layers such that files in upper layer supersede the ones in lower layer.

When objects with the same name exist in both directory trees of upper and lower layers, then their treatment depends on the object type:

File: We see the file in the upper layer, and the file in the lower layer is hidden.

Directory: content of both upper and lower layers of the directory tree is combined and shown in the overlay


#### Copy-on-Write
Whenever a file already present in lower layer is modified, the file is first copied over to the upper layer and then the modifications are made here.

#### Overlay in action

Lets create directories 
{% highlight sh %}
root@dd4a4d50aefc:~# mkdir lower upper merged workdir
root@dd4a4d50aefc:~# echo "I am in lower layer" > lower/lower.txt
root@dd4a4d50aefc:~# echo "I am in upper layer" > upper/upper.txt
root@dd4a4d50aefc:~# echo "I am common file lower layer" > lower/common.txt
root@dd4a4d50aefc:~# echo "I am common file upper layer" > upper/common.txt
root@dd4a4d50aefc:~# sudo mount -t overlay overlay -o lowerdir=/root/lower,upperdir=/root/upper,workdir=/root/workdir /root/merged
root@dd4a4d50aefc:~# ls merged/
common.txt  lower.txt  upper.txt
root@dd4a4d50aefc:~# cat merged/common.txt 
I am common file upper layer
root@dd4a4d50aefc:~# ls lower/
common.txt  lower.txt
root@dd4a4d50aefc:~# ls upper/
common.txt  upper.txt
{% endhighlight %}

The lower layer can be read-only and an overlay itself, while the upper layer is normally writeable. In order to create an overlay of two directories, dir1 and dir2, we can use the following mount command:

{% highlight sh %}
root@dd4a4d50aefc:~# sudo mount -t overlay overlay -o lowerdir=/root/lower2:/root/lower1,upperdir=/root/upper,workdir=/root/workdir /root/merged
{% endhighlight %}

while specifying multiple lower layers, they are separated by a :, with the rightmost lower directory on the bottom, and the leftmost lower directory on the top of the overlay.

#### New file creation in overlay

{% highlight sh %}
root@dd4a4d50aefc:~# echo "I am the new file on the block" > merged/new.txt
root@dd4a4d50aefc:~# ls merged/
common.txt  lower.txt  new.txt  upper.txt
root@dd4a4d50aefc:~# ls upper/
common.txt  new.txt  upper.txt
root@dd4a4d50aefc:~# ls lower/
common.txt  lower.txt
{% endhighlight %}

References 
- https://docs.docker.com/storage/storagedriver/#images-and-layers
- https://wiki.archlinux.org/index.php/Overlay_filesystem
- https://www.kernel.org/doc/Documentation/filesystems/overlayfs.txt 
