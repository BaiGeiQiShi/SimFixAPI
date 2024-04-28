# SimFix

## 1. Environment

- Ubuntu 20.04
- docker
- JDK 1.8
- [Defects4J 2.0](https://github.com/rjust/defects4j)
- [CatenaD4J](https://github.com/universetraveller/CatenaD4J.git)


## 2. Installation

#### 2.1 Create the docker image

```shell
docker build -t simfix-env .
```

This docker image includes **Defects4J**, **CatenaD4J**, and **JDK 1.8**.

#### 2.2 Create the container

```shell
docker run -it --name=simfix simfix-env /bin/bash
```

#### 2.3 Clone the SimFix repository

At the root of this container, we clone the SimFix repository.

```shell
cd /
git clone https://github.com/BaiGeiQiShi/SimFix.git
```

#### 2.4 Install dependencies
After testing, we found that using **pip** in the Docker file might cause image creation to fail, so configuration inside the container is required.
```shell
pip install pandas
```

## 3. Quick Test
```
# Generating the patches
cd ./SimFix

cd 105_bugs_with_src
catena4j checkout -p Chart -v 18b2 -w ./Chat18b2
cd ..
./start_simfix.sh
```


## 4. Usage
You should first checkout the bug in Catena4j
```
# Generate the patches

```

If you have any questions, you can go to the [SimFix](https://github.com/xgdsmileboy/SimFix.git) repository or create issues for more information.
