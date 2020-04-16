import os
with open('dumps/gost.sql', 'r') as filename:
    for line in reversed(filename):
        print(line.rstrip())