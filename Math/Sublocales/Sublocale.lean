import Math.Sublocales.Basic
import Math.Sublocales.FixedPoints

/-!
# Sublocale Sets and Their Equivalence with Nuclei

This file formalizes sublocales as subsets of a frame closed under
arbitrary meets and Heyting implications from the left.
We prove that the set of fixed points of any nucleus is a sublocale.
-/

universe u

namespace Pftop.Sublocales

open Pftop.Frames

-- Local notation for meets
local infixl:70 " ⊓ " => min

/-- A sublocale of a frame `L` is a subset `S` of `L` closed under arbitrary meets (`sInf`)
and Heyting implications from the left (`⇨`). -/
structure Sublocale (L : Type u) [Frame L] where
  carrier : Set L
  closed_sInf : ∀ M, M ⊆ carrier → CompleteLattice.sInf M ∈ carrier
  closed_himp : ∀ s, s ∈ carrier → ∀ x : L, x ⇨ s ∈ carrier

namespace Sublocale

variable {L : Type u} [Frame L]

/-- Coercion from `Sublocale L` to `Type _` (the subtype of elements in the sublocale). -/
instance : CoeSort (Sublocale L) (Type _) :=
  ⟨fun S => Subtype (fun x => x ∈ S.carrier)⟩

/-- The membership relation for `Sublocale`. -/
instance : Membership L (Sublocale L) where
  mem S x := x ∈ S.carrier

/-- For any nucleus `j`, the set of fixed points `{x : L | j.toFun x = x}` forms a sublocale. -/
def ofNucleus (j : Nucleus L) : Sublocale L where
  carrier := fun x => j.toFun x = x
  closed_sInf M hM := by
    -- We need to show j.toFun (sInf M) = sInf M
    apply PartialOrder.le_antisymm
    · -- j.toFun (sInf M) ≤ sInf M
      apply CompleteLattice.le_sInf
      intro m hm
      have h1 : CompleteLattice.sInf M ≤ m := CompleteLattice.sInf_le M m hm
      have h2 : j.toFun (CompleteLattice.sInf M) ≤ j.toFun m := j.monotone _ _ h1
      have h3 : j.toFun m = m := hM m hm
      rw [h3] at h2
      exact h2
    · -- sInf M ≤ j.toFun (sInf M)
      exact j.inflationary (CompleteLattice.sInf M)
  closed_himp s hs x := by
    -- We need to show j.toFun (x ⇨ s) = x ⇨ s
    have hs_fixed : j.toFun s = s := hs
    apply PartialOrder.le_antisymm
    · -- j.toFun (x ⇨ s) ≤ x ⇨ s is equivalent to j.toFun (x ⇨ s) ⊓ x ≤ s by Heyting adjunction
      rw [le_himp_iff]
      have h1 : j.toFun (x ⇨ s) ⊓ x ≤ j.toFun (x ⇨ s) ⊓ j.toFun x := by
        apply CompleteLattice.le_inf
        · exact CompleteLattice.inf_le_left _ _
        · have hx_le := j.inflationary x
          exact Preorder.le_trans _ _ _ (CompleteLattice.inf_le_right _ _) hx_le
      have h2 : j.toFun (x ⇨ s) ⊓ j.toFun x = j.toFun ((x ⇨ s) ⊓ x) := by rw [j.map_inf]
      have h3 : (x ⇨ s) ⊓ x ≤ s := himp_inf_le x s
      have h4 : j.toFun ((x ⇨ s) ⊓ x) ≤ j.toFun s := j.monotone _ _ h3
      rw [hs_fixed] at h4
      rw [h2] at h1
      exact Preorder.le_trans _ _ _ h1 h4
    · -- x ⇨ s ≤ j.toFun (x ⇨ s)
      exact j.inflationary (x ⇨ s)

end Sublocale

end Pftop.Sublocales
