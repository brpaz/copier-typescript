#!/bin/bash
#
# Helper script to generate a project from the template and output the path to the generated project
# Useful for testing the template generation.
OUTPUT_DIR=${OUTPUT_DIR:-$(mktemp -d)}

copier copy -r HEAD --force --trust --skip-tasks \
    -d project_name="Test Project" \
    -d project_description="A test generated project" \
    -d git_repo_slug="acme/test-project" \
    -d git_repo_url="https://github.com/acme/test-project" \
    . "$OUTPUT_DIR/test-project"

if [ $? -ne 0 ]; then
    echo "Error: Failed to generate project from template"
    exit 1
fi

# If context is github actions, output the path to the generated project
if [ -n "$GITHUB_ACTIONS" ]; then
    echo "output_dir=$tmpdir/test-project" >> $GITHUB_OUTPUT
else
    echo "Generated project path: $OUTPUT_DIR/test-project"
fi
