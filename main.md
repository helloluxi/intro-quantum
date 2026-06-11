# A Glimpse of Quantum Computing: Metrology, Signal Processing, and Simulation

\subtitle{Luca Lu}
\subsubtitle{DevTech Engineer, NVIDIA}
\today{en-US}
\graphicspath{fig}



## About Me

\columns[7fr 4fr]
- \strong{2017-2021}: B.Sc. in Applied Mathematics (minor in Physics), Zhejiang University, China
  - Majorana stellar representation.
- \strong{2021-2025}: Ph.D. in Applied Mathematics, Zhejiang University, China
  - Quantum amplitude estimation.
- \strong{Sep 2023-Dec 2023}: Visiting scholar, University of Pavia, Italy
  - Global quantum metrology.
- \strong{Aug 2024-Aug 2025}: Visiting scholar, North Carolina State University, USA
  - Quantum signal processing;
  - Qubit simulation of hybrid oscillator-qubit systems.
\column
\figure{me.jpeg}{}
\endcolumn



## Schrödinger's Cat & Equation

\row
\figure[0.8]{cat.jpg}{}
\endrow


## Qubits

\row
\figure[.36]{cbit.svg}{Classical bit}
&nbsp;
\figure[.36]{qbit.svg}{Quantum bit (qubit)}
\endrow



## Quantum Entanglement

\columns
In an $n$-qubit system, a state is usually written as
$$
\ket{\psi} = c_0 \ket{00\ldots0} + c_1 \ket{00\ldots1} + \cdots + c_{2^n-1} \ket{11\ldots1}.
$$
In contrast, a product state of $n$ \strong{unentangled} qubits has the form
$$
\ket{\psi} = (a_0\ket{0}+b_0\ket{1})(a_1\ket{0}+b_1\ket{1})\cdots(a_{n-1}\ket{0}+b_{n-1}\ket{1}).
$$
Quantum entanglement makes the dimension of the state space grow \strong{exponentially}.

\column
\row
\figure[.7]{entanglement.svg}{Quantum entanglement}
\endrow
\endcolumn



## Unitary Operations

\row
\figure[.23]{bloch.png}{Bloch sphere<br>$\ket{\psi} = \cos\frac{\theta}{2}\ket{0} + e^{i\phi}\sin\frac{\theta}{2}\ket{1}$}
&nbsp;
\figure[.27]{pauli.png}{Pauli-X gate}
\endrow



## Noise

\columns
A \strong{density operator} describes a quantum state that may include classical uncertainty:
$$
\rho = \sum_k p_k \ket{\psi_k}\bra{\psi_k}.
$$

- Pure state: $\rho = \ket{\psi}\bra{\psi}$.
- Mixed state: a probability mixture of possible states.
- Noise and evolution are modeled by \strong{quantum channels}:
  $$\rho \mapsto \mathcal{E}(\rho).$$

\column
\row
\figure[1]{mixed.png}{Mixed state under bit-flip noise}
\endrow
\endcolumn



## Measurement

A general quantum measurement is described by a \strong{positive operator-valued measure} (POVM) $\{ M_x \}$, satisfying $M_x \geq 0$ and $\sum_x M_x = I$.
The probability of observing outcome $x$ is
$$ p(x) = \tr(\rho M_x). $$

\row
\figure[.4]{interferometer.png}{}
\endrow


## Grover Search Algorithm

\columns
\strong{Grover search} finds a marked item among $N$ unsorted items:
- A classical algorithm needs $O(N)$ queries.
- Grover's algorithm needs only $O(\sqrt{N})$ queries.

\strong{Core idea:}
- Two reflections = one rotation.
- Measure when near target.



\column
\row
\figure[.7]{grover.svg}{Geometric interpretation}
\endrow
\endcolumn




## Classical vs. Quantum 

\row
\figure[.85]{hypercube.jpg}{}
\endrow



## 

\bcenter{Part I: Quantum Metrology}



## Quanutm Metrology

- Metrology: science of measurement.
- Quantum Metrology: Enhanced parameter estimation using quantum resources (entanglement, squeezed light, etc).

\row
\figure[.5]{qm_illu.svg}{General process of quantum metrology.}
\figure[.3]{LIGO.jpeg}{LIGO uses squeezed light to sense changes at the scale of $10^{-19}$ m.}
\endrow



