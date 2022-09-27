FROM ruby:2.7
RUN apt-get install -y libmagickwand-dev imagemagick
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN bundle install
EXPOSE 4000
CMD bundle exec jekyll serve --host=0.0.0.0