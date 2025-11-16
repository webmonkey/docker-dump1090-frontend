IMAGE_NAME=webmonkey/dump1090-frontend

build:
	docker build -t $(IMAGE_NAME) .


run:
	docker run --rm -it \
    	--device=/dev/bus/usb:/dev/bus/usb \
		$(IMAGE_NAME)

push:
	docker image push $(IMAGE_NAME)
