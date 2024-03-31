#!/usr/bin/env python3


import sys
import re

def tokenize_text(text):
    pattern = r'\b\w+\b'
    tokens = re.findall(pattern, text.lower())
    return tokens

def reducer():
    vocabulary = {}
    article_terms = {}
    term_article_count = {} 

    for line in sys.stdin:
        article_id, title, text = line.strip().split('\t')
        tokens = tokenize_text(text)

        unique_terms_in_article = set() 

        for token in tokens:
            if token not in vocabulary:
                vocabulary[token] = len(vocabulary) 
            term_id = vocabulary[token]

            unique_terms_in_article.add(term_id)

            if article_id not in article_terms:
                article_terms[article_id] = {}

            if term_id in article_terms[article_id]:
                article_terms[article_id][term_id] += 1
            else:
                article_terms[article_id][term_id] = 1

        for term_id in unique_terms_in_article:
            if term_id in term_article_count:
                term_article_count[term_id] += 1
            else:
                term_article_count[term_id] = 1

    for article_id, terms in article_terms.items():
        term_freqs = []
        for term_id in vocabulary.values():
            freq = terms.get(term_id, 0)  
            if freq > 0:
                num_articles_term_appeared_in = term_article_count.get(term_id, 0)
                normalized_freq = freq / num_articles_term_appeared_in
                term_freqs.append((term_id, normalized_freq))
        output = f"{article_id}:[{','.join(f'({term_id},{normalized_freq})' for term_id, normalized_freq in term_freqs)}]"
        print(output)


if __name__ == "__main__":
    reducer()

