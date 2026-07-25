# AI Agent Guidelines & Repository Entry Point

Welcome, AI Agent! This file outlines the instructions and layout designed specifically for automated agents contributing to the `lean-pointfree` library.

---

## 1. Core Terminology & Naming Consistency
- **Term**: We refer to this field of mathematics as **point-free topology** (or **locale theory**), **never** "pointless topology" in our primary documentation, code, or communication.
- **Search Note**: Note that "pointless topology" is a very common term in the literature (e.g., in Picado & Pultr or Johnstone) and is highly useful as an external search term. However, for internal consistency and professional alignment, we strictly standardize on **point-free** throughout this repository.

---

## 2. Directory Layout & Separation of Concerns

The repository is split into two distinct documentation areas:
1. **`Docs/` (Human Review & Mathematical Mirror)**:
   - Contains definitions and theorems that strictly mirror our implemented Lean 4 formal proofs.
   - Designed for human mathematicians and auditors to review the formalization correctness.
2. **`open-wiki/` (Agent Workspace & Development Notes)**:
   - Contains agent guides, literature notes, and open tasks.
   - Serves as the agent's scratchpad and workspace management hub.

```
pftop/
├── Math/                    # Lean 4 library code
├── Docs/                    # Mathematical definitions & theorems (Human Review)
│   ├── Definitions/         # Mirror of Lean definitions (e.g. Nucleus, FixedPoints)
│   └── Theorems/            # Mirror of Lean theorems (e.g. NucleusMonotonicity)
├── open-wiki/               # AI Agent Workspace & Internal Wiki
│   ├── agent.md             # Sibling/referenced agent instructions
│   ├── Survey/              # Prior art audits and literature surveys
│   └── Tasks/               # Interactive task board (current, roadmap, backlog)
├── agent.md                 # Core agent entry point (this file)
├── GEMINI.md                # General developer instructions
├── lean-toolchain           # Lean 4 version configuration
└── lakefile.toml            # Lake build package configuration
```

---

## 3. Contributing Guidelines for Agents

When starting a task:
1. **Consult the Task Board**: Check `open-wiki/Tasks/current.md` for in-progress work, and `open-wiki/Tasks/good-first-theorem.md` for easy introductory lemmas.
2. **Implement Surgically**: Keep files small, self-contained, and fast to compile. Avoid adding bloated external dependencies.
3. **Synchronize Human Docs**: Immediately after writing or modifying any Lean 4 definition or theorem, create or update its matching markdown file under `Docs/Definitions/` or `Docs/Theorems/`. Ensure it contains:
   - Mathematical formulation
   - LaTeX proofs
   - Code signatures
   - Citations to standard references
4. **Update the Wiki**: Record findings or completed task items under `open-wiki/`.
