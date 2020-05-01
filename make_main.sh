#!/bin/bash

FIRST_CHAPTER=1
LAST_CHAPTER=14


preamble="\documentclass[11pt]{book}
\input{style/preamble_math}
\input{style/preamble_format}"

title="\title{Unsupervised Learning}
\author{Nakul Verma}
\date{}"


REGEX_RANGE='([0-9]+)-([0-9]+)'
for ((i=$FIRST_CHAPTER;i<=$LAST_CHAPTER;i++)); do
    CHAPTERS[$i]=0
done

echo "Warning: this operation will overwrite main.tex"


## Get chapters to generate
read -p "Enter chapter numbers to generate: " input
for i in ${input[@]}
do
    if [[ $i =~ $REGEX_RANGE ]]; then
	for ((j=${BASH_REMATCH[1]};j<=${BASH_REMATCH[2]};j++)); do
	    if [[ $j -le $LAST_CHAPTER ]] && [[ $j -ge $FIRST_CHAPTER ]]; then
		CHAPTERS[$j]=1
	    else
		echo "Chapter $j does not exist."
	    fi
	done
    else
	if [[ $i -le $LAST_CHAPTER ]] && [[ $i -ge $FIRST_CHAPTER ]]; then
	    CHAPTERS[$i]=1
	else
	    echo "Chapter $i does not exist."
	fi
    fi
done


## Check if want to generate the whole book
all_zero=1
for ((i=$FIRST_CHAPTER;i<=$LAST_CHAPTER;i++))
do
    if [[ CHAPTERS[$i] -eq 1 ]]; then
	all_zero=0
    fi
done
if [[ $all_zero -eq 1 ]]; then
    for ((i=$FIRST_CHAPTER;i<=$LAST_CHAPTER;i++))
    do
	CHAPTERS[$i]=1
    done
fi

all_one=1
for ((i=$FIRST_CHAPTER;i<=$LAST_CHAPTER;i++))
do
    if [[ CHAPTERS[$i] -eq 0 ]]; then
	all_one=0
    fi
done



## Include parts?
read -p "Include parts? [yN]: " parts
case "$parts" in
    y|yes|YES|Yes|Y)
	include_part=1
	;;
    *)
	include_part=0
	;;
esac

## Build main file
### preamble
echo "$preamble" > main.tex
echo "" >> main.tex
echo "" >> main.tex

### bibresource
for ((i=1;i<=14;i++))
do
    if [[ CHAPTERS[$i] -eq 1 ]]; then
	echo "\addbibresource{chapter_$i/references}" >> main.tex
    fi
done
echo "" >> main.tex
echo "" >> main.tex

### title
echo "$title" >> main.tex
echo "" >> main.tex
echo "" >> main.tex


### document
echo "\begin{document}" >> main.tex

if [[ include_part -eq 1 || all_one -eq 1 ]]; then
    echo "\maketitle" >> main.tex
    echo "\tableofcontents" >> main.tex
    echo "" >> main.tex
    echo "" >> main.tex
fi

### Preface
if [[ include_part -eq 1 ]]; then
    echo "\include{preface/preface}" >> main.tex
    echo "" >> main.tex
fi

### Part 1
if [[ include_part -eq 1 ]]; then
    echo "\part{Clustering}" >> main.tex
    echo "" >> main.tex
fi

for ((i=1;i<=4;i++))
do
    if [[ CHAPTERS[$i] -eq 1 ]]; then
	echo "\include{chapter_$i/chapter_$i}" >> main.tex
    fi
done

echo "" >> main.tex
echo "" >> main.tex


### Part 2

if [[ include_part -eq 1 ]]; then
    echo "\part{Dimensionality Reduction}" >> main.tex
    echo "" >> main.tex
fi

for ((i=5;i<=7;i++))
do
    if [[ CHAPTERS[$i] -eq 1 ]]; then
	echo "\include{chapter_$i/chapter_$i}" >> main.tex
    fi
done

echo "" >> main.tex
echo "" >> main.tex

### Part 3

if [[ include_part -eq 1 ]]; then
    echo "\part{Density Estimation}" >> main.tex
    echo "" >> main.tex
fi

for ((i=8;i<=10;i++))
do
    if [[ CHAPTERS[$i] -eq 1 ]]; then
	echo "\include{chapter_$i/chapter_$i}" >> main.tex
    fi
done

echo "" >> main.tex
echo "" >> main.tex


### Part 4

if [[ include_part -eq 1 ]]; then
    echo "\part{Ad Hoc Techniques}" >> main.tex
    echo "" >> main.tex
fi

for ((i=11;i<=14;i++))
do
    if [[ CHAPTERS[$i] -eq 1 ]]; then
	echo "\include{chapter_$i/chapter_$i}" >> main.tex
    fi
done

echo "" >> main.tex
echo "" >> main.tex

### Appendix

if [[ include_part -eq 1 ]]; then
    echo "\part*{Appendices}" >> main.tex
    echo "\include{appendix}" >> main.tex
    echo "" >> main.tex
fi

### Index

if [[ include_part -eq 1 ]]; then
    echo "\printindex" >> main.tex
    echo "" >> main.tex
fi

echo "\end{document}" >> main.tex


echo "main file exported to ./main.tex"
