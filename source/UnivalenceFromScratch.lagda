Martin Escardo, 28 February 2018.

    ---------------------------------------------------
    A self-contained, brief and complete formulation of
    Voevodsky's Univalence Axiom
    ---------------------------------------------------

1. Introduction
   ------------
   
In introductions to the subject for a general audience of
mathematicians or logicians, the univalence axiom is typically
explained by handwaving. This gives rise to several misconceptions,
which cannot be properly addressed in the absence of a precise
definition.

Here we give a complete formulation of the univalence axiom from
scratch,

 * first written informally but rigorously in mathematical English
   prose, and
 
 * then formally in Agda notation for Martin-Löf typet theory.

(Search for "UnivalenceFromScratch" to jump to the formal version.)

The univalence axiom is not true or false, in say, ZFC or the internal
language of an elementary topos. It cannot even be formulated. As the
saying goes, it is not even wrong.

This is because

   univalence is a property of the *identity type* of a *universe of types*.

Nothing like Martin-Löf's identity type occurs in ZFC or topos logic,
although universes have of course been considered in both.

2. Informal, rigorous construction of the univalence type
   ------------------------------------------------------

This is correct: univalence is a type. It takes a number of steps to
construct it, in addition to subtle decisions (as e.g. to work with
equivalences rather than isomorphisms, as discussed below).

We first need to briefly introduce Martin-Löf type theory. We will not
give a course in MLTT. Instead, we will mention which constructs of
MLTT are needed to give a complete definition of the univalence
axiom. This will be enough to illustrate the important fact that in
order to understand univalence we first need to understand Martin-Löf
type theory (MLTT) well.

* Types and their elements
  ------------------------

Types are the analogues of sets in ZFC and objects in topos theory.

Types are construced together with their elements, and not by
collecting some previously existing elements. When a type is
constructed, we get freshly new elements for it. We write

    x:X

to declare that the element x has type X. This is not something that
is true or false (like a membership relation x ∈ X in ZFC). For
example, if ℕ is the type of natural numbers, we may have

    17 : ℕ,
   (13,17) : ℕ × ℕ.

However, the following statements are nonsensical and syntactically
incorrect, rather than false:

    17 : ℕ × ℕ (nonsense),
   (13,17) : ℕ (nonsense).

* Products and sums of type families
  ----------------------------------

Given family of types A(x) indexed by elements of a type x:X, we can
form its product and sum:

    Π(x:X), A(x),
    Σ(x:X), A(x),

which we also write Π A and Σ A. An element of the type Π A is a
function that maps elements x:X to elements of A(x). An element of the
type Σ A is a pair (x,a) with x:X and a:A(x).

We also have the type X→Y of functions from X to Y, which is the
particular case of Π with the constant family A(x)=Y

We also have the cartesian product X×Y, whose elements are pairs. This
is the particular case of Σ, again with A(x)=Y. (It also can be viewed
as a particular case of Π, for families indexed by a two-point type 𝟚
with elements ₀,₁:𝟚. But we need a universe U in order to be able to
define A(₀)=X and A(₁)=Y - see below.)

We also have the disjoint sum X+Y, which can be seen as a particular
case of Σ for families indexed by the type 𝟚.

And we have the empty type 𝟘 and the one-element type 𝟙.

* Quantifiers and logic
  ---------------------

There is no underlying logic in MLTT. Propositions are types, and Π
and Σ play the role of universal and existential quantifiers, via the
so-called Curry-Howard interpretation of logic. But univalent type
theory relies on a variation ∃ of Σ which will not play any role here
and hence won't be discussed. As for the connectives, implication is
given by the function-space construction →, conjunction by the binary
cartesian product ×, and disjunction by the binary disjoint sum + (or
by a variation ∨ that occurs in univalent type theory, again not
needed here).

* The identity type
  -----------------

Given a type X and elements x,y:X, we have the identity type

    Id_X(x,y),

with the subscript X often elided. We have a function

    refl : Π(x:X), Id(x,x).

The idea is that the function refl witnesses the reflexivity of the
"relation" Id. Without univalence, refl is the only given way to
construct elements of the identity type.

