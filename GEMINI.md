# Lean Point-Free (pftop) — Development Instructions

Welcome to the `lean-pointfree` (pftop) repository! This project is an agent-first research library and knowledge base for the formalization of point-free topology (locale theory) in Lean 4.

---

## 1. Core Philosophy & Dual-Form Principle
Every mathematical object and theorem in this repository must exist in two equally important forms:
1. **Lean 4 Implementation**: Small, clean, reusable, type-safe, and idiomatic code.
2. **Markdown Documentation**: Written for graduate mathematicians (not just Lean experts), explaining motivation, definitions, equivalence, references, and status.

Neither form is considered complete without the other.

---

## 2. Directory Layout & Organization

Maintain the following structure strictly:

```
pftop/
├── Math/                  # Lean 4 library code
│   ├── Frames/            # Complete lattices and frames
│   ├── Locales/           # Locales (opposite of frames)
│   ├── Sublocales/        # Sublocale theory, nuclei, quotients
│   ├── Compact/           # Compactness properties
│   ├── Spectral/          # Spectral and coherent spaces
│   └── Constructive/      # Formal topology, coverages
├── Docs/                  # Mathematical and design documentation
│   ├── Foundations/       # General mathematical foundations
│   ├── Survey/            # Literature surveys and prior art audits
│   ├── Definitions/       # Markdown files for every definition (e.g. Nucleus.md)
│   ├── Theorems/          # Markdown files for significant theorems
│   ├── Design/            # Design decisions and architectural guidelines
│   └── References/        # BibTeX and markdown references
├── Notes/                 # Notes and intermediate discussions
│   ├── Scratch/           # Unfinished drafts and scratchpads
│   ├── OpenProblems/      # Known mathematical or formalization obstacles
│   └── Reading/           # Reading notes for books and papers
├── Examples/              # Practical examples and applications
├── Scripts/               # Automated scripts (builds, docs generation, etc.)
├── Tasks/                 # Task and roadmap tracking (current, backlog, blocked, etc.)
├── lean-toolchain         # Lean version configuration
└── lakefile.toml          # Lake build package configuration
```

---

## 3. Lean Coding Style Guidelines
- **Extremely Small Files**: Do not write monolithic files. Separate logic into `Basic.lean`, `Instances.lean`, `Lemmas.lean`, and `Examples.lean` inside each module subdirectory.
- **Clarity over Automation**: Favor explicit, readable proofs with minimal complex or brittle automation.
- **Small Lemmas**: Prove big theorems by combining highly reusable, tiny auxiliary lemmas.
- **Explicit Namespace**: All code should be contained within the `Pftop` namespace (e.g. `namespace Pftop.Frames`).
- **Comprehensive Comments**: Every declaration must have a docstring (`/-- ... -/`) stating its mathematical meaning.

---

## 4. Documentation Guidelines
Every definition or theorem page in `Docs/Definitions/` or `Docs/Theorems/` must contain:
- **Definition/Statement**: Mathematical formulation.
- **Motivation**: Why this object is studied, what problems it solves.
- **Examples**: Trivial and non-trivial examples.
- **Equivalent formulations**: Alternative characterizations.
- **References**: Citations to Johnstones' *Stone Spaces* or Picado & Pultr's *Frames and Locales*.
- **Lean Implementation Status**: Links to the specific Lean file and status (WIP, Completed, Verified).

---

## 5. Development Workflow
1. **Check Task Board**: Inspect files in `Tasks/` (`current.md`, `good-first-theorem.md`, `backlog.md`).
2. **Research & Plan**: Research existing Mathlib4 definitions first to prevent duplication.
3. **Surgical Implementation**: Implement minimum working diffs.
4. **Synchronize Docs**: Create/update corresponding Markdown files in `Docs/`.
5. **Verify**: Ensure the project compiles cleanly via `lake build`.
