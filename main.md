# Brief Introduction to Quantum Computing 

\subtitle{Luca Lu}
\subsubtitle{DevTech Engineer, NVIDIA}
\today{en-US}
\graphicspath{fig}



## About Me

\columns[7fr 4fr]
- \strong{2017–2021}: B.Sc. in Applied Mathematics (minor in Physics), Zhejiang University, China
  - Majorana stellar representation.
- \strong{2021–2025}: Ph.D. in Applied Mathematics, Zhejiang University, China
  - Quantum amplitude estimation.
- \strong{Sep 2023–Dec 2023}: Visiting scholar, University of Pavia, Italy
  - Global quantum metrology.
- \strong{Aug 2024–Aug 2025}: Visiting scholar, North Carolina State University, USA
  - Quantum signal processing;
  - Qubit simulation of hybrid oscillator-qubit systems.
\column
\figure{me.jpeg}{}
\endcolumn



## Outline

- Why a quantum talk for CUDA developers?
- Qubits, superposition, entanglement
- Gates, circuits, and measurement
- Noise: the realistic picture
- What you can compute: Grover, block encoding, QSVT
- A peek at my research, including simulating continuous-variable hardware on qubits



## Why Should a CUDA Developer Care?

\columns
A quantum state of $n$ qubits is just a complex vector of length $2^n$:
$$
\ket{\psi} = \pp{c_0,\, c_1,\, \ldots,\, c_{2^n-1}}^\top, \qquad \sum_k \abs{c_k}^2 = 1.
$$

- A quantum \strong{gate} is a unitary matrix-vector product on that vector.
- Simulating $n$ qubits = storing and multiplying a $2^n$ array.
- $n = 40$ qubits $\approx$ a trillion complex amplitudes.

\strong{This is a dense linear-algebra problem at extreme scale — exactly what GPUs are built for.}

\column
\row
\figure[.5]{cbit.svg}{Classical bit}
\figure[.5]{qbit.svg}{Qubit}
\endrow
\endcolumn

<!-- TODO (you): add a personal one-liner on how you got into this / why NVIDIA cares. -->



## Qubits: A Bit That Lives on a Sphere

\columns
A classical bit is $0$ or $1$. A qubit is a \strong{normalized superposition}:
$$
\ket{\psi} = \cos\hf{\theta}\ket{0} + e^{i\phi}\sin\hf{\theta}\ket{1}.
$$

- Two real numbers $(\theta, \phi)$ — a point on the \strong{Bloch sphere}.
- Reading it out collapses it to $0$ or $1$ with probabilities $\cos^2\hf{\theta}$, $\sin^2\hf{\theta}$.

\column
\row
\figure[.6]{bloch.png}{The Bloch sphere}
\endrow
\endcolumn



## From One Qubit to Many: Exponential State Space

\columns
$n$ independent qubits — a \strong{product state} — needs only $2n$ numbers:
$$
(a_0\ket{0}+b_0\ket{1})\cdots(a_{n-1}\ket{0}+b_{n-1}\ket{1}).
$$

A general \strong{entangled} state needs all $2^n$:
$$
\ket{\psi} = c_0 \ket{0\ldots0} + \cdots + c_{2^n-1} \ket{1\ldots1}.
$$

\strong{Entanglement is what makes the state space blow up exponentially} — the source of quantum power, and of the cost of simulating it.

\column
\row
\figure[.8]{entanglement.svg}{Quantum entanglement}
\endrow
\endcolumn



## [PLACEHOLDER] Misconception: Superposition $\neq$ Parallelism

<!--
TODO (you): fill this in. Suggested beat for a CUDA audience:
 - "A quantum computer is NOT 2^n classical machines running in parallel."
 - You hold 2^n amplitudes, but measurement gives you ONE sampled outcome.
 - The art is arranging interference so the useful answer has high amplitude.
 - Analogy of choice: SIMD lanes you can never all read back / a giant
   reduction where you only get one stochastic sample.
-->

\strong{[Your slide here — kill this placeholder once written.]}



## Quantum Gates Are Just Unitary Matrices

\columns
Every gate is a unitary matrix acting on the state vector — a matrix-vector multiply.

- Single-qubit gates: $2\times 2$ (e.g. Pauli-$X$, the quantum NOT).
- Two-qubit gates (e.g. CNOT) create entanglement.
- A \strong{circuit} is a sequence of these matmuls; reversible, norm-preserving.

\column
\row
\figure[.7]{pauli.png}{Pauli-$X$ gate}
\endrow
\endcolumn



