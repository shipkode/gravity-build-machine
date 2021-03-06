# Gravity Build Machine

Automation for creating a docker build box that includes:

* Docker
* Docker registry
* Build essentials

This automation can be used to build and deploy gravity in
development configurations.

The automation can be run using vagrant and virtualbox or
run against a OS-ready bare metal server with ssh and remote sudo
access.

## Getting started

This automation runs on Mac OSX. Before you get started, you will need to
install the pre-requisites described below.

### Installing pre-requisites

* [Virtualbox](https://www.virtualbox.org/) ([download](https://www.virtualbox.org/wiki/Downloads)|[install](https://www.virtualbox.org/manual/ch02.html#idm861))
* [Vagrant](https://www.vagrantup.com) ([download](https://www.vagrantup.com/downloads.html)|[install](https://www.vagrantup.com/docs/installation/)). Note: you will need version 2.2.2 or greater.
* [Ansible](https://www.ansible.com/) ([install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html))


### Installing vagrant plugins

With certain versions of vagrant, it is possible to run into issues installing
vagrant plugins. We recommend you install these two plugins once you have
installed vagrant:

     $ vagrant plugin install vagrant-disksize
     $ vagrant plugin install vagrant-vbguest

### Checking out the code

To clone this repo, use the following command:

    git clone git@github.com:shipkode/gravity-build-machine.git

At this point, you are ready to get started!

## Running

### Creating your VM

You now are ready to standup your VM. Type in the commands below:

    cd gravity-build-machine
    make install

That's it! Now watch as the wonders of automation unfold, and your
environment and workloads are all setup.

You should see something like this:

    META: ran handlers
    META: ran handlers

    PLAY RECAP *********************************************************************
    docker1                    : ok=18   changed=0    unreachable=0    failed=0

    vagrant package --base "gravity-build-machine_docker1_1542675441580_28582"
    ==> gravity-build-machine_docker1_1542675441580_28582: Attempting graceful shutdown of VM...
        gravity-build-machine_docker1_1542675441580_28582: Guest communication could not be established! This is usually because
        gravity-build-machine_docker1_1542675441580_28582: SSH is not running, the authentication information was changed,
        gravity-build-machine_docker1_1542675441580_28582: or some other networking issue. Vagrant will force halt, if
        gravity-build-machine_docker1_1542675441580_28582: capable.
    ==> gravity-build-machine_docker1_1542675441580_28582: Forcing shutdown of VM...
    ==> gravity-build-machine_docker1_1542675441580_28582: Clearing any previously set forwarded ports...
    ==> gravity-build-machine_docker1_1542675441580_28582: Exporting VM...
    ==> gravity-build-machine_docker1_1542675441580_28582: Compressing package to: /Users/dlapsley/Documents/repos/gravity-build-machine/package.box
    vagrant box add --force --provider virtualbox --name "shipkode/bionic64_gravity-build-machine" "package.box"
    ==> box: Box file was not detected as metadata. Adding it directly...
    ==> box: Adding box 'shipkode/bionic64_gravity-build-machine' (v0) for provider: virtualbox
        box: Unpacking necessary files from: file:///Users/dlapsley/Documents/repos/gravity-build-machine/package.box
    ==> box: Successfully added box 'shipkode/bionic64_gravity-build-machine' (v0) for 'virtualbox'!
    MacBook-Pro:gravity-build-machine dlapsley$ vagrant box list
    shipkode/bionic64_gravity-build-machine (virtualbox, 0)
    ubuntu/bionic64                        (virtualbox, 20181018.0.0)
    MacBook-Pro:gravity-build-machine dlapsley$

Congratulations! You now have a docker build box at your disposal :)

## Deploying on bare metal

You can also leverage all of this automation on a bare-metal, pre-provisioned
server. You will need to do the following:

### Edit ansible/site.yml

You'll need to update your docker and vbox user information. Update the 
vars section of the file to look something like this:

    vars:
      debug: False
      docker_users:
        - my_ssh_user_name
      vbox_user: my_ssh_user_name

Where *my_ssh_user_name* is the name of the user that has ssh (and sudo
access to the baremetal server).

### Update ansible inventory.example

Update the inventory file ansible/inventory.example so that it has your server
and credential information.

### Deploy!

Now it's time to deploy your server:

    $ cd ansible
    $ make deploy

## License

[Apache Software License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
