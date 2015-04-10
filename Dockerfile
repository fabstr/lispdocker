FROM ubuntu:14.04

RUN apt-get update && apt-get install -y sbcl emacs24
RUN adduser --home /home/lisp --uid 1000 --disabled-password lisp

# download quicklisp and monokai,
ADD http://beta.quicklisp.org/quicklisp.lisp /quicklisp.lisp
ADD https://raw.githubusercontent.com/oneKelvinSmith/monokai-emacs/master/monokai-theme.el \
	    /home/lisp/.emacs.d/themes/monokai-theme.el

# install sbclrc (which points sbcl to quicklisp)
ADD files/sbclrc /home/lisp/.sbclrc

# installplugin.el is used to install a plugin
ADD files/installplugin.el /installplugin.el

# script.sh does all the magic
ADD files/script.sh /script.sh

# set some permissions
RUN chown -R lisp:lisp /home/lisp/.emacs.d /quicklisp.lisp 
RUN chmod +x /script.sh

USER lisp

# setup quicklisp and slime
RUN /script.sh -s

# install auto-complete
RUN /script.sh -p auto-complete

# install evil
RUN /script.sh -p evil

# emacs init file is last, we should be able to make changes without rebuilding
# everything
ADD files/emacs /home/lisp/.emacs.d/init