## [PLACEHOLDER] What a Quantum Algorithm Actually Looks Like

<!--
TODO (you): fill this in. Suggested beat:
 - prepare |0...0>  ->  apply a circuit of gates  ->  measure  ->  repeat.
 - You sample, so you run many shots and aggregate statistics.
 - The win comes from interference + structure, not brute force.
 - Optional: a tiny circuit diagram or pseudo-"kernel launch" framing.
-->

\strong{[Your slide here — kill this placeholder once written.]}



## Measurement: The Catch

\columns
You never read the amplitudes directly. A measurement is described by a \strong{POVM} $\{M_x\}$ with $M_x \geq 0$, $\sum_x M_x = I$, and
$$
p(x) = \tr(\rho M_x).
$$

- Each run yields one random outcome $x$.
- Information comes from \strong{many shots} + clever circuit design.

\column
\row
\figure[.7]{interferometer.png}{}
\endrow
\endcolumn



## Noise: The Realistic Picture

\columns
Real hardware is noisy, so we use a \strong{density operator} $\rho = \sum_k p_k \ket{\psi_k}\bra{\psi_k}$ instead of a single vector.

- Pure state: $\rho = \ket{\psi}\bra{\psi}$; otherwise mixed.
- Evolution becomes a \strong{quantum channel} (CPTP map):
  $$ \rho \mapsto \sum_k K_k \rho K_k^\dagger, \qquad \sum_k K_k^\dagger K_k = I. $$
- Example — bit flip: $K_0 = \sqrt{\hf{1+\sqrt{\eta}}}\,I,\ K_1 = \sqrt{\hf{1-\sqrt{\eta}}}\,X.$

\column
\row
\figure[.9]{mixed.png}{A bit-flip channel on the Bloch sphere}
\endrow
\endcolumn



## Example: Grover Search

\columns
\strong{Grover search} finds a marked item among $N$ unsorted items:
- Classical: $O(N)$ queries.
- Grover: $O(\sqrt{N})$ queries.

\strong{Idea — amplitude amplification:} two reflections rotate the state toward the target,
$$ \mathcal{G} = (2\ket{\psi}\bra{\psi}-I)(2\ket{u}\bra{u}-I), $$
nudging it by an angle $\theta$ with $\sin\hf{\theta}=1/\sqrt{N}$ each step.

After $\approx O(\sqrt{N})$ steps, measuring returns the target with high probability.

\column
\row
\figure[.8]{grover.svg}{Geometric picture of Grover search}
\endrow
\endcolumn



## Block Encoding: Putting a Matrix in a Circuit

To compute with a matrix $A$ on a quantum computer, we hide it in the corner of a larger unitary $U_A$:
$$U_A = \pmat{ A & * \\ * & * }.$$

For a Hermitian $H$ with eigenvalues in $[-1,1]$, a standard choice is
$$U_H = \pmat{ H & i\sqrt{I-H^2} \\ i\sqrt{I-H^2} & H }.$$

\strong{Think of it as the quantum API for "give me access to this operator."}



## QSVT: Functions of a Matrix's Spectrum

\columns
\strong{Quantum Singular Value Transformation (QSVT)} applies a polynomial $P$ to the eigen-/singular values of $A$:
$$
\pmat{A & * \\ * & *} \;\mapsto\; \pmat{P(A) & * \\ * & *}.
$$

- Same idea as classical \strong{Chebyshev / polynomial filters} on a spectrum.
- Cost is counted in \strong{calls to the operator} — the quantum analogue of matvec count in an iterative solver.

\column
\row
\figure[.9]{poly_exp.svg}{Approximating $f(x)=e^{itx}$ by a polynomial}
\endrow
\endcolumn



## QSVT: One Primitive, Many Algorithms

\columns
### Hamiltonian Simulation
\row
\figure[.9]{poly_exp.svg}{}
\endrow
- $f(x) = e^{itx}$ — time evolution $e^{iHt}$.

\column
### Linear Systems
\row
\figure[.9]{poly_inverse.svg}{}
\endrow
- $f(x) = x^{-1}$ — solve $Ax=b$.

\column
### Fixed-Point Search
\row
\figure[.9]{poly_sgn.svg}{}
\endrow
- $f(x) = \mathrm{sgn}(x)$ — Grover without overshoot.
\endcolumn

\strong{Pick the polynomial, get the algorithm.}



## My Research: Three Threads

\columns
\strong{Thread 1 — Limits of estimation}
- \em{How much} can a measurement actually tell you about a parameter encoded in a quantum state?
- An information-theoretic answer, and where noise caps you.

