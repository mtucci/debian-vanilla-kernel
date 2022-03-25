This container downloads the latest stable vanilla kernel from [kernel.org](https://www.kernel.org/) and it compiles it using the latest kernel config file in the `/boot` directory on the host as the starting configuration.

Example usage:
```shell
docker build -t debian-vanilla-kernel .
docker run --rm -v /boot:/boot -v $PWD/build:/build debian-vanilla-kernel
```

The resulting `.deb` packages can be found in the `build` directory.
