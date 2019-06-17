import digdag


def set():
    digdag.env.store({"sample_value": 1})


def get():
    print("value: %s" % digdag.env.params["sample_value"])


def args(arg1, arg2=None):
    print("arg1: " + str(arg1))
    print("arg2: " + str(arg2))


def export(p1):
    print(p1)
    print(p1['sample-key'])
