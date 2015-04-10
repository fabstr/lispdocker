XAUTH=/tmp/.docker.xauth

build: Dockerfile files/start.sh files/dotfiles/emacs
	docker build -t lispdocker . 

run: build
	touch ${XAUTH} 
	xauth nlist :0  | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -
	docker run \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ${XAUTH}:${XAUTH} \
		-v $$HOME:/development \
		-e DISPLAY=$$DISPLAY \
		-e XAUTHORITY=${XAUTH} \
		-it lispdocker /start.sh