\column
\strong{Thread 2 — Extending the QSVT toolbox}
- Make the polynomial-filter machinery do \strong{more per circuit}: many outputs at once, and \strong{matrix-valued} and \strong{multivariate} filters.

\column
\strong{Thread 3 — Simulating analog hardware on digital qubits}
- Continuous-variable (bosonic) processors are infinite-dimensional. Simulate them on a qubit/GPU register with \strong{polylogarithmic} overhead.
\endcolumn

\row
\figure[.7]{relations.svg}{}
\endrow



## Thread 1: How Many Bits Can You Learn?

\columns
Estimating a parameter $\phi$ from a quantum state has two regimes:
- \strong{Local} — Fisher information: how finely you resolve $\phi$ \em{near} a known value.
- \strong{Global} — mutual information (MI): how many \strong{bits} about $\phi$ you actually extract, no prior assumed.

\strong{My results:} upper bounds on MI from the state's spectrum and its Fisher information — and a proof that under realistic noise, you can't beat the standard limit.

\column
\row
\figure[.5]{prob_1.png}{}
\figure[.45]{prob_2.png}{}
\endrow
\strong{Global} (left) vs \strong{local} (right): the same local sensitivity can hide global ambiguity.
\endcolumn



## Thread 2a: $U(N)$-QSP — More Output Per Circuit

\columns
Standard QSP/QSVT applies one polynomial and yields essentially \strong{one bit} per measurement.

\strong{$U(N)$-QSP/QSVT} uses an $N$-dimensional auxiliary register to apply a whole \strong{matrix of polynomials} at once — extracting $\log N$ bits in a single shot.

- Decide which of $N$ intervals holds a parameter in one measurement, instead of $O(\log N)$ rounds.
- Application: quantum amplitude estimation with error $\sim 1/d$ in the circuit depth $d$.

\column
\row
\figure[.85]{qsp_u.png}{$U(N)$-QSP: a multi-qubit auxiliary register drives multiple polynomial outputs.}
\endrow
\endcolumn



## Thread 2b: Bivariate QSP — Low-Rank Filters

\columns
\strong{Goal:} implement a two-variable polynomial filter $f(w,v) = \sum_{j,k} f_{jk}\, w^j v^k$ as a circuit.

\strong{Method:} factor it, $f(w,v) \approx \sum_{j=1}^r p_j(w)\, q_j(v)$, and build the pieces separately — exactly a \strong{low-rank decomposition}, the same move as SVD / PCA compression.

- Smooth filters have fast-decaying coefficients $\Rightarrow$ a tiny rank $r \ll d$ suffices.
- E.g. with decay exponent $s=4$, keeping $5\%$ of components reaches error $<0.1$.

\column
\row
\figure[.85]{decay_comparison.png}{Coefficient decay enables large rank reduction for smooth functions.}
\endrow
\endcolumn



## Thread 3: Two Kinds of Quantum Hardware

\columns
### Discrete Variable (DV)
\figure[.45]{qubit_intro.png}{}
- State: $\sum_{j=0}^{N-1} c_j \ket{j}$ — a finite vector.
- Gates: Pauli, CNOT, $T$, $\ldots$
- Easy to calibrate; the mainstream of quantum computing.

\column
### Continuous Variable (CV)
\figure[.6]{osc_intro.png}{}
- State: $\sum_{j=0}^{\infty} c_j \ket{j}_F$ — \strong{infinite-dimensional} (a bosonic mode / oscillator).
- Gates: displacement, squeezing, rotation, beam splitter, $\ldots$
- Hardware-efficient; long history in quantum optics.

\column
### Hybrid CV-DV
\figure[.75]{hybrid_intro.png}{}
- State: $\sum_j c_j \ket{j}\ket{\phi_j}_{CV}$.
- Adds qubit-conditional bosonic gates.
- A promising frontier — but how do we \strong{simulate} it?
\endcolumn



## The Problem: Bosonic Modes Are Infinite-Dimensional

\columns
To run a CV system on qubit hardware (or simulate it on a GPU), you must turn an \strong{infinite-dimensional} state into a finite array.

