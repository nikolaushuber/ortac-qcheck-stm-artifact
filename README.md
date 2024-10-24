# Ortac/QCheck-STM artifact

[Ortac](https://github.com/ocaml-gospel/ortac) is a tool for performing runtime
assertion checking of OCaml modules. By consuming
[Gospel](https://github.com/ocaml-gospel/gospel) annotated module signatures
it translates specifications into executable OCaml code. This code can in turn
be leveraged by different *plugins* in order to perform various analysis and
verification tasks.

This software artifact showcases the QCheck-STM plugin of Ortac, which is
meant for testing modules providing mutable data structures. The artifact acts
as a demonstration of how to use the tool, and what kind of errors can be found
with it. We specify and test 6 OCaml modules:

- `Array`, `Stack`, `Queue`, `Hashtbl` (part of the OCaml standard library)
- `Bitv` [https://github.com/backtracking/bitv](https://github.com/backtracking/bitv)
- `Varray` [https://github.com/art-w/varray](https://github.com/art-w/varray)

## Repository overview

`artifact/`

This holds the Gospel specifications for the `Array`, `Stack`, `Queue`,
`Hashtbl`, `Bitv`, and `Varray` library. It also contains minimal configuration
modules for each. The provided `dune` file instructs the OCaml build tool to
generate testing code with Ortac/QCheck-STM and create test executables for the
specified modules.

`dependencies/`

To make the installation process of this artifact as reproducible as possible,
all (transitive) OCaml dependencies needed to build the testing executables are
provided in this folder.

`doc/`

This folder holds the documentation of the Ortac/QCheck-STM tool.

`Makefile`

A build script using `make`. Provides targets for installing the tool,
running the tests, and viewing the documentation of Ortac/QCheck-STM.

`opam_install.sh`

A shell script for installing the OCaml package manager `opam`. This is
automatically run by `make install` as described further down.

`dune-project`

A file used by the OCaml build tool `dune` to mark the root of the current
project.




## Installation

Since the output of Ortac/QCheck-STM is itself OCaml code, a full OCaml
development environment is needed to compile the tests. In order to simplify
the process of installing all required dependencies, a `Makefile` is provided.
Simply issue

```
make install
```

on the command-line inside the current directory.

This will roughly perform the following operations:

- Install the OCaml package manager `opam`
- Install the OCaml compiler
- Install the `gmp` package
- Install the OCaml build tool `dune`
- Build and install Ortac/QCheck-STM
- Build and install the test binaries

For manual installation please consult the `Makefile`.

## Running tests

To run all tests, simply type

```
make test
```

This will run the created test executables with known seeds to showcase various
errors found in the specified OCaml modules.

The tests can of course also be run independently (The `-v` command-line flag
causes verbose output):

- `array_spec_tests -v`
- `stack_spec_tests -v`
- `queue_spec_tests -v`
- `hashtbl_spec_tests -v`
- `bitv_spec_tests -v`
- `varray_spec_tests -v`

In case any `unknown command` errors occur, you may first have to run
`eval $(opam env)` to set all required environment variables.

In the standard configuration the test environment runs multiple instances of
the generated tests sequentially in the same process. This means, that if a
test crashes, the surrounding test process is also killed. To instruct the
runtime to instead execute all tests in separate process, you can set the
environment variable `ORTAC_QCHECK_STM_TIMEOUT=x`, which automatically runs
each test in separate process with a timeout of `x` seconds:

```
ORTAC_QCHECK_STM_TIMEOUT=10 queue_spec_tests -v
```

For more information on this, please consult the documentation.

## Errors found

No errors were found in `Array`, `Stack`, and `Queue` while running the
generated tests for these modules.

The `Hashtbl` test revealed an interested inconsistency between the
documentation and the provided contract. `Hashtbl.create` takes as input an
initial guess of the expected size of the table. As it turns out, this initial
guess can be negative. An issue
[has been raised](https://github.com/ocaml/ocaml/issues/13469) and the
documentation [adapted](https://github.com/ocaml/ocaml/pull/13535).

The `Varray` module shows a bug when starting from an empty array, and then
pushing and popping from different ends of the array. The issue
[has been raised](https://github.com/art-w/varray/issues/2) on the project
repository.

For `Bitv` the generated tests revealed two different kinds of errors. For the
`fill`, `blit`, and `sub` functions the index-bound check can overflow, which
may result in a segmentation fault. The issue
[has been raised](https://github.com/backtracking/bitv/issues/31) and
[fixed](https://github.com/backtracking/bitv/pull/32). The `rotatel` and
`rotater` functions raise a `Division_by_zero` exception if used on zero-length
vectors, which is inconsistent as zero-length vectors can be shifted
successfully. The issue
[has been raised](https://github.com/backtracking/bitv/issues/33) on the project
repository.

## Documentation

In order to view the documentation of Ortac/QCheck-STM you can issue

```
make doc
```

This will open the documentation inside your system's standard browser.

## License

This artifact is licensed under the **MIT license**. See the [LICENSE](LICENSE)
file for more information.

Be aware that the OCaml packages in `dependencies/` have their own respective
licenses.



