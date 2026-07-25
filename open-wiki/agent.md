# AI Agent Workspace — Implementation Guidelines

This document provides specialized guidelines and details for AI agents developing the `lean-pointfree` library.

---

## 1. Terminology Standard
- **Core Standard**: Always use the term **point-free topology**, not "pointless topology".
- **External Search**: Note that when performing grounded Google searches or web fetches of external papers, "pointless topology" is a highly productive and common search term. Translate these search results into "point-free topology" for all internal documents.

---

## 2. Self-Contained Mathematical Core
To ensure compilation takes less than **1 second** and avoids the massive overhead of full Mathlib4 builds, this project utilizes a lightweight, self-contained complete lattice and frame core under `Math/Frames/Basic.lean`.

### Available Primitives
When formalizing definitions and theorems, use the following custom types and classes:
- **`Set α`**: Represented as a predicate `α → Prop` (using `abbrev Set`).
- **Set Membership (`∈`)**: Instantiated via `Membership α (Set α)`, where `s ∈ x` corresponds to `s x`.
- **Set Image (`''`)**: Notation for `Set.image`, defined as `Set.image f s := fun y => ∃ x, s x ∧ f x = y`.
- **Lattice operations**: `⊓` (min) and `⊔` (max) are defined locally for `CompleteLattice`.
- **`CompleteLattice α`**: Extends `PartialOrder α`, `Min α`, `Max α`.
- **`Frame α`**: Extends `CompleteLattice α` with the infinite distributive law `inf_sSup_distrib`.

### Core Namespace
All core frames are located under `Pftop.Frames`. When implementing code, always add `open Pftop.Frames` at the top of your files to bring these classes and notations into scope.

---

## 3. Separation of Concerns Workflow
- **`Math/`**: Only contains verified, compiling Lean 4 code.
- **`Docs/`**: Reserved strictly for human review (e.g. audited markdown sheets mirroring implemented Lean proofs).
- **`open-wiki/`**: Workspace for open tasks, roadmap tracking, and literature notes.
