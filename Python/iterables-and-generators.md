# Iterators vs Iterables vs Generators

An **iterable** is an object that has an `__iter__` method which returns an **iterator**.

An **iterator** is an object that has a `__next__` method which returns the next item in the sequence. If there are no more items in the sequence, it should raise a `StopIteration` exception.

A **generator** is an iterator that can be used only once. This means that once a generator has been iterated over, it cannot be iterated over again. This is because generators do not store all the values in memory, they generate the values on the fly. This is also called lazy evaluation.

```python
# This is an iterable
class MyIterable:
    def __init__(self, n):
        self.n = n

    def __iter__(self):
        return MyIterator(self.n)

# This is an iterator
class MyIterator:
    def __init__(self, n):
        self.n = n
        self.i = 0

    def __next__(self):
        if self.i < self.n:
            i = self.i
            self.i += 1
            return i
        else:
            raise StopIteration

# This is a generator
def my_generator(n):
    i = 0
    while i < n:
        yield i
        i += 1

# This is how we use them
for i in MyIterable(5):
    print(i) # 0 1 2 3 4

for i in my_generator(5):
    print(i) # 0 1 2 3 4
```