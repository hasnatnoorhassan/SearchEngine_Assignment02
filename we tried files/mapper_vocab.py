#!/usr/bin/env python3

import sys
import csv
import re

def tokenize_text(text):
    pattern = r'\b\w+\b'
    tokens = re.findall(pattern, text.lower())
    return tokens

def mapper():
    csv_reader = csv.reader(sys.stdin)
    for row in csv_reader:
        if len(row) == 3:
            article_id, title, text = row
            tokens = tokenize_text(text)
            for token in tokens:
                print(f"{token}\t{article_id}")

if __name__ == "__main__":
    mapper()

