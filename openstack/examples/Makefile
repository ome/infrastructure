NAME := mini-idr
UID := $(shell echo $$UID)

ssh:
	ssh -qt \
		-o UserKnownHostsFile=/dev/null \
		-o StrictHostKeyChecking=no \
		omero@$$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $(NAME))

config:
	docker exec -u root $(NAME) usermod -u $(UID) omero
	docker exec -u root $(NAME) chown -R omero /home/omero
	docker exec -u root $(NAME) bash -eux /tmp/idr-example-omero-bootstrap.sh
	docker exec -u omero $(NAME) bash -eux /tmp/idr-setup-1.sh

run: build
	docker run -d \
		-p 58888:80 \
		-p 54064:4064 \
		-p 54063:4063 \
		--cap-add SYS_ADMIN \
		--name $(NAME) \
		-v /run \
		-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
		-v /uod:/uod:ro \
		-v /uod/idr/versions/mini-idr:/OMERO \
		$(NAME)
	echo See: $$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $(NAME))

build:
	docker build -t $(NAME) .

clean:
	docker stop $(NAME)
	docker rm $(NAME)
