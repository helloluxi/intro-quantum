# Quantum Metrology, Signal Processing, and Simulation

\subtitle{Luca Lu}
\subsubtitle{DevTech Engineer, NVIDIA}
\today{en-US}
\graphicspath{fig}

\todo{Opening hook: add a 20-30 second bridge for a technical computing audience. Suggested direction: computation is limited by representation, memory, and structured linear algebra; quantum computing changes all three at once.}



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



## Roadmap

This talk is not a full survey. The goal is to build enough background to understand three research stories.

- \strong{Quantum metrology}: how much information can a measurement reveal?
- \strong{Quantum signal processing}: how do quantum algorithms transform matrices?
- \strong{Quantum simulation}: how do we represent analog quantum hardware on qubits?

\strong{Pattern for each part:} background first, then one slide for my work.

\todo{Add one sentence tying metrology, signal processing, and simulation together in your own voice.}



## Minimal Quantum Vocabulary

\columns
\strong{State}
- The mathematical object describing what the system can do next.
- For $n$ qubits, a pure state is a normalized vector in $\mathbb{C}^{2^n}$.

\strong{Operation}
- A gate is a reversible linear transformation.
- A circuit is a sequence of gates.

\column
\strong{Measurement}
- A measurement produces one classical outcome sampled from a probability distribution.
- The amplitudes are not directly readable.

\strong{Noise}
- Real devices are open systems, so states become density operators and gates become channels.
\endcolumn



## Qubits: A Bit That Lives on a Sphere

\columns
A classical bit is $0$ or $1$. A qubit is a \strong{normalized superposition}:
$$
\ket{\psi} = \cos\hf{\theta}\ket{0} + e^{i\phi}\sin\hf{\theta}\ket{1}.
$$

- Two real numbers $(\theta, \phi)$ define a point on the \strong{Bloch sphere}.
- Reading it out collapses it to $0$ or $1$ with probabilities $\cos^2\hf{\theta}$ and $\sin^2\hf{\theta}$.

\column
\row
\figure[.6]{bloch.png}{The Bloch sphere}
\endrow
\endcolumn



## From One Qubit to Many: Exponential State Space

\columns
$n$ independent qubits - a \strong{product state} - need only $2n$ numbers:
$$
(a_0\ket{0}+b_0\ket{1})\cdots(a_{n-1}\ket{0}+b_{n-1}\ket{1}).
$$

A general \strong{entangled} state needs all $2^n$:
$$
\ket{\psi} = c_0 \ket{0\ldots0} + \cdots + c_{2^n-1} \ket{1\ldots1}.
$$

\strong{Entanglement is what makes the state space blow up exponentially} - the source of quantum power, and of the cost of simulating it.

\column
\row
\figure[.8]{entanglement.svg}{Quantum entanglement}
\endrow
\endcolumn



## Circuits and Measurement

\columns
Every gate is a unitary matrix acting on the state:

- Single-qubit gates: $2\times 2$ matrices.
- Two-qubit gates can create entanglement.
- A circuit prepares a state, evolves it, and then measures it.

\strong{The catch:} one run gives one sampled outcome. Information comes from many shots and from arranging interference so useful outcomes have high probability.

\column
\row
\figure[.7]{pauli.png}{Pauli-$X$ gate}
\endrow
\endcolumn

\todo{Optional: add a concise analogy for why superposition is not classical parallelism.}



## Noise: The Realistic Picture

\columns
Real hardware is noisy, so we use a \strong{density operator} $\rho = \sum_k p_k \ket{\psi_k}\bra{\psi_k}$ instead of a single vector.

- Pure state: $\rho = \ket{\psi}\bra{\psi}$; otherwise mixed.
- Evolution becomes a \strong{quantum channel}:
  $$ \rho \mapsto \sum_k K_k \rho K_k^\dagger, \qquad \sum_k K_k^\dagger K_k = I. $$
- Noise limits the information and computation we can extract.

\column
\row
\figure[.85]{mixed.png}{A bit-flip channel on the Bloch sphere}
\endrow
\endcolumn



## Part I: Quantum Metrology

\columns
\strong{Metrology} is the science of measurement.

\strong{Quantum metrology} asks how quantum resources - superposition, entanglement, squeezing - can improve parameter estimation.

