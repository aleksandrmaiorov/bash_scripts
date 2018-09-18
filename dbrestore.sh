#!/bin/bash
## In order to use this script, please download backup and extract. 
## $ git clone http://github.com/aleksandrmaiorov/bash_scripts/dbrestore.sh
## $ cd bash_scripts
## $ chmod +x dbrestore.sh
## $ bash dbrestore.sh

echo "This script is used to restore database"
read -p "Please enter hostname : " db_host
read -p "Please enter username for database : " db_usrnm
read -p "Please enter password of a user for database : " db_psw
read -p "Please enter database name : " db_name
read -p "Please enter path to DDL folder Be aware that this step will create ddl file required for next steps : " ddl_path
ls $ddl_path > ~/ddl_file
read -p "Are you sure you want to continue? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	echo "Starting restore of database from archive"
	ddls=` cat ~/ddl_file`
    echo "This script is used to restore database"
    mysql --host=$db_host --user=$db_usrnm --password=$db_psw  -e "set global foreign_key_checks=0;"
	for ddl in $ddls; do
		mysql --host=$db_host --user=$db_usrnm --password=$db_psw  $db_name < $ddl_path/$ddl
	done
	mysql --host=$db_host --user=$db_usrnm --password=$db_psw  -e "set global foreign_key_checks=1;"
echo "Database upload completed without problem"
else
  exit 0
  echo "You canceled upload process!!"
fi