The textbook approach — \strong{Fock-basis encoding} — truncates at $N$ levels and maps $\ket{k}_F \mapsto \ket{k}$. But the basic operators become dense and ugly. The ladder operator is
$$
\a = \pmat{ 0 & \sqrt{1} & & \\ & 0 & \sqrt{2} & \\ & & 0 & \ddots \\ & & & \ddots },
$$
so even a \strong{displacement} $\D{\alpha}=e^{\alpha\a^\dagger - \alpha^*\a}$ has matrix elements
$$
\bra{m}\D{\alpha}\ket{n} = \sqrt{\tfrac{n!}{m!}}\,\alpha^{m-n} e^{-\abs{\alpha}^2/2} L_n^{(m-n)}(\abs{\alpha}^2),
$$
a generalized Laguerre polynomial.

\strong{The catch:} simulating the elementary CV gates this way costs resources \strong{exponential} in the qubits-per-mode — the encoding fights you.

\column
\row
\figure[.85]{comp_power.svg}{$A\to B$: can hardware $A$ efficiently simulate processor $B$?}
\endrow
\endcolumn



## The Idea: Encode the Wave Function, Not the Fock Levels

\columns
A CV state has a \strong{position wave function} $\psi(q)$. Instead of truncating Fock levels, \strong{sample $\psi$ on a grid} and store the samples as qubit amplitudes:
$$
\enc_Q(\ket{\psi}) = \sqrt{\lambda}\sum_{j=0}^{N-1} \psi(\lambda\tilde{j})\,\ket{j}, \qquad N = 2^n.
$$

- $n$ qubits $\Rightarrow$ a $2^n$-point grid — exponentially fine resolution in the qubit count.
- Same move as discretizing a PDE field onto a grid, then storing the grid in a state vector.
- Position and momentum pictures are linked by the \strong{quantum Fourier transform} — the discrete FFT, in $O(n^2)$ gates.

\column
\row
\figure[.8]{encodings.png}{Fock-basis vs. position (wave-function) encoding.}
\endrow
\endcolumn



## Why It Works: Diagonalize in the Right Basis

\columns
The payoff: \strong{position operators are diagonal} in the position grid, \strong{momentum operators are diagonal} in the momentum grid.

- Any $e^{i f(\hat q)}$ is just a layer of phase rotations ($R_z$) on the position register — \strong{exact}, no truncation error.
- Any $e^{i g(\hat p)}$ is the same, after one QFT to hop into the momentum basis.
- A Gaussian gate = a short product of position-only and momentum-only pieces, sandwiched by QFTs.

\strong{The only error comes from the QFTs} (finite-grid aliasing), and it is fully characterized.

\column
\strong{"Rotating by not rotating":} an oscillator rotation $\RR{\theta}$ is three shear layers,
$$
\RR{\theta} = e^{-\frac{i}{2}\tan\frac\theta2\,\hat q^2}\, e^{-\frac{i}{2}\sin\theta\,\hat p^2}\, e^{-\frac{i}{2}\tan\frac\theta2\,\hat q^2},
$$
each a diagonal phase layer in its own basis.
\endcolumn



## The Result: Exponential Savings

\columns
Every Gaussian and conditional-Gaussian gate — displacement, rotation, squeezing, beam splitter, and their qubit-controlled versions — simulates in
$$
O\!\big(\log^2(\Gamma + \log\tfrac1\epsilon)\big)
$$
elementary qubit gates per gate ($\Gamma$ = Fock-level bound, $\epsilon$ = target error).

- \strong{Polylogarithmic} per gate, vs. \strong{exponential} for Fock-basis encoding.
- Each gate is a few QFTs plus $O(n^2)$ phase rotations — FFT-and-diagonal-scale, the GPU's bread and butter.
- Rigorous QFT-error bounds turn this into a concrete resource budget: e.g. error $\lesssim 10^{-6}$ up to Fock level $10$ needs just $n=6$ qubits per mode.

\column
\strong{Measurements too:}
- Homodyne — read out the position register directly.
- Heterodyne — a beam splitter plus homodyne.
- Photon counting — iterative phase estimation on a conditional rotation.

\row
\figure[.7]{heterodyne.png}{Heterodyne = beam splitter + homodyne.}
\endrow
\endcolumn



## Summary

- A quantum state is a $2^n$ complex vector; gates are unitary matmuls; measurement samples it.
- Entanglement is the source of both the power and the exponential simulation cost — a natural fit for GPUs.
- \strong{QSVT} unifies many quantum algorithms as polynomial functions of an operator's spectrum, costed in operator calls.
- My work pushes on the limits of estimation and on extending the QSP/QSVT toolbox.



## 

&nbsp;

\hcenter{Thank you!}

\row
\qrcode{https://helloluxi.github.io/phd-defense}{Slides}
&nbsp;
\qrcode{https://xlu.casa/s/}{Homepage}
\endrow
