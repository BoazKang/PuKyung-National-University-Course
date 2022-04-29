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
                
                
class MultiLayer:
    def __init__(self,input_size,hidden_size,output_size):
        self.input_size = input_size
        self.hidden_size = hidden_size
        self.output_size = output_size
        
        self.hidden_size.insert(0,self.input_size)
        self.hidden_size.append(self.output_size)
        self.W = {}
        for i in range(len(hidden_size)-1):
            w_key = 'W'+str(i+1)
            b_key = 'b'+str(i+1)
            self.W[w_key] = np.random.randn(hidden_size[i],hidden_size[i+1])
            self.W[b_key] = np.random.randn(hidden_size[i+1])
            
        self.layers = OrderedDict()
        
        for i in range(int(len(self.W)/2)-1):
            aff_key = 'Affine_'+str(i+1)
            relu_key = 'Relu_'+str(i+1)
            w_key = 'W'+str(i+1)
            b_key = 'b'+str(i+1)
            self.layers[aff_key] = Affine(self.W[w_key],self.W[b_key])
            self.layers[relu_key] = Relu()
        
        last_num = str(int(len(self.W)/2))
        self.layers['Affine_'+last_num] = Affine(self.W['W'+last_num],self.W['b'+last_num])
        self.Lastlayer = SoftmaxWithLoss()
        self.loss_val = []
        self.acc_val = []
    
    #def summary(self):
        
    
    def predict(self,x):
        for layer in self.layers.values():
            x = layer.forward(x)
        return x

    def loss(self,x,t):
        y = self.predict(x)
        loss = self.Lastlayer.forward(y,t)
        return loss

    def gradient(self,x,t):
        self.loss(x,t)
        dout = 1
        dout = self.Lastlayer.backward(dout)
        layers = list(self.layers.values())
        layers.reverse()
        for layer in layers:
            dout = layer.backward(dout)
        
        grads = {}
        layer_number = int(len(self.layers.keys())/2)

        
        # for i in range(int(len(self.W)/2)):
        #     w_key = 'W'+str(i+1)
        #     b_key = 'b'+str(i+1)
        #     aff_key = 'Affine_'+str(i+1)
        #     grads[w_key] = self.layers[aff_key].dW
        #     grads[b_key] = self.layers[aff_key].db
            
        for i in range(1,layer_number+2):
            grads['W'+str(i)] = self.layers['Affine'+str(i)].dW
            grads['b'+str(i)] = self.layers['Affine'+str(i)].db
            
        return grads
    
    def accuracy(self,x,t):
        y = np.argmax(self.predict(x),axis=1)
        t = np.argmax(t, axis=1)
        acc = np.sum(y==t)/y.size
        return acc
            
    
    def fit(self,epochs,batch_size,lr,x,t,x_val,t_val):
        if divmod(x.shape[0],batch_size)[1] > 0:
            batch = divmod(x.shape[0],batch_size)[0] + 1
        else:
            batch = divmod(x.shape[0],batch_size)[0]
        for epoch in range(epochs):
            if epoch == 0:
                start = 0
            end = start + batch_size
            if epoch == epochs-1 and divmod(x.shape[0],batch_size)[1] != 0:
                end = start+divmod(x.shape[0],batch_size)[1]
            x_tmp = x[start:end,:]
            t_tmp = t[start:end,:]
            start = end
            for i in range(batch):
                grads = self.gradient(x_tmp,t_tmp)
            for key in grads.keys():
                self.W[key] -=  lr*grads[key]
            if epoch % 20 == 0:
                print(f"epoch {epoch}:val_loss==========={np.round(self.loss(x_val,t_val),4)}, val_acc:========{np.round(self.accuracy(x_val,t_val),4)*100}%")
                self.loss_val.append(self.loss(x_val,t_val))
                self.acc_val.append(self.accuracy(x_val,t_val))
                
    def fit_gd(self,epochs,lr,x,t,x_val,t_val):
        for epoch in range(epochs):
            grads = self.gradient(x,t)
            for key in grads.keys():
                self.W[key] -= lr*grads[key]
            if epoch % 20 == 0:
                print(f"epoch {epoch}:val_loss==========={np.round(self.loss(x_val,t_val),4)}, val_acc:========{np.round(self.accuracy(x_val,t_val),4)*100}%")
                self.loss_val.append(self.loss(x_val,t_val))
                self.acc_val.append(self.accuracy(x_val,t_val))
                
                
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
