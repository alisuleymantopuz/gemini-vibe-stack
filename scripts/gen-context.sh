#!/bin/bash

# gen-context.sh
# Aggregates project files into a single markdown file for Gemini context window.

OUTPUT_FILE="gemini_context.md"

echo "# Gemini Vibe Stack Context" > "$OUTPUT_FILE"
echo "Generated on $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "Scanning /repos for source code..."

# Find all files in repos, excluding node_modules, .git, and other unnecessary dirs
find repos -type f \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    -not -path "*/.DS_Store" \
    -not -path "*/dist/*" \
    -not -path "*/build/*" \
    | while read -r file; do

    echo "Adding $file..."
    
    # Add file path header
    echo "## File: $file" >> "$OUTPUT_FILE"
    echo "\`\`\`" >> "$OUTPUT_FILE"
    
    # Add file content
    cat "$file" >> "$OUTPUT_FILE"
    
    echo "\`\`\`" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo "✅ Context generation complete: $OUTPUT_FILE"
echo "You can now upload $OUTPUT_FILE to Gemini 1.5 Pro."
