# Definition: Stone Locale

A **Stone locale** is the point-free analogue of a Stone space (a compact, Hausdorff, zero-dimensional topological space). In point-free topology, Stone locales are formalized constructively as compact, zero-dimensional frames.

---

## 1. Mathematical Definitions

Let $L$ be a frame.

### Clopen (Complemented) Elements
An element $a \in L$ is **clopen** (or complemented) if it has a complement in the lattice:
$$\exists b \in L, \quad a \wedge b = \bot \quad \text{and} \quad a \vee b = \top$$

### Zero-Dimensional Frames
A frame $L$ is **zero-dimensional** if every element $x \in L$ can be represented as the supremum of a set of clopen elements:
$$\forall x \in L, \quad \exists S \subseteq L, \quad (\forall s \in S, s \text{ is clopen}) \wedge \bigvee S = x$$

### Compact Frames
A frame $L$ is **compact** if every join-cover of the top element $\top$ has a finite subcover. In order theory, this is modeled by stating that the top element $\top$ is a **compact element** of the lattice:
$$\forall M \subseteq L, \quad \top \leq \bigvee M \implies \exists F \subseteq M \text{ finite}, \quad \top \leq \bigvee F$$

### Stone Locales
A locale $X = L^{\text{op}}$ is a **Stone locale** if its underlying frame $L$ is both compact and zero-dimensional.

---

## 2. Motivation & Duality

In classical topology, Stone's Representation Theorem states that the category of Stone spaces is dually equivalent to the category of Boolean algebras. However, proving this duality classically requires the **Axiom of Choice** (specifically, the Boolean Prime Ideal Theorem) to reconstruct points.

In point-free topology, the duality between **Stone locales** and **Boolean algebras** is fully constructive:
- For any Boolean algebra $B$, the frame of ideals of $B$, denoted $\text{Idl}(B)$, is a Stone locale.
- For any Stone locale $L$, the set of clopen elements $\text{Clop}(L)$ forms a Boolean algebra.
- These two constructions define a dual equivalence of categories:
  $$\mathbf{StoneLoc} \simeq \mathbf{BoolAlg}^{\text{op}}$$
This equivalence does not require any choice principles, demonstrating the foundational and constructive power of point-free topology.

---

## 3. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter VII (Stone Spaces and Stone Duality).
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter III (Stone Duality).

---

## 4. Lean 4 Implementation Status

- **Status**: Completed & Verified
- **File**: `Math/Spectral/Basic.lean`
- **Key Signatures**:
  ```lean
  def IsClopen {L : Type*} [Frame L] (a : L) : Prop :=
    ∃ b : L, a ⊓ b = ⊥ ∧ a ⊔ b = ⊤

  def IsZeroDimensional (L : Type*) [Frame L] : Prop :=
    ∀ x : L, ∃ S : Set L, (∀ s ∈ S, IsClopen s) ∧ sSup S = x

  class StoneLocale (L : Type*) [Frame L] : Prop where
    compact : IsCompactElement (⊤ : L)
    zero_dim : IsZeroDimensional L
  ```