Typical workflow:
$$
\phi \longrightarrow \rho_\phi \longrightarrow \text{measurement outcome } x \longrightarrow \hat{\phi}(x).
$$

\column
\row
\figure[.45]{qm_illu.svg}{General process of quantum metrology}
\figure[.35]{LIGO.jpeg}{LIGO uses squeezed light for precision sensing}
\endrow
\endcolumn



## Two Scaling Laws

\columns
\strong{Standard quantum limit (SQL)}
$$
\Delta \phi \sim O(N^{-1/2})
$$

\strong{Heisenberg limit (HL)}
$$
\Delta \phi \sim O(N^{-1})
$$

The usual story: better probe states can change the scaling.

\column
\row
\figure[.65]{strategy.png}{Probe strategy affects the achievable precision}
\endrow
\endcolumn



## Fisher Information: Local Estimation

\columns
For a measurement $M=\{M_x\}$ with probabilities $p(x|\phi)=\tr(\rho_\phi M_x)$,
$$
F_C(\phi;M)=\sum_x \frac{\partial_\phi p(x|\phi)^2}{p(x|\phi)}.
$$

Quantum Fisher information maximizes this over measurements:
$$
F_Q(\phi)=\max_M F_C(\phi;M).
$$

\strong{Meaning:} FI tells us how distinguishable nearby parameters are.

\column
\row
\figure[.4]{cfi_illu.svg}{Classical FI}
\figure[.4]{qfi_illu.svg}{Quantum FI}
\endrow
\endcolumn



## Why Local Precision Is Not Enough

\columns
A state can be locally very sensitive and still globally ambiguous.

Example: a NOON state
$$
\ket{\psi_\phi}=\frac{1}{\sqrt{2}}\pp{\ket{N,0}+e^{iN\phi}\ket{0,N}}
$$
has Fisher information $F(\phi)=N^2$, but
$$
\phi \quad\text{and}\quad \phi+\frac{2\pi}{N}
$$
are indistinguishable.

\column
\row
\figure[.5]{MachZehnder.png}{}
\figure[.45]{prob_2.png}{Local sensitivity can hide global ambiguity}
\endrow
\endcolumn



## Mutual Information: Global Estimation

\columns
Mutual information measures how many bits about $\Phi$ are learned from the outcome $X$:
$$
I(X,\Phi)=\sum_x\int p(\phi)p(x|\phi)\log\frac{p(x|\phi)}{p(x)}\,d\phi.
$$

- MI is a \strong{global} distinguishability measure.
- It depends on the full prior and all possible outcomes.
- It is invariant under reparameterizing $\phi$.

\column
\row
\figure[.75]{alice_bob.svg}{Alice encodes $\phi$; Bob measures and learns about it}
\endrow
\endcolumn



## My Work: Bits Returned by Quantum Estimation

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
\figure[.45]{chi_qpe.png}{MI bound for noisy QPE}
\figure[.45]{fisher_bound_noise.png}{Noise restores SQL behavior}
\endrow
\endcolumn

\todo{Add one short spoken takeaway connecting "bits returned" to information throughput.}



## Part II: Quantum Signal Processing

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



## Block Encoding: Putting a Matrix in a Circuit

To compute with a matrix $A$ on a quantum computer, we hide it in the corner of a larger unitary $U_A$:
$$
U_A = \pmat{ A & * \\ * & * }.
$$

For a Hermitian $H$ with eigenvalues in $[-1,1]$, one standard form is
$$
U_H = \pmat{ H & i\sqrt{I-H^2} \\ i\sqrt{I-H^2} & H }.
$$

\strong{Think of block encoding as the quantum API for "give me access to this operator."}



## QSVT: Functions of a Matrix's Spectrum

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



## QSVT: One Primitive, Many Algorithms

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



## QSP: A Polynomial from a Circuit

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



## My Work: $U(N)$-QSP

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



## Part III: Quantum Simulation

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



## Fock Encoding: The Direct Route Is Dense

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



## Position Encoding: Store the Wave Function

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



## Why It Works: Diagonalize in the Right Basis

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



## My Work: Efficient Qubit Simulation of Hybrid CV-DV Gates

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
