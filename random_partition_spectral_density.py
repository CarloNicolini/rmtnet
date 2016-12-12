import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sbn
from numpy.linalg import eigvals
from scipy import stats

nsamples=250

sizes = [50, 50, 50, 50]
p_in = 0.5
p_out= 0.5
n=sum(sizes)

vs = np.array([0]*n)
for i in range(0,nsamples):
	G = nx.random_partition_graph(sizes, p_in, p_out )
	A = nx.to_numpy_matrix(G)
	v = np.real(eigvals(A))
	vs = vs + v

vs = vs/(nsamples*np.sqrt(n))

kde = stats.gaussian_kde(vs,bw_method='silverman')
x = np.linspace(vs.min(), vs.max(), 100)
rho = kde(x)

#plt.subplot(1,3,1)
plt.plot(x,rho,'o-')
plt.plot(np.linspace(vs.min(),vs.max(),vs.shape[0]),vs,'o-r')
plt.ylabel('Spectral density')
plt.xlabel('Eigenvalues')
plt.title('Random partition spectral density')
plt.show()