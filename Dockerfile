FROM ubuntu:14.04

RUN apt-get update && apt-get install -y sbcl emacs24
RUN adduser --home /home/lisp --uid 1000 --disabled-password lisp

# setup quicklis and install slime
ADD files/quicklisp.lisp /quicklisp.lisp
ADD files/setup.sh /setup.sh
ADD files/dotfiles/sbclrc /home/lisp/.sbclrc
RUN chmod +x /setup.sh
RUN su - lisp -c /setup.sh

ADD files/start.sh /start.sh
RUN chmod +x /start.sh

ADD files/setupemacs.lisp /setupemacs.lisp
RUN mkdir -p /home/lisp/.emacs.d/themes

ADD files/monokai-theme.el /home/lisp/.emacs.d/themes/monokai-theme.el
RUN chown -R lisp:lisp /home/lisp/.emacs.d

USER lisp

RUN emacs -batch --eval "(defconst pkg-to-install 'auto-complete)" -l /setupemacs.lisp
RUN emacs -batch --eval "(defconst pkg-to-install 'evil)" -l /setupemacs.lisp

ADD files/dotfiles/emacs /home/lisp/.emacs.d/init
USER root
RUN chown lisp:lisp /home/lisp/.emacs.d/init
USER lisp
