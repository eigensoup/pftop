# Definition: Co-frame (Coframe)

A **co-frame** (often spelled **coframe**) is the order-theoretic dual of a frame. While a frame generalizes the lattice of open sets of a topological space (satisfying the infinite distributive law of binary meets over arbitrary joins), a co-frame generalizes the lattice of closed sets of a topological space (satisfying the dual infinite distributive law of binary joins over arbitrary meets).

---

## 1. Mathematical Definition

A **co-frame** is a complete lattice $C$ that satisfies the **infinite distributive law of joins over meets**:
$$x \lor \left( \bigwedge S \right) = \bigwedge \{x \lor y \mid y \in S\}$$
for all $x \in C$ and any subset $S \subseteq C$.

### Order Duality
A complete lattice $C$ is a co-frame if and only if its opposite lattice $C^{\text{op}}$ (the same set with the reversed order) is a frame.

---

## 2. Motivation and Topological Analog

In point-free topology:
- **Frames** represent the lattice of **open sets** $\mathcal{O}(X)$ of a space.
- **Co-frames** represent the lattice of **closed sets** $\mathcal{C}(X)$ of a space.

While open sets are closed under arbitrary unions ($\bigvee$) and finite intersections ($\wedge$), closed sets are closed under arbitrary intersections ($\bigwedge$) and finite unions ($\lor$). In the lattice of closed sets:
- Arbitrary meet ($\bigwedge$) is set-theoretic intersection.
- Binary join ($\lor$) is set-theoretic union.

The distributivity of finite union over arbitrary intersection is precisely the co-frame law:
$$F \cup \left( \bigcap_{i} G_i \right) = \bigcap_{i} (F \cup G_i)$$
which holds for any closed sets $F, G_i$. Thus, the lattice of closed sets of any topological space is always a co-frame.

---

## 3. Key Examples of Co-frames

1. **The Lattice of Closed Sets**: For any topological space $X$, the lattice of closed sets ordered by inclusion is a co-frame.
2. **Opposite of a Frame**: For any frame $L$, the dual lattice $L^{\text{op}}$ is a co-frame.
3. **The Lattice of Sublocales $\mathcal{S}(L)$**: For any frame $L$, the lattice of all its sublocales (ordered by inclusion) forms a co-frame. This is the point-free analogue of the lattice of all subspaces of a space.

---

## 4. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter II, Section 4.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2.

---

## 5. Lean 4 Implementation Status

- **Status**: Completed & Verified
- **File**: `Math/Frames/Coframe.lean`
- **Key Signatures**:
  ```lean
  class Coframe (α : Type u) extends CompleteLattice α where
    sup_sInf_distrib : ∀ (x : α) (s : Set α), x ⊔ sInf s = sInf (Set.image (fun y => x ⊔ y) s)
  ```
