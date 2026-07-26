import Math.Frames.Basic

/-!
# P-Frames and Cozero Elements

This file defines the rather below relation, the completely below relation,
cozero elements, and P-frames.

A P-frame is a frame where every cozero element is complemented.
-/

universe u

set_option quotPrecheck false

namespace Pftop.Frames

-- Local notations for lattice operations
local infixl:70 " ⊓ " => min
local infixl:65 " ⊔ " => max

/-- `a` is rather below `b` (written `a ≺ b` or `RatherBelow a b`) if there exists
a separator `s` such that `a ⊓ s = ⊥` and `b ⊔ s = ⊤`. -/
def RatherBelow {L : Type u} [Frame L] (a b : L) : Prop :=
  ∃ s : L, a ⊓ s = ⊥ ∧ b ⊔ s = ⊤

infixl:50 " ≺ " => RatherBelow

/-- Notation for `Rat` as `ℚ` -/
local notation "ℚ" => Rat

/-- `a` is completely below `b` (written `a ≺≺ b` or `CompletelyBelow a b`) if there exists
a rational-indexed scale `f : ℚ → L` interpolating between `a` and `b`. -/
def CompletelyBelow {L : Type u} [Frame L] (a b : L) : Prop :=
  ∃ f : ℚ → L, f 0 = a ∧ f 1 = b ∧ ∀ p q : ℚ, p < q → f p ≺ f q

infixl:50 " ≺≺ " => CompletelyBelow

/-- The range of a sequence `f : Nat → L` represented as a predicate (set). -/
def sequenceRange {L : Type u} (f : Nat → L) : Set L :=
  fun y => ∃ n, f n = y

/-- An element `c` of a frame `L` is a cozero element if it is the supremum of
a countable sequence of elements completely below it. -/
def IsCozero {L : Type u} [Frame L] (c : L) : Prop :=
  ∃ f : Nat → L, (∀ n, f n ≺≺ c) ∧ CompleteLattice.sSup (sequenceRange f) = c

/-- An element `a` of a frame `L` is complemented if there exists
an element `b : L` which acts as its complement. -/
def IsComplemented {L : Type u} [Frame L] (a : L) : Prop :=
  ∃ b : L, a ⊓ b = ⊥ ∧ a ⊔ b = ⊤

/-- A frame `L` is a P-frame if every cozero element in `L` is complemented. -/
class PFrame (L : Type u) [Frame L] : Prop where
  cozero_complemented : ∀ c : L, IsCozero c → IsComplemented c

/-- The top element `⊤` is always complemented. -/
theorem top_is_complemented {L : Type u} [Frame L] : IsComplemented (⊤ : L) := by
  have h1 : (⊤ : L) ⊓ ⊥ = ⊥ := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.inf_le_right ⊤ ⊥
    · exact CompleteLattice.bot_le _
  have h2 : (⊤ : L) ⊔ ⊥ = ⊤ := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.le_top _
    · exact CompleteLattice.le_sup_left ⊤ ⊥
  exact ⟨⊥, ⟨h1, h2⟩⟩

/-- The bottom element `⊥` is always complemented. -/
theorem bot_is_complemented {L : Type u} [Frame L] : IsComplemented (⊥ : L) := by
  have h1 : (⊥ : L) ⊓ ⊤ = ⊥ := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.inf_le_left ⊥ ⊤
    · exact CompleteLattice.bot_le _
  have h2 : (⊥ : L) ⊔ ⊤ = ⊤ := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.le_top _
    · exact CompleteLattice.le_sup_right ⊥ ⊤
  exact ⟨⊤, ⟨h1, h2⟩⟩

end Pftop.Frames
