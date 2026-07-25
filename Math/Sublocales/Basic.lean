import Math.Frames.Basic

/-!
# Nuclei on Frames — Basic Definitions

This file defines the type of nuclei on a frame, and establishes basic properties and
the identity nucleus.
A nucleus is a meet-preserving, inflationary, and idempotent operator.
-/

universe u

open Pftop.Frames

namespace Pftop.Sublocales

-- Local notations for lattice operations
local infixl:70 " ⊓ " => min
local infixl:65 " ⊔ " => max

/-- A nucleus on a frame `L` is an endomap `j : L → L` that is
inflationary, idempotent, and meet-preserving. -/
structure Nucleus (L : Type u) [Frame L] where
  toFun : L → L
  inflationary' : ∀ x : L, x ≤ toFun x
  idempotent' : ∀ x : L, toFun (toFun x) = toFun x
  map_inf' : ∀ x y : L, toFun (x ⊓ y) = toFun x ⊓ toFun y

namespace Nucleus

variable {L : Type u} [Frame L] (j : Nucleus L)

theorem inflationary (x : L) : x ≤ j.toFun x :=
  j.inflationary' x

theorem idempotent (x : L) : j.toFun (j.toFun x) = j.toFun x :=
  j.idempotent' x

theorem map_inf (x y : L) : j.toFun (x ⊓ y) = j.toFun x ⊓ j.toFun y :=
  j.map_inf' x y

/-- Any nucleus is monotone. -/
theorem monotone (x y : L) (h : x ≤ y) : j.toFun x ≤ j.toFun y := by
  have h1 : x ⊓ y = x := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.inf_le_left x y
    · exact CompleteLattice.le_inf x x y (Preorder.le_refl x) h
  have h2 : j.toFun (x ⊓ y) = j.toFun x := by rw [h1]
  rw [map_inf] at h2
  rw [← h2]
  exact CompleteLattice.inf_le_right (j.toFun x) (j.toFun y)

/-- A nucleus preserves the top element (top is mapped to top). -/
@[simp]
theorem map_top : j.toFun CompleteLattice.top = CompleteLattice.top := by
  apply PartialOrder.le_antisymm
  · exact CompleteLattice.le_top (j.toFun CompleteLattice.top)
  · exact j.inflationary CompleteLattice.top

/-- The identity nucleus on a frame `L` maps every element to itself. -/
def identity (L : Type u) [Frame L] : Nucleus L where
  toFun x := x
  inflationary' _ := Preorder.le_refl _
  idempotent' _ := rfl
  map_inf' _ _ := rfl

@[simp]
theorem identity_apply (L : Type u) [Frame L] (x : L) : (identity L).toFun x = x := rfl

end Nucleus

end Pftop.Sublocales