In addition to refl, we stipulate that for any given type family A(x,y,p)
indexed by elements x,y:X and p:Id(x,y) and any given function

    f : Π(x:X), A(x,x,refl(x)),

we have a function 

    J(A,f) : Π(x,y:X), Π(p:Id(x,y)) → A(x,y,p),

with

    J(A,f)(x,x,refl(x)) = f(x).

The idea is that Id(x,y) collects the ways in which x and y are
identified.

With these requirements, the exact nature of the type Id(x,y) is
fairly unspecified. It is consistent that it is always a subsingleton,
which is known as the K axiom for the type X, in the following sense:

   K(X) = Π(x,y:X), Π(p,q:Id(x,y)), Id(p,q).

The second identity type is that of the type Id(x,y). This is possible
because any type has an identity type, including the identity type
itself, and the identity type of the identity type, and so on, which
is the basis for univalent mathematics (but this is not discussed
here, as it is not needed in order to construct the univalence type).

On the other hand the univalence axioms provides a means to
constructing elements other than refl(x), at least for some types
X. It will be the case than for some other types X, even in the
presence of univalence, K(X) "holds", meaning that we can construct an
element of it. Such types are called sets. The K axiom says that all
types are sets. The univalence axiom says that some types are not sets
(then they may be 1-groupoids, 2-groupoids, ..., and even ∞-groupoids,
but we will not address this aspect of univalent mathematics here).

We will see examples of uses of J in the steps leading to the
construction of the univalence type.

* Universes
  ---------

Our final ingredient is a "large" type of "small" types, called a
universe. It is common to assume a tower of universes U₀, U₁, U₂,
... of "larger and larger" types, with

   U₀ : U₁,  U₁ : U₂,  U₂ : U₃, ...

It is sometimes assumed that these universes are cumulative, but we
will not assume (or reject) this.

The letters U, V, W range over universes, the successor of a universe
U is written U ′, and the first universe after the universes U and V
is written U ⊔ V, to avoid subscripts.

When we have universes, a type family A indexed by a type X:U may be
considered to be a function A:X→V for some universe V.

Universes are also used to construct types of mathematical structures,
such as the type of groups, whose definition starts like this:

 Grp = Σ(G:U), isSet(G) × Σ(e:G), Σ(_∙_:G×G→G), (Π(x:G), Id(e∙x,x)) × ⋯ 

Here isSet(G)=Π(x,y:G),Id(x,y), as above. With univalence, G itself
will not be a set, but a 1-gropoid instead, namely a type whose
identity types are all sets. Moreover, if U univalent for A,B:Grp, the
identity type Id(A,B) can be shown to be in bijection with the group
isomorphisms of A and B.

* Univalence
  ----------

Univalence is a property of the identity type Id_U of a universe U. It
takes a number of steps to define this type.
  
We say that a type X is a singleton if we have an element c with
Id(c,x) for all x:X. In Curry-Howard logic, this is

    isSingleton(X) = Σ(c : X), Π(x : X), Id(c,x).

(Alternative terminology: X is contractible.)

For a function f:X→Y and an element y:Y, its fiber is the type of
points x:X that are mapped to y:

    f⁻¹(y) = Σ(x:X),Id(f(x),y)

The function f is called an equivalence if its is fibers are are all
singletons:

    isEquiv(f) = Π(y:Y), isSingleton(f⁻¹(y)).

The type of equivalences from X:U to Y:U is

    Eq(X,Y) = Σ(f : X → Y), isEquiv(f).

Given x:X, we have the singleton type of y:Y with Id(y,x):

   singletonType(x) = Σ(y:X), Id(y,x).

We also have the element singleton(x) of this type:

   singleton(x) = (x , refl(x)).

We now need to *prove* that singleton types are singletons:

   Π(x : X), isSingleton(singletonType x).

In order to do that, we use J with the type family

  A(y,x,p) := Id(singleton(x), (y , p)),

and the function f : Π(x:X), A(x,x,refl(x)) defined by

  f(x) := refl(singleton(x)).

Then we use J(A,f) to get a function

  φ : Π(y x : X), Π(p : Id y x), Id(singleton(x), (y , p))
  φ := J(A,f).

