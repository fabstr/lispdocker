FROM ubuntu:14.04

RUN apt-get update && apt-get install -y sbcl emacs24
RUN adduser --home /home/lisp --uid 1000 --disabled-password lisp

# setup quicklisp and install slime
ADD http://beta.quicklisp.org/quicklisp.lisp /quicklisp.lisp
ADD files/sbclrc /home/lisp/.sbclrc
ADD files/setupemacs.lisp /setupemacs.lisp
ADD files/script.sh /script.sh
ADD https://raw.githubusercontent.com/oneKelvinSmith/monokai-emacs/master/monokai-theme.el \
	    /home/lisp/.emacs.d/themes/monokai-theme.el
RUN chown -R lisp:lisp /home/lisp/.emacs.d /quicklisp.lisp 
RUN chmod +x /script.sh

USER lisp
RUN /script.sh -s
RUN mkdir -p /home/lisp/.emacs.d/themes
RUN /script.sh -p auto-complete
RUN /script.sh -p evil

# add this latest, smaller set of changes to update
ADD files/emacs /home/lisp/.emacs.d/init
