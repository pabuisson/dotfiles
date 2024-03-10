#! /bin/sh

# This script is used to quickly adapt iterm2 profile and vim color scheme
# afer I switch Mac OS theme from dark to light, or vice-versa.
#
# - It relies on iterm2 python API
# - It updates my git.delta light mode setting
# - It launches my iterm_mode_switcher python script

# TODO: execute this script when the mac os setting is modified

# SETS GIT DELTA LIGHT MODE

mac_os_ui_mode="$(defaults read -g AppleInterfaceStyle)"
if [[ "$mac_os_ui_mode" == "Dark" ]]
then
    git config --global --replace-all delta.light false
else
    git config --global --replace-all delta.light true
fi


# CALLS PYTHON SCRIPT TO DEAL WITH ITERM2

# Find the first available Python executable
python_executables=("python" "python3")
python_command=""
for python_exe in "${python_executables[@]}"; do
    if command -v "$python_exe" &> /dev/null; then
        python_command="$python_exe"
        break
    fi
done

# Check if any Python executable was found
if [[ -z "$python_command" ]]; then
    echo "Python is not installed. Please install Python and try again."
    exit 1
fi

# Check if iterm2 package is installed
if ! "$python_command" -c "import iterm2" &> /dev/null; then
    echo "iterm2 package is not installed. Installing..."
    # NOTE: shouldn't use --break-system-packages, but it seems the easiest way to install this package
    #       without having to create virtual env or bringing "environment mgmt" tools like Conda
    "$python_command" -m pip install iterm2 --break-system-packages
fi

# Execute the Python script
"$python_command" ~/.dotfiles/iterm_mode_switcher.py
