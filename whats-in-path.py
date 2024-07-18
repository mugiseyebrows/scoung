import os
import argparse


def withdot(ext):
    if not ext.startswith('.'):
        return '.' + ext
    return ext

parser = argparse.ArgumentParser()
parser.add_argument("-e", "--ext", nargs = '+')
args = parser.parse_args()
exts = [withdot(ext).lower() for ext in args.ext]

for path in os.environ['PATH'].split(';'):
    try:
        for n in os.listdir(path):
            if os.path.splitext(n)[1].lower() in exts:
                print(os.path.join(path, n))
    except FileNotFoundError:
        pass