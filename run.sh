SCRIPT_DIR=$(pwd)
file=$SCRIPT_DIR/success.txt
ROOT_DIR=/SimFix/105_bugs_with_src

#for item in `ls $ROOT_DIR`; do
cat ${file} | while read item
do
	echo $item
    PID=`echo $item | awk '{split($1,arr,"_");print(arr[1])}'`
    BID=${item#*_}
    BID_NUM=`echo $item | awk '{split($1,arr,"_");print(arr[2])}'`
    CID_NUM=`echo $item | awk '{split($1,arr,"_");print(arr[3])}'`
#    echo ${PID}:${BID_NUM}:${CID_NUM}
    # PROJECT_DIR=/home/lxy/research/multi_location_bug_repair/NIChecker/projects/${PID}_${BID}
    PROJECT_DIR=${ROOT_DIR}/${PID}${BID_NUM}b${CID_NUM}
    echo ${PROJECT_DIR}
    # Checkout defects4j project
     if [ ! -d "${PROJECT_DIR}" ]; then
       # Script statements if $DIR not exists.
#       rm -rf ${PROJECT_DIR}
        echo "project dir is not exists"
        echo PID:${PID}
        catena4j checkout -p ${PID} -v ${BID_NUM}b${CID_NUM} -w ${PROJECT_DIR}
     fi

    cd ${PROJECT_DIR}
    defects4j compile
    cp /AnalysisData/runGzoltar/26SampleBugsResult/$item/ochiai.ranking.txt $PROJECT_DIR/ochiai.ranking.txt

<< 'COMMENT'
COMMENT
done

