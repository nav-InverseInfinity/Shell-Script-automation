# Shell-Script-automation

1. **system_monitor.sh** - script will display the CPU, RAM and Disk usage of your system.

   Using Ansible playbook, we can execute this monitoring script on remote servers and monitor their usage.

    By creating a cronjob we can send email notification if the "Warning" turns to "YES"
    
## Find and Upload/Copy

 **find_and_upload.sh** refer [here]()

The aim fo this script si to find a file or multiple files/extensions then either copy it to local drive or Make it a tar ball and upload to AWS S3.
In order to make it a user interactive script, used Conditional and Case statements for interactions, where it reads user's reponse and as per the choice, it will perform the tasks.



