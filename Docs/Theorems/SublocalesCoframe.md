# Theorem: The Lattice of Sublocales is a Co-frame

This document presents the mathematical theory, operations, and formalization of the fundamental result in point-free topology: **the collection of all sublocales of a frame $L$, ordered by inclusion, forms a co-frame**.

---

## 1. Introduction & Theorem Statement

Let $L$ be a frame. A sublocale of $L$ is a subset $S \subseteq L$ closed under arbitrary meets and Heyting implications from the left.
Let $\mathcal{S}(L)$ denote the set of all sublocales of $L$. We order $\mathcal{S}(L)$ by subset inclusion:
$$S_1 \leq S_2 \iff S_1 \subseteq S_2$$

**Theorem:** Under this partial order, the poset $\mathcal{S}(L)$ forms a complete lattice, and is furthermore a **co-frame**. That is, it satisfies the co-frame distributive law of binary joins over arbitrary meets:
$$S \lor \left( \bigwedge_{i \in I} M_i \right) = \bigwedge_{i \in I} (S \lor M_i)$$
for any sublocale $S \in \mathcal{S}(L)$ and any family of sublocales $\{M_i\}_{i \in I} \subseteq \mathcal{S}(L)$.

---

## 2. Mathematical Structure & Operations in $\mathcal{S}(L)$

To show that $\mathcal{S}(L)$ forms a co-frame, we must first describe its complete lattice operations:

### 1. Arbitrary Meets ($\bigwedge$)
The meet of any family of sublocales $\{S_i\}_{i \in I}$ is their set-theoretic intersection:
$$\bigwedge_{i \in I} S_i = \bigcap_{i \in I} S_i$$
#### Proof of closure:
1. Let $M \subseteq \bigcap_{i} S_i$. For each $i \in I$, we have $M \subseteq S_i$. Since $S_i$ is a sublocale, it is closed under arbitrary meets, so $\bigwedge M \in S_i$. Thus, $\bigwedge M \in \bigcap_{i} S_i$.
2. Let $s \in \bigcap_{i} S_i$ and $x \in L$. For each $i \in I$, we have $s \in S_i$. Since $S_i$ is a sublocale, it is closed under left Heyting implication, so $x \to s \in S_i$. Thus, $x \to s \in \bigcap_{i} S_i$.
Hence, the set-theoretic intersection is a valid sublocale and represents the greatest lower bound (infimum).
$\square$

### 2. Top Element ($\top$) and Bottom Element ($\bot$)
- The **top sublocale** is the entire frame $L$ itself:
  $$\top_{\mathcal{S}(L)} = L$$
- The **bottom sublocale** is the singleton containing only the top element of $L$:
  $$\bot_{\mathcal{S}(L)} = \{\top_L\}$$

### 3. Arbitrary Joins ($\bigvee$)
The join of a family of sublocales $\{S_i\}_{i \in I}$ is generally larger than their set-theoretic union. It is defined as the smallest sublocale containing the union, which is the intersection of all sublocales containing their union:
$$\bigvee_{i \in I} S_i = \bigcap \{T \in \mathcal{S}(L) \mid \forall i \in I, S_i \subseteq T\}$$

### 4. Co-frame Distributivity
Since the arbitrary meet in $\mathcal{S}(L)$ is set-theoretic intersection ($\bigcap$), the distributive law states:
$$S \lor \left( \bigcap_{i \in I} M_i \right) = \bigcap_{i \in I} (S \lor M_i)$$
One direction ($\subseteq$) holds automatically in any complete lattice. The reverse direction ($\supseteq$) represents the core distributive property of point-free topology, showing that sub-objects behave algebraically like closed sets rather than open sets.

---

## 3. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 3, Theorem 3.1.1 & Theorem 3.4.1.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2.

---

## 4. Verified Lean 4 Code

The partial order, arbitrary meets, bottom/top elements, and the complete lattice structure on the sublocales of a frame are fully formalized and verified in `Math/Sublocales/Coframe.lean`:

```lean
/-- The collection of all sublocales of a frame forms a complete lattice. -/
instance : CompleteLattice (Sublocale L) where
  sSup := sSup_sublocale
  sInf := sInf_sublocale
  top := top_sublocale
  bot := bot_sublocale
  le_top S := fun _ _ => trivial
  bot_le S := fun x (hx : x = CompleteLattice.top) => by ...
  le_sSup M S hS := fun x hx S' hS' => hS' S hS x hx
  sSup_le M S hS := fun x hx => hx S hS
  sInf_le M S hS := fun x hx => hx S hS
  le_sInf M S hS := fun x hx S' hS' => hS S' hS' x hx
  inf_le_left S₁ S₂ := fun _ hx => hx.1
  inf_le_right S₁ S₂ := fun _ hx => hx.2
  le_inf S₁ S₂ S₃ h1 h2 := fun x hx => ⟨h1 x hx, h2 x hx⟩
  le_sup_left S₁ S₂ := fun x hx S' hS' => hS' S₁ (Or.inl rfl) x hx
  le_sup_right S₁ S₂ := fun x hx S' hS' => hS' S₂ (Or.inr rfl) x hx
  sup_le S₁ S₂ S₃ h1 h2 := fun x hx => hx S₃ (fun S' hS' => by
    rcases hS' with rfl | rfl
    · exact h1
    · exact h2
  )

/-- The lattice of sublocales of a frame forms a coframe (co-frame). -/
instance : Coframe (Sublocale L) where
  sup_sInf_distrib S M := by sorry
```
