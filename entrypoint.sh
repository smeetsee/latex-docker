#!/bin/sh -l

echo "::debug::Entrypoint script started."
echo "::debug::Current working directory: $(pwd)"

# Get the input file from the GitHub Action input or the first argument
TEX_FILE="${INPUT_TEX_FILE:-$1}"

# Check if the input file is provided
if [ -z "$TEX_FILE" ]; then
  echo "::error file=entrypoint.sh,line=7::No .tex file provided. Please specify the 'tex-file' input."
  exit 1
fi

# Run pdflatex to compile the LaTeX file
pdflatex -shell-escape -interaction=nonstopmode -halt-on-error "$TEX_FILE"

# Check if the compilation was successful
if [ $? -ne 0 ]; then
  echo "::error file=entrypoint.sh,line=13::Failed to compile $TEX_FILE."
  exit 1
fi

# Output the success message
echo "::notice file=entrypoint.sh,line=17::Successfully compiled $TEX_FILE."

# Write outputs to the $GITHUB_OUTPUT file
echo "time=$(date)" >>"$GITHUB_OUTPUT"

exit 0