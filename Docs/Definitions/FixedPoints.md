# Definition: Fixed Point Frame

For any nucleus $j$ on a frame $L$, the set of fixed points of $j$ forms a frame, denoted $L_j$, which represents the subspace (sublocale) defined by the nucleus.

---

## 1. Mathematical Definition

Let $L$ be a frame, and let $j : L \to L$ be a nucleus. The **fixed point frame** $L_j$ (or $L_{\text{fix}(j)}$) is the subset of elements in $L$ that are invariant under $j$:
$$L_j = \{x \in L \mid j(x) = x\}$$

We define the following operations on $L_j$:
1. **Partial Order**: Inherited from $L$:
   $$x \leq_{L_j} y \iff x \leq_L y$$
2. **Top Element**: $\top_{L_j} = \top_L$ (since $j(\top) = \top$).
3. **Meets (Infimum)**: For any $x, y \in L_j$:
   $$x \wedge_{L_j} y = x \wedge_L y$$
   *Proof*: Since $x, y \in L_j$, we have $j(x) = x$ and $j(y) = y$. Thus:
   $$j(x \wedge_L y) = j(x) \wedge_L j(y) = x \wedge_L y$$
   So the meet in $L$ is already a fixed point.
4. **Joins (Supremum)**: For any subset $S \subseteq L_j$:
   $$\bigvee_{L_j} S = j\left(\bigvee_L S\right)$$
   *Proof*: Since $j$ is idempotent, $j(j(u)) = j(u)$ for any $u \in L$. Thus $j(\bigvee S)$ is a fixed point. It acts as the least upper bound in $L_j$.

---

## 2. Motivation

In point-free topology, any quotient of a frame $L$ (which corresponds to a sublocale of $L^{\text{op}}$) is always of the form $L_j$ for some nucleus $j$.
The map $j : L \to L_j$ is a surjective frame homomorphism, and the inclusion $i : L_j \hookrightarrow L$ is its right adjoint (which is a meet-preserving, inflationary, and idempotent map of posets).

Thus, studying quotients of $L$ is algebraically identical to studying the fixed point frames of nuclei on $L$.

---

## 3. Equivalent formulations

- The frame $L_j$ can be defined as the image of $L$ under $j$, i.e., $L_j = j(L)$. This is equivalent because $x \in j(L) \iff j(x) = x$ due to idempotence.
- The inclusion map $i : L_j \hookrightarrow L$ and the nucleus $j : L \to L_j$ form a **Galois insertion** (or reflection), where $j$ is the left adjoint and $i$ is the right adjoint.

---

## 4. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 2, Proposition 2.2.1.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.2, Proposition 2.2.

---

## 5. Lean 4 Implementation Status

- **Status**: Completed & Verified
- **File**: `Math/Sublocales/FixedPoints.lean`
- **Key Signatures**:
  ```lean
  def FixedPoints (j : Nucleus L) : Type* := { x : L // j x = x }

  instance : PartialOrder (FixedPoints j) := Subtype.partialOrder _

  instance : Min (FixedPoints j) where
    min x y := ⟨x.val ⊓ y.val, by ...⟩

  instance : Max (FixedPoints j) where
    max x y := ⟨j (x.val ⊔ y.val), ...⟩
  ```
