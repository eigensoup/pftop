# Open Question: Generalization of the P-Frame Reflection for Completely Regular Frames

This note documents the question of whether the P-frame reflection of an arbitrary
completely regular frame can be constructed in a single step using the Boolean
reflection of its cozero part, and gives a rigorous account of what is and is not
currently established about it.

---

## 1. Relevant Definitions

Let $L$ be a completely regular frame.

### Cozero $\sigma$-Frame
The **cozero part** of $L$, denoted $\mathrm{Coz}\,L$, is the sublattice of $L$
consisting of all cozero elements: $c \in L$ such that $c = \bigvee_{n\in\mathbb N} c_n$
for some sequence with $c_n \prec\!\prec c$ for all $n$. $\mathrm{Coz}\,L$ is a
**regular $\sigma$-frame**.

### Boolean $\sigma$-Frame Reflection
For a regular $\sigma$-frame $A$, $B(A)$ denotes its **Boolean $\sigma$-frame
reflection**, the universal Boolean $\sigma$-algebra receiving a $\sigma$-frame
homomorphism from $A$.

### Frame of $\sigma$-Ideals
For a regular $\sigma$-frame $A$, a **$\sigma$-ideal** is a down-set closed under
countable joins. $\mathcal H_\sigma(A)$ denotes the frame of all $\sigma$-ideals of
$A$, ordered by inclusion (joins = generated $\sigma$-ideal of the union, meets =
intersection).

---

## 2. The Core Question

For any **Lindelöf** completely regular frame $L$:
$$PL \cong \mathcal H_\sigma(B(\mathrm{Coz}\,L)).$$

**Question:** For an arbitrary (possibly non-Lindelöf) completely regular frame
$L$, does there exist a surjective frame homomorphism
$$h : \mathcal H_\sigma(B(\mathrm{Coz}\,L)) \twoheadrightarrow PL\ ?$$

---

## 3. Analysis

### 3.1 Lemma (established): $\mathcal H_\sigma(A)$ is always Lindelöf

*For every regular $\sigma$-frame $A$, $\mathcal H_\sigma(A)$ is Lindelöf — regardless
of the cardinality of $A$.*

**Proof.** Let $\{I_\alpha\}_{\alpha \in \mathcal A}$ be $\sigma$-ideals of $A$ with
$\bigvee_\alpha I_\alpha = A$ in $\mathcal H_\sigma(A)$. The join of a family of
$\sigma$-ideals is the $\sigma$-ideal *generated* by their union, and this is reached
in a single closure step: any countable join of elements drawn from $\bigcup_\alpha
I_\alpha$ involves only countably many of the $I_\alpha$, and a countable join of such
countable joins is again a countable join (reindex $\mathbb N \times \mathbb N \cong
\mathbb N$). So the generated ideal is exactly $\{\bigvee_n z_n : z_n \in
\bigcup_\alpha I_\alpha\}$.

Since $\top_A$ lies in this generated ideal, $\top_A = \bigvee_n z_n$ for some
sequence with each $z_n \in I_{\alpha_n}$, drawing on only countably many indices
$\{\alpha_n\}$. That countable subfamily already contains a witness for $\top_A$, so
$\bigvee_n I_{\alpha_n} = A$ in $\mathcal H_\sigma(A)$. $\blacksquare$

In particular $\mathcal H_\sigma(B(\mathrm{Coz}\,L))$ is **always** Lindelöf, for
every completely regular $L$, Lindelöf or not.

### 3.2 The natural comparison map, and where it demonstrably fails

For any completely regular $L$, define
$$\varphi : L \to \mathcal H_\sigma(\mathrm{Coz}\,L), \qquad \varphi(a) = {\downarrow}a \cap \mathrm{Coz}\,L.$$
This preserves finite meets (since $\mathrm{Coz}\,L$ is closed under finite meets).
Whether it preserves *arbitrary* joins is exactly the question of whether $L$ is
recovered from its countable cozero data — and it fails in general.

**Concrete witness.** Let $L = \mathcal P(\aleph_1)$, the discrete frame on
$\aleph_1$ points. Every element is complemented, so every element is trivially
cozero (via its own complement), giving $\mathrm{Coz}\,L = L$, and since $L$ is
already Boolean, $B(\mathrm{Coz}\,L) \cong \mathrm{Coz}\,L$.