(Notice the reversal of y and x.)

With this, we can define a function

  g : Π(x : X), Π(σ : singletonType x), Id (singleton x) σ
  g(x , (y , p)) := φ(y,x,p).

Finally, using g we get our desired result, that singleton types are
singletons:

  h : (x : X) → Σ \(c : singletonType x) → (σ : singletonType x) → Id c σ
  h x = (singleton x , g x)

Now, for any type X, its identity function Id_X, defined by

  id(x) = x,

is an equivalence. This is because the fiber id⁻¹(x) is simply the
singleton type defined above, which we proved to be a singleton. We
need to name this function, because it is needed in the formulation of
the univalence of U:

  idIsEquiv : Π(X : U), isEquiv(id_X).

Now we use J the second time to define a function

  IdToEq : Π(X,Y:U), Id(X,Y) → Eq(X,Y).

For X,Y:U and p:Id(X,Y), we set

  A(X,Y,p) := Eq(X,Y)
  
and

  f(X) := (id_X , idIsEquiv(X)),

and

  IdToEq := J(A,f).

Finally, we say that the universe U is univalent if the map
IdToEq(X,Y) is itself an equivalence:

  isUnivalent(U) := Π(X,Y:U), isEquiv(IdToEq(X,Y)).

* Notes
  -----

 0. The minimal Martin-Löf type theory needed to formulate univalence has

      Π, Σ, Id, U.

    One universe suffices (the one which univalence talks about).
  
 1. It can be shown, by a very complicated and interesting argument,
    that

     Π(u,v: isUnivalent(U)), Id(u,v).

    This says that the univalence is a subsingleton type (any two of
    its elements are identified). In the first step we use u (or v) to
    get function extensionality (any two pointwise identified
    functions are identified), which is *not* provable in MLTT, but is
    provable from the assumption that U is univalent. Then, using
    this, one shows that being an equivalence is a subsingleton
    type. Finally, again using function extensionality, we get that a
    product of subsingletons is a subsingleton. But then Id(u,v),
    which is what we wanted to show. But this of course omits the
    proof that univalence implies function extensionality (original
    due to Voevodsky), which is fairly elaborate.

 2. For a function f:X→Y, consider the type

     Iso(f) := Σ(g:Y→X), (Π(x:X), Id(g(f(x)), x)) × (Π(y:Y), Id(f(g(y)), y)).

    We have a functions r:Iso(f)→isEquiv(f) and
    s:isEquiv(f)→Iso(f). However, the type isEquiv(f) is always a
    subsingleton, assuming function extensionality, whereas tthe type
    Iso(f) need not be. What we do have is that the function r is a
    retraction with section s.

    Moreover, the univalence type formulated as above, but using
    Iso(f) rather than isEquiv(f) is provably empty. So, to have a
    consistent axiom, it is crucial to use the type isEquiv(f). It was
    Voevodsky's insight that not only a subsingleton version of Iso(f)
    is needed, but also how to construct it. The construction of
    isEquiv(f) is very simple, but very difficult to arrive at. It is
    motivated by homotopical models of the theory. But the univalence
    axiom can be understood without reference to homotopy theory.

 3. The fact (again proved by Voevodsky, with the model of simplicial
    sets) that MLTT is consistent with the univalence axiom shows
    that, before we postulate univalence, that MLTT is
    "proto-univalent" in the sense that it cannot distinguish concrete
    isomorphic types such as ℕ and ℕ×ℕ. This is because, being
    isomorphic, they are equivalent. But then univalence gives Id(ℕ,
    ℕ×ℕ). And if we have P(ℕ) then we get, using J, also P(ℕ×ℕ), and
    vice verse. Exercise!

    So MLTT is invariant under isomorphism in this double negative,
    meta-mathematical sense. With univalence, it becomes invariant
    under isomorphism in a positive, mathematical sense.

 4. Thus, we see that the formulation of univalence is far from
    direct, and has much more to it than the slogan "isomorphic types
    are equal".

    What the consistency of the univalence type says is that one
    possible understanding of the identity type Id(X,Y) for X,Y:U is
    as precisely the type Eq(X,Y) of equivalences. Without univalence,
    the nature of the identity type of the universe in MLTT is fairly
    underspecified. It is a remarkable property of MLTT that it is
    consistent with this interpretation of the identity type of the
    universe.

 5. For the univalence axiom to be consistent, it is important that
    "equality reflection", which identifies identity type with
    (definitional) equalities, is absent from the theory. This is
    because equality reflection gives the K axiom for all types,
    including the universe, which is direct contradiction with
    univalence.

