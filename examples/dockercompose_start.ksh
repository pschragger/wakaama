#!/bin/ksh

usage(){
 print "USAGE:\n$0 b|c|l|s|h \n"
 print " b - bootserver \n c - client\n l - lightclient\n s - server\n h - shared\n"
}

if [[ $# -eq 0 ]];then
   print "$0 : No Arguments"
   usage()
   exit -1
fi

typeset -x exampledir=""
typeset -x dockertype=""
DATE=`date +%m%d%Y`
TIME=`date +%H%M`
MYDATETIME=${DATE}${TIME}
cd ..

case $1 in
	b)
		exampledir="./examples/bootstrap_server"
        dockertype="bootstrap_server"
		;;
	c)
        dockertype="client"
		exampledir="./examples/client"
        ;;
		
    l)
        exampledir="./examples/lightclient"
        dockertype="lightclient"
        ;;
    s)
        dockertype="server"
        exampledir="./examples/server"
        ;;
    h)
        exampledir="./examples/shared"
        print " shared not implemented"
        exit 0
        ;;
	*)
		echo "Sorry, I don't understand"
        usage()
        exit -1
     
esac

if [[ -d ./log ]];then
   echo ""
   else
   mkdir log
fi
print "Setting up ${dockertype} "
cp ${exampledir}/docker-compose.yml  docker-compose.yml

print "starting Docker-compose for ${dockertype}"
rm ./log/startup_docker_${dockertype}.*
docker-compose up --build > ./log/startup_docker_${dockertype}.${MYDATETIME}.log 2>&1 &



#sleep(10)
#rm docker-compose.yml