; used to install packages
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")t)
(setq url-http-attempt-keepalives nil)
(package-initialize)
(package-refresh-contents)
(package-install pkg-to-install)
