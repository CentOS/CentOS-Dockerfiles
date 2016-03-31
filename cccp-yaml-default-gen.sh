#!/bin/bash

###########################################################################################################
#													  #
#	Script to travese the directories and generate the default cccp.yaml where it is missing	  #
#													  #
#				Author : Mohammed Zeeshan Ahmed	(mohammed.zee1000@gmail.com)		  #
#													  #
###########################################################################################################

function gencccpyaml() {
	
	mode=$1;
	project=$2;

	case $mode in
		OSV)		
			osversion=$3;
			PTH="./$project/$osversion/cccp.yaml"; # Determine path of the cccp.yaml file
			t="?"; # Temp variable, used below to get first character from osversion
			JOBID="${osversion%"${osversion#${t}}"}${osversion: -1}-$project" # JOBID = FirstChar(osversion)LastChar(osversion)-PROJECTNAME
		;;
		DIRECT)
			PTH="./$project/cccp.yaml";
			JOBID="CentOS-Dockerfile-$project";
		;;
	esac

    #	echo "$PTH $JOBID"; #TEST

	# Check if yaml file already exists, if so skip it

	if [ -f $PTH ]; then
		echo "*** $PTH already exists.....SKIPPED";
		return;
	fi

	# Generate the cccp.yaml file
echo "*** Generating default cccp.yaml";
cat <<EOF >> $PTH
job-id: $JOBID
test-skip: true
EOF


}

echo "Getting started....";echo;

# Check every project directory in the Centos-Dockerfiles
for project in `ls .`; do
	# echo $project; # TEST
	if [ -d $project  ]; then
			
		echo "Found project : $project, getting in..."
		ls ./$project | grep centos &> /dev/null; # Check if centosX directories are present in the project dir

		# if there is a match process os versions
		if [ $? -eq 0 ]; then

			echo "* Project contains centosX where X is a version, switching to osversion mode...";

			for osversion in `ls ./$project`; do

				#echo $osversion; #TEST
				gencccpyaml OSV $project $osversion;

			done
		else
			echo "* Project does not contain centosX directories, switching to direct mode...";
			#echo "HAHA"; #TEST
			#ls ./$project;	#TEST
			gencccpyaml DIRECT $project;
		fi
	fi
	echo;
done
