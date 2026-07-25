import Math.Sublocales.Sublocale
import Math.Frames.Coframe

/-!
# The Co-frame of Sublocales

This file establishes that the set of sublocales of a frame `L` forms a coframe (co-frame).
We define the partial order on sublocales via set inclusion, show that they form a
complete lattice, and state the coframe distributive law.

We provide formal, verified proofs for the partial order, meet/infimum constructions,
and the complete lattice properties where feasible, utilizing `sorry` for the complex
distributive law.
-/

universe u

open Pftop.Frames
open Pftop.Sublocales

namespace Pftop.Sublocales

variable {L : Type u} [Frame L]

/-- The partial order on sublocales is given by set inclusion of their carriers. -/
instance : LE (Sublocale L) where
  le S₁ S₂ := S₁.carrier ⊆ S₂.carrier

instance : PartialOrder (Sublocale L) where
  le S₁ S₂ := S₁.carrier ⊆ S₂.carrier
  lt S₁ S₂ := S₁.carrier ⊆ S₂.carrier ∧ ¬(S₂.carrier ⊆ S₁.carrier)
  le_refl S := fun _ hx => hx
  le_trans S₁ S₂ S₃ h12 h23 := fun x hx => h23 x (h12 x hx)
  le_antisymm S₁ S₂ h12 h23 := by
    have h : S₁.carrier = S₂.carrier := by
      funext x
      apply propext
      constructor
      · exact h12 x
      · exact h23 x
    cases S₁
    cases S₂
    dsimp at h
    subst h
    rfl
  lt_iff_le_not_le S₁ S₂ := Iff.rfl

/-- The intersection of any family of sublocales is a sublocale. -/
def sInf_sublocale (M : Set (Sublocale L)) : Sublocale L where
  carrier x := ∀ S ∈ M, x ∈ S.carrier
  closed_sInf M_L h_sub S hS := by
    have h_sub_S : M_L ⊆ S.carrier := fun m hm => h_sub m hm S hS
    exact S.closed_sInf M_L h_sub_S
  closed_himp s hs x S hS := by
    have hs_S : s ∈ S.carrier := hs S hS
    exact S.closed_himp s hs_S x

/-- The top sublocale is the entire frame L. -/
def top_sublocale : Sublocale L where
  carrier _ := True
  closed_sInf _ _ := trivial
  closed_himp _ _ _ := trivial

/-- The bottom sublocale is the singleton containing only the top element ⊤. -/
def bot_sublocale : Sublocale L where
  carrier x := x = CompleteLattice.top
  closed_sInf M hM := by
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.le_top _
    · apply CompleteLattice.le_sInf
      intro m hm
      have h : m = CompleteLattice.top := hM m hm
      rw [h]
      exact Preorder.le_refl _
  closed_himp s hs x := by
    have h : s = CompleteLattice.top := hs
    rw [h]
    apply PartialOrder.le_antisymm
    · exact CompleteLattice.le_top _
    · rw [le_himp_iff]
      exact CompleteLattice.le_top _

/-- Binary meet of two sublocales is their set-theoretic intersection. -/
instance : Min (Sublocale L) where
  min S₁ S₂ := {
    carrier := fun x => x ∈ S₁ ∧ x ∈ S₂
    closed_sInf := fun M hM => ⟨
      S₁.closed_sInf M (fun x hx => (hM x hx).1),
      S₂.closed_sInf M (fun x hx => (hM x hx).2)
    ⟩
    closed_himp := fun s hs x => ⟨
      S₁.closed_himp s hs.1 x,
      S₂.closed_himp s hs.2 x
    ⟩
  }

/-- Arbitrary join of sublocales is the infimum of all sublocales containing their union. -/
def sSup_sublocale (M : Set (Sublocale L)) : Sublocale L :=
  sInf_sublocale (fun S => ∀ S' ∈ M, S' ≤ S)

/-- Binary join of two sublocales. -/
instance : Max (Sublocale L) where
  max S₁ S₂ := sSup_sublocale (fun S => S = S₁ ∨ S = S₂)

/-- The collection of all sublocales of a frame forms a complete lattice. -/
instance : CompleteLattice (Sublocale L) where
  sSup := sSup_sublocale
  sInf := sInf_sublocale
  top := top_sublocale
  bot := bot_sublocale
  le_top S := fun _ _ => trivial
  bot_le S := fun x (hx : x = CompleteLattice.top) => by
    rw [hx]
    -- Since S is a sublocale, it is closed under sInf of empty set, which is top
    have h : CompleteLattice.sInf (fun (_ : L) => False) ∈ S.carrier := by
      apply S.closed_sInf
      intro _ h
      cases h
    -- sInf of empty set is top
    have h_top : CompleteLattice.sInf (fun (_ : L) => False) = CompleteLattice.top := by
      apply PartialOrder.le_antisymm
      · exact CompleteLattice.le_top _
      · apply CompleteLattice.le_sInf
        intro _ h
        cases h
    rw [h_top] at h
    exact h
  le_sSup M S hS := fun x hx S' hS' => hS' S hS x hx
  sSup_le M S hS := fun x hx => hx S hS
  sInf_le M S hS := fun x hx => hx S hS
  le_sInf M S hS := fun x hx S' hS' => hS S' hS' x hx
  inf_le_left S₁ S₂ := fun _ hx => hx.1
  inf_le_right S₁ S₂ := fun _ hx => hx.2
  le_inf S₁ S₂ S₃ h1 h2 := fun x hx => ⟨h1 x hx, h2 x hx⟩
  le_sup_left S₁ S₂ := fun x hx S' hS' => hS' S₁ (Or.inl rfl) x hx
  le_sup_right S₁ S₂ := fun x hx S' hS' => hS' S₂ (Or.inr rfl) x hx
  sup_le S₁ S₂ S₃ h1 h2 := fun x hx => hx S₃ (fun S' hS' => by
    rcases hS' with rfl | rfl
    · exact h1
    · exact h2
  )

/-- The lattice of sublocales of a frame forms a coframe (co-frame). -/
instance : Coframe (Sublocale L) where
  sup_sInf_distrib S M := by
    -- We leave the full distributivity proof of sublocales as a recognized
    -- complex theorem, but the instance is fully integrated.
    sorry

end Pftop.Sublocales
