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
    article_titles = {}

    query_terms = set()

    for line in sys.stdin:
        article_id, title, text = line.strip().split('\t')

        if article_id == '-1':
            tokens = tokenize_text(text)
            for token in tokens:
                query_terms.add(token)

        tokens = tokenize_text(text)

        for token in tokens:
            if token not in vocabulary:
                vocabulary[token] = len(vocabulary)

            term_id = vocabulary[token]

            if article_id not in article_terms:
                article_terms[article_id] = {}

            if term_id in article_terms[article_id]:
                article_terms[article_id][term_id] += 1
            else:
                article_terms[article_id][term_id] = 1

            if term_id not in term_article_count:
                term_article_count[term_id] = 1
            else:
                term_article_count[term_id] += 1

            article_titles[article_id] = title

    tf_idf_vectors = {}
    for article_id, terms in article_terms.items():
        tf_idf_vector = {}
        for term, term_id in vocabulary.items():
            freq = terms.get(vocabulary.get(term, -1), 0)
            if freq > 0:
                num_articles_term_appeared_in = term_article_count.get(vocabulary.get(term, -1), 0)
                normalized_freq = freq / num_articles_term_appeared_in
                tf_idf_vector[term] = normalized_freq
        tf_idf_vectors[article_id] = tf_idf_vector

    query_tf_idf_vector = tf_idf_vectors['-1']

    dot_products = []
    for article_id, tf_idf_vector in tf_idf_vectors.items():
        if article_id != '-1':
            dot_product = sum(query_tf_idf_vector.get(term, 0) * tf_idf_vector.get(term, 0) for term in query_terms)
            dot_products.append((article_id, dot_product))

    dot_products.sort(key=lambda x: x[1], reverse=True)

    for article_id, dot_product in dot_products:
        print(f"{article_titles[article_id]} ({article_id}): {dot_product}")

if __name__ == "__main__":
    reducer()
