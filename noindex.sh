# This script creates a default .htaccess file that disables indexes on a newly
# added website/domain. It assumes the path to the website is
# ~/wwwroot/DOMAIN.TLD/SUBDOMAIN/public_html
# ~~ Scott Johnson

# Don't let the arguments be empty.
if [ -z "$1" ]; then
   echo "No domain provided."
   exit 1
fi

# Split the domain name into it's parts.
DOMAIN1=$( echo $1 | cut -s -f1 -d. )
DOMAIN2=$( echo $1 | cut -s -f2 -d. )
DOMAIN3=$( echo $1 | cut -s -f3 -d. )

# Make sure this is a minimal domain name with tld.
if [ -z "$DOMAIN2" ]; then
   # Invalid domain.
   echo "Invalid domain $1"
   exit 1

elif [ -z "$DOMAIN3" ]; then
   # Domain is missing sub part.
   DOMAIN=$DOMAIN1.$DOMAIN2
   SUBDOMAIN="www"

else
   # This is a full three part domain.
   DOMAIN=$DOMAIN2.$DOMAIN3
   SUBDOMAIN=$DOMAIN1

fi

# Determines the full directory of where to put the default .htaccess file.
DIRECTORY=~/wwwroot/$DOMAIN/$SUBDOMAIN

# Check the existance of this directory.
if [ ! -d "$DIRECTORY" ]; then
   echo "Directory does not exist $DIRECTORY"
   exit 1
fi

# Determines the full path of the .htaccess file.
PATH=$DIRECTORY/.htaccess

# Check if PATH already exists.
if [ -f "$PATH" ]; then
   echo "Path already exists $PATH"
   exit 1
fi

# Output the final .htaccess file.
echo "Options -Indexes">$PATH

# Finished successfully!
echo $PATH
echo done.
exit 0
