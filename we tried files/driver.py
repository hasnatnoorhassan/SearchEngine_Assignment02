#!/usr/bin/env python3

import sys
import subprocess
import string

def run_mapreduce_job(input_path, input_hadoop, output_path, mapper_path, reducer_path):
    # Run the MapReduce job
    cm=[
        "hadoop",
        "fs",
        "-put",
        input_path,
        input_hadoop,
    ]
    subprocess.run(cm)
    cmd = [
        "hadoop",
        "jar",
        "/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar",
        "-input",
        input_hadoop,
        "-output",
        output_path,
        "-mapper",
        "mapper.py",
        "-reducer",
        "reducer.py",
        "-file",
        mapper_path,
        "-file",
        reducer_path
    ]
    subprocess.run(cmd)


def preprocessedquery(text_query):
    custom_stopwords = set(["the", "a", "an", "is", "are", "was", "were", "be", "been", "being",
                        "to", "of", "for", "with", "on", "at", "in", "by", "about", "into",
                        "through", "during", "before", "after", "above", "below", "over",
                        "under", "between", "among", "from", "and", "or", "but", "so", "if",
                        "because", "although", "though", "while", "when", "where", "how", "what",
                        "which", "who", "whom", "whose", "why", "then", "there", "here", "thus",
                        "hence", "therefore", "however", "nevertheless", "moreover", "furthermore",
                        "consequently", "as", "so", "if", "unless", "until", "while", "since", "because",
                        "though", "although", "even", "once", "since", "whether", "either", "neither",
                        "both", "each", "every", "any", "all", "some", "few", "many", "several", "most",
                        "such", "what", "which", "whose", "who", "whom", "where", "when", "why", "how",
                        "there", "here", "this", "that", "these", "those", "one", "two", "three", "four",
                        "five", "first", "second", "third", "last", "next", "every", "all", "some", "few",
                        "most", "several", "more", "less", "much", "many", "little", "fewer", "fewest",
                        "most", "almost", "enough", "too", "so", "very", "just", "only", "even", "still",
                        "already", "much", "quite", "such", "too", "very", "again", "almost", "just",
                        "once", "twice", "three", "time", "somebody", "someone", "something", "somewhere",
                        "anybody", "anyone", "anything", "anywhere", "nobody", "no one", "nothing",
                        "nowhere", "everybody", "everyone", "everything", "everywhere"])

    text = text_query.translate(str.maketrans('', '', string.punctuation))
    words = text.split()
    filtered_words = [word for word in words if word.lower() not in custom_stopwords]
    return filtered_words


def query_vector(new_file_path,input_path,vocabularypath, preprocess_text):
    vocabulary = {}
    term_freq = {}
    words = preprocess_text.split(' ')
    with open(vocabularypath, 'r') as file:
        for line in file:
            line_words = line.strip().split('\t')
            term, term_id, count = line_words[0], line_words[1], int(line_words[2])
            vocabulary[term] = (term_id, count)
    for word in words:
        if word in term_freq:
            term_freq[word] += 1
        else:
            term_freq[word] = 1
    queryvectorlist=[]
    for word, freq in term_freq.items():

        if word in vocabulary:
            term_id, vocab_count = vocabulary[word]
            ratio = freq / vocab_count
            tuple1=(term_id,ratio)
            queryvectorlist.append(tuple1)
    print(queryvectorlist)
    with open(input_path, 'r') as input_file, open(new_file_path, 'w') as output_file:
      for line in input_file:
          output_file.write(str(queryvectorlist) + "\t" +  line)


def main(input_path, input_hadoop,output_path, mapper_path, reducer_path):
    run_mapreduce_job(input_path,input_hadoop, output_path, mapper_path, reducer_path)
        

if __name__ == "__main__":
    if len(sys.argv) != 7:
        print("Usage: pagerank_driver.py <input_path> <input_hadoop> <input_path2> <output_path> <mapper_path> <reducer_path> <query_text>")
        sys.exit(1)
    input_path = sys.argv[1]
    input_hadoop = sys.argv[2]
    vocab_path=sys.argv[3]
    output_path = sys.argv[4]
    mapper_path = sys.argv[5]
    reducer_path = sys.argv[6]
    query_text = sys.argv[7]

    #run all functions normal py here 
    PreprocessedQuery = preprocessedquery(query_text)
    print(PreprocessedQuery)
    new_file_path="new_input.txt"
    query_vector(new_file_path,input_path,vocab_path, ' '.join(PreprocessedQuery))
    input_path = new_file_path

    main(input_path,input_hadoop, output_path, mapper_path, reducer_path)


#python3 driver.py sample1.csv /inputs/input.txt vocabulary.txt /input/output_2 /home/hamza/mapper.py /home/hamza/reducer.py "this is query anarchy autism something aa autistic"
