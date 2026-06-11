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



## Controlled Gates & Circuits

\columns
\row
\figure[.6]{cnot.svg}{CNOT: $\ket{c}\ket{t}\mapsto\ket{c}\ket{t\oplus c}$, i.e. $\pmat{1&0&0&0\\0&1&0&0\\0&0&0&1\\0&0&1&0}$}
\endrow

\column
\row
\figure[.95]{ansatz.svg}{Single-qubit gates $+$ CNOTs $\Rightarrow$ any circuit}
\endrow
\endcolumn



## Measurement

A general quantum measurement is described by a \strong{positive operator-valued measure} (POVM) $\{ M_x \}$, satisfying $M_x \geq 0$ and $\sum_x M_x = I$.
The probability of observing outcome $x$ is
$$ p(x) = \tr(\rho M_x). $$

\row
\figure[.4]{interferometer.png}{}
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


## Grover Search Algorithm

\columns
\strong{Grover search} finds a marked item among $N$ unsorted items: \cite{Grover. "A fast quantum mechanical algorithm for database search." STOC 1996, pp. 212–219.}
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



## Shor's Algorithm: Breaking RSA

\columns
\strong{RSA} trusts that factoring a large $N = p \times q$ back into its primes is hard. \strong{Shor's algorithm} cracks it with an exponential speedup. \cite{Shor. "Polynomial-Time Algorithms for Prime Factorization and Discrete Logarithms on a Quantum Computer." SIAM J. Comput. 26, 1484 (1997).}

- \strong{Classically}: the 829-bit RSA-250 took $\sim$2,700 core-years. \cite{Boudot, Gaudry, Guillevic, Heninger, Thomé, and Zimmermann. "Comparing the difficulty of factorization and discrete logarithm: a 240-digit experiment." CRYPTO 2020.}
- \strong{Ideal qubits}: as few as 1,730 logical qubits suffice for RSA-2048. \cite{Chevignard, Fouque, and Schrottenloher. "Reducing the Number of Qubits in Quantum Factoring." CRYPTO 2025 (eprint 2024/222).}
- \strong{Noisy qubits}: RSA-2048 would fall in $<$ 1 week on $< 10^6$ physical qubits. \cite{Gidney. "How to factor 2048 bit RSA integers with less than a million noisy qubits." arXiv:2505.15917 (2025).}

\column
\row
\figure[.95]{qpe.svg}{Quantum Phase Estimation: a core building block of Shor's algorithm}
\endrow
\endcolumn



## Why Quantum Accelerates?

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

## Flavors of Quantum Hardware

Quantum machines are built from different physical systems, each with its own strengths.

\columns
### Qubits (Discrete-Variable, DV)
\row
\figure[.6]{qubit_intro.png}{}
\endrow
- Discrete two-level cells.
- The mainstream model; easy to control.

\column
### Oscillators (Continuous-Variable, CV)
\row
\figure[.8]{osc_intro.png}{}
\endrow
- A field with infinitely many levels.
- Compact; native to optics and acoustics.

\column
### Hybrid CV-DV
\row
\figure[.84]{hybrid_intro.png}{}
\endrow
- Qubits coupled to oscillators.
- Best of both — the new frontier.
\endcolumn



## Gaussian Operations
\columns

Their Hamiltonians are built from \strong{ladder operators} $\hat a,\hat a^\dagger$ that add or remove one quantum.

In the \strong{Fock basis} $\ket{0},\ket{1},\ket{2},\dots$ (photon-number levels), an operator is just a matrix — e.g. $\hat a$ steps one level down:
$$
\hat a = \pmat{0 & 1 & 0 & \cdots \\ 0 & 0 & \sqrt{2} & \cdots \\ 0 & 0 & 0 & \cdots \\ \vdots & \vdots & \vdots & \ddots}.
$$

\column
\strong{Native (Gaussian) gates} reshape the state:

- \strong{Displace}: $D(\alpha)=e^{\alpha\hat a^\dagger-\alpha^*\hat a}$
- \strong{Rotate}: $R(\theta)=e^{-i\theta\hat{n}}=e^{-i\theta\,\hat a^\dagger\hat a}$
- \strong{Squeeze}: $S(r)=e^{\frac{r}{2}(\hat a^2-\hat a^{\dagger2})}$
- \strong{Beam splitter}: $\mathrm{BS}(\theta)=e^{-i\theta(\hat a^\dagger\hat b+\hat a\hat b^\dagger)}$ (two modes)

<div style="text-align:center; margin-top:28px;"><a href="demo.html" target="_blank" style="display:inline-block; background:transparent; color:#2563eb; border:2px solid #2563eb; padding:12px 26px; border-radius:12px; text-decoration:none; font-weight:700; font-size:1.3em;">▶ Live demo</a></div>
\endcolumn



## Simulating a Bosonic Hamiltonian

\columns
Much of chemistry and materials science is really about \strong{bosons}: vibrations in molecules, phonons in solids, photons in a cavity.

A real model — e.g. the Bose–Hubbard Hamiltonian for bosons hopping ($J$) and interacting ($U$) on a lattice:
$$
H = -J\!\!\sum_{\langle i,j\rangle}\!\! \hat a_i^\dagger \hat a_j \;+\; \frac{U}{2}\sum_i \hat n_i(\hat n_i-1).
$$

To simulate it, compile the evolution $e^{-iHt}$ from native gates.

\column
- \strong{Trotter} — split a sum into small steps:
$$e^{-i(A+B)t} \approx \big(e^{-iAt/r}\,e^{-iBt/r}\big)^r.$$
- \strong{BCH} — build products from commutators:
$$e^{itA}e^{itB}e^{-itA}e^{-itB} \approx e^{-t^2[A,B]}.$$

A single qubit steering displacements can then assemble \strong{any} oscillator interaction. \cite{Kang, Soley, Crane, Girvin, and Wiebe. "Leveraging Hamiltonian simulation techniques to compile operations on bosonic devices." arXiv:2303.15542 (2023).}
\endcolumn



## Different Machines, Different Instruction Sets

\columns
Each machine exposes its own \strong{instruction set architecture (ISA)} — the operations it runs natively:

- \strong{Qubits}:
  - CNOT $+$ single-qubit rotations.
  - Clifford $+\,T$ (fault-tolerent).
- \strong{Oscillators}:
  - Cubic ISA: Gaussian gates $+$ one cubic gate.
- \strong{Hybrid Oscillator-Qubit}: \cite{Liu, Singh, Smith, et al. "Hybrid Oscillator-Qubit Quantum Processors." arXiv:2407.10381 (2024).}
  - phase-space ISA: conditional displace + qubit rotation + beam splitter 
  - Fock-space ISA: SNAP + qubit rotation + beam splitter
  - sideband ISA: Jaynes-Cumming + displace + beam splitter

\column
\row
\figure[.9]{comp_power.svg}{$A\to B$: can machine $A$ efficiently run machine $B$?}
\endrow
\endcolumn



## My Work: Efficient Qubit Simulation of Hybrid CV-DV Processor

\strong{My result} \cite{Lu, Bakalov, and Liu. "Efficient Qubit Simulation of Hybrid Oscillator-Qubit Quantum Processors." (2025).}: Phase-space ISA can be emulated on qubits with CNOT+rotation ISA with complexity
$$
O\!\left(\log^2\!\left(\Gamma+\log\tfrac{1}{\epsilon}\right)\right)
$$
per gate, where $\Gamma$ is fock level cutoff and $\epsilon$ is accuracy.

\row
\figure[.4]{compare_fock.png}{Same accuracy, far fewer gates.}
\figure[.3]{advantage.png}{When real hybrid hardware wins (red) vs. when qubit emulation suffices (blue).}
\endrow





## The Quantum Computing Landscape

\columns
Two numbers decide what a quantum computer can do: \strong{how many qubits} and \strong{how clean each gate is}.

- \strong{Classically simulable}: too few qubits, or too noisy — a laptop keeps up.
- \strong{NISQ}: enough qubits to be hard to simulate, but no error correction — today's machines live here.
- \strong{Fault-tolerant}: gate error below the surface-code threshold ($\sim 1\%$) — error correction kicks in and Shor-scale algorithms become reachable.

\column
\row
\figure[.95]{landscape.png}{Qubit count vs. gate error rate. \cite{Jaques. "The Landscape of Quantum Computing." https://sam-jaques.appspot.com/quantum_landscape (2026). }}
\endrow
\endcolumn



## Other Topics: Quantum Still Runs on Classical Compute

Every stage of quantum research leans on classical horsepower — and the GPU is the engine behind it.

- \strong{State preparation}: loading data or an ansatz into a circuit is itself a classical optimization problem.
- \strong{Gate compilation}: transpiling a circuit onto a hardware ISA — and translating across ISAs (qubit, oscillator, hybrid) — is heavy classical search.
- \strong{Hamiltonian simulation}: compiling $e^{-iHt}$ via Trotter / QSP means computing phase factors and step counts offline, at high precision.
- \strong{Quantum AI}: quantum circuits as learning models.
  - \strong{VQE / QAOA}: variational circuits trained by a classical loop for ground-state energies and combinatorial optimization.
  - \strong{QNN}: parameterized circuits as trainable networks, with quantum kernels and data re-uploading.
- \strong{AI for quantum}: neural networks serving the machine, all trained on a fast GPU backend.
  - \strong{Neural quantum states}: network ansätze solve the many-body Schrödinger equation, rivaling tensor networks.
  - \strong{AI decoders}: networks like \strong{AlphaQubit} read error syndromes faster and more accurately than hand-tuned matching.
  - \strong{Control & compilation}: ML shapes control pulses, synthesizes circuits, and finds QSP phase factors.

## 

&nbsp;

\hcenter{Thank you!}

\row
\qrcode{https://helloluxi.github.io/intro-qcqi}{Slides<br>https://helloluxi.github.io/intro-qcqi}
&nbsp;
\qrcode{https://xlu.casa}{Homepage<br>https://xlu.casa}
\endrow