3. Formal construction of the univalence type in Agda
   --------------------------------------------------

We now give a symbolic rendering of the above construction of the
univalence type, in Agda notation (see
http://wiki.portal.chalmers.se/agda/pmwiki.php).

\begin{code}

module UnivalenceFromScratch where

open import Agda.Primitive using (_⊔_) renaming (lzero to U₀ ; lsuc to usuc ; Level to Universe)

_̇ : (U : Universe) → _
U ̇ = Set U -- This should be the only use of the Agda keyword 'Set' in this development.

infix  0 _̇

_′ : Universe → Universe
_′ = usuc

data Σ {U V : Universe} {X : U ̇} (Y : X → V ̇) : U ⊔ V ̇ where
  _,_ : (x : X) (y : Y x) → Σ Y

data Id {U : Universe} {X : U ̇} : X → X → U ̇ where
  refl : (x : X) → Id x x

J : {U V : Universe} {X : U ̇}
  → (A : (x y : X) → Id x y → V ̇)
  → ((x : X) → A x x (refl x))
  → (x y : X) (p : Id x y) → A x y p
J A f x x (refl x) = f x

isSingleton : {U : Universe} → U ̇ → U ̇
isSingleton X = Σ \(c : X) → (x : X) → Id c x

fiber : {U V : Universe} {X : U ̇} {Y : V ̇} (f : X → Y) → Y → U ⊔ V ̇
fiber f y = Σ \x → Id (f x) y

isEquiv : {U V : Universe} {X : U ̇} {Y : V ̇} → (X → Y) → U ⊔ V ̇
isEquiv f = (y : _) → isSingleton(fiber f y)

Eq : {U V : Universe} → U ̇ → V ̇ → U ⊔ V ̇
Eq X Y = Σ \(f : X → Y) → isEquiv f

singletonType : {U : Universe} {X : U ̇} → X → U ̇
singletonType x = Σ \y → Id y x

singleton : {U : Universe} {X : U ̇} (x : X) → singletonType x
singleton x = (x , refl x)

singletonTypesAreSingletons : ∀ {U} {X : U ̇} (x : X) → isSingleton(singletonType x)
singletonTypesAreSingletons {U} {X} = h
 where
  A : (y x : X) → Id y x → U ̇
  A y x p = Id (singleton x) (y , p)
  f : (x : X) → A x x (refl x)
  f x = refl (singleton x)
  φ : (y x : X) (p : Id y x) → Id (singleton x) (y , p)
  φ = J A f
  g : (x : X) (σ : singletonType x) → Id (singleton x) σ
  g x (y , p) = φ y x p
  h : (x : X) → Σ \(c : singletonType x) → (σ : singletonType x) → Id c σ
  h x = (singleton x , g x)

id : ∀ {U} (X : U ̇) → X → X
id X x = x

idIsEquiv : {U : Universe} (X : U ̇) → isEquiv(id X)
idIsEquiv X = g
 where
  g : (x : X) → isSingleton (fiber (id X) x)
  g x = singletonTypesAreSingletons x

IdToEq : {U : Universe} (X Y : U ̇) → Id X Y → Eq X Y
IdToEq {U} = J A f
 where
  A :  (X Y : U ̇) → Id X Y → U ̇
  A X Y p = Eq X Y
  f : (X : U ̇) → A X X (refl X)
  f X = (id X , idIsEquiv X)

isUnivalent : (U : Universe) → U ′ ̇
isUnivalent U = (X Y : U ̇) → isEquiv(IdToEq X Y)

\end{code}

Thus, we see that even in its concise symbolic form, the formulation
of univalence is far from direct.