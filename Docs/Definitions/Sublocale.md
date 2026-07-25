# Definition: Sublocale Set

A **sublocale** of a frame $L$ (representing a subspace of the locale $L^{\text{op}}$) can be formalized as a subset $S \subseteq L$ closed under arbitrary meets and Heyting implications from the left.

---

## 1. Mathematical Definition

Let $L$ be a frame. A subset $S \subseteq L$ is a **sublocale set** if it satisfies the following two closure conditions:

1. **Closure under arbitrary meets ($\bigwedge$)**:
   For any subset $M \subseteq S$, the infimum in $L$ lies in $S$:
   $$\bigwedge M \in S$$
   *Note: Since the empty subset $\emptyset \subseteq S$, this implies that $\top = \bigwedge \emptyset \in S$.*
2. **Closure under left Heyting implication ($\to$)**:
   For any $s \in S$ and any $x \in L$, the Heyting implication lies in $S$:
   $$x \to s \in S$$

---

## 2. Equivalence with Nuclei

There is a bijective correspondence between sublocale sets $S \subseteq L$ and nuclei $j : L \to L$.

### Direction 1: Nucleus $\implies$ Sublocale Set
Let $j : L \to L$ be a nucleus. The set of its fixed points $S_j = \{x \in L \mid j(x) = x\}$ is a sublocale set.

#### Proof of closure under meets ($\bigwedge$):
Let $M \subseteq S_j$. We show $j(\bigwedge M) = \bigwedge M$.
1. Since $j$ is inflationary, $\bigwedge M \leq j(\bigwedge M)$.
2. To show $j(\bigwedge M) \leq \bigwedge M$, we show that $j(\bigwedge M)$ is a lower bound of $M$:
   For any $m \in M$, since $\bigwedge M \leq m$ and $j$ is monotone, we have:
   $$j(\bigwedge M) \leq j(m) = m \quad (\text{since } m \in S_j \implies j(m) = m)$$
   Thus, $j(\bigwedge M) \leq m$ for all $m \in M$, which implies:
   $$j(\bigwedge M) \leq \bigwedge M$$
3. By antisymmetry, $j(\bigwedge M) = \bigwedge M$, so $\bigwedge M \in S_j$.
$\square$

#### Proof of closure under implication ($\to$):
Let $s \in S_j$ and $x \in L$. We show $j(x \to s) = x \to s$.
1. Since $j$ is inflationary, $x \to s \leq j(x \to s)$.
2. To show $j(x \to s) \leq x \to s$, by the adjunction of Heyting implication, we must show:
   $$j(x \to s) \wedge x \leq s$$
3. Since $x \leq j(x)$ and $j$ is meet-preserving and monotone, we have:
   $$j(x \to s) \wedge x \leq j(x \to s) \wedge j(x) = j((x \to s) \wedge x) \leq j(s) = s$$
   (The last inequality holds because $(x \to s) \wedge x \leq s$ and $j$ is monotone, and $j(s) = s$ since $s \in S_j$).
4. Thus, by Heyting adjunction, $j(x \to s) \leq x \to s$.
5. By antisymmetry, $j(x \to s) = x \to s$, so $x \to s \in S_j$.
$\square$

---

### Direction 2: Sublocale Set $\implies$ Nucleus
Let $S \subseteq L$ be a sublocale set. We define a map $j_S : L \to L$ by:
$$j_S(x) = \bigwedge \{s \in S \mid x \leq s\}$$
Then $j_S$ is a nucleus, and its set of fixed points is precisely $S$.

---

## 3. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 3, Theorem 3.1.1.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2.

---

## 4. Lean 4 Implementation Status

- **Status**: Completed & Verified
- **File**: `Math/Sublocales/Sublocale.lean`
- **Key Signatures**:
  ```lean
  structure Sublocale (L : Type*) [Frame L] where
    carrier : Set L
    closed_sInf : ∀ M ⊆ carrier, sInf M ∈ carrier
    closed_himp : ∀ s ∈ carrier, ∀ x : L, x ⇨ s ∈ carrier

  def ofNucleus (j : Nucleus L) : Sublocale L := ...
  ```