Consider $\bigvee_{\alpha < \aleph_1} \{\alpha\} = \top_L$. Then:
- $\varphi(\top_L) = {\downarrow}\top_L \cap \mathrm{Coz}\,L = \top_{\mathcal H_\sigma}$.
- $\bigvee_{\alpha<\aleph_1} \varphi(\{\alpha\})$ is the $\sigma$-ideal *generated* by
  all the singleton ideals $\{{\downarrow}\{\alpha\}\}_\alpha$ — i.e. all countable
  joins of singletons — which is exactly the ideal of **countable subsets of
  $\aleph_1$**. This is a *proper* $\sigma$-ideal (it does not contain $\aleph_1$
  itself).

So $\varphi\big(\bigvee_\alpha \{\alpha\}\big) \ne \bigvee_\alpha \varphi(\{\alpha\})$:
$\varphi$ fails to preserve this uncountable join, explicitly and checkably. This is
the actual mechanism behind the Lindelöf-only isomorphism: cozero/$\sigma$-ideal data
is inherently countable-join data, and it is blind to a join built from $\aleph_1$
pairwise disjoint pieces.

### 3.3 Why a cardinality/Lindelöf-degree argument does *not* settle the question

A natural next move is to try to leverage 3.1 directly: $L = \mathcal P(\aleph_1)$ is
already a P-frame (every element is complemented), so $PL = L$, which is *not*
Lindelöf. If quotients preserved Lindelöf degree, this would immediately contradict
$PL$ being a quotient of the always-Lindelöf $\mathcal H_\sigma(B(\mathrm{Coz}\,L))$,
settling the question by counterexample.

**This does not work, because quotients of Lindelöf frames need not be Lindelöf.**
Concretely: let $X = \aleph_1 \cup \{\infty\}$ be the one-point compactification of
the discrete space on $\aleph_1$ points. $X$ is compact, hence Lindelöf. The discrete
part $\aleph_1$ is *open* in $X$, and restriction to an open sublocale is always a
frame surjection, so
$$\mathcal O(X) \twoheadrightarrow {\downarrow}U \cong \mathcal O(\aleph_1) = \mathcal P(\aleph_1)$$
is a genuine surjective frame homomorphism from a compact (a fortiori Lindelöf) frame
onto the non-Lindelöf discrete frame on $\aleph_1$ points. Lindelöf degree, and
cardinality, can jump arbitrarily across a frame quotient.

This closes off the cardinality-style disproof in two directions at once: it rules
out the argument sketched above, and it independently invalidates the reasoning
previously recorded in this note (an appeal to "quotients of P-frames need not be
P-frames," Ball–Walters-Wayland–Zenk 2011). That fact is true, but it is a
non-sequitur here: it shows the class of P-frames isn't closed under quotients in
general, which does not preclude $PL$ — itself a P-frame — from being *this specific*
quotient of $\mathcal H_\sigma(B(\mathrm{Coz}\,L))$. There is no contradiction in a
P-frame also being a quotient of another P-frame. Since general quotients of Lindelöf
frames aren't bounded in cardinality or Lindelöf degree either, the case for the
target claim's falsity cannot currently be closed this way.

### 3.4 Current status

- **Established:** the natural/canonical comparison map $\varphi$ fails to be a
  frame homomorphism for non-Lindelöf $L$ (§3.2), and $\mathcal H_\sigma(B(\mathrm{Coz}\,L))$
  is always Lindelöf (§3.1).
- **Not established:** whether *some other, non-canonical* surjection
  $h : \mathcal H_\sigma(B(\mathrm{Coz}\,L)) \twoheadrightarrow PL$ could still exist
  for a non-Lindelöf $L$ (e.g. $L = \mathcal P(\aleph_1)$). §3.3 shows the obvious
  obstruction (Lindelöf/cardinality preservation) does not apply, so bare existence
  of $h$ is not ruled out by this line of argument.
- **Working conjecture:** the generalization is still false in general, but for a
  structural reason rather than a cardinality one — namely that the transfinite
  construction ($L_0 = L$, $L_{\alpha+1}$ = free complementation of cozero elements
  of $L_\alpha$, colimits at limits) genuinely produces new cozero elements at each
  stage that are not in the image of any single countably-generated frame built from
  $L_0$'s data alone. This is *not yet proven here* and should be checked against the
  actual argument in Ball, Walters-Wayland & Zenk (2011) rather than re-derived from
  scratch.

**Next step:** locate and verify the specific counterexample/proof BWZ use to
establish that the transfinite chain does not collapse to one step in general, and
compare it against the $\mathcal P(\aleph_1)$ example above.

---

## 4. References

- Ball, R. N., Walters-Wayland, J., & Zenk, E. (2011). *The P-frame reflection of a
  completely regular frame*. Topology and its Applications, 158(14), 1778-1794.
- Banaschewski, B. (2011). *Baire sets and the Boolean reflection of sigma-frames*.
