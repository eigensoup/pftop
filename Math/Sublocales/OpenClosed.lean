import Math.Sublocales.Basic

/-!
# Open and Closed Nuclei on Frames

This file defines the open and closed nuclei associated with an element of a frame.
For any element `u : L`:
1. The closed nucleus `j^u` is defined by `x ↦ u ⊔ x`.
2. The open nucleus `j_u` is defined by `x ↦ u ⇨ x` (Heyting implication).
-/

namespace Pftop.Sublocales

variable {L : Type*} [Frame L]

/-- The closed nucleus associated with an element `u : L` is `x ↦ u ⊔ x`. -/
def closedNucleus (u : L) : Nucleus L where
  toFun x := u ⊔ x
  inflationary' x := le_sup_right
  idempotent' x := by
    -- u ⊔ (u ⊔ x) = (u ⊔ u) ⊔ x = u ⊔ x
    rw [sup_assoc, sup_idem]
  map_inf' x y := by
    -- u ⊔ (x ⊓ y) = (u ⊔ x) ⊓ (u ⊔ y)
    rw [sup_inf_left]

namespace closedNucleus

variable (u : L)

@[simp]
theorem coe_apply (x : L) : (closedNucleus u) x = u ⊔ x := rfl

end closedNucleus

end Pftop.Sublocales
