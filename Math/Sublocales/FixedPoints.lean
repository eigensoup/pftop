import Math.Sublocales.Basic

/-!
# Fixed Point Frames of a Nucleus

For any nucleus `j` on a frame `L`, the set of fixed points of `j`
forms a frame under the induced meet operation and $j$-modified join operation.
-/

universe u

namespace Pftop.Sublocales

open Pftop.Frames

variable {L : Type u} [Frame L]

/-- The type of fixed points of a nucleus `j`. -/
def FixedPoints (j : Nucleus L) : Type u :=
  { x : L // j.toFun x = x }

namespace FixedPoints

@[ext]
theorem ext {j : Nucleus L} {x y : FixedPoints j} (h : x.val = y.val) : x = y :=
  Subtype.ext h

/-- Any element of the form `j x` is a fixed point. -/
def ofFun (j : Nucleus L) (x : L) : FixedPoints j :=
  ⟨j.toFun x, j.idempotent x⟩

/-- The partial order on `FixedPoints j` is inherited from `L`. -/
instance {j : Nucleus L} : PartialOrder (FixedPoints j) where
  le x y := x.val ≤ y.val
  lt x y := x.val < y.val
  le_refl x := Preorder.le_refl x.val
  le_trans x y z hxy hyz := Preorder.le_trans x.val y.val z.val hxy hyz
  le_antisymm x y hxy hyx := by
    apply ext
    exact PartialOrder.le_antisymm x.val y.val hxy hyx
  lt_iff_le_not_le x y := Preorder.lt_iff_le_not_le x.val y.val

/-- Meet (infimum) of two fixed points is their meet in `L`. -/
instance {j : Nucleus L} : Min (FixedPoints j) where
  min x y := ⟨min x.val y.val, by
    have hx : j.toFun x.val = x.val := x.property
    have hy : j.toFun y.val = y.val := y.property
    rw [j.map_inf, hx, hy]⟩

/-- Join (supremum) of two fixed points is `j (x ⊔ y)`. -/
instance {j : Nucleus L} : Max (FixedPoints j) where
  max x y := ⟨j.toFun (max x.val y.val), j.idempotent (max x.val y.val)⟩

end FixedPoints

end Pftop.Sublocales
