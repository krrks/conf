#!/bin/sh

if [ -f "./index.php" ] || [ -z $phpzip_url  ]
then
echo "=> [$(date +%F' '%T)] Skip installation."
else

echo "=> [$(date +%F' '%T)] Fetching php zip file."
wget -q -O srcfl.zip $phpzip_url 

# echo "=> [$(date +%F' '%T)] Waiting persisten volume."
# while [ ! -f ./wp-content/pvc.txt ]
# do
#   touch ./wp-content/pvc.txt
#   sleep 3
#   echo "-> [$(date +%F' '%T)] Waiting 3s."
# done
# while [ ! -f ./wp-includes/pvc.txt ]
# do
#   touch ./wp-includes/pvc.txt
#   sleep 3
#   echo "-> [$(date +%F' '%T)] Waiting 3s."
# done
# rm ./wp-content/pvc.txt ./wp-includes/pvc.txt


echo "=> [$(date +%F' '%T)] Unzip src.zip."
unzip -q -n srcfl.zip

echo "=> [$(date +%F' '%T)] Clear files."
rm -r httpd-pre-init
rm -r php-pre-start
rm srcfl.zip 
# cp -rn ./wordpress/* ./
# rm -r wordpress
echo "=> [$(date +%F' '%T)] Setting wp-config."
cd wordpress
cp wp-config-sample.php wp-config.php
sed -i $'s/\'database_name_here\'/$_ENV[\"database_name\"]/g' wp-config.php
sed -i $'s/\'username_here\'/$_ENV[\"database_user\"]/g' wp-config.php
sed -i $'s/\'password_here\'/$_ENV[\"database_password\"]/g' wp-config.php
sed -i $'s/\'DB_HOST\'\, \'localhost\'/\'DB_HOST\', \'mysql\'/g' wp-config.php
# sed -i $'/\(\'AUTH_KEY\'/c define\(\'AUTH_KEY\'\, $_ENV[\"WP_AK\"]\)\;' wp-config.php
# sed -i $'/\(\'SECURE_AUTH_KEY\'/c define\(\'SECURE_AUTH_KEY\'\, $_ENV[\"WP_SAK\"]\)\;' wp-config.php
# sed -i $'/\(\'LOGGED_IN_KEY\'/c define\(\'LOGGED_IN_KEY\'\, $_ENV[\"WP_LIK\"]\)\;' wp-config.php
# sed -i $'/\(\'NONCE_KEY\'/c define\(\'NONCE_KEY\'\, $_ENV[\"WP_NK\"]\)\;' wp-config.php
# sed -i $'/\(\'AUTH_SALT\'/c define\(\'AUTH_SALT\', $_ENV[\"WP_AS\"]\)\;' wp-config.php
# sed -i $'/\(\'SECURE_AUTH_SALT\'/c define\(\'SECURE_AUTH_SALT\'\, $_ENV[\"WP_SAS\"]\)\;' wp-config.php
# sed -i $'/\(\'LOGGED_IN_SALT\'/c define\(\'LOGGED_IN_SALT\'\, $_ENV[\"WP_LIS\"]\)\;' wp-config.php
# sed -i $'/\(\'NONCE_SALT\'/c define\(\'NONCE_SALT\'\, $_ENV[\"WP_NS\"]\)\;' wp-config.php

echo "---> [$(date +%F' '%T)] Installation finished."
fi


