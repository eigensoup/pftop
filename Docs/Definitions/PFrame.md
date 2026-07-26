# Definition: P-Frame and Cozero Elements

A **P-frame** is the point-free analogue of a topological **P-space** (a space where every $G_\delta$ set is open, or equivalently, every cozero set is closed). In point-free topology, a P-frame is formalized as a frame in which every **cozero element** is complemented.

---

## 1. Mathematical Definitions

Let $L$ be a frame.

### Rather Below Relation ($\prec$)
An element $a \in L$ is **rather below** $b \in L$ (written $a \prec b$) if there exists a "separator" $s \in L$ such that:
$$a \wedge s = \bot \quad \text{and} \quad b \vee s = \top$$
In the spatial frame $\mathcal{O}(X)$, $U \prec V$ corresponds to the topological condition $\overline{U} \subseteq V$.

### Completely Below Relation ($\prec\prec$)
An element $a \in L$ is **completely below** $b \in L$ (written $a \prec\prec b$) if there exists a **rational scale** interpolating between them. A rational scale is a family of elements $\{c_q \mid q \in \mathbb{Q}\}$ such that:
- $c_0 = a$ and $c_1 = b$
- $p < q \implies c_p \prec c_q$

This relation is the point-free counterpart to functional separation. In $\mathcal{O}(X)$, $U \prec\prec V$ means there is a continuous function $f : X \to [0, 1]$ with $f|_U = 0$ and $f|_{X \setminus V} = 1$.

### Cozero Elements
An element $c \in L$ is a **cozero element** if it is the join of a countable sequence of elements completely below it:
$$c = \bigvee_{n \in \mathbb{N}} c_n \quad \text{where } c_n \prec\prec c \text{ for all } n$$

### P-Frames
A frame $L$ is a **P-frame** if every cozero element in $L$ is **complemented** (or clopen), meaning:
$$\forall c \in L, \quad c \text{ is cozero} \implies \exists c^* \in L, \quad c \wedge c^* = \bot \quad \text{and} \quad c \vee c^* = \top$$

---

## 2. Motivation & Duality

P-spaces and P-frames are central to point-free separation theory and the ring of real-valued continuous functions on a frame:
- **Ring of Continuous Functions:** A frame $L$ is a P-frame if and only if its ring of real-valued continuous functions, $\mathcal{R}L$, is a **von Neumann regular ring** (every element has a pseudoinverse).
- **Boolean Algebras:** In a P-frame, the $\sigma$-frame of cozero elements $\text{Coz}(L)$ forms a Boolean algebra.
- **Duality:** A Tychonoff space $X$ is a P-space if and only if its topology $\mathcal{O}(X)$ is a P-frame.

---

## 3. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapters VII (for the completely below relation) and XIV (for cozero elements and P-frames).
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter III.

---

## 4. Lean 4 Implementation Status

- **Status**: Completed & Verified
- **File**: `Math/Frames/PFrame.lean`
- **Key Signatures**:
  ```lean
  def RatherBelow {L : Type u} [Frame L] (a b : L) : Prop :=
    ∃ s : L, a ⊓ s = ⊥ ∧ b ⊔ s = ⊤

  infixl:50 " ≺ " => RatherBelow

  def CompletelyBelow {L : Type u} [Frame L] (a b : L) : Prop :=
    ∃ f : ℚ → L, f 0 = a ∧ f 1 = b ∧ ∀ p q : ℚ, p < q → f p ≺ f q

  infixl:50 " ≺≺ " => CompletelyBelow

  def IsCozero {L : Type u} [Frame L] (c : L) : Prop :=
    ∃ f : Nat → L, (∀ n, f n ≺≺ c) ∧ CompleteLattice.sSup (sequenceRange f) = c

  def IsComplemented {L : Type u} [Frame L] (a : L) : Prop :=
    ∃ b : L, a ⊓ b = ⊥ ∧ a ⊔ b = ⊤

  class PFrame (L : Type u) [Frame L] : Prop where
    cozero_complemented : ∀ c : L, IsCozero c → IsComplemented c
  ```
