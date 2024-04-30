# SimFix
This repository is used to replicate the experiments of article **"Towards Effective Multi-Hunk Bug Repair: Detecting, Creating, Evaluating, and Understanding Indivisible Bugs"** on SimFix. If you want to learn more about SimFix, please follow the original repository of [SimFix](https://github.com/xgdsmileboy/SimFix.git).

## 1. Modification
In order to use SimFix more flexibly, we have added a parameter to SimFix to indicate the number of generated plausible patches.

## 2. Environment

- Ubuntu 20.04
- docker
- Python 3.8
- pip
- pandas
- JDK 1.8
- [Defects4J 2.0](https://github.com/rjust/defects4j)
- [CatenaD4J](https://github.com/universetraveller/CatenaD4J.git)

## 3. Experiment Setup
- Timeout: 5h
- Plausible patches number: 500

## 4. Excluded Bug
> None


## 5. Installation

#### 5.1 Create the docker image
Use the `Dockerfile` in `./Docker` to create the docker image.
```shell
docker build -t simfix-env .
```

This docker image includes **Defects4J**, **CatenaD4J**, and **JDK 1.8**.

#### 5.2 Create the container

```shell
docker run -it --name=simfix simfix-env /bin/bash
```

#### 5.3 Clone the SimFix repository

At the root of this container, we clone the SimFix repository.

```shell
cd /
git clone https://github.com/BaiGeiQiShi/SimFixAPI.git
```

#### 5.4 Install dependencies and Setup
After testing, we found that using **pip** in the Docker file might cause image creation to fail, so configuration inside the container is required.
```shell
cd ./SimFixAPI
./setup.sh
```

## 6. Quick Test
It takes several minutes to quickly test your installation. (**Note:** In quick test, the `ochiai.ranking.txt` in Chart18b2 only contains one location！)
```
# Generate the patches
./start_simfix.sh
```
After finishing the repair, the results are in folders: `log` and `patch`.

* `log` : debug output, including buggy statements already tried, patches and reference code snippet for correct patch generation.

* `patch` : a single source file repaired by SimFix that can pass the test suite. In the source file, you can find the patch, which is formatted as (example of Chart18b2):

```java
 // start of generated patch
if(index<=this.keys.size()){
rebuildIndex();
}
// end of generated patch
/* start of original code
        if (index < this.keys.size()) {
        rebuildIndex();
        }
 end of original code*/
  ```

## 7. Experiment Reproduction
You should first checkout the 105 bugs in Catena4j and then repair these 105 bugs
```shell
./checkout_105.sh  #checkout 105 bugs
./start_simfix.sh  #repair 105 bugs
```
After finishing the repair, you can also check the results in folders: `log` and `patch`.


If you have any questions, you can go to the [SimFix](https://github.com/xgdsmileboy/SimFix.git) repository or create issues for more information.
