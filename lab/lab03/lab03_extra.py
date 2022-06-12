""" Optional problems for Lab 3 """

from math import floor


def is_prime(n):
    """Returns True if n is a prime number and False otherwise.

    >>> is_prime(2)
    True
    >>> is_prime(16)
    False
    >>> is_prime(521)
    True
    """
    "*** YOUR CODE HERE ***"
    from math import sqrt
    cur = 2

    def helper(n, cur):
        if n == 2 or cur == floor(sqrt(n)):
            return True
        elif n % cur == 0:
            return False
        else:
            return helper(n, cur+1)
    return helper(n, cur)


def gcd(a, b):
    """Returns the greatest common divisor of a and b.
    Should be implemented using recursion.

    >>> gcd(34, 19)
    1
    >>> gcd(39, 91)
    13
    >>> gcd(20, 30)
    10
    >>> gcd(40, 40)
    40
    """
    "*** YOUR CODE HERE ***"
    if b == 0:
        return a
    return gcd(b, a % b)


def ten_pairs(n):
    """Return the number of ten-pairs within positive integer n.

    >>> ten_pairs(7823952)
    3
    >>> ten_pairs(55055)
    6
    >>> ten_pairs(9641469)
    6
    """
    "*** YOUR CODE HERE ***"
    cur = n % 10
    n //= 10
    if n == 0:
        return 0

    def helper(n, cur):
        cnt = 0
        while n != 0:
            if n % 10 == cur:
                cnt += 1
            n //= 10
        return cnt
    return helper(n, 10-cur)+ten_pairs(n)
