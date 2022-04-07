
#!/bin/bash

date_fmt=$(date "+%d-%m-%y-%H-%M")

find /var/www/ -type f  | xargs tar cf /opt/web_backup/web_media_content_bak_$date_fmt.tar.gz


# finding specific extensions 
# find /var/www/ -type f | egrep -i ".jpg|.png" | xargs tar -cf /opt/web_backup/web_media_content_bak_$date_fmt.tar.gz

echo "Listing the backup files"
ls /opt/web_backup

#presuming we already have a S3 backup bucket named "company-name-web-content-weekly-backup"

#Copying tarball to S3 bucket

aws s3 cp ./web_media_content_bak_$date_fmt.tar.gz s3://company-name-web-content-weekly-backup

