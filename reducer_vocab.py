#!/usr/bin/env python3

import sys

def reducer():
    current_token = None
    articles = set()
    index = 0
    vocabulary = {}

    for line in sys.stdin:
        token, article_id = line.strip().split('\t', 1)
        
        if current_token == token:
            articles.add(article_id)
        else:
            if current_token:
                vocabulary[current_token] = (index, articles)
                index += 1
            current_token = token
            articles = set([article_id])

    if current_token:
        vocabulary[current_token] = (index, articles)

    sorted_vocabulary = sorted(vocabulary.items(), key=lambda x: x[0])
    for token, (index, articles) in sorted_vocabulary:
        #article_list = ','.join(sorted(articles))
        article_len=len(articles)
        print(f"{token}\t{index}\t{article_len}")

if __name__ == "__main__":
    reducer()
