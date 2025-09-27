#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data from JSON input
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // "~"')

# Get git branch (skip locks for performance)
git_branch=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_branch=$(git branch --show-current 2>/dev/null || echo "detached")
fi

# Get git stats (lines added/removed)
lines_added=0
lines_removed=0
if [ -n "$git_branch" ] && [ "$git_branch" != "detached" ]; then
    # Get diff stats against main/master, fallback to HEAD~1
    main_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")
    if git rev-parse --verify "origin/$main_branch" >/dev/null 2>&1; then
        diff_stats=$(git diff --numstat "origin/$main_branch"...HEAD 2>/dev/null | awk '{added+=$1; removed+=$2} END {print added, removed}')
    else
        diff_stats=$(git diff --numstat HEAD~1 2>/dev/null | awk '{added+=$1; removed+=$2} END {print added, removed}')
    fi
    
    if [ -n "$diff_stats" ]; then
        lines_added=$(echo $diff_stats | cut -d' ' -f1)
        lines_removed=$(echo $diff_stats | cut -d' ' -f2)
        # Handle case where no changes
        [ "$lines_added" = "" ] && lines_added=0
        [ "$lines_removed" = "" ] && lines_removed=0
    fi
fi

# Shorten directory path for display
short_cwd=$(echo "$cwd" | sed "s|$HOME|~|")
if [ ${#short_cwd} -gt 30 ]; then
    short_cwd="...${short_cwd: -27}"
fi

# Color codes
BLUE='\033[94m'
GREEN='\033[92m'
YELLOW='\033[93m'
PURPLE='\033[95m'
CYAN='\033[96m'
RED='\033[91m'
BOLD='\033[1m'
RESET='\033[0m'

# Build status line with colors and icons
status_line=""

# Model section
status_line+="${PURPLE}${BOLD}󰧑 ${model}${RESET}"

# Current directory section
status_line+=" ${BLUE}${BOLD} ${short_cwd}${RESET}"

# Git branch section (only if in git repo)
if [ -n "$git_branch" ]; then
    status_line+=" ${YELLOW}${BOLD} ${git_branch}${RESET}"
    
    # Git stats (only if there are changes)
    if [ "$lines_added" -gt 0 ] || [ "$lines_removed" -gt 0 ]; then
        if [ "$lines_added" -gt 0 ]; then
            status_line+=" ${GREEN}${BOLD}+${lines_added}${RESET}"
        fi
        if [ "$lines_removed" -gt 0 ]; then
            status_line+=" ${RED}${BOLD}-${lines_removed}${RESET}"
        fi
    fi
fi

printf "$status_line"
