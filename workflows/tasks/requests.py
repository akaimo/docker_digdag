import digdag
import requests


def req():
    url = "https://www.google.com"
    respose = requests.get(url)
    print(respose)
