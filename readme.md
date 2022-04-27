The Incident Response Script set is a 3 part set:

1. Log Collector Script (cust_facing_full_log_export.ps1 and cust_facing_select_log_export.ps1) - This is a script that can be shared with clients when the need arises. This script must be run with Administrator Privileges on potentially infected machines. This script takes ~30 seconds to pull running processes, local users, connections and all log files on the machine and then compress them for upload to sharefile. 

2. Log Converter Script (Final_EVTX_TO_CSV.ps1)- This script takes the customer uploaded files and converts them to CSV. This script is propriety! This script should not be shared with Customers. This script should be run locally on the red team members machine. It uses the file structure created with Script 1, so changing any of the file structure created in the first script will break it. This script takes 2 command line parameters, the path of the .evtx output folder, considered "input" and the path of the csv folder folder, considered output. This script can take a few minutes to run, so be ready in case the wait is ~10 min (.evtx to .csv is compute heavy process).

The syntax for this script is:
.\Final_EVTX_TO_CSV.ps1 "PATH \TO THE .EVTX \FILE FROM \SCRIPT 1 \HERE" "PATH TO\ .CSV FOLDER \CREATED IN \SCRIPT 1 HERE" 


3. The Log Searching Script - This script is written in Python. It works with the .csv files created in Script 2. This script is available in 2 flavors. The first is a single .csv file searcher. This script takes 2 command line args, one being the input file (file to be searched) and output file (file where results are to be written. The longer version searches each .csv file created in Script 2. The command line argument for this script is the path to the .csv folder created in script 1. 

The syntax for the SINGLE log searcher script is:
Sample of Command line args needed: py log_searcher.py "Path to \ .csv File to \ Be Searched" "Path Where \Output Should Be \Written To"

**NOTE TO RUN THIS SCRIPT CORRECTLY YOU MUST CREATE A CSV FILE TO OUTPUT RESULTS TO. THIS FILE CAN BE ANYWHERE ON YOUR MACHINE**

The syntax for the Folder log searcher script is:
Sample of Command line args needed: py log_folder_searcher.py "Path to\ .CSV Folder"

**NOTE THIS SCRIPT OUTPUTS TO A FILE IT CREATES IN THE .CSV FOLDER**