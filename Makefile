

BOX_FILE := "package.box"
BOX_NAME := "shipkode/bionic64_docker-build-machine"

.PHONY:	up
up:
	vagrant up

.PHONY:	ssh
ssh:
	vagrant ssh

.PHONY:	halt
halt:
	vagrant halt

.PHONY:	status
status:
	vagrant status

.PHONY:	destroy
destroy:
	vagrant destroy -f

provision:	up
	vagrant provision

${BOX_FILE}:	provision
	vagrant package --base $(shell VBoxManage list vms | grep docker-build-machine | awk '{ print $$1 }')

install:	${BOX_FILE}
	vagrant box add --force --provider virtualbox --name ${BOX_NAME} ${BOX_FILE}

.PHONY:	deploy
deploy:
	 ansible-playbook -i ansible/inventory.example ansible/site.yml --ask-pass --ask-become-pass

clean:	destroy
	rm -f ${BOX_FILE}

