## Docker buildx cluster

This repo aim to setup a docker buildx cluster between two VMs to perform tests.

### Requirements

- [`Vagrant`](https://www.vagrantup.com/)
- [`Virtualbox`](https://www.virtualbox.org/)

### How to

First you must start the VMs:

```shell
$ vagrant up
```

Then you need to connect to the first VM:

```shell
$ vagrant ssh buildx1
```

Add the ssh-key:

```shell
$ ssh-add /vagrant/ssh-key/id_ed25519
```

Create buildx context:

```shell
$ /vagrant/scripts/docker-create-nodes.sh
```

Check that buildx context has been successfully created:

```shell
$ docker buildx inspect --bootstrap cluster_builder
```

## License

MIT