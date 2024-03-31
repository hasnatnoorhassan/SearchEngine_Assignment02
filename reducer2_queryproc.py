import sys

def read_input(file):
    for line in file:
        yield line.strip().split('\t')

def reducer():
    current_word = None
    word_count = 0

    for line in sys.stdin:
        word, token, count = line.strip().split('\t')

        if current_word == word:
            word_count += int(count)
        else:
            if current_word:
                print(current_word + '\t' + token + '\t' + str(word_count))
            current_word = word
            word_count = int(count)

    if current_word:
        print(current_word + '\t' + token + '\t' + str(word_count))

if __name__ == "__main__":
    reducer()
