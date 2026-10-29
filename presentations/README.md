# ZKDL lecture slides

Slides follow the structure of the book. Every lecture has one source file;
`make` builds a static PDF (one page per frame) and an animated PDF (one page
per overlay step) for each. See `CONVENTIONS.md` for the style rules.

| # | Lecture | Book chapters |
|---|---|---|
| 01 | `01-preliminaries` — notation, groups, fields | 1, 3 |
| 02 | `02-security-analysis` — security analysis, polynomials | 7, 4 |
| 03 | `03-linear-algebra` — linear algebra | 5 |
| 04 | `04-field-extensions-ec` — field extensions, elliptic curves | 6, 8 |
| 05 | `05-projective-pairing` — projective coordinates, pairings | 8 |
| 06 | `06-commitments` — commitment schemes | 9 |
| 07 | `07-intro-zk` — introduction to zero-knowledge proofs | 10 |
| 08 | `08-sigma-protocols` — Σ-protocols | 11 |
| 09 | `09-circuits-r1cs` — zk-SNARKs, arithmetic circuits, R1CS | 12 |
| 10 | `10-qap-pcp` — QAP, PCPs | 13 |
| 11 | `11-groth16` — pairing-based SNARKs, Pinocchio, Groth16 | 14 |
| 12 | `12-ntt` — number theoretic transform | 16.1 |
| 13 | `13-bulletproofs-ipa` — Bulletproofs: inner-product argument | 17 |
| 14 | `14-bulletproofs-applications` — Bulletproofs: range proofs, circuits | 17 |
| 15 | `15-sumcheck` — sum-check protocol | 18 |
| 16 | `16-gkr` — GKR, offline memory checking | 19, 20 |
| 17 | `17-lookups` — lookup checks (plookup, logup) | 21 |
| 18 | `18-ultragroth` — UltraGroth | 22 |
| 19 | `19-lattices` — introduction to lattice-based cryptography | 23 |
| 20 | `20-lattice-sigma` — lattice Σ-protocols | 24 |
| 21 | `21-labrador` — LaBRADOR | 25 |
| 22 | `22-codes` — introduction to code-based cryptography | 26 |
| 23 | `23-iopp` — interactive oracle proofs of proximity | 27 |
| 24 | `24-stark` — building ZK-STARK (FRI, AIR) | 28 |

Deprecated lectures left for further revisions (Circom, PlonK, the old STARK deck) are in `deprecated/`;
they still compile there with `latexmk -pdf <file>.tex`.

## Building

```sh
make            # all lectures, static + animated
make static     # static versions only
make 08-sigma-protocols.pdf 08-sigma-protocols-animated.pdf
make clean
```

Figures referenced as `../contents/images/...` come from the book, so build
from inside the repository.
