# Theorem: Nucleus Monotonicity and the Identity Nucleus

This document presents the mathematical proof and formalization of two foundational properties in point-free topology: **Nucleus Monotonicity** and the existence of the **Identity Nucleus**.

---

## 1. Monotonicity of a Nucleus

A nucleus is defined algebraically in our library as a meet-preserving, inflationary, and idempotent operator. Interestingly, **monotonicity** is not required to be bundled as an independent axiom; it is constructively derivable from meet-preservation and the properties of infima.

### Mathematical Formulation & Proof
Let $L$ be a frame and $j : L \to L$ be a meet-preserving operator ($j(a \wedge b) = j(a) \wedge j(b)$). Let $x, y \in L$ with $x \leq y$.

#### Proof:
1. Since $x \leq y$, the meet $x \wedge y$ is exactly $x$.
2. Applying $j$ to both sides, we get:
   $$j(x \wedge y) = j(x)$$
3. Since $j$ is meet-preserving, we have:
   $$j(x) \wedge j(y) = j(x)$$
4. By the definition of the meet operation in a lattice, $A \wedge B = A \implies A \leq B$. Thus:
   $$j(x) \leq j(y)$$
$\square$

---

## 2. The Identity Nucleus

The identity function $id : L \to L$ maps every element to itself:
$$\text{identity}(x) = x$$
This is the simplest possible nucleus on any frame, corresponding to the "top" sublocale (the space itself).

---

## 3. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 2, Lemma 2.1.1.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2.

---

## 4. Verified Lean 4 Code

These proofs are fully verified and compile instantly in `Math/Sublocales/Basic.lean`:

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

/-- The identity nucleus on a frame `L` maps every element to itself. -/
def identity (L : Type u) [Frame L] : Nucleus L where
  toFun x := x
  inflationary' _ := Preorder.le_refl _
  idempotent' _ := rfl
  map_inf' _ _ := rfl
```
