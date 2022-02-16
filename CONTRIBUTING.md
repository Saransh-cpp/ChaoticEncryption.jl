# Contributing to ChaoticEncryption.jl

If you'd like to contribute to ChaoticEncryption.jl (thanks!), please have a look at the [guidelines below](#workflow).

If you're already familiar with our workflow, maybe have a quick look at the [pre-commit checks](#pre-commit-checks) directly below.

## Pre-commit checks

Before you commit any code, please perform the following checks:

- [Package installs](#local-installation)
```julia-repl
julia> ]dev .
```
- [All tests pass](#testing)
```julia-repl
julia> ]test ChaoticEncryption
```
- [The documentation builds](#building-the-documentation)
```
julia ./docs/make.jl
```

## Workflow

We use [GIT](https://en.wikipedia.org/wiki/Git) and [GitHub](https://en.wikipedia.org/wiki/GitHub) to coordinate our work. When making any kind of update, we try to follow the procedure below.

### A. Before you begin

1. Create an [issue](https://guides.github.com/features/issues/) where new proposals can be discussed before any coding is done.
2. Create a [branch](https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/) of this repo (ideally on your own [fork](https://help.github.com/articles/fork-a-repo/)), where all changes will be made
3. Download the source code onto your local system, by [cloning](https://help.github.com/articles/cloning-a-repository/) the repository (or your fork of the repository).
4. [Install](#local-installation) ChaoticEncryption.jl with the developer options.
5. [Test](#testing) if your installation worked, using: `julia> ]test ChaoticEncryption`.

You now have everything you need to start making changes!

### B. Writing your code

6. ChaoticEncryption.jl is developed in [Julia](https://julialang.org/)).
7. Commit your changes to your branch with [useful, descriptive commit messages](https://chris.beams.io/posts/git-commit/): Remember these are publicly visible and should still make sense a few months ahead in time. While developing, you can keep using the GitHub issue you're working on as a place for discussion. [Refer to your commits](https://stackoverflow.com/questions/8910271/how-can-i-reference-a-commit-in-an-issue-comment-on-github) when discussing specific lines of code.
8. If you want to add a dependency on another library, or re-use code you found somewhere else, please add a link to the original source code.

### C. Merging your changes with PyBaMM

9. [Test your code!](#testing)
10. ChaoticEncryption.jl has online documentation at https://saransh-cpp.github.io/ChaoticEncryption.jl/. To make sure any new code you added show up there, please read the [documentation](#documentation) section.
11. When you feel your code is finished, or at least warrants serious discussion, run the [pre-commit checks](#pre-commit-checks) and then create a [pull request](https://help.github.com/articles/about-pull-requests/) (PR) on [ChaoticEncryption.jl's GitHub page](https://github.com/Saransh-cpp/ChaoticEncryption.jl).
12. Once a PR has been created, it will be reviewed by any member of the community. Changes might be suggested which you can make by simply adding new commits to the branch. When everything's finished, someone with the right GitHub permissions will merge your changes into PyBaMM main repository.

Finally, if you really, really, _really_ love developing ChaoticEncryption.jl, have a look at the current [project infrastructure](#infrastructure).

## Local Installation

Thanks to julia, `ChaoticEncryption.jl` can be installed for developers using a single command. Navigate to the project repository and in your `Julia REPL` type:

```julia-repl
julia> ]dev .
```

## Testing

All code requires testing. We use the [Julia's testing suite](https://docs.julialang.org/en/v1/stdlib/Test/) package for our tests. (These tests typically just check that the code runs without error, and so, are more _debugging_ than _testing_ in a strict sense. Nevertheless, they are very useful to have!). We use [`SafeTestsets.jl`](https://github.com/YingboMa/SafeTestsets.jl) to isolate the running tests, which in turn helps us in identifying the breaking point.

Before running the tests, make sure you have `SafeTestsets.jl` installed -

```julia-repl
julia> ]add SafeTestsets.jl
```
Or
```julia-repl
julia> using Pkg
julia> Pkg.add("SafeTestsets)
```

To run the tests, open up your `Julia REPL` and type -

```julia-repl
julia> ]test ChaoticEncryption
```

### Writing tests

Every new feature should have its own test. To create ones, have a look at the `test` directory and see if there's a test for a similar method. Copy-pasting this is a good way to start.

Next, add some simple (and speedy!) tests of your main features. If these run without exceptions that's a good start! Julia's official documentation for unit-testing is very useful and can be found [here](https://docs.julialang.org/en/v1/stdlib/Test/).

### Coverage

The coverage value of our codebase shows how much of our code is actually seen by the unit tests. The coverage value should never go down and should always be ~100%

[`Codecov`](#codecov) is used to automatically run coverage on pull requests.

To run the coverage locally -
1. Make sure `Coverage.jl` is installed -
```julia-repl
julia> using Pkg
julia> Pkg.add("Coverage")
```
or
```julia-repl
julia> ]add Coverage
```
2. Run the tests with `coverage=true` -
```julia-repl
julia> using Pkg
julia> Pkg.test("ChaoticEncryption"; coverage=true)
```

## Documentation

ChaoticEncryption.jl is documented in several ways.

First and foremost, every method and every class should have a [docstring](https://docs.julialang.org/en/v1/manual/documentation/) that describes in plain terms what it does, and what the expected input and output is.

These docstrings are directly rendered in the deployed documentation website. The source for this website is present in the [`docs`](https://github.com/Saransh-cpp/ChaoticEncryption.jl/tree/master/docs) folder and the deployed branch i

In addition, we write a (very) small bit of documentation in separate MarkDown in the `docs` directory. Most of what these files do is simply import docstrings from the source code. But they also do things like add tables and indexes. If you've added a new function to a module, search the `docs` directory for that module's `.md` file and add your function (in alphabetical order) to its index. If you've added a whole new module, copy-paste another module's file and add a link to your new file in the appropriate `index.md` file.

### Building the documentation

To test and debug the documentation, it's best to build it locally. To do this, navigate to your PyBaMM directory in a console, and then type:

```
julia docs/make.jl
```
And then visit the webpage served at http://127.0.0.1:8000.


## Infrastructure

### Setuptools

Installation of ChaoticEncryption.jl _and dependencies_ is handled via Julia itself.

Configuration files:

```
Project.toml
```

### Continuous Integration using GitHub actions

Each change pushed to the ChaoticEncryption.jl GitHub repository will trigger the test to be run, using [GitHub actions](https://github.com/features/actions).

Tests are run for different operating systems, and for different julia versions officially supported by ChaoticEncryption.jl. If you opened a Pull Request, feedback is directly available on the corresponding page. If all tests pass, a green tick will be displayed next to the corresponding test run. If one or more test(s) fail, a red cross will be displayed instead.

In all cases, more details can be obtained by clicking on a specific run.

Configuration files for various GitHub actions workflow can be found in `.github/worklfows`.

### Codecov

Code coverage (how much of our code is actually seen by the (linux) unit tests) is tested using [Codecov](https://docs.codecov.io/), a report is visible on https://codecov.io/gh/Saransh-cpp/ChaoticEncryption.jl.

### GitHub pages

Documentation is built using https://pages.github.com/ and published on https://saransh-cpp.github.io/ChaoticEncryption.jl/.

Configuration files:
```
documentation.yml
```

### GitHub

GitHub does some magic with particular filenames. In particular:

- The first page people see when they go to [our GitHub page](https://github.com/Saransh-cpp/ChaoticEncryption.jl) displays the contents of [README.md](README.md), which is written in the [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) format. Some guidelines can be found [here](https://help.github.com/articles/about-readmes/).
- The license for using PyBaMM is stored in [LICENSE](LICENSE), and [automatically](https://help.github.com/articles/adding-a-license-to-a-repository/) linked to by GitHub.
- This file, [CONTRIBUTING.md](CONTRIBUTING.md) is recognised as the contribution guidelines and a link is [automatically](https://github.com/blog/1184-contributing-guidelines) displayed when new issues or pull requests are created.

## Acknowledgements

This CONTRIBUTING.md file was copied from the excellent [PyBaMM GitHub repo](https://github.com/pybamm-team/PyBaMM).