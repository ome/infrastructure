NAME := mini-idr

ssh:
	ssh omero@$$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $(NAME))

run: build
	docker run -d --name $(NAME) -v /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro $(NAME)
	echo See: $$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $(NAME))

build:
	docker build -t $(NAME) .

clean:
	docker stop $(NAME)
	docker rm $(NAME)
