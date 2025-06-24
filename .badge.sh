# Get the current repo name
repo_name=$(basename -s .git "$(git config --get remote.origin.url)")

# Construct the correct badge line
badge_line="![CI](https://github.com/stuycs-k/$repo_name/actions/workflows/ci.yml/badge.svg)"

# README file to update
readme_file="README.md"

# Step 1: Remove the last line if it contains "AP1L"
if tail -n 1 "$readme_file" | grep -q "AP1L"; then
    # Remove the last line
    head -n -1 "$readme_file" > "${readme_file}.tmp" && mv "${readme_file}.tmp" "$readme_file"
    echo "🧹 Removed last line containing 'AP1L'"
fi

# Step 2: Add the badge if it's not already present
if ! grep -Fq "$badge_line" "$readme_file"; then
    echo -e "\n$badge_line" >> "$readme_file"
    echo "✅ Added CI badge for $repo_name"
    git config user.name "github-actions[bot]"
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git add .
    git diff --cached --quiet || (git commit -m "Run update.sh on repo creation" && git push)
else
    echo "ℹ️  CI badge already present"
fi
