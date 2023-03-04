---
layout: post
title: Podman and Colima as docker desktop alternatives for enterprise users
description: "Alternatives for Docker Desktop Enterprise Users Pros and Cons of Podman and Colima"
categories: docker docker-desktop mac
tags: docker docker-desktop mac colima podman
---
# Docker Desktop Alternatives for Enterprise Users

Docker has changed its [Service Agreement](https://www.docker.com/pricing/) and requires a paid subscription for Docker Desktop. It is a popular tool used by many developers to manage containers on their Mac. However, some users may want to explore alternatives to Docker Desktop / Docker for various reasons, such as performance issues or the desire for daemonless docker. Two possible alternatives to Docker Desktop on a Mac are [Podman](https://podman.io/) and [Colima](https://github.com/abiosoft/colima). In this blog, I just wanted to quickly document my experience on try out these two alternatives as well as the pros and cons of each.

## Replacing Docker Desktop with Podman on Mac

Podman is a container management tool that allows users to manage containers without requiring a daemon to be running in the background. It is an open-source project developed by Red Hat and provides a CLI that is compatible with Docker.

Install Podman: Podman can be installed on a Mac using Homebrew. Open a terminal window and enter the following commands:

{% highlight sh %}

brew install podman

brew install podman-completion

{% endhighlight %}

This will install Podman and its completion script.

Start using Podman: Once Podman is installed, you can start using it to manage your containers. To run a container, use the podman run command. For example, to run a simple hello-world container, enter the following command in the terminal:

{% highlight sh %}

podman run hello-world

{% endhighlight %}

## Pros and Cons of Podman

### Pros:

- Podman does not require a daemon to be running in the background, which can improve performance and security.
- Podman provides a Docker-compatible CLI, making it easy to switch from Docker to Podman.
- Podman supports rootless containers, which allows non-root users to run containers.

### Cons:

- Podman is not as widely used as Docker, so finding support or tutorials may be more difficult.
- Podman does not currently support Docker Compose, although this may change in the future.

Note: I had issues with volume mounting in podman, but looks like passing the mount to podman machine during its creation fixes it.
For ex,

{% highlight sh %}

podman machine init --disk-size 20 -v \$HOME:$HOME

podman machine start

{% endhighlight %}

## Replacing Docker Desktop with Colima on Mac

Colima is a Docker and Kubernetes development environment for Mac. It is built on top of macOS Hypervisor framework and provides a lightweight, native experience for managing containers.

To replace Docker Desktop with Colima on a Mac, follow these steps:

Install Colima: Colima can be downloaded from the official website. Once downloaded, open the DMG file and drag the Colima app to the Applications folder.

Start using Colima: Once Colima is installed, open the app and follow the setup instructions. You can then start using Colima to manage your containers.

## Pros and Cons of Colima

### Pros:

- Colima provides a lightweight, native experience for managing containers on a Mac.
- Colima supports Docker Compose and Kubernetes, making it a versatile tool for container management.
- Colima provides a web-based interface for managing containers, which can be more user-friendly than a CLI.

### Cons:

- Colima is a relatively new tool and may have bugs or compatibility issues.
C- olima is not as widely used as Docker, so finding support or tutorials may be more difficult.

## Conclusion
Replacing Docker Desktop with Podman or Colima on a Mac is relatively easy, and both tools offer certain pros and cons. Podman is a lightweight tool that provides a Docker-compatible CLI, while Colima provides a native, web-based interface for managing containers. Ultimately, the choice of which tool to use depends on the user.