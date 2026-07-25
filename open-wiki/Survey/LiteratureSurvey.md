# Literature Survey of Point-Free Topology Formalizations

This survey is a continuously updated record of existing point-free topology (locale theory and formal topology) developments in modern proof assistants (Lean, Agda, Coq, Isabelle/HOL).

*Note: In the literature and search queries, this field is frequently referred to as "pointless topology", which remains a valuable search term. For internal consistency, we refer to it exclusively as point-free topology.*

---

## 1. Primary Mathematical Literature
These textbooks and papers provide the theoretical foundation and blueprints for our formalization strategies.

### Johnstone — *Stone Spaces* (1982)
- **Relevance**: The seminal textbook introducing point-free topology, locale theory and stone spaces. Excellent reference for sublocale lattices, open/closed sublocales, and compactness.
- **Ideas worth importing**: Direct constructions of sublocales via nuclei and quotients.

### Picado & Pultr — *Frames and Locales: Topology without points* (2012)
- **Relevance**: A modern, highly accessible text focusing entirely on point-free topology. It provides explicit algebraic formulations for sublocales, open/closed sublocales, and various separation axioms.
- **Ideas worth importing**: Extremely systematic exposition of nuclei properties, especially the complete lattice of nuclei, which is our first major mathematical target.

### Johnstone — *Sketches of an Elephant: A Topos Theory Compendium* (2002)
- **Relevance**: Highly advanced reference on topos theory and locale theory.
- **Ideas worth importing**: Categorical treatment of locales, sublocales, pushforwards, pullbacks, and their relation to sheaves.

---

## 2. Proof Assistant Implementations

### Lean 4 (Mathlib4)
- **Source**: `Mathlib.Order.Frame`, `Mathlib.Topology.Category.Locale`, `Mathlib.Topology.Sets.Opens`.
- **License**: Apache 2.0
- **Relevance**: Direct baseline. Mathlib4 provides the definitions of `Frame` (a complete lattice satisfying the infinite distributive law) and the category of locales `Locale := Frmᵒᵖ`.
- **Maturity**: High (Production-grade, upstream standard library).
- **Ideas worth importing**: Reuse the `Frame` typeclass, `Opens X` frame instance, and the category `Locale`.
- **Missing components**: No sublocale theory, nuclei, fixed-point frames, quotients, or separation/compactness axioms formalized inside point-free topology itself (though point-set topology equivalents are abundant).

### Agda (TypeTopology / formal-topology-in-UF)
- **Source**: Martin Escardó's `TypeTopology` (specifically locale theory sub-modules), Ayberk Tosun's `formal-topology-in-UF` (Interaction Systems and HITs), and Pietro Sabelli's `topological-co-induction`.
- **License**: MIT / BSD
- **Relevance**: Very high. These libraries implement constructive, predicative point-free topology, locale theory, and formal topology using Univalent Foundations (UF) and Martin-Löf Type Theory.
- **Maturity**: High for constructive foundations.
- **Ideas worth importing**:
  - The use of **Interaction Systems** to inductively generate cover relations (highly constructive).
  - Use of **Higher Inductive Types (HITs)** for covers to bypass the need for Choice in proving nucleus properties.
- **Missing components**: Some aspects of advanced sublocale lattices are omitted due to strict predicativity constraints.

### Coq (Erik Palmgren, Bas Spitters, constructive-topology)
- **Source**: Formalizations of Point-free and Constructive Topology by Erik Palmgren, Bas Spitters, and related projects.
- **License**: BSD / LGPL
- **Relevance**: High. Excellent blueprint for constructive logic, complete lattices, and the use of Typeclasses in Coq to model the algebraic hierarchy of lattices and locales.
- **Maturity**: Academic / Medium.
- **Ideas worth importing**:
  - Modelling of frames as Complete Lattices with explicit meet-distributivity over joins using ensembles/predicates.
  - Avoiding classical logic (Axiom of Choice, Excluded Middle) where possible.
- **Missing components**: Lacks integration with modern package managers; often written for older versions of Coq.

### Isabelle/HOL (Archive of Formal Proofs - HOL-Library)
- **Source**: `HOL-Library.Complete_Lattices`, and AFP entries on Lattices and Orders.
- **License**: BSD / GPL
- **Relevance**: Medium. Isabelle uses its Locale module system to declare structures like frames/complete lattices.
- **Maturity**: Very high (Isabelle Standard Library and AFP are extremely stable).
- **Ideas worth importing**:
  - Pointwise orders on functions and standard lattice properties.
- **Missing components**: Isabelle's "locale" refers to a module-system feature, and point-free topology (locale theory) is not fully developed beyond algebraic definitions of frames and lattices.
