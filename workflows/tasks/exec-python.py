import digdag
import sys
import os

sys.path.append(os.path.join(os.path.dirname(__file__), '.'))

import func


def version():
    print(sys.version)


def date():
    func.date()
