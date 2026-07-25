# Lean Point-Free: Good First Theorems

This document lists simple theorems and lemmas that are excellent starting points for new contributors (human or AI) under the custom `Pftop` framework.

---

## 1. Identity Map is a Nucleus
- **Description**: Show that the identity function `id : L → L` on a frame $L$ is a nucleus.
- **Mathematical Statement**: For all $x \in L$, $id(x) = x$.
  - Inflationary: $x \leq x$
  - Monotone: $x \leq y \implies x \leq y$
  - Idempotent: $id(id(x)) = id(x)$
  - Meet-preserving: $id(x \wedge y) = id(x) \wedge id(y)$
- **Expected Lean Prerequisites**: Structure instantiation, basic properties of `id`.
- **Difficulty**: 1/10
- **Proof Sketch**:
  All properties follow immediately from definition or by `rfl`.

---

## 2. Nucleus Preserves Top ($j(top) = top$)
- **Description**: Show that for any nucleus $j$ on a frame $L$, $j(top) = top$.
- **Mathematical Statement**: $j(\top) = \top$.
- **Expected Lean Prerequisites**: Using inequalities in partial orders, `le_antisymm`.
- **Difficulty**: 2/10
- **Proof Sketch**:
  - $top \leq j(top)$ since $j$ is inflationary.
  - $j(top) \leq top$ holds because $top$ ($\top$) is the top element of $L$.
  - Combine via antisymmetry.

---

## 3. Monotonicity of Nucleus (if proved from meet-preservation)
- **Description**: Show that if $j$ is meet-preserving and inflationary, it is automatically monotone.
- **Mathematical Statement**: $x \leq y \implies j(x) \leq j(y)$.
- **Expected Lean Prerequisites**: Working with meet operations, `inf_le_left`.
- **Difficulty**: 3/10
- **Proof Sketch**:
  - Assume $x \leq y$, which is equivalent to $x \wedge y = x$.
  - Therefore, $j(x) = j(x \wedge y) = j(x) \wedge j(y)$ by meet-preservation.
  - From $j(x) = j(x) \wedge j(y)$, we obtain $j(x) \leq j(y)$ by properties of infimum.

---

## 4. Closed Nucleus is a Nucleus
- **Description**: For a fixed $u \in L$, show that the map $j^u(x) = u \vee x$ is a nucleus.
- **Mathematical Statement**: $j^u$ is inflationary, monotone, idempotent, and meet-preserving.
- **Expected Lean Prerequisites**: Lattice operations, distributivity of meet over join.
- **Difficulty**: 4/10
- **Proof Sketch**:
  - Inflationary: $x \leq u \vee x$ is standard for join.
  - Monotone: $x \leq y \implies u \vee x \leq u \vee y$ is standard.
  - Idempotent: $u \vee (u \vee x) = (u \vee u) \vee x = u \vee x$.
  - Meet-preserving: $(u \vee x) \wedge (u \vee y) = u \vee (x \wedge y)$ by the distributive law of frames!
