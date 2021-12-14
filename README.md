# vyos-image

Custom VyOS 1.4.x build, with [Tailscale][] and [Azure][] support.

Building requires a Linux machine, and Docker. The resulting `.iso` will be
created in the `build` directory.

## Usage:

```bash
git clone --recursive https://github.com/nullgrid/vyos-image.git
make
```

[Tailscale]: https://tailscale.com/
[Azure]: https://azure.microsoft.com/en-us/
