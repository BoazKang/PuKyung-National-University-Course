import numpy as np

def numerical_gradient(f,x):
    h = 1e-4
    grad = np.zeros_like(x)
    if x.ndim == 2: 
        for i in range(grad.shape[0]):
            for j in range(grad.shape[1]):
                fx = f(x[i,j])
                tmp_val = x[i,j]
                x[i,j] = tmp_val + h
                fxh = f(x[i,j])
                grad[i,j] = (fxh - fx)/h
                x[i,j] = tmp_val
        return grad
    else:
        for i in range(x.size):
            tmp_val = x[i]
            x[i] = tmp_val + h
            fxh1 = f(x[i])
            x[i] = tmp_val - h
            fxh2 = f(x[i])
            grad[i] = (fxh1-fxh2)/2*h
            x[i] = tmp_val
        return grad