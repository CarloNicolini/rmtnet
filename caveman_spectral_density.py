import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sbn
from numpy.linalg import eigvals
from scipy import stats

nsamples=50
l=24
k=10
n=l*k

vs = np.array([0]*n)
for i in range(0,nsamples):
	G = nx.connected_caveman_graph(l,k)
	A = nx.to_numpy_matrix(G)
	v = np.real(eigvals(A))
	vs = vs + v

vs = vs/(nsamples*np.sqrt(n))

kde = stats.gaussian_kde(vs,bw_method='silverman')
x = np.linspace(vs.min(), vs.max(), 100)
rho = kde(x)

#plt.subplot(1,3,1)
plt.plot(x,rho)
plt.ylabel('Spectral density')
plt.xlabel('Eigenvalues')
plt.title('Caveman Model spectral density')
plt.show()