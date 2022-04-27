#log file searcher v2#
#cleaner python code and stopwatch for runtime calculation#

import csv
import sys
import time

inFile = sys.argv[1]
outFile = sys.argv[2]

codes = [
        '45058', '4720', '4728', '1100', '1102', '4743', '4742',
        '5101', '4722', '4724', '4625', '4672', '4733', '4732',
        '4688', '4670', '4104', '4657', '4103', '4698', '4697',
        '104', '7045', '4699', '4698', '4702',
        ]

def main():
    with open(inFile, 'r', ) as csv_app:
        csv_reader = csv.reader(csv_app)

        with open(outFile, 'a', ) as new_csv:
            csv_writer = csv.writer(new_csv)

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