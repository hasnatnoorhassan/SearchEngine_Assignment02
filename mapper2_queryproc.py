import sys

def mapper():
    vocab = {}
    for line in sys.stdin:
        word, token, count = line.strip().split()
        vocab[word] = (token, count)

    query_data = {
        'QUERY_ID': ['0'],
        'TITLE': ['query'],
        'FULL_TEXT': ['tell me something about anarchy']
    }

    for word in query_data['FULL_TEXT'][0].split():
        if word in vocab:
            print(word + '\t' + vocab[word][0] + '\t' + vocab[word][1])

if __name__ == "__main__":
    mapper()
