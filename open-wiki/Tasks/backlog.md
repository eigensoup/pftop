# Lean Point-Free: Backlog

This backlog maintains upcoming tasks, estimated by difficulty, dependencies, and expected prerequisites.

## Backlog Tasks

### 1. Define Nucleus structure
- **Description**: Define a Lean 4 structure `Nucleus (L : Type u) [Frame L]` that bundles a function $j : L \to L$ with the properties of being inflationary, monotone, idempotent, and meet-preserving.
- **Difficulty**: Easy (2/10)
- **Dependencies**: None
- **Expected Lean Prerequisites**: Basic structures, Order theory (`Order.Frame`).
- **Expected Mathematical Prerequisites**: Definition of a nucleus on a frame.

### 2. Fixed-Point Frame Construction
- **Description**: Define the type of fixed points `FixedPoints j` for a nucleus `j` and show it is a frame. Prove that the inclusion map is meet-preserving and that there is a join-preserving reflection.
- **Difficulty**: Medium (5/10)
- **Dependencies**: Nucleus structure definition
- **Expected Lean Prerequisites**: Typeclass instances, quotient/subtype constructions, Galois insertions/connections.
- **Expected Mathematical Prerequisites**: Fixed point frames, Galois connections.

### 3. Nucleus complete lattice
- **Description**: Show that the set of all nuclei on a frame forms a complete lattice.
- **Difficulty**: Hard (7/10)
- **Dependencies**: Nucleus structure definition
- **Expected Lean Prerequisites**: Pointwise operations, complete lattice definitions, Order Homomorphisms.
- **Expected Mathematical Prerequisites**: Complete lattices, pointwise order on functions.

### 4. Define Open and Closed Nuclei
- **Description**: For any $a \in L$, define the open nucleus $j_u(x) = u \to x$ and closed nucleus $j^u(x) = u \vee x$.
- **Difficulty**: Easy (3/10)
- **Dependencies**: Nucleus structure definition
- **Expected Lean Prerequisites**: Frame operations, Heyting algebra operators (impl/negation).
- **Expected Mathematical Prerequisites**: Open/closed nuclei, Heyting algebra structures.
