"""
See the book Mathias Dehmer,
"Mathematical Foundations and Applications of Graph Entropy"
Chapter 6 Statistical Methods in Graphs: Parameter Estimation, Model Selection, and Hypothesis Test
"""
import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sbn
from numpy.linalg import eigvals
from scipy import stats

# Generate 100 ER random graphs with the Erdos-Renyi model 
# and compute their eigenvalues mean
n = 50
p = 0.007
nsamples = 5

vs = np.array([0]*n)
for i in range(0,nsamples):
	G = nx.gnp_random_graph(n,p)
	A = nx.to_numpy_matrix(G)
	v = np.real(eigvals(A))
	vs = vs + v

vs = vs/(nsamples*np.sqrt(n))

kde = stats.gaussian_kde(vs,bw_method='silverman')
x = np.linspace(vs.min(), vs.max(), 100)
rho = kde(x)

plt.subplot(1,3,1)
plt.plot(x,rho)
plt.ylabel('Spectral density')
plt.xlabel('Eigenvalues')
plt.title('ER Model spectral density')

plt.savefig('spectral_densities.pdf')

# Generate 100 samples of Barabasi-Albert with n=500 nodes and
# m=p*n*(n-1)/2 and compute their spectral density
m = p*n*(n-1)/2
vs = np.array([0]*n)
for i in range(0,nsamples):
	G = nx.barabasi_albert_graph(n,int(m))
	A = nx.to_numpy_matrix(G)
	v = np.real(eigvals(A))
	vs = vs + v

vs = vs/(nsamples*np.sqrt(n))

kde = stats.gaussian_kde(vs,bw_method='silverman')
x = np.linspace(vs.min(), vs.max(), 100)
rho = kde(x)

plt.subplot(1,3,2)
plt.plot(x,rho)
plt.ylabel('Spectral density')
plt.xlabel('Eigenvalues')
plt.title('BA Model spectral density')


# Compute the spectral entropy of ER model at various p
nsamplesp=50
ps=np.linspace(0.01,0.99,nsamplesp)
spect_ent=np.array([0]*nsamplesp)
for j,p in enumerate(ps):
	vs = np.array([0]*n)
	for i in range(0,nsamples):
		G = nx.gnp_random_graph(n,p)
		A = nx.to_numpy_matrix(G)
		v = np.real(eigvals(A))
		vs = vs + v
	vs = vs/(nsamples*np.sqrt(n))
	kde = stats.gaussian_kde(vs,bw_method='silverman')
	x = np.linspace(vs.min(), vs.max(), 100)
	rho = kde(x)
	spect_ent[j] = -np.sum(rho*np.log(rho))

plt.subplot(1,3,3)
plt.plot(ps,spect_ent)
plt.plot(ps,0.5*np.log((4*np.pi**2)*ps*(1-ps))-0.5,'r')
plt.xlabel('p')
plt.ylabel('Spectral Entropy')
plt.show()

plt.subplot(1,3,3)

plt.savefig('spectral_densities.pdf')