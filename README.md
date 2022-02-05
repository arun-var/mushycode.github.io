
This blog is has been modified from [this repository](https://github.com/dirkfabisch/mediator)
Getting Started
---
- [Clone this repository](https://github.com/mushycode/mushycode.github.io.git)
- Run `docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -p 4000:4000 -w /usr/src/myapp ruby:2.7 bash`
- Install the requried gems ([GitHub Pages](https://github.com/github/pages-gem), [Bourbon](https://github.com/thoughtbot/bourbon) and [Jekyll](https://github.com/jekyll/jekyll), [Jemoji](https://github.com/jekyll/jemoji)): `bundle install`
- Run the jekyll server: `bundle exec jekyll serve --host=0.0.0.0`
- Access the blog on your browser at `http://localhost:4000`

