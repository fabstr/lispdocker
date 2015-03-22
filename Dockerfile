FROM ubuntu:14.04

RUN apt-get update && apt-get install -y sbcl emacs24
RUN adduser --home /home/lisp --disabled-password lisp

ADD files/quicklisp.lisp /quicklisp.lisp
ADD files/start.sh /start.sh
RUN chmod +x /start.sh

USER lisp

RUN sbcl --load "/quicklisp.lisp" \
	 --eval "(quicklisp-quickstart:install)"
RUN sbcl --load "/home/lisp/quicklisp/setup.lisp" \
	 --eval '(ql:quickload "quicklisp-slime-helper")'

ADD files/dotfiles/sbclrc /home/lisp/.sbclrc
ADD files/dotfiles/emacs /home/lisp/.emacs
