#!/bin/sh

set -e

# install packages
apt-get update

extensions -i bcmath gd intl mbstring mcrypt mysql readline soap xsl

apt-get clean -y

# magento needs a bit more memory than 256M
sed -e 's/^\(memory_limit\).*/\1 = 1024M/' \
    -i /etc/php/${DW_PHP_VERSION}/mods-available/custom.ini

sed -e 's/\(max_nesting_level\).*/\1=1000/' \
    -i /etc/php/${DW_PHP_VERSION}/mods-available/xdebug.ini

# install magerun
curl -sS -o /usr/local/bin/magerun https://files.magerun.net/n98-magerun.phar
chmod +x /usr/local/bin/magerun

# update permissions to allow rootless operation
/usr/local/bin/permissions
