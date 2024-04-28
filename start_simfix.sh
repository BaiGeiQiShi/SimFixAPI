#!/bin/bash -x

CURR=$(pwd)

echo -n '' > time-info.txt

for dir in 105_bugs_with_src/*
do
	#prepare data
	dir=${dir##*/}
	project=${dir%%[0-9]*}
	project_s=${project,}
	bugid=${dir#*$project}
        bug=${bugid%%[a-c]*}

	cd "$CURR/105_bugs_with_src/$dir"
	fail_tests=`catena4j test`
        fail_tests=${fail_tests#*-}
        tmp=${fail_tests#*-}

	if [[ ! -d $CURR/d4j-info/all_tests/${project,} ]]; then
        	mkdir $CURR/d4j-info/all_tests/${project,}
        fi
	cp "$CURR/105_bugs_with_src/$dir/all_tests" "$CURR/d4j-info/all_tests/${project,}/$bug.txt"

        if [[ ! -d $CURR/d4j-info/failed_tests_ori/${project,} ]]; then
                mkdir $CURR/d4j-info/failed_tests_ori/${project,}
        fi
	cp "$CURR/105_bugs_with_src/$dir/failing_tests" "$CURR/d4j-info/failed_tests_ori/${project,}/$bug.txt"
        
	if [[ ! -d $CURR/d4j-info/failed_tests/${project,} ]]; then
                mkdir $CURR/d4j-info/failed_tests/${project,}
        fi
	echo -n "" > "$CURR/d4j-info/failed_tests/${project,}/$bug.txt"


	if [[ ! -d $CURR/d4j-info/location/ochiai/${project,} ]]; then
                mkdir $CURR/d4j-info/location/ochiai/${project,}
        fi
        python3 $CURR/fl_reformat.py "$CURR/105_bugs_with_src/$dir/ochiai.ranking.txt" "$CURR/d4j-info/location/ochiai/${project,}/$bug.txt"
        while [[ $fail_tests != $tmp ]]
        do
                fail_test=${fail_tests%%-*}
                echo $fail_test >> "$CURR/d4j-info/failed_tests/${project,}/$bug.txt"
                fail_tests=${fail_tests#*-}
                tmp=${fail_tests#*-}
        done
        echo $fail_tests >> "$CURR/d4j-info/failed_tests/${project,}/$bug.txt"


	#run simfix
	cd "$CURR"

	if [[ -d "./projects/${project_s}/${project_s}_${bug}_buggy" ]];then
		rm -rf ./projects/${project_s}/${project_s}_${bug}_buggy
		mkdir -p ./projects/${project_s}
		cp -r ./105_bugs_with_src/$dir ./projects/${project_s}/${project_s}_${bug}_buggy
		echo "${project}-${bugid}" >> time-info.txt
		date "+ %Y-%m-%d %H:%M:%S" >> time-info.txt
		timeout -s 9 18000s java -cp SimFix.jar cofix.main.Main 500 --proj_home=$CURR/projects/ --proj_name=${project_s} --bug_id=${bug}
		date "+ %Y-%m-%d %H:%M:%S" >> time-info.txt
	else
		mkdir -p ./projects/${project_s}
		cp -r ./105_bugs_with_src/$dir ./projects/${project_s}/${project_s}_${bug}_buggy
		echo "${project}-${bugid}" >> time-info.txt
                date "+ %Y-%m-%d %H:%M:%S" >> time-info.txt
		timeout -s 9 18000s java -cp SimFix.jar cofix.main.Main 500 --proj_home=$CURR/projects/ --proj_name=${project_s} --bug_id=${bug}
		date "+ %Y-%m-%d %H:%M:%S" >> time-info.txt
	fi

	if [[ -d "./patch/${project_s}/${bug}" ]];then
		mv ./patch/${project_s}/${bug} ./patch/${project_s}/${bugid}
	fi
done
