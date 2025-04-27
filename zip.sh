#!/bin/bash
# Bash script to zip the whole project in order to make it deriverable
# please make sure zip, typst, and npm are installed

set -e  # exit on error

if [ ! -x "$(command -v zip)" ]; then
    echo "zip not found"
    exit
fi

if [ ! -x "$(command -v typst)" ]; then
    echo "typst not found"
    exit
fi


OUTFILE=../aid-pf-100429021.zip
[ -e $OUTFILE ] && rm $OUTFILE  # remove if exists already


# compile the report (and save it to root folder)
echo "Compiling the report..."

cd report/

typst compile report.typ --root ..
cp report.pdf ..

cd ..


echo "Zipping..."

# copy files from src to root dir
cd src/

tmp_files=()  # files to delete

# shopt -s dotglob  # include hidden files in glob search
for file in *; do
    # exclude some files
    if [[ $file == "uv.lock" ]] || [[ $file == "README.md" ]] || [[ $file == *.csv ]] || [[ $file == __pycache__ ]] then
        continue
    fi

    # add `_LDCM` to IPYNB files
    if [[ $file == *.ipynb ]] then
        outfile=${file%.*}_LDCM.${file##*.}
    else
        outfile=$file
    fi

    cp $file "../${outfile}"
    tmp_files+=( $outfile )  # add filename to array
done

# compute requirements.txt
uv export --format=requirements-txt --no-hashes > ../requirements.txt
tmp_files+=( "requirements.txt" )

# README.md to README.txt
cp README.md ../README.txt
tmp_files+=( "README.txt" )

cd ..


# compile presentation
echo "Compiling the presentation..."
cd presentation

npx @marp-team/marp-cli@latest presentation.md --pdf --allow-local-files
cp presentation.pdf ..

cd ..



# zip it (excluding useless stuff)
zip -FS -r $OUTFILE . -x zip.sh report/\* \*.git\* img/\* \*__pycache__/\* \*.venv/\* build/\* .vscode/\* LICENSE README.md src/\* presentation/\* .ruff_cache/\* data/\*

# # cleanup
echo "Cleaning up..."
rm report.pdf
rm presentation.pdf

for f in ${tmp_files[@]}; do
    rm $f
done
