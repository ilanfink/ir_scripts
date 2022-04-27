#log folder searcher v2#
#cleaner python code and stopwatch for runtime calculation#

import csv
import sys
import time


path = sys.argv[1]

log_files = {'application log':'\Application.csv',
             'system log':'\System.csv',
             'security log': '\Security.csv',
             'windows firewall log':'\Microsoft-Windows-Windows Firewall With Advanced Security%4Firewall.csv',
             'terminal local session manager log':'\Microsoft-Windows-TerminalServices-LocalSessionManager%4Operational.csv',
             'terminal remote session log':'\Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.csv',
             'bits client log':'\Microsoft-Windows-Bits-Client%4Operational.csv',
             'task scheduler log':'\Microsoft-Windows-TaskScheduler%4Operational.csv',
             'powershell log':'\Microsoft-Windows-PowerShell%4Operational.csv',
             'windows defender log':'\Microsoft-Windows-Windows Defender%4Operational.csv',
             }

codes = [
        '45058', '4720', '4728', '1100', '1102', '4743', '4742',
        '5101', '4722', '4724', '4625', '4672', '4733', '4732',
        '4688', '4670', '4104', '4657', '4103', '4698', '4697',
        '104', '7045', '4699', '4698', '4702',
        ]

def main():
    with open(path + '\events_of_note.csv', 'a', ) as new_csv:
        csv_writer = csv.writer(new_csv)

        for log_file, log_path in log_files.items():
            print(f'Working On {log_file}')
            with open(path + log_path, 'r') as csv_app:
                csv_reader = csv.reader(csv_app)

                next(csv_reader, None)


                for line in csv_reader:

                    if line[1] in codes:
                        csv_writer.writerow(line)

if __name__ == "__main__":
    start = time.time()
    main()
    end = time.time()
    runtime = round((end - start), 1)
    print(f'This took {runtime} seconds to run')