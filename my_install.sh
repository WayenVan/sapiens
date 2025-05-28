#!/bin/bash

print_green "Installing additional Python packages..."
pip install chumpy scipy munkres tqdm cython fsspec yapf==0.40.1 matplotlib packaging omegaconf ipdb ftfy regex
pip install json_tricks terminaltables modelindex prettytable albumentations

cd "$(dirname "$0")"

# Function to print messages in green
print_green() {
	echo -e "\033[0;32m$1\033[0m"
}

# Function to install a package via pip with editable mode and verbose output
pip_install_editable() {
	print_green "Installing $1..."
	cd "$1" || exit
	# pip install -e . -v
	pip install . -v #avoid using editable mode for now
	cd - || exit
	print_green "Finished installing $1."
}

# Install engine
pip_install_editable "engine"

# Install cv, handling dependencies
pip_install_editable "cv"
pip install -r "cv/requirements/optional.txt" # Install optional requirements

# Install pretrain
pip_install_editable "pretrain"

# Install pose
pip_install_editable "pose"

# Install det
pip_install_editable "det"

# Install seg
pip_install_editable "seg"

print_green "Installation done!"
