#!/bin/bash

echo "File path to search?"

read path

echo -ne "Find option \n1. single file  \n2. multiple files or extensions\n"

read option



echo -e "Perform \n1. Copy to local drive \n2. Make it a tar ball and Upload to AWS S3 \n"

read fhandle



case $fhandle in
        1) echo "Enter the destination directory: "
                read dest
           ;;

        2) echo "Enter the destionation directory to save the tar ball"
		read tar_dest
	   ;;

esac

case $option in
        1) echo "Enter the file name to search"
                read single
        	found_single=$(sudo find $path -type f -name "$single")

	        if [ -n $found_single ]; then
	                echo "Found the file $found_single"

	                echo "Perform next step, yes or no?"

	                		read next_step

	                if [[ $next_step =~ ^([nN][oO]|[nN])$ ]]; then

	                        echo "bye"

	                elif [[ $fhandle =~ ^([1])$ ]]; then

	                        sudo find $path -type f -name "$single" -exec cp {} $dest \;

	                        cd $dest && echo "File copied to $PWD" && ls -l $dest | grep "$single"

	                elif [[ $fhandle =~ ^([2])$ ]]; then

                          echo "Enter tar ball name"

                                read tar_ball

                          sudo find $path -type f -name "$single" | xargs tar -czvf /$tar_dest/$tar_ball.tar.gz

                          cd $tar_dest && echo "File copied to $PWD" && ls -l $tar_dest | grep $tar_ball.tar.gz

                          echo "Proceeding to S3 upload statge"

                                sleep 3

                          echo "S3 bucket list"

                                aws s3 ls

                		      echo -ne "\n1. Do you want to create a new S3 bucket?  \n2. Enter an existing bucket name?\n"

                        		        read bucket_choice

                        	case $bucket_choice in
                                	1) echo "Enter a unique bucket name?"
                                        		read bucket_name

                                     echo "Check for existing bucket"

                                     aws s3 ls | grep $bucket_name

                                     if [[ $? -ne 0 ]]; then

                                           echo "Creating the S3 bucket"

                                           aws s3 mb s3://$bucket_name

                                           echo "Bucket created"

                                           aws s3 ls | grep $bucket_name

                                           echo "Uploading to S3"

                                           cd $tar_dest && aws s3 cp ./$tar_ball.tar.gz s3://$bucket_name

                                           echo "Uploaded on S3 bucket"

                                           aws s3 ls s3://$bucket_name


                                      else echo "Bucket is not unique or already exist"

                                      fi
                                      ;;

                                		2) echo "Bucket name -" 
                                            read exist_bucket

                                       echo "Check for existing bucket"

                                       aws s3 ls | grep $exist_bucket

                                       if [[ $? -eq 0 ]]; then

	                                                   echo "Uploading to S3"

	                                                   cd $tar_dest && aws s3 cp ./$tar_ball.tar.gz s3://$exist_bucket

	                                                   echo "Uploaded on S3 bucket"

	                                                   aws s3 ls s3://$exist_bucket

                                       else echo "Entered bucket name doesn't exist"

                                         fi
                                         ;;
					                  esac


                      fi
                 else echo "File name doesn't exist, try again"

                 fi
                 ;;

            2) echo "Enter the file extensions (ex - .xml|.jpg) "
                        read multi

                sudo find $path -type f | egrep -i "$multi" 

                echo "Perform next step, yes or no?"

                    read next_step

                if [[ $next_step =~ ^([nN][oO]|[nN])$ ]]; then

                        echo "bye"

                elif [[ $fhandle =~ ^([1])$ ]]; then

                        sudo find $path -type f | egrep -i "$multi" | sudo xargs -I{} cp {} $dest

                        cd $dest && echo "File copied to $PWD" && ls -l $dest | grep "$multi"


                elif [[ $fhandle =~ ^([2])$ ]]; then

                      echo "Enter tar ball name"
                            read tar_ball

                      sudo find $path -type f | egrep -i "$multi" | xargs tar -czvf /$tar_dest/$tar_ball.tar.gz

                      cd $tar_dest && echo "Copied to $PWD" && ls -l $tar_dest | grep $tar_ball.tar.gz

                      echo "Proceeding to S3 upload statge"

                      sleep 3

                      echo "S3 bucket list"

                        aws s3 ls

                      echo -ne "\n1. Do you want to create a new S3 bucket?  \n2. Enter an existing bucket name?\n"
                                read bucket_choice

                      case $bucket_choice in
                              1) echo "Enter a unique bucket name?"
                                      read bucket_name

                                 echo "Check for existing bucket"

                                 aws s3 ls | grep $bucket_name

                                 if [[ $? -ne 0 ]]; then

                                       echo "Creating the S3 bucket"

                                       aws s3 mb s3://$bucket_name

                                       echo "Bucket created"

                                       aws s3 ls | grep $bucket_name

                                       echo "Uploading to S3"

                                       cd $tar_dest && aws s3 cp ./$tar_ball.tar.gz s3://$bucket_name

                                       echo "Uploaded on S3 bucket"

                                       aws s3 ls s3://$bucket_name

                                  else echo "Bucket is not unique or already exist"

                                  fi
                                  ;;							  

                               2) echo "Bucket name -" 
                                        read exist_bucket

                                   echo "Check for existing bucket"

                                   aws s3 ls | grep $exist_bucket

                                   if [[ $? -eq 0 ]]; then

                                       echo "Uploading to S3"

                                       cd $tar_dest && aws s3 cp ./$tar_ball.tar.gz s3://$exist_bucket

                                       echo "Uploaded on S3 bucket"

                                       aws s3 ls s3://$exist_bucket

                                  else echo "Entered bucket name doesn't exist"

                                  fi
                                  ;;
                      esac


              fi
              ;;


 esac
 
 
 
