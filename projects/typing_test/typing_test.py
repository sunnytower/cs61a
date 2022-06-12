""" Typing Test implementation """

from os import remove
from tracemalloc import start
from utils import *
from ucb import main

# BEGIN Q1-5
"*** YOUR CODE HERE ***"


def lines_from_file(path):
    lst = []
    file = open(path)
    if(readable(file)):
        lst += readlines(file)
        for i in range(len(lst)):
            lst[i] = strip(lst[i])
    close(file)
    return lst


def new_sample(path, i):
    lst = lines_from_file(path)
    return lst[i]


def analyze(sample_paragraph, typed_string, start_time, end_time):
    def words_per_minute():
        return len(typed_string)*60/5/(end_time-start_time)

    def accuracy_percentage():
        lst1, lst2 = split(sample_paragraph), split(typed_string)
        if len(lst2) == 0:
            return 0.0
        cnt = 0
        lst = min(len(lst1), len(lst2))
        for i in range(lst):
            if lst1[i] == lst2[i]:
                cnt += 1
        return cnt/lst*100
    return [words_per_minute(), accuracy_percentage()]


def pig_latin(s):
    i = 0
    while i < len(s):
        if lower(s)[i] in "aeiou":
            break
        i += 1
    if i == 0:
        return s + "way"
    else:
        return s[i:]+s[:i]+"ay"


def autocorrect(user_input, words_list, score_function):
    if user_input in words_list:
        return user_input
    return min(words_list, key=lambda x: score_function(user_input, x))
    # END Q1-5


def swap_score(s1, s2):
    if s1 == '' or s2 == '':
        return 0
    elif s1[0] == s2[0]:
        return swap_score(s1[1:], s2[1:])
    else:
        return 1+swap_score(s1[1:], s2[1:])

        # Question 6


def score_function(word1, word2):
    """A score_function that computes the edit distance between word1 and word2."""

    if word1 in word2 or word2 in word1:  # Fill in the condition
        # BEGIN Q6
        "*** YOUR CODE HERE ***"
        return abs(len(word1)-len(word2))
        # END Q6

    elif word1[0] == word2[0]:  # Feel free to remove or add additional cases
        # BEGIN Q6
        "*** YOUR CODE HERE ***"
        return score_function(word1[1:], word2[1:])
        # END Q6

    else:
        # Fill in these lines
        add_char = 1 + score_function(word2[0]+word1, word2)
        remove_char = 1 + score_function(word1[1:], word2)
        substitute_char = 1+score_function(word1[1:], word2[1:])
        # BEGIN Q6
        "*** YOUR CODE HERE ***"
        return min(add_char, remove_char, substitute_char)
        # END Q6


KEY_DISTANCES = get_key_distances()


def score_function_accurate(word1, word2):
    if word1 in word2 or word2 in word1:
        return abs(len(word1)-len(word2))
    elif word1[0] == word2[0]:
        return score_function_accurate(word1[1:], word2[1:])
    else:
        add_char = 1 + score_function_accurate(word2[0]+word1, word2)
        remove_char = 1 + score_function_accurate(word1[1:], word2)
        substitute_char = KEY_DISTANCES[word1[0], word2[0]
                                        ]+score_function_accurate(word1[1:], word2[1:])
        return min(add_char, remove_char, substitute_char)


def memo(f):
    d = {}

    def real_memo(word1, word2):
        if (word1, word2) in d:
            return d[word1, word2]
        else:
            d[word1, word2] = f(word1, word2)
            return d[word1, word2]
    return real_memo


# accurate is a recursive function,so to use dict in function memo, you have to redirect accurate function point to real_memo in global funciton
score_function_accurate = memo(score_function_accurate)
score_function_final = score_function_accurate


# BEGIN Q7-8
"*** YOUR CODE HERE ***"
# END Q7-8
