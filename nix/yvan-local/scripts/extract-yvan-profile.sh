#!/usr/bin/env bash

# extract-yvan-profile.sh - Extract yvan-local record from Nix profile
# Usage: ./extract-yvan-profile.sh [url]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

VERBOSE=false
MODE="json"

# Logging functions
log_info() {
	echo -e "${BLUE}[INFO]${NC} $1" >&2
}

log_warn() {
	echo -e "${YELLOW}[WARN]${NC} $1" >&2
}

log_error() {
	echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_success() {
	echo -e "${GREEN}[SUCCESS]${NC} $1" >&2
}

# Show help
show_help() {
	cat <<EOF
Usage: $0 [OPTIONS] [url]

Extract yvan-local record from Nix profile.

With 'url' argument, outputs just the store path URL.
Without arguments, outputs the full JSON record.

OPTIONS:
    -v, --verbose    Enable verbose output
    -h, --help       Show this help message

EXAMPLES:
    $0                  # Extract yvan-local record as JSON
    $0 url              # Get store path URL only
    $0 -v              # Verbose output with debugging info

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	url)
		MODE="url"
		shift
		;;
	-v | --verbose)
		VERBOSE=true
		shift
		;;
	-h | --help)
		show_help
		exit 0
		;;
	*)
		log_error "Unknown option: $1"
		show_help
		exit 1
		;;
	esac
done

# Check dependencies
check_dependencies() {
	local deps=("jq" "nix")
	for dep in "${deps[@]}"; do
		if ! command -v "$dep" &>/dev/null; then
			log_error "Required dependency not found: $dep"
			exit 1
		fi
	done
}

extract_yvan_record() {
	if [[ "$VERBOSE" == true ]]; then
		log_info "Getting profile JSON..."
	fi

	local profile_info
	profile_info=$(nix profile list --json | jq '.elements' 2>/dev/null) || {
		log_error "Failed to get profile list"
		return 1
	}

	if [[ "$VERBOSE" == true ]]; then
		log_info "Profile JSON structure:"
		echo "$profile_info" | jq 'keys' >&2
		log_info "Total entries: $(echo "$profile_info" | jq 'keys | length')"
	fi

	local yvan_info=""

	# Method 1: Direct key access for 'nix/yvan-local'
	if [[ "$VERBOSE" == true ]]; then
		log_info "Trying direct key access: jq '.\"nix/yvan-local\"'"
	fi

	yvan_info=$(echo "$profile_info" | jq '."nix/yvan-local"' 2>/dev/null || echo "null")

	if [[ "$yvan_info" != "null" && -n "$yvan_info" ]]; then
		if [[ "$VERBOSE" == true ]]; then
			log_success "Found yvan-local using direct key access"
		fi
		echo "$yvan_info"
		return 0
	fi

	# Method 2: Find any key containing 'yvan-local'
	if [[ "$VERBOSE" == true ]]; then
		log_info "Trying key search: jq 'to_entries[] | select(.key | contains(\"yvan-local\")) | .value'"
	fi

	yvan_info=$(echo "$profile_info" | jq 'to_entries[] | select(.key | contains("yvan-local")) | .value' 2>/dev/null || echo "null")

	if [[ "$yvan_info" != "null" && -n "$yvan_info" ]]; then
		if [[ "$VERBOSE" == true ]]; then
			log_success "Found yvan-local using key search"
		fi
		echo "$yvan_info"
		return 0
	fi

	# Method 3: Find any entry where attrPath contains 'yvan-local'
	if [[ "$VERBOSE" == true ]]; then
		log_info "Trying attrPath search: jq 'to_entries[] | select(.value.attrPath // \"\" | contains(\"yvan-local\")) | .value'"
	fi

	yvan_info=$(echo "$profile_info" | jq 'to_entries[] | select(.value.attrPath // "" | contains("yvan-local")) | .value' 2>/dev/null || echo "null")

	if [[ "$yvan_info" != "null" && -n "$yvan_info" ]]; then
		if [[ "$VERBOSE" == true ]]; then
			log_success "Found yvan-local using attrPath search"
		fi
		echo "$yvan_info"
		return 0
	fi

	# If we get here, we couldn't find yvan-local
	log_error "yvan-local not found in profile using any method"

	if [[ "$VERBOSE" == true ]]; then
		log_info "Available profile keys:"
		echo "$profile_info" | jq 'keys[]' >&2

		log_info "Full profile structure:"
		echo "$profile_info" | jq '.' >&2
	fi

	return 1
}

# Main function
main() {
	check_dependencies

	if [[ "$VERBOSE" == true ]]; then
		log_info "Starting yvan-local extraction..."
	fi

	local yvan_record
	yvan_record=$(extract_yvan_record) || exit 1

	# Output based on mode
	if [[ "$MODE" == "url" ]]; then
		echo "$yvan_record" | jq -r '.storePaths[0]'
	else
		echo "$yvan_record" | jq '.'
	fi

	if [[ "$VERBOSE" == true ]]; then
		log_success "Extraction completed successfully"
	fi
}

# Run main function
main "$@"
