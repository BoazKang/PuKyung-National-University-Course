import numpy as np
from loss import *
from activation import *
from gradient import numerical_gradient

class TwoLayerNet:
    def __init__(self,input_size,hidden_size,output_size):
        self.W = {}
        self.W['W1'] = np.random.randn(input_size,hidden_size)
        self.W['b1'] = np.random.randn(hidden_size)
        self.W['W2'] = np.random.randn(hidden_size, output_size)
        self.W['b2'] = np.random.randn(output_size)
        self.loss_val = []
    
    def predict(self,x):
        W1 = self.W['W1']
        W2 = self.W['W2']
        b1 = self.W['b1']
        b2 = self.W['b2']
        
        a1 = np.dot(x,W1) + b1 # 출력값
        z1 = relu(a1)
        a2 = np.dot(z1,W2) + b2
        out = softmax(a2)        
        return out
    
    def loss(self,x,t):
        y = self.predict(x)
        loss = cross_entropy_error(y,t)
        return loss

    def numerical_gradient(self,x,t):
        f = lambda W : self.loss(x,t)
        grads = {}
        grads['W1'] = numerical_gradient(f, self.W['W1']) # 밖에서 만든 numerical_gradient함수
        grads['b1'] = numerical_gradient(f, self.W['b1'])
        grads['W2'] = numerical_gradient(f, self.W['W2'])
        grads['b2'] = numerical_gradient(f, self.W['b2'])
        return grads
    
    # def gradient_descent(self,epochs):
    
    def accuracy(self,x,t):
        y = self.predict(x)
        y = np.argmax(y, axis=1)
        t = np.argmax(t, axis=1)
        acc = sum(y == t)/x.shape[0]
        return acc
    
    def train(self,epochs,learning_rate,x,t):
        for epoch in range(epochs):
            grads = self.numerical_gradient(x,t)
            for key in grads.keys():
                self.W[key] -= learning_rate*grads[key]
            # print(f'epoch:{epoch}, accuracy:{self.accuracy(x,t)}, loss:{self.loss(x,t)}')
            self.loss_val.append(self.loss(x,t))