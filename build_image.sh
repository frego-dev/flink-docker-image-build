#!/bin/bash

STABLE_COMMIT_HASH="c61ae4c"

FLINK_VERSION="1.13"
JAVA_VERSION="8"
SCALA_VERSION="2.12"

SUPPORTED_FLINK_VERSIONS=("1.11" "1.12" "1.13")
SUPPORTED_JAVA_VERSIONS=("8" "11")
SUPPORTED_SCALA_VERSIONS=("2.11" "2.12")

while getopts ":f:j:s:" opt; do
  case $opt in
    f) FLINK_VERSION="$OPTARG"
    ;;
    j) JAVA_VERSION="$OPTARG"
    ;;
    s) SCALA_VERSION="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [[ ! " ${SUPPORTED_FLINK_VERSIONS[@]} " =~ " ${FLINK_VERSION} " ]]; then
    # whatever you want to do when array doesn't contain value
    echo "Unsupported Flink version: $FLINK_VERSION"
    echo "Supported Flink versions: "${SUPPORTED_FLINK_VERSIONS[*]}""
    exit
fi

if [[ ! " ${SUPPORTED_JAVA_VERSIONS[@]} " =~ " ${JAVA_VERSION} " ]]; then
    # whatever you want to do when array doesn't contain value
    echo "Unsupported Java version: $JAVA_VERSION"
    echo "Supported Java versions: "${SUPPORTED_JAVA_VERSIONS[*]}""
    exit
fi

if [[ ! " ${SUPPORTED_SCALA_VERSIONS[@]} " =~ " ${SCALA_VERSION} " ]]; then
    # whatever you want to do when array doesn't contain value
    echo "Unsupported Scala version: $SCALA_VERSION"
    echo "Supported Scala versions: "${SUPPORTED_SCALA_VERSIONS[*]}""
    exit
fi


echo "Building Flink image with configuration:"
echo "  - Flink version: $FLINK_VERSION"
echo "  - Java version: $JAVA_VERSION"
echo "  - Scala version: $SCALA_VERSION"

if [ -d "flink-docker" ] 
then
    echo "Detected existing apache/flink-docker git repository. Fetching updates ..."
    cd "flink-docker"
    git fetch origin
else
    echo "Downloading Dockerfiles from official apache/flink-docker git repository..."
    git clone git@github.com:apache/flink-docker.git 
    cd "flink-docker"
fi

echo "Checkout to commit: $STABLE_COMMIT_HASH"
git checkout $STABLE_COMMIT_HASH -q

IMG=$FLINK_VERSION-scala_$SCALA_VERSION-java$JAVA_VERSION
DIR_STR="$FLINK_VERSION/scala_$SCALA_VERSION-java$JAVA_VERSION-debian"
echo "Building Flink image: $DIR_STR"
cd $DIR_STR


docker build -t flink:$IMG . 

printf "\nFlink image has been successfully built! Check 'docker images' command\n"









