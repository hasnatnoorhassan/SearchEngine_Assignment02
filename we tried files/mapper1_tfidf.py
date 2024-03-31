#!/usr/bin/env python3

import sys
import csv
import re

def mapper():

    csv_reader = csv.reader(sys.stdin)
    for row in csv_reader:
        if len(row) == 3:
            article_id, title, text = row

            print(f"{article_id}\t{title}\t{text}")

if __name__ == "__main__":
    mapper()
