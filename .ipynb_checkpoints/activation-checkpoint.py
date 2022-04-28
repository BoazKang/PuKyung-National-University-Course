import numpy as np

# activation function

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def softmax(x):
    x = x - np.max(x, axis=1).reshape(-1,1)
    return np.exp(x) / np.sum(np.exp(x), axis=1).reshape(-1,1)

def relu(x):
    return np.maximum(0,x)