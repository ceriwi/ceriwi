FROM jekyll/jekyll:3.8

CMD jekyll serve --watch --drafts
EXPOSE 4000
