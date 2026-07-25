# Design and Architectural Guidelines

This document outlines the architectural guidelines and conventions for contributing to the `lean-pointfree` library.

---

## 1. Modular & Small File Structure
To keep the compilation times fast and the mental overhead low, we split every mathematical module into small, focused files:
- **`Basic.lean`**: Core definitions, structures, and their basic axioms.
- **`Lemmas.lean`**: Key properties, theorems, and auxiliary helper lemmas.
- **`Instances.lean`**: Typeclass instances (e.g. showing a construction is a Frame).
- **`Examples.lean`**: Concrete constructions, counters, and applications.

---

## 2. Naming Conventions
- Align closely with Mathlib4 naming styles:
  - Structures/Classes: `UpperCamelCase` (e.g., `Nucleus`, `FixedPoints`).
  - Definitions/Theorems/Lemmas: `lowerCamelCase` with snake_case-like separator segments where appropriate, or purely `snake_case` if matching Mathlib. Mathlib4 uses `lowerCamelCase` for terms and `snake_case` for properties or algebraic rules.
  - Namespace: Use the hierarchical prefix `Pftop` followed by the module name (e.g., `namespace Pftop.Sublocales`).

---

## 3. Explicit vs Implicit Arguments
- Always think carefully about which arguments should be implicit (`{}`) or explicit (`()`).
- The frame $L$ itself should usually be an implicit or typeclass argument when possible, e.g.:
  ```lean
  variable {L : Type u} [Frame L]
  ```

---

## 4. Documentation Coupling
Every Lean definition or theorem must have:
1. An exhaustive docstring in the `.lean` code.
2. A corresponding markdown file in `Docs/Definitions/` or `Docs/Theorems/`.
3. Links connecting the two (referencing file paths in the markdown, and doc titles in the Lean code).
