# COMS 4995 Fall 2018 Unsupervised Learning

This git repository holds the scribe notes for lectures.

## Quick Usage

**Forking repoo.** Create a fork of this repo by clicking on
  **Fork** on the top-right corner of the page. See also:
  [forking a repo](https://help.github.com/articles/fork-a-repo/)

**Making a local copy.** To clone the scribe notes into a local
  repository, run the following command:

```
$ git clone https://github.com/[YOUR-USERNAME]/uml-notes.git
```

  Be sure to replace [YOUR-USERNAME] with your actual git username.

**Generate main.** The root directory contains the shell script
  `make_main.sh`. This helps you generate the `main.tex` file for
  specific chapters.

```
$ ./make_main.sh
Warning: this operation will overwrite main.tex
Enter chapter numbers to generate: 1 2 6-9
Include parts? [yN]:

main file exported to ./main.tex
```

In the above example, this will generate a `main.tex` file that will
load chapters 1,2,6,7,8,9. Leaving the chapter numbers blank will
generate the whole book.

*Note*: you may need to give `make_main.sh` executable permission:

```
$ chmod +x make_main.sh
```

*Note*: if you cannot run the `make_main.sh` file, you can copy the
 `main.tex.backup` file to `main.tex` and make changes to the
 `main.tex` file manually.

**Creating a branch.** When scribing, you should checkout a
  branch. This will help us keep the `master` branch from becoming too
  chaotic.

Let's say you're scribing k-means. As k-means is covered in Chapter 1,
you should checkout the `chapter-one` branch: 

```
$ git checkout -b chapter-one
```

Do local edits and push your edits into your branch:

```
$ git push origin chapter-one
```

If you've checked out the `chapter-one` branch, please make edits only
to chapter one files.

**Making a pull request.** Once you've finalized your scribe notes,
  please submit a [pull request](https://yangsu.github.io/pull-request-tutorial/) on github.
  We will review your notes, and if no major changes need to be made,
  we will merge your branch into the master branch.


**Compiling LaTeX.** We recommend installing `latexmk` (often comes
  with texlive), and running:

```
$ latexmk -pdf main.tex
```

## Organization

Here is the general shape of the tex-related files:

```
uml-notes/
|-style/
  |-preamble.tex
|-chapter_1/
  |-chapter_1.tex
  |-1_section.tex
  |-2_section.tex
  .
  .
  |-references.bib
  |-files/
    |-img.png
.
.
|-main.tex
```

Our goal is to reduce the number of conflicts: each student will
scribe on a particular section(s) within a chapter. For example, the
section on k-means is `chapter_1/3_kmeans.tex`.

The `chapter_1/chapter_1.tex` file combines all the section files
together. This way, ideally, only one student will be modifying a tex
file at a time. 


## Best Practices

**LaTeX** We've defined some commonly used macros below you may feel
free to use. Please don't edit the preambles before consulting with
us! Let us know if you need to import an additional package or think
we should include other macros.

```
USEFUL MACROS

PROBABILITY
Expectation:  \E
Probability:  \Pr
Variance:     \Var
KL Div:       \Div{}{}        % looks like D( - || - )

LINEAR ALGEBRA
Matrix (bf):  \mat{}
Vector (bf):  \vec{}

ANALYSIS
Abs:          \abs{}
Norm:         \norm{}
Inner prod:   \ip{}
Argmin:       \argmin{}
Argmax:       \argmax{}
Varepsilon:   \eps

COMMON SETS
Reals:        \bbR
Rationals:    \bbQ
Naturals:     \bbN
Complex Num:  \bbC
Integers:     \bbZ
Finite field: \bbF
```

**git** Everytime you edit any part of a line, git will save the
  change for the whole line. However, in text, a line could
  potentially be a whole paragraph. So, please consider turning on
  automatic word wrapping to help truncate each line at, say, 70
  characters.

In `emacs`, you can turn this on using:
```
M-x auto-fill-mode
```
In `vim`, this is
```
:set tw=70
```
