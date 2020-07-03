#using : after a switch variable means it requires some input (ie, t: requires something after t to validate while h requires nothing.
while getopts "ht:r:p:v" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         t)
             TEST=$OPTARG
             ;;
         r)
             SERVER=$OPTARG
             ;;
         p)
             PASSWD=$OPTARG
             ;;
         v)
             VERBOSE=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $TEST ]] || [[ -z $SERVER ]] || [[ -z $PASSWD ]]
then
     usage
     exit 1
fi