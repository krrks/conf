#!/bin/sh

if [ -f "./index.php" ]
then
echo "Skip installation."
else

wget -q $phpzip_url /opt/app-root/src/
unzip -q /opt/app-root/src/latest.zip

echo "Clear files"
rm -r httpd-pre-init
rm -r php-pre-start
rm latest.zip 
mv ./wordpress/* ./
rm -r wordpress
echo "Setting wp-config"
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

fi

echo "Installation finished."
