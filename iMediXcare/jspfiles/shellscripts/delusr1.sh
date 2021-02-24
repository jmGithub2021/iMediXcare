#deleting ftp user Account
if [ $# <> 0 ]
then
userdel -r $1
fi