## Heisenberg Limit vs Standard Quantum Limit

- Standard quantum limit \strong{(SQL)}: $\Delta \phi \sim \mathcal{O}(N^{-\frac{1}{2}})$.
- Heisenberg limit \strong{(HL)}: $\Delta \phi \sim \mathcal{O}(N^{-1})$.

\row
\figure[.5]{strategy.png}{Limits are largely determined by the probe states. \cite{Giovannetti, Lloyd, and Maccone. "Quantum metrology." Physical review letters 96, no. 1 (2006): 010401.}}
\endrow




## Fisher Information vs Mutual Information

\columns
\row
\figure[.4]{qfi_illu.svg}{Fisher information}
\endrow

QFI measures \strong{local sensitivity}: how well nearby values of $\phi$ can be separated.

$$
F_Q(\phi)=\max_M \sum_x \frac{\pp{\partial_\phi p(x|\phi)}^2}{p(x|\phi)}.
$$

- HL: $F\sim N^2$; SQL: $F\sim N$.

\column
\row
\figure[.66]{alice_bob.svg}{Mutual information}
\endrow

MI measures \strong{global distinguishability}: how many bits of information is extracted.

$$
I(X,\Phi)=\sum_x\int p(\phi)p(x|\phi)\log\frac{p(x|\phi)}{p(x)}\,d\phi.
$$

- HL: $I = \log N + o(\log N)$; SQL: $I = \frac{1}{2}\log N + o(\log N)$. \cite{Hassani, Macchiavello and Maccone. "Digital Quantum Estimation." PRL 119, 200502 (2017).}

\endcolumn



## How many bits does your quantum estimation return? 

\columns
\strong{Results} \cite{Górecki, Lu, Macchiavello, and Maccone. "Mutual information bounded by Fisher information." Physical Review Research 7, L022013 (2025).}
- Mutual Information Bound by Fisher Information:
  $$I(X,\Phi)\leq \log\pp{1+\frac{1}{2}\int_a^b \sqrt{F(\phi)}\,d\phi}.$$
- In noisy quantum phase estimation, the extractable information is capped at SQL scaling.  $$ I(X,\Phi) \leq \log\left(1 + \pi\sqrt{\frac{N\eta}{1-\eta}} \right).$$
  

\column
\row
\figure{fisher_bound_noise.png}{Noise restores \strong{Standard Quantum Limit} behavior}
\endrow
\endcolumn



## 

\bcenter{Part II: Quantum Signal Processing}

## The Problem

Many computational tasks involve operating on matrices:

- \strong{Hamiltonian simulation}: compute $e^{-iHt}$.
- \strong{Linear systems}: solve $Ax = b$.
- \strong{Eigenvalue / SVD}: decompose $A = U\Sigma V^\dagger$.
- \strong{Matrix multiplication}: compute $AB$.

How do we implement these efficiently on a quantum computer?



## Block Encoding: Matrix Arithmetic

A \strong{block encoding} embeds a matrix $A$ in a larger unitary:
$$
(\bra{0}\otimes I) U_A (\ket{0}\otimes I) = A,
\qquad
U_A = \pmat{A & * \\ * & *}.
$$

\columns
### Product
\row
\figure[.98]{block_mul.svg}{}
\endrow
- Compose $U_B$ then $U_A$; post-select both ancillas to $|0\rangle$.
- Result: a block encoding of $AB$.

\column
### Linear Combination 
\row
\figure[.98]{lcu_add.svg}{}
\endrow
- $\mathrm{PREPARE}$: $|0\rangle \mapsto \sqrt{\alpha}|0\rangle + \sqrt{\beta}|1\rangle$.
- Apply $U_A$ controlled on ancilla $= |0\rangle$, $U_B$ on ancilla $= |1\rangle$.
- Result is a block encoding of $\alpha A + \beta B$.
\endcolumn



## Quantum Signal Processing & Singular Value Transformation

\columns[6fr 4fr]
\strong{Quantum Signal Processing (QSP)} interleaves signal oracle $W(x) = \pmat{x & i\sqrt{1-x^2} \\ i\sqrt{1-x^2} & x}$ to $W(P(x))$. \strong{Quantum Singular Value Transformation (QSVT)} lifts QSP to matrices.

