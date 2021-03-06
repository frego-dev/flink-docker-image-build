# How to use Flink docker images on arm64/v8 architecture
### Building flink docker image using official Flink docker repository

One of the most convenient ways to create a Flink development environment is to use Flink’s official docker image. The Flink docker image is easy to work with, however some of the major architecture is not supported. For example, using Apple’s new M1 chip, you will run in the following error message since M1 is an ARM64/v8 architecture based chip:

<img width="484" alt="arm64v8_error" src="https://user-images.githubusercontent.com/79912756/130320118-d6720138-2079-44b0-b3df-5cc915a8d47b.png">

The official Flink images support only the amd64 architecture, so all platforms based on other architecture won’t be able to run the Flink images.
Luckily, the Flink docker image is based on openjdk:8-jre or openjdk:11-jre images that also support arm64 and window-amd64 architectures, so we can easily make a custom build of the official Flink image that already works on our current environment.

**Note:** _We would like to highlight that this custom build Flink image is appropriate to create development environment and we don’t recommend to run it in production environment._

Based on the official Flink docker repository, we have implemented a simple bash script (`build_image.sh`) that downloads then build the required Flink image version.
Currently, the following versions are supported:
- Flink versions: 1.11, 1.12, 1.13 [default: 1.13]
- Java versions: 8, 11 [default: 8]
- Scala versions: 2.11, 2.12 [default: 2.12]

#### Usage examples
To execute the build script, you can download the script, you can clone this repository, but the easiest way to run it using `curl`.

##### Execute with default setting
```bash
curl https://raw.githubusercontent.com/frego-dev/flink-docker-image-build/main/build_image.sh | bash
```

##### Flink version: 1.12, Java version: 8, Scala version: 2.12

```bash
curl https://raw.githubusercontent.com/frego-dev/flink-docker-image-build/main/build_image.sh | bash -s -- -f 1.11 -j 8 -s 2.12
```

##### Flink version: 1.13, Java version: 11, Scala version: 2.11

```bash
curl https://raw.githubusercontent.com/frego-dev/flink-docker-image-build/main/build_image.sh | bash -s -- -f 1.13 -j 11 -s 2.11
```

