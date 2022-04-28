import numpy as np
from loss import *
from activation import *
from gradient import *
from collections import OrderedDict

class OneLayerNet:
    def __init__(self, input_size, output_size):
        self.W = {}
        self.W['W1'] = np.random.randn(input_size,output_size)
        self.W['b'] = np.random.randn(output_size)
        
    def predict(self,x):
        W1, b = self.W['W1'], self.W['b']
        pred = softmax(np.dot(x,W1) + b)
        return pred
    
    def loss(self,x,t):
        y = self.predict(x)
        return cross_entropy_error(y,t)
    
    def numerical_gradient(self,x,t):
        y = self.predict(x)
        f = lambda W : cross_entropy_error(y,t)
        grad = {}
        grad['W1'] = numerical_gradient(f, self.W['W1'])
        grad['b'] = numerical_gradient(f, self.W['b'])
        return grad
    
    def accuracy(self,x,t):
        y = self.predict(x)
        acc = np.sum(np.argmax(y, axis=1) == np.argmax(t, axis=1)) / y.shape[0]
        return acc
    
    def fit(self,x,t,epochs=1000,lr=1e-3,verbos=1):
        for epoch in range(epochs):
            self.W['W1'] -= lr*self.numerical_gradient(x,t)['W1']
            self.W['b'] -= lr*self.numerical_gradient(x,t)['b']
            if verbos == 1:
                print(f'epoch: {epoch}, loss: {self.loss(x,t)}, acc: {self.accuracy(x,t)}')
                
                
class TwoLayerNet:
    def __init__(self,input_size,hidden_size,output_size):
        self.W = {}
        self.W['W1'] = np.random.randn(input_size,hidden_size)
        self.W['b1'] = np.random.randn(hidden_size)
        self.W['W2'] = np.random.randn(hidden_size, output_size)
        self.W['b2'] = np.random.randn(output_size)
        self.acc_val = []
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
    
    def fit(self,x,t,epochs=1000,lr=1e-3,verbos=1):
        for epoch in range(epochs):
            grads = self.numerical_gradient(x,t)
            for key in grads.keys():
                self.W[key] -= lr*grads[key]
            
            self.acc_val.append(self.accuracy(x,t))
            self.loss_val.append(self.loss(x,t))
            if verbos == 1:
                print(f'epoch:{epoch}, acc:{self.accuracy(x,t)}, loss:{self.loss(x,t)}')
                
                
class ThreeLayerNet:
    def __init__(self,input_size,hidden_size1,hidden_size2,output_size):
        self.layer = {}
        self.layer['W1'] = np.random.randn(input_size,hidden_size1)
        self.layer['b1'] = np.random.randn(hidden_size1)
        self.layer['W2'] = np.random.randn(hidden_size1,hidden_size2)
        self.layer['b2'] = np.random.randn(hidden_size2)
        self.layer['W3'] = np.random.randn(hidden_size2,output_size)
        self.layer['b3'] = np.random.randn(output_size)
        
        self.acc_val = []
        self.loss_val = []
        
    def predict(self,x):
        W1,W2,W3 = self.layer['W1'], self.layer['W2'], self.layer['W3']
        b1,b2,b3 = self.layer['b1'], self.layer['b2'], self.layer['b3']
        
        l1 = np.dot(x,W1) + b1
        a1 = relu(l1)
        l2 = np.dot(a1,W2) + b2
        a2 = relu(l2)
        l3 = np.dot(a2,W3) + b3
        out = softmax(l3)
        return out
    
    def loss(self,x,t):
        y = self.predict(x)
        loss = cross_entropy_error(y,t)
        return loss
    
    def numerical_gradient(self,x,t):
        f = lambda W : self.loss(x,t)
        grads = {}
        grads['W1'] = numerical_gradient(f,self.layer['W1'])
        grads['b1'] = numerical_gradient(f,self.layer['b1'])
        grads['W2'] = numerical_gradient(f,self.layer['W2'])
        grads['b2'] = numerical_gradient(f,self.layer['b2'])
        grads['W3'] = numerical_gradient(f,self.layer['W3'])
        grads['b3'] = numerical_gradient(f,self.layer['b3'])
        return grads
    
    def accuracy(self,x,t):
        y = self.predict(x)
        y = np.argmax(y, axis=1)
        t = np.argmax(t, axis=1)
        acc = sum(y == t)/x.shape[0]
        return acc
    
    def fit(self,x,t,epochs=1000,lr=1e-3,verbos=1):
        for epoch in range(epochs):
            grads = self.numerical_gradient(x,t)
            for key in grads.keys():
                self.layer[key] -= lr*grads[key]
            
            self.acc_val.append(self.accuracy(x,t))
            self.loss_val.append(self.loss(x,t))
            if verbos == 1:
                print(f'epoch:{epoch}, acc:{self.accuracy(x,t)}, loss:{self.loss(x,t)}')
                
                