\strong{Theory} \cite{Gilyén, Su, Low and Wiebe. "Quantum singular value transformation and beyond." arXiv:1806.01838 (2018).}: $P$ is achievable iff:
- $|P(x)| \leq 1$ on $x\in[-1,1]$;
- $\deg P \leq d$;
- $P$ has parity $d \bmod 2$.

\row
\figure[.95]{qsp.svg}{QSP circuit}
\endrow

\column
### Eg: Linear Systems Solver
\row
\figure[.9]{poly_inverse.svg}{}
\endrow
- $f(x)=x^{-1}$ solves $Ax=b$.
- Query Complexity: $O(\kappa\log(1/\epsilon))$ \cite{Childs, Kothari and Somma. "Quantum algorithm for systems of linear equations with exponentially improved dependence on precision." SIAM J. Comput. 46 (2017).}
  - $\kappa$: Condition number
\endcolumn



## My Work: U(N)-QSP/QSVT

\columns[6fr 4fr]
\strong{Motivation}:
- Some algorithms require building multiple polynomials simultaneously. 
- Multivariate QSP, in particular, needs more degrees of freedom than U(2)-QSP can provide;

\strong{Result} \cite{Lu, Liu, and Lin. "Quantum Signal Processing and Quantum Singular Value Transformation on U(N)." Quantum 10, 2048 (2026).}: Given a unitary $U$ and a degree-$\leq d$ complex polynomial matrix $\bmp(z)$, there exists a $d$-query circuit implementing a block encoding
$$\pmat{\bmp(U) & * \\ * & *}$$
if and only if all singular values of $\bmp(z)$ lie in $[0,1]$ for $|z|\leq 1$.

\column
\row
\figure[.9]{qsp_u.png}{$U(N)$-QSP circuit}
\endrow
\row
\figure[.9]{quatro_decision.png}{Multi-interval decision polynomials}
\endrow
\endcolumn



## 

\bcenter{Part III: Quantum Simulation}

## Quantum Simulation

\columns
### Discrete Variable (DV)
\row
\figure[.6]{qubit_intro.png}{}
\endrow
- Finite-dimensional qubit registers.
- Mainstream model for quantum algorithms.

\column
### Continuous Variable (CV)
\row
\figure[.8]{osc_intro.png}{}
\endrow
- Infinite-dimensional bosonic modes.
- Natural in quantum optics and oscillators.

\column
### Hybrid CV-DV
\row
\figure[.84]{hybrid_intro.png}{}
\endrow
- Qubits coupled to bosonic modes.
- Promising, but hard to simulate.
\endcolumn



## Why Simulation Becomes Expensive

\columns
\todo{Real Numbers?}

\column
\row
\figure[.75]{comp_power.svg}{$A\to B$: can hardware $A$ efficiently simulate processor $B$?}
\endrow
\endcolumn



## Qubit Simulation of Hybrid CV-DV Quantum Systems

\columns
\strong{Result:} Gaussian and conditional-Gaussian gates can be simulated on qubit registers with
$$
O\!\left(\log^2\!\left(\Gamma+\log\frac{1}{\epsilon}\right)\right)
$$
elementary gates per hybrid gate to precision $\epsilon$, where $\Gamma$ is the photon number cutoff.

\todo{Interactive demos}

\column
\row
\figure[.75]{hybrid_intro.png}{Hybrid oscillator-qubit systems}
\endrow
\endcolumn




## TODO: GPU simulation & Beyond

\todo{Placeholder: a one-page map of active quantum directions, beyond what this talk covers.}

\columns
- \strong{Quantum error correction (QEC)}: making noisy qubits reliable.
- \strong{Variational algorithms (VQE / QAOA)}: near-term hybrid quantum-classical optimization.
- \strong{Quantum machine learning (QNN)}: parameterized circuits as learnable models.

\column
- \strong{Cryptography}: Shor's algorithm and post-quantum security.
- \strong{Simulation tooling}: CUDA-Q / cuQuantum and GPU-accelerated backends.
\endcolumn

\todo{Pick 2-3 to name aloud; use this to bridge into my own work.}


## 

&nbsp;

\hcenter{Thank you!}

\row
\qrcode{https://helloluxi.github.io/intro-qcqi}{Slides<br>https://helloluxi.github.io/intro-qcqi}
&nbsp;
\qrcode{https://xlu.casa}{Homepage<br>https://xlu.casa}
\endrow
