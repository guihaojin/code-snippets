import fire
# import requests
from sklearn.feature_extraction.text import TfidfVectorizer
from scipy.spatial.distance import cosine
import json

# DATA_URL = 'https://s3-us-west-1.amazonaws.com/buddyai-interview-materials/qa_list.json'

# qa_list = requests.get(DATA_URL).json()

with open('data.json') as data_file:
    qa_list = json.load(data_file)

class TfIdfModel(object):
    def __init__(self, qa_list):
        self.qa_list = qa_list
        corpus = []
        for qa in qa_list:
            corpus.append(qa['_question'].replace('?', ''))
        self.vectorizer = TfidfVectorizer(min_df=1)
        self.corpus_tfidf = self.vectorizer.fit_transform(corpus)

    def get_tfidf(self, question):
        return self.vectorizer.transform([question])

    @staticmethod
    def _get_similarity_helper(v1, v2):
        return 1.0 - cosine(v1.toarray(), v2.toarray())

    def get_most_similar(self, question):
        most_similar = 0
        most_similar_i = -1
        for i in xrange(self.corpus_tfidf.shape[0]):
            s = self._get_similarity_helper(self.corpus_tfidf[i], self.get_tfidf(question))
            if s > most_similar:
                most_similar = s
                most_similar_i = i
        print 'similarity: %s, position: %s' % (most_similar, most_similar_i)
        return most_similar, most_similar_i

    def get_answer(self, question):
        question = question.replace('?', '')
        similarity, pos = self.get_most_similar(question)
        if pos == -1:
            return None
        else:
            return self.qa_list[pos]['answer']

tfidf_model = TfIdfModel(qa_list)

def chatbot(question, model='tfidf'):
    if model == 'tfidf':
        print tfidf_model.get_answer(question)
    elif model == 'cls':
        print 'Not implemented yet, stay tuned.'
    else:
        print 'Invalid model, exit.'

if __name__ == '__main__':
    while True:
        test_question = raw_input('test data: ')
        chatbot(test_question)
