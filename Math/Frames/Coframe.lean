import Math.Frames.Basic

/-!
# Co-frames

This file introduces the definition of co-frames (coframes) as the algebraic dual of frames.
A coframe is a complete lattice satisfying the infinite distributive law of joins
over arbitrary meets.
-/

universe u

open Pftop.Frames

namespace Pftop.Frames

local infixl:65 " ⊔ " => max

/-- A co-frame is a complete lattice satisfying the infinite distributive law
of joins (binary suprema) over arbitrary meets (infima). -/
class Coframe (α : Type u) extends CompleteLattice α where
  sup_sInf_distrib : ∀ (x : α) (s : Set α), x ⊔ sInf s = sInf (Set.image (fun y => x ⊔ y) s)

end Pftop.Frames
