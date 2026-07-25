# Definition: Open and Closed Nuclei

For any element $u$ in a frame $L$, there are two canonical nuclei associated with it: the **closed nucleus** $j^u$ and the **open nucleus** $j_u$. These represent the closed and open sublocales of the space, respectively.

---

## 1. Closed Nucleus

### Definition
For a fixed element $u \in L$, the **closed nucleus** $j^u : L \to L$ is defined as:
$$j^u(x) = u \vee x$$

### Mathematical Verification
To be a nucleus, $j^u$ must satisfy four properties:
1. **Inflationary**: $x \leq u \vee x$ holds trivially by the properties of supremum.
2. **Monotone**: $x \leq y \implies u \vee x \leq u \vee y$ holds by monotonicity of join.
3. **Idempotent**:
   $$j^u(j^u(x)) = u \vee (u \vee x) = (u \vee u) \vee x = u \vee x = j^u(x)$$
4. **Meet-preserving**:
   $$j^u(x \wedge y) = u \vee (x \wedge y) = (u \vee x) \wedge (u \vee y) = j^u(x) \wedge j^u(y)$$
   This holds due to the distributive law of frames (as frames are distributive lattices).

---

## 2. Open Nucleus

### Definition
For a fixed element $u \in L$, the **open nucleus** $j_u : L \to L$ is defined using the Heyting implication (exponential in the category of posets):
$$j_u(x) = u \to x$$

### Mathematical Verification
1. **Inflationary**: $x \leq u \to x$ is equivalent to $u \wedge x \leq x$ by the adjunction of Heyting implication, which holds trivially.
2. **Idempotent**:
   $$j_u(j_u(x)) = u \to (u \to x) = (u \wedge u) \to x = u \to x = j_u(x)$$
3. **Meet-preserving**:
   $$j_u(x \wedge y) = u \to (x \wedge y) = (u \to x) \wedge (u \to y) = j_u(x) \wedge j_u(y)$$
   This holds by the standard properties of the exponential / implication operator.

---

## 3. Motivation & Duality

In point-set topology, any open subset $U \subseteq X$ has a closed complement $X \setminus U$.
In point-free topology, for any element $u \in L$ (representing an "open set"), the fixed points of $j_u$ form the **open sublocale** associated with $u$, and the fixed points of $j^u$ form the **closed sublocale** associated with $u$.

These two sublocales are complementary in the complete lattice of sublocales of $X = L^{\text{op}}$. This means:
- Their intersection is the empty sublocale (corresponding to the top nucleus $x \mapsto \top$).
- Their join is the entire locale (corresponding to the identity nucleus $x \mapsto x$).

---

## 4. References

- Picado, J., & Pultr, A. (2012). *Frames and Locales: Topology without points*. Chapter III, Section 3.
- Johnstone, P. T. (1982). *Stone Spaces*. Chapter II, Section 2.3.

---

## 5. Lean 4 Implementation Status

- **Status**: Completed (Closed Nucleus) & Verified
- **File**: `Math/Sublocales/OpenClosed.lean`
- **Key Signatures**:
  ```lean
  def closedNucleus (u : L) : Nucleus L where
    toFun x := u ⊔ x
    inflationary' x := le_sup_right
    idempotent' x := by rw [sup_assoc, sup_idem]
    map_inf' x y := by rw [sup_inf_left]
  ```
