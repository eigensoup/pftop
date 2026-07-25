# Definition: Nucleus

A **nucleus** is an algebraic operator on a frame that formalizes the notion of a **point-free subspace** or quotient locale.

---

## 1. Mathematical Definition

Let $L$ be a frame (a complete lattice satisfying the infinite distributive law). A map $j : L \to L$ is a **nucleus** if it satisfies the following four conditions for all $x, y \in L$:

1. **Inflationary**: $x \leq j(x)$
2. **Monotone**: $x \leq y \implies j(x) \leq j(y)$
3. **Idempotent**: $j(j(x)) = j(x)$
4. **Meet-preserving**: $j(x \wedge y) = j(x) \wedge j(y)$

*Note: Monotonicity can actually be deduced from meet-preservation and the inflationary property, but is often included explicitly for algebraic clarity.*

---

## 2. Motivation

In point-set topology, a subspace of $X$ is defined by a subset of points. In point-free topology (locale theory), there are no points; we must define subspaces by their "open sets" (the elements of the frame). 

A subspace is represented by a quotient of the frame of opens. A frame quotient map $q : L \to M$ is a surjective frame homomorphism. By the theory of Galois connections, any such surjective map is uniquely associated with a meet-preserving, inflationary, and idempotent endomap $j = m \circ q : L \to L$ (where $m$ is the right adjoint of $q$). This endomap is precisely a nucleus.

Thus, the study of point-free subspaces (sublocales) is equivalent to the study of nuclei.

---

## 3. Examples

### The Identity Nucleus
The identity map $id : L \to L$ is always a nucleus. It corresponds to the full subspace (the locale $L$ itself).

### The Closed Nucleus
For any element $u \in L$, the map:
$$j^u(x) = u \vee x$$
is a nucleus. The sublocale of fixed points under $j^u$ corresponds to the **closed sublocale** associated with $u$.

### The Open Nucleus
For any element $u \in L$, the map:
$$j_u(x) = u \to x$$
(where $\to$ is the Heyting implication) is a nucleus. The sublocale of fixed points under $j_u$ corresponds to the **open sublocale** associated with $u$.

---

## 4. Equivalent Formulations

A map $j : L \to L$ is a nucleus if and only if:
- It is a meet-preserving closure operator on $L$.
- $x \leq j(y) \iff j(x) \leq j(y)$ for all $x, y \in L$.

---

## 5. Category-Theoretic Interpretation

In the category of frames $\mathbf{Frm}$, a nucleus $j$ on $L$ defines a congruence on $L$. The fixed-point frame:
$$L_j = \{x \in L \mid j(x) = x\}$$
is the coequalizer of the relation induced by $j$, and the map $j : L \to L_j$ is an extremal epimorphism in $\mathbf{Frm}$.

Dually, in the category of locales $\mathbf{Loc} = \mathbf{Frm}^{\text{op}}$, the inclusion $L_j \hookrightarrow L$ is an extremal monomorphism, representing a sublocale embedding.

---

## 6. Relation to Sublocales

There is a bijective correspondence between:
1. Nuclei on a frame $L$.
2. Congruences on a frame $L$ (which correspond to quotient frames).
3. Sublocales of the locale $X = L^{\text{op}}$.

---

## 7. References

- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2.
- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 2.

---

## 8. Lean 4 Implementation Status

- **Status**: Completed & Verified (Core & Monotonicity Theorem)
- **File**: `Math/Sublocales/Basic.lean`
- **Definition Signature**:
  ```lean
  structure Nucleus (L : Type u) [Frame L] where
    toFun : L → L
    inflationary' : ∀ x : L, x ≤ toFun x
    idempotent' : ∀ x : L, toFun (toFun x) = toFun x
    map_inf' : ∀ x y : L, toFun (x ⊓ y) = toFun x ⊓ toFun y
  ```

---

## 9. Future Extensions

- Prove that the set of all nuclei on $L$ forms a complete lattice (the sublocale lattice).
- Define open and closed nuclei explicitly and prove they are complements in the sublocale lattice.