class MultiLayerNet:
    def __init__(self,input_size,hidden_size,output_size):
        hidden_size.append(output_size)
        self.W = {}
        self.W['Input'] = np.random.randn(input_size,hidden_size[0])
        self.W['Input_b'] = np.random.randn(hidden_size[0])
        for i in range(len(hidden_size)-1):
            w = 'W'+str(i)
            b = 'b'+str(i)
            self.W[w] = np.random.randn(hidden_size[i],hidden_size[i+1])
            self.W[b] = np.random.randn(hidden_size[i+1])
            
    def predict(self,x):
        j=0
        for i in range(len(self.W)):
            if j % 2 == 0 and i < (len(self.W)-1):
                x = relu(np.dot(x,self.W[list(self.W.keys())[i]]) + self.W[list(self.W.keys())[i+1]])
            elif j % 2 == 0 and i >= (len(self.W)-1):
                x = (np.dot(x,self.W[list(self.W.keys())[i]]) + self.W[list(self.W.keys())[i+1]])
            j+=1
        return softmax(x)
    
    def loss(self,x,t):
        y = self.predict(x)
        return cross_entropy_error(y,t)
    
    def numerical_gradient(self,x,t):
        f = lambda W: self.loss(x,t)
        grads = {}
        for key in self.W.keys():
            grads[key] = numerical_gradient(f,self.W[key])
        return grads
    
    def accuracy(self,x,t):
        y = np.argmax(self.predict(x),axis=1)
        t = np.argmax(t, axis=1)
        acc = np.sum(y==t)/y.size
        return acc
    
    def fit(self,x,t,epochs=1000,lr=1e-3,verbos=1):
        for epoch in range(epochs):
            for key in self.W.keys():
                self.W[key] -= lr*self.numerical_gradient(x,t)[key]
            if verbos == 1:
                print(epoch,":epoch============== accuracy: ",self.accuracy(x,t),"==========loss :", self.loss(x,t))
                
                
class Relu:
    def __init__(self):
        self.mask = None
        
    def forward(self,x):
        self.mask = (x <= 0)
        out = x.copy()
        out[self.mask] = 0
        return out
    
    def backward(self,dout):
        dout[self.mask] = 0
        dx = dout
        return dx
    
    
class Sigmoid:
    def __init__(self):
        self.out = None
        
    def forward(self,x):
        out = 1 / (1+np.exp(-x))
        self.out = out
        return out
    
    def backward(self,dout):
        dx = dout*self.out*(1-self.out)
        return dx
    
    
class Affine:
    def __init__(self,W,b):
        self.W = W
        self.b = b
        self.x = None
        self.dW = None
        self.db = None
        
    def forward(self,x):
        self.x = x
        out = np.dot(x,self.W) + self.b
        return out
    
    def backward(self,dout):
        dx = np.dot(dout, self.W.T)
        self.dW = np.dot(self.x.T,dout)
        self.db = np.sum(dout,axis=0)
        return dx
    
    
class SoftmaxWithLoss:
    def __init__(self):
        self.loss = None
        self.y = None
        self.t = None
    
    def forward(self,x,t):
        self.y = softmax(x)
        self.t = t
        self.loss = cross_entropy_error(self.y,self.t)
        return self.loss
    
    def backward(self,dout=1):
        dx = dout*(self.y - self.t) / self.y.shape[0]
        return dx
    
    
class TwoLayerNet2:
    def __init__(self,input_size,hidden_size,output_size):
        self.W = {}
        self.W['W1'] = np.random.randn(input_size,hidden_size)
        self.W['b1'] = np.random.randn(hidden_size)
        self.W['W2'] = np.random.randn(hidden_size, output_size)
        self.W['b2'] = np.random.randn(output_size)
        
        self.acc_val = []
        self.loss_val = []
        
        self.layers = OrderedDict()
        self.layers['Affine1'] = Affine(self.W['W1'],self.W['b1'])
        self.layers['Relu1'] = Relu()
        self.layers['Affine2'] = Affine(self.W['W2'],self.W['b2'])
        
        self.lastLayer = SoftmaxWithLoss()
    
    def predict(self,x):
        for layer in self.layers.values():
            x = layer.forward(x)
        return x
    
    def loss(self,x,t):
        y = self.predict(x)
        loss = self.lastLayer.forward(y,t)
        return loss

    def numerical_gradient(self,x,t):
        f = lambda W : self.loss(x,t)
        grads = {}
        grads['W1'] = numerical_gradient(f, self.W['W1'])
        grads['b1'] = numerical_gradient(f, self.W['b1'])
        grads['W2'] = numerical_gradient(f, self.W['W2'])
        grads['b2'] = numerical_gradient(f, self.W['b2'])
        return grads
    
    def gradient(self,x,t):
        self.loss(x,t)
        dout = 1
        dout = self.lastLayer.backward(dout)
        layers = list(self.layers.values())
        layers.reverse()
        for layer in layers:
            dout = layer.backward(dout)
            
        grads = {}
        grads['W1'] = self.layers['Affine1'].dW
        grads['b1'] = self.layers['Affine1'].db
        grads['W2'] = self.layers['Affine2'].dW
        grads['b2'] = self.layers['Affine2'].db
        
        return grads
        
    def accuracy(self,x,t):
        y = self.predict(x)
        y = np.argmax(y, axis=1)
        t = np.argmax(t, axis=1)
        acc = sum(y == t)/x.shape[0]
        return acc
    
    def fit(self,x,t,epochs=1000,lr=1e-3,verbos=1):
        for epoch in range(epochs):
            grads = self.gradient(x,t)
            self.W['W1'] -= lr * grads['W1']
            self.W['b1'] -= lr * grads['b1']
            self.W['W2'] -= lr * grads['W2']
            self.W['b2'] -= lr * grads['b2']
            
            self.loss_val.append(self.loss(x,t))
            self.acc_val.append(self.accuracy(x,t))
            if verbos == 1:
                print(f'epoch:{epoch}, acc:{np.round(self.accuracy(x,t),2)}, loss:{self.loss(x,t)}')
