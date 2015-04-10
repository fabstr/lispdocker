#!/bin/sh

while getopts "srp:" opt; do
	case $opt in
		s)
			# used to install quicklisp and slime
			sbcl --load "/quicklisp.lisp" \
				--eval "(quicklisp-quickstart:install)"
			sbcl --load "/home/lisp/quicklisp/setup.lisp" \
				--eval '(ql:quickload "quicklisp-slime-helper")'
			;;
		r)
			# development is the user's mounted home directory, 
			# cd their and start emacs with slime
			cd /development && emacs -f slime 
			;;
		p)
			# install a plugin for emacs
			emacs -batch \
				--eval "(defconst pkg-to-install '${OPTARG})" \
				-l /installplugin.el
			;;
	esac
done
