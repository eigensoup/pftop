# Theorem: Nucleus Monotonicity and Top-Preservation

This document outlines the mathematical proof and formalization of two fundamental properties of any nucleus $j$ on a frame $L$:
1. **Monotonicity**: $x \leq y \implies j(x) \leq j(y)$
2. **Top-Preservation**: $j(\top) = \top$

---

## 1. Mathematical Statement & Proofs

Let $L$ be a frame, and let $j : L \to L$ be a map satisfying:
- **Inflationary**: $\forall x \in L, x \leq j(x)$
- **Meet-preserving**: $\forall x, y \in L, j(x \wedge y) = j(x) \wedge j(y)$

### Theorem 1 (Monotonicity)
For all $x, y \in L$, if $x \leq y$, then $j(x) \leq j(y)$.

#### Proof:
1. Assume $x \leq y$. By definition of the meet operation in a lattice, this is equivalent to:
   $$x \wedge y = x$$
2. Applying the map $j$ to both sides, we get:
   $$j(x \wedge y) = j(x)$$
3. Since $j$ is meet-preserving, we have:
   $$j(x) \wedge j(y) = j(x)$$
4. By the properties of the meet operation, $A \wedge B = A \implies A \leq B$. Thus:
   $$j(x) \leq j(y)$$
$\square$

---

### Theorem 2 (Top-Preservation)
The top element $\top$ is always a fixed point of $j$, i.e., $j(\top) = \top$.

#### Proof:
1. Since $j$ is inflationary, we have:
   $$\top \leq j(\top)$$
2. Since $\top$ is the top element of the complete lattice $L$, any element in $L$ is bounded above by $\top$. Thus:
   $$j(\top) \leq \top$$
3. By antisymmetry of the partial order $\leq$, we conclude:
   $$j(\top) = \top$$
$\square$

---

## 2. Citations & References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 2, Lemma 2.1.1.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2.

---

## 3. Lean 4 Implementation

These theorems are formalized in `Math/Sublocales/Basic.lean` as follows:

```lean
/-- Any nucleus is monotone. -/
theorem monotone (x y : L) (h : x ≤ y) : j.toFun x ≤ j.toFun y := by
  have h1 : x ⊓ y = x := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.inf_le_left x y
    · exact CompleteLattice.le_inf x x y (Preorder.le_refl x) h
  have h2 : j.toFun (x ⊓ y) = j.toFun x := by rw [h1]
  rw [map_inf] at h2
  rw [← h2]
  exact CompleteLattice.inf_le_right (j.toFun x) (j.toFun y)

/-- A nucleus preserves the top element (top is mapped to top). -/
@[simp]
theorem map_top : j.toFun CompleteLattice.top = CompleteLattice.top := by
  apply PartialOrder.le_antisymm
  · exact CompleteLattice.le_top (j.toFun CompleteLattice.top)
  · exact j.inflationary CompleteLattice.top
```
