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



## Schrödinger's Cat

\todo{Figure: Schrödinger's cat}



## Qubits

\row
\figure[.3]{cbit.svg}{Classical bit}
&nbsp;
\figure[.3]{qbit.svg}{Quantum bit (qubit)}
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



## TODO: CUDA Simulation? Mention RSA?



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
\figure[.52]{qfi_illu.svg}{Quantum Fisher information}
\endrow

QFI measures \strong{local sensitivity}: how well nearby values of $\phi$ can be separated.

$$
F_Q(\phi)=\max_M \sum_x \frac{\pp{\partial_\phi p(x|\phi)}^2}{p(x|\phi)}.
$$

\column
\row
\figure[.72]{alice_bob.svg}{Mutual information}
\endrow

MI measures \strong{global distinguishability}: how many bits about $\Phi$ are learned from $X$.
It uses the full prior and all outcomes.

$$
I(X,\Phi)=\sum_x\int p(\phi)p(x|\phi)\log\frac{p(x|\phi)}{p(x)}\,d\phi.
$$

\endcolumn



## My Work: Mutual Information Bound by Fisher Information

\columns
\strong{Question:} how many bits can any measurement extract from a quantum parameter?

\strong{Results}
- A spectrum-based upper bound on mutual information.
- A Fisher-information upper bound:
  $$I(X,\Phi)\leq \log\pp{1+\frac{1}{2}\int_a^b \sqrt{F(\phi)}\,d\phi}.$$
- In noisy quantum phase estimation, the extractable information is capped at SQL scaling.

\strong{Takeaway:} local sensitivity alone does not guarantee globally usable information.

\column
\row
\figure{fisher_bound_noise.png}{Noise restores SQL behavior}
\endrow
\endcolumn

\todo{Add one short spoken takeaway connecting "bits returned" to information throughput.}



## Quantum Signal Processing

\columns
Many quantum algorithms reduce to one problem:

\strong{Given access to an operator, implement a useful function of it.}

Classical analogy:
- eigensolvers apply spectral filters;
- iterative solvers count matrix-vector products;
- approximation theory turns functions into polynomials.

\column
\row
\figure[.8]{poly_exp.svg}{Approximating $f(x)=e^{itx}$ by a polynomial}
\endrow
\endcolumn



## Block Encoding

To compute with a matrix $A$ on a quantum computer, we hide it in the corner of a larger unitary $U_A$:
$$
U_A = \pmat{ A & * \\ * & * }.
$$

For a Hermitian $H$ with eigenvalues in $[-1,1]$, one standard form is
$$
U_H = \pmat{ H & i\sqrt{I-H^2} \\ i\sqrt{I-H^2} & H }.
$$

\strong{Think of block encoding as the quantum API for "give me access to this operator."}



## QSVT

\columns
\strong{Quantum Singular Value Transformation (QSVT)} applies a polynomial $P$ to the eigen-/singular values of $A$:
$$
\pmat{A & * \\ * & *} \;\mapsto\; \pmat{P(A) & * \\ * & *}.
$$

- The polynomial degree is the number of calls to the encoded operator.
- This is the quantum analogue of counting matvecs in an iterative method.

\column
\row
\figure[.75]{qsvt.png}{QSVT alternates calls to the block encoding}
\endrow
\endcolumn



## QSVT (cont.)

\columns
### Hamiltonian Simulation
\row
\figure[.9]{poly_exp.svg}{}
\endrow
- $f(x)=e^{itx}$ gives time evolution.

\column
### Linear Systems
\row
\figure[.9]{poly_inverse.svg}{}
\endrow
- $f(x)=x^{-1}$ solves $Ax=b$.

\column
### Fixed-Point Search
\row
\figure[.9]{poly_sgn.svg}{}
\endrow
- $f(x)=\mathrm{sgn}(x)$ gives robust search.
\endcolumn

\strong{Pick the polynomial, get the algorithm.}



## QSP

\columns
Quantum signal processing (QSP) builds a polynomial transformation by alternating:

- a fixed signal unitary containing the input $x$;
- tunable phase rotations;
- one auxiliary qubit.

In standard QSP/QSVT, a circuit essentially produces one scalar polynomial output.

\column
\row
\figure[.75]{qsp.svg}{A QSP circuit}
\endrow
\endcolumn



## My Work: U(N)-QSP

\columns
\strong{Idea:} replace the one-qubit auxiliary system by an $N$-dimensional auxiliary register.

\strong{Result:} implement a \strong{matrix of polynomials}
$$
\bmp(U)=\{P_{jk}(U)\}
$$
with singular-value constraints replacing scalar boundedness constraints.

\strong{Why useful:} one measurement can extract $\log N$ bits, e.g. deciding which of $N$ intervals contains a parameter.

\column
\row
\figure[.45]{qsp_u.png}{$U(N)$-QSP circuit}
\figure[.45]{quatro_decision.png}{Multi-interval decision polynomials}
\endrow
\row
\figure[.55]{quatro_comparison.png}{$U(N)$-QSP vs staged scalar QSP}
\endrow
\endcolumn

\todo{Explain "more output per circuit" using one analogy, then immediately return to the theorem or application.}



## 

\bcenter{Part III: Quantum Simulation}

## Quantum Simulation

\columns
### Discrete Variable (DV)
\figure[.42]{qubit_intro.png}{}
- Finite-dimensional qubit registers.
- Mainstream model for quantum algorithms.

\column
### Continuous Variable (CV)
\figure[.55]{osc_intro.png}{}
- Infinite-dimensional bosonic modes.
- Natural in quantum optics and oscillators.

\column
### Hybrid CV-DV
\figure[.68]{hybrid_intro.png}{}
- Qubits coupled to bosonic modes.
- Promising, but hard to simulate.
\endcolumn



## Why Simulation Becomes Expensive

\columns
A quantum state of $n$ qubits is a complex vector of length $2^n$:
$$
\ket{\psi} = \pp{c_0,\, c_1,\, \ldots,\, c_{2^n-1}}^\top, \qquad \sum_k \abs{c_k}^2 = 1.
$$

- Simulating $n$ qubits means storing and updating a $2^n$ array.
- $n=40$ qubits is already about a trillion complex amplitudes.
- For CV systems, the Hilbert space is infinite before discretization.

\strong{The central question is representation: what finite object should stand in for an infinite-dimensional state?}

\column
\row
\figure[.75]{comp_power.svg}{$A\to B$: can hardware $A$ efficiently simulate processor $B$?}
\endrow
\endcolumn



## Fock Encoding

\columns
The textbook approach truncates Fock levels:
$$
\sum_{j=0}^{\infty}c_j\ket{j}_F
\quad\mapsto\quad
\sum_{j=0}^{N-1}c_j\ket{j}.
$$

But elementary CV operators become dense. The ladder operator is
$$
\hat a=\pmat{0&\sqrt{1}&&\\&0&\sqrt{2}&\\&&0&\ddots\\&&&\ddots},
$$
and displacement involves generalized Laguerre polynomials.

\strong{The encoding fights the gates.}

\column
\row
\figure[.8]{encodings.png}{Fock-basis vs position encoding}
\endrow
\endcolumn



## Position Encoding

\columns
A CV state has a position wave function $\psi(q)$. Instead of storing Fock coefficients, sample the wave function on a grid:
$$
\enc_Q(\ket{\psi})=\sqrt{\lambda}\sum_{j=0}^{N-1}\psi(\lambda\tilde{j})\ket{j},\qquad N=2^n.
$$

- $n$ qubits give a $2^n$-point grid.
- Position and momentum pictures are connected by the quantum Fourier transform.
- This is closer to discretizing a field than truncating a ladder operator.

\column
\row
\figure[.75]{encodings.png}{Wave-function encoding}
\endrow
\endcolumn



## Why It Works

\columns
Position operators are diagonal in the position grid; momentum operators are diagonal in the momentum grid.

- Any $e^{i f(\hat q)}$ is a diagonal phase layer.
- Any $e^{i g(\hat p)}$ is the same after a QFT.
- Gaussian gates decompose into position-only and momentum-only pieces.

Example:
$$
\RR{\theta}
=e^{-\frac{i}{2}\tan\frac\theta2\,\hat q^2}
 e^{-\frac{i}{2}\sin\theta\,\hat p^2}
 e^{-\frac{i}{2}\tan\frac\theta2\,\hat q^2}.
$$

\column
\row
\figure[.75]{heterodyne.png}{Measurements also reduce to gate decompositions}
\endrow
\endcolumn



## My Work: Qubit Simulation of Hybrid CV-DV Quantum Systems

\columns
\strong{Result:} Gaussian and conditional-Gaussian gates can be simulated on qubit registers with
$$
O\!\left(\log^2\!\left(\Gamma+\log\frac{1}{\epsilon}\right)\right)
$$
elementary gates per hybrid gate.

\strong{Mechanism:}
- encode wave functions on a qubit grid;
- switch bases with QFTs;
- implement diagonal phase layers;
- track QFT/discretization errors rigorously.

\strong{Takeaway:} the right encoding turns dense CV operators into structured qubit circuits.

\column
\row
\figure[.75]{hybrid_intro.png}{Hybrid oscillator-qubit systems}
\endrow
\endcolumn

\todo{Add one concrete example gate, such as displacement or rotation, if the audience needs a more physical anchor.}



## Summary

- \strong{Metrology}: Fisher information is local; mutual information captures globally extractable bits.
- \strong{Signal processing}: QSVT turns matrix functions into polynomial transformations of block encodings.
- \strong{Simulation}: position encoding plus QFTs can make hybrid CV-DV gates efficient on qubit registers.

\strong{Common theme:} the representation determines what information, computation, or simulation is actually accessible.



## 

&nbsp;

\hcenter{Thank you!}

\row
\qrcode{https://helloluxi.github.io/intro-qcqi}{Slides}
&nbsp;
\qrcode{https://xlu.casa/s/}{Homepage}
\endrow
