# Lean Point-Free: Sublocale Theory Roadmap

This document outlines the long-term mathematical and formalization milestones for the `lean-pointfree` library.

## Milestone 1: Literature Survey and Architectural Design (Phase 1)
- [x] Establish initial project layout and dependency structures.
- [x] Document existing Mathlib4 order-theoretic and locale-theoretic abstractions (`Order.Frame`, `Topology.Category.Locale`).
- [x] Audit prior formalization projects in Coq, Agda, Isabelle, and identify key proof strategies and structures worth porting.
- [x] Draft design guidelines for definitions and theorems in the library.

## Milestone 2: Nuclei on Frames (Phase 2 & 3)
- [/] Define the type of Nuclei on a frame $L$.
  - [x] Inflationary: $x \leq j(x)$
  - [x] Idempotent: $j(j(x)) = j(x)$
  - [x] Meet-preserving: $j(x \wedge y) = j(x) \wedge j(y)$
  - [x] Monotone (proven as a theorem): $x \leq y \implies j(x) \leq j(y)$
- [/] Define the fixed point frame $L_j = \{x \in L \mid j(x) = x\}$.
  - [x] Define `FixedPoints j` type.
  - [x] Show that it is a `PartialOrder` and `OrderTop`.
  - [x] Show that it is a `SemilatticeInf` and `SemilatticeSup`.
  - [ ] Show that it is a `CompleteLattice` and `Frame` (arbitrary joins/meets).
- [ ] Define nucleus morphisms and prove that the collection of nuclei on a frame forms a complete lattice.

## Milestone 3: Sublocales and Quotients (Phase 3)
- [ ] Formalize quotient locales.
- [x] Define sublocales using nuclei/fixed-point frames and prove their correspondence to quotient locales.
- [ ] Prove the existence of the sublocale lattice.
- [/] Define open and closed sublocales.
  - [x] Define closed nucleus $j^u(x) = u \vee x$ and show it is a nucleus.
  - [ ] Define open nucleus $j_u(x) = u \to x$.

## Milestone 4: Compact, Regular, Zero-Dimensional and Stone Locales (Phase 4)
- [x] Formalize compactness properties (using `IsCompactElement ⊤`).
- [x] Formalize zero-dimensional locales (basis of complemented/clopen elements).
- [ ] Formalize regular locales.
- [x] Formalize Stone locales/frames.

## Milestone 5: Categorical Properties of Sublocales
- [ ] Define sublocale embeddings.
- [ ] Formalize pushforwards and pullbacks of sublocales.
- [ ] Prove universal properties of sublocales and quotients.
