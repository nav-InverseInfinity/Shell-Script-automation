
#!/bin/bash

	#gives list of zombie process PPID (parent's PID)
	
	ps -Aoppid,stat | grep -i z | awk '{print $1}' > /opt/zom_ppid.txt
  
	cat /opt/zom_ppid.txt

	#if the file is not empty, then kill the zombie PPIDs
	
	if [[ -s /opt/zom_ppid.txt ]]; then
  
		for i in $(cat /opt/zom_ppid.txt); do
    
			echo "killing PPID $i"
      
			kill -9 $i
      
			done
	fi	

