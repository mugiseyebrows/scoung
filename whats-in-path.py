import os

for path in os.environ['PATH'].split(';'):
    try:
        for n in os.listdir(path):
            if os.path.splitext(n)[1].lower() == '.exe':
                print(os.path.join(path, n))
    except FileNotFoundError:
        pass