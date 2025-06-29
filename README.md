# howto nix on fedora sway atomic

## steps

### make sway atomic install media

* follow instructions here
    - https://fedoraproject.org/atomic-desktops/sway/download


### allow transient root in rpm-ostree

```
$ sudo tee /etc/ostree/prepare-root.conf <<'EOL'
[composefs]
enabled = yes
[root]
transient = true
EOL

$ rpm-ostree initramfs-etc --reboot --track=/etc/ostree/prepare-root.conf
```


### install nix standalone

* use determinate systems nix installer to install upstream vanilla nix

```
$ curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

* respond “no” to “Install Determinate Nix?”
* respond “yes” to “Proceed?”


### setup nix with home-manager

* add nix channels

```
$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable
$ nix-channel --add \
https://github.com/nix-community/home-manager/archive/master.tar.gz \
home-manager
$ nix-channel --update
```

* install home-manager

```
$ nix-shell '<home-manager>' -A install
```

* clone home-manager 

```
$ mkdir -p ~/.config
$ git clone git@github.com:philetus/nix-home-manager.git ~/.config/home-manager
```

* edit config in default editor (nano by default)

```
$ home-manager edit
```

* load home-manager config

```
$ home-manager switch
```

* reboot system


# references

* https://fedoraproject.org/atomic-desktops/sway/
* https://julianhofer.eu/blog/01-silverblue-nix/
* https://github.com/DeterminateSystems/nix-installer
    - https://github.com/DeterminateSystems/nix-installer/issues/1445#issuecomment-2856334377
* https://github.com/sharkdp/fd
