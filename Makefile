.PHONY: build configure prepare clean

build: configure
	docker run --rm -t --privileged -v $(PWD)/vyos-build:/vyos -w /vyos vyos/vyos-build:current sudo make iso
	mkdir -p ./build
	mv vyos-build/build/vyos-*.iso ./build

configure: prepare
	docker run --rm -t --privileged -v $(PWD)/vyos-build:/vyos -w /vyos vyos/vyos-build:current ./configure --architecture amd64 --custom-apt-key ./tailscale.gpg --custom-apt-entry "deb https://pkgs.tailscale.com/stable/debian bullseye main" --custom-package "tailscale" --custom-package "waagent" --custom-package "cloud-init" --build-comment "VyOS with Tailscale" --build-type production --version 1.4-rolling-`date +%Y%m%d%H%M`

prepare:
	cp tailscale/tailscale.gpg vyos-build/tailscale.gpg

	mkdir -p vyos-build/data/live-build-config/includes.chroot/etc/default
	cp tailscale/tailscaled vyos-build/data/live-build-config/includes.chroot/etc/default/tailscaled

	mkdir -p vyos-build/data/live-build-config/includes.chroot/etc/systemd/system/tailscaled.service.d
	cp tailscale/override.conf vyos-build/data/live-build-config/includes.chroot/etc/systemd/system/tailscaled.service.d/override.conf

clean:
	rm -rf ./build
