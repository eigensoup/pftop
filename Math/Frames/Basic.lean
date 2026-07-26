/-!
# Minimal Complete Lattices and Frames

This file introduces a lightweight, self-contained implementation of
complete lattices and frames in Lean 4, removing heavy external dependencies
to ensure instant compilation.
-/

universe u v

set_option quotPrecheck false

namespace Pftop.Frames

/-- A set in type `α` is represented as a predicate `α → Prop`. -/
abbrev Set (α : Type u) := α → Prop

/-- Declare a standard Membership instance so we can use standard `∈` notation. -/
instance {α : Type u} : Membership α (Set α) where
  mem s x := s x

/-- Declare a standard HasSubset instance so we can use standard `⊆` notation. -/
instance {α : Type u} : HasSubset (Set α) where
  Subset s t := ∀ x, s x → t x

/-- Image of a set under a function `f : α → β`. -/
def Set.image {α : Type u} {β : Type v} (f : α → β) (s : Set α) : Set β :=
  fun y => ∃ x, s x ∧ f x = y

-- Custom local notation for set image
local infixr:80 " '' " => Set.image

/-- Preorder relation typeclass. -/
class Preorder (α : Type u) extends LE α, LT α where
  le_refl : ∀ a : α, a ≤ a
  le_trans : ∀ a b c : α, a ≤ b → b ≤ c → a ≤ c
  lt_iff_le_not_le : ∀ a b : α, a < b ↔ a ≤ b ∧ ¬(b ≤ a)

/-- Partial order relation typeclass. -/
class PartialOrder (α : Type u) extends Preorder α where
  le_antisymm : ∀ a b : α, a ≤ b → b ≤ a → a = b

-- Local notations for lattice operations
local infixl:70 " ⊓ " => min
local infixl:65 " ⊔ " => max

/-- A complete lattice is a partially ordered set with arbitrary infima and suprema,
as well as top and bottom elements. -/
class CompleteLattice (α : Type u) extends PartialOrder α, Min α, Max α where
  sSup : Set α → α
  sInf : Set α → α
  top : α
  bot : α
  le_top : ∀ x : α, x ≤ top
  bot_le : ∀ x : α, bot ≤ x
  le_sSup : ∀ (s : Set α) (a : α), a ∈ s → a ≤ sSup s
  sSup_le : ∀ (s : Set α) (a : α), (∀ b ∈ s, b ≤ a) → sSup s ≤ a
  sInf_le : ∀ (s : Set α) (a : α), a ∈ s → sInf s ≤ a
  le_sInf : ∀ (s : Set α) (a : α), (∀ b ∈ s, a ≤ b) → a ≤ sInf s
  inf_le_left : ∀ a b : α, a ⊓ b ≤ a
  inf_le_right : ∀ a b : α, a ⊓ b ≤ b
  le_inf : ∀ a b c : α, a ≤ b → a ≤ c → a ≤ b ⊓ c
  le_sup_left : ∀ a b : α, a ≤ a ⊔ b
  le_sup_right : ∀ a b : α, b ≤ a ⊔ b
  sup_le : ∀ a b c : α, a ≤ c → b ≤ c → a ⊔ b ≤ c

notation "⊤" => CompleteLattice.top
notation "⊥" => CompleteLattice.bot

/-- A frame is a complete lattice satisfying the infinite distributive law
of meets over arbitrary joins. -/
class Frame (α : Type u) extends CompleteLattice α where
  inf_sSup_distrib : ∀ (x : α) (s : Set α), x ⊓ sSup s = sSup ((fun y => x ⊓ y) '' s)

/-- Heyting implication in a frame: x ⇨ y is defined as the supremum of all z such that z ⊓ x ≤ y. -/
def himp {α : Type u} [Frame α] (x y : α) : α :=
  CompleteLattice.sSup (fun z => z ⊓ x ≤ y)

infixr:60 " ⇨ " => himp

theorem le_himp_iff {α : Type u} [Frame α] (x y z : α) : z ≤ x ⇨ y ↔ z ⊓ x ≤ y := by
  constructor
  · intro h
    -- One direction of Heyting adjunction requires frame distributivity
    sorry
  · intro h
    exact CompleteLattice.le_sSup (fun w => w ⊓ x ≤ y) z h

theorem himp_inf_le {α : Type u} [Frame α] (x y : α) : (x ⇨ y) ⊓ x ≤ y := by
  exact (le_himp_iff x y (x ⇨ y)).mp (Preorder.le_refl _)

end Pftop.Frames
