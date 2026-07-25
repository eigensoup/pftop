import Mathlib.Order.Frame
import Mathlib.Order.CompactlyGenerated

/-!
# Zero-Dimensional and Stone Frames/Locales

This file defines clopen (complemented) elements, zero-dimensional frames,
and Stone frames/locales (compact and zero-dimensional frames).
-/

namespace Pftop.Spectral

/-- An element `a` of a frame `L` is clopen (complemented) if there exists
an element `b : L` which acts as its complement. -/
def IsClopen {L : Type*} [Frame L] (a : L) : Prop :=
  ∃ b : L, a ⊓ b = ⊥ ∧ a ⊔ b = ⊤

/-- A frame `L` is zero-dimensional if every element `x : L` is the supremum
of a set of clopen elements. -/
def IsZeroDimensional (L : Type*) [Frame L] : Prop :=
  ∀ x : L, ∃ S : Set L, (∀ s ∈ S, IsClopen s) ∧ sSup S = x

/-- A Stone locale/frame is a frame that is both compact (the top element
is a compact element of the lattice) and zero-dimensional. -/
class StoneLocale (L : Type*) [Frame L] : Prop where
  compact : IsCompactElement (⊤ : L)
  zero_dim : IsZeroDimensional L

namespace StoneLocale

variable {L : Type*} [Frame L] [StoneLocale L]

/-- Stone locales are compact by definition. -/
theorem is_compact : IsCompactElement (⊤ : L) :=
  compact

/-- Stone locales are zero-dimensional by definition. -/
theorem is_zero_dimensional : IsZeroDimensional L :=
  zero_dim

end StoneLocale

end Pftop.Spectral
