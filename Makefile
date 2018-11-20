

BOX_FILE := "package.box"
BOX_NAME := "shipkode/bionic64_docker-build-machine"

.PHONY:	up
up:
	vagrant up

.PHONY:	halt
down:
	vagrant halt

.PHONY:	destroy
destroy:
	vagrant destroy -f

provision:	up
	vagrant provision

${BOX_FILE}:	provision
	vagrant package --base $(shell VBoxManage list vms | grep docker-build-machine | awk '{ print $$1 }')

install:	${BOX_FILE}
	vagrant box add --force --provider virtualbox --name ${BOX_NAME} ${BOX_FILE}

clean:	destroy
	rm -f ${BOX_FILE}

