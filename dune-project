(lang dune 3.16)

(name artifact)

(version 0.1)

(license MIT)

(generate_opam_files true)

(package
 (name artifact)
 (depends
  (ocaml (= 4.14.2))
  (dune (>= 3.16))
  (ortac-qcheck-stm (= 0.4.0))
  (varray (= 0.2))
  (bitv (= 2.0))
  odoc))
