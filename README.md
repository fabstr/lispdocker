A simple docker container with emacs, sbcl and slime. 

On startup it mounts `$HOME` and starts the emacs gui and slime.

Usage:
- `make build` to build it
- `make run` to start emacs etc

You might need to change UID in Dockerfile.
