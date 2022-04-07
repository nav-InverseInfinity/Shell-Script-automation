# Shell-Script-automation

1. **system_monitor.sh** - script will display the CPU, RAM and Disk usage of your system.

   Using Ansible playbook, we can execute this monitoring script on remote servers and monitor their usage.

    By creating a cronjob we can send email notification if the "Warning" turns to "YES"
    
## Find and Upload/Copy

 **find_and_upload.sh** refer [here]()

The aim fo this script si to find a file or multiple files/extensions then either copy it to local drive or Make it a tar ball and upload to AWS S3.
In order to make it a user interactive script, used Conditional and Case statements for interactions, where it reads user's reponse and as per the choice, it will perform the tasks.


# Screenshots
## Find, tar and upload to S3


<img width="826" alt="Screenshot 2022-04-07 at 12 02 07" src="https://user-images.githubusercontent.com/98486154/162188500-0b82922d-ae91-4bbc-98cd-5caf797b82cd.png">


<img width="866" alt="Screenshot 2022-04-07 at 12 01 32" src="https://user-images.githubusercontent.com/98486154/162188527-a671f952-42e7-4067-b04b-314c2b99ff56.png">


List of S3 buckets

<img width="825" alt="Screenshot 2022-04-07 at 12 03 57" src="https://user-images.githubusercontent.com/98486154/162188602-c78599ec-f878-4e3a-94ed-953d2835dc58.png">

Uploaded S3 object

<img width="1014" alt="Screenshot 2022-04-07 at 12 20 05" src="https://user-images.githubusercontent.com/98486154/162189172-9034e012-483d-49a9-b821-832a32f60613.png">




