# Developing a Search Engine Utilising MapReduce
## Assignment # 02 Fundamentals of Big Data Analytics
### Hasnat Noor Hassan 22i2049 | Hamza Zahid 22i1974 | Umema Ashar 22i2036 | DSC

This repository contains an attemp to a basic approach to developing a Search Engine using MapReduce. It uses a a portion of the English Wikipedia dump
provided by Wikimedia, which includes around 5 million Wikipedia articles.

## Overview
This project implements a basic search engine using the MapReduce paradigm, focusing on document indexing and query processing. It utilizes the Vector Space Model (VSM) for information retrieval, specifically the TF/IDF (Term Frequency-Inverse Document Frequency) weighting scheme.

## Features
1. Document Indexing: Initiates tasks to analyze the corpus including Word Enumeration, Document Count, and Indexer using MapReduce.<br>
2. Query Processing: Utilizes Ranker Engine to create a vectorized representation of queries and conduct relevance analysis.<br>
3. Vector Space Model: Represents documents and queries as vectors, incorporating TF/IDF weights for relevance scoring.<br>
4. Sparse Vector Representation: Implements sparse vector representation using dictionaries (maps) for efficient storage and computation.<br>
5. Hash-Based Word Enumeration: Dynamically generates IDs for words using hash functions to eliminate the need for word enumeration during preprocessing.<br>

## Implementation
### Document Indexing
1. Word Enumeration: Scans the corpus, generates a set of unique words, and assigns a unique ID to each word using MapReduce.<br>
2. Document Count: Calculates the Inverse Document Frequency (IDF) for each term or the number of documents in which each term appears using MapReduce.<br>
3. Vocabulary: Consolidates the results of Word Enumeration and Document Count into a single data structure.<br>

### Indexer
Computes a machine-readable representation of the entire document corpus.
Generates a TF/IDF representation for each document and stores a tuple of (document ID, vector representation) using MapReduce.

### Ranker Engine
Query Vectorizer: Generates the vectorized representation of a query, integrated into the Relevance Analyzer component.<br>
Relevance Analyzer: Calculates the relevance function between the query and each document, potentially utilizing MapReduce.<br>
Content Extractor: Retrieves relevant content from the text corpus using the provided relevant IDs.<br>

## Usage
Indexing: Run the indexing process using Hadoop MapReduce on the text corpus.<br>
Query Processing: Enter user queries, which will be processed using the VSM and relevant documents will be retrieved.<br>

## Approach

### Clustering of Dataset using Microsoft Azure:
Utilize Microsoft Azure for clustering the dataset, organizing similar documents together for efficient processing.

### Vocabulary Generation:
Generate a vocabulary by parsing the clustered dataset, extracting unique words, and assigning them unique identifiers.

### TF/IDF Calculation and Filtering:
Calculate Term Frequency (TF) and Inverse Document Frequency (IDF) for each term in the vocabulary.
Filter out less relevant terms based on predetermined thresholds or statistical measures.

### Query Processing:
Tokenize user queries and match tokens with words in the vocabulary.
Calculate TF/IDF scores for query terms to determine their importance in the query.

### Document Parsing and Relevance Calculation:
Parse all documents to identify occurrences of query words.
Calculate relevance scores for each document based on the TF/IDF scores of query terms and their occurrences in the document.

### Top Document Retrieval:
Retrieve the top 5 documents in which the query words occur most frequently, based on their relevance scores.

## Contributors
Hasnat Noor Hassan 22i2049 | Hamza Zahid 22i1974 | Umema Ashar 22i2936 | DSC
