MARKER_FILE="$HOME/.wsl_welcome_shown"
if [[ ! -f "$MARKER_FILE" ]]; then
  cat <<'POSTER'
============================================================
                  Welcome to Fedora DevOps
============================================================
Fedora DevOps  is a modern developer-focused WSL environment
shipped with a variety of prebuilt DevOps tools. It includes
an additional tool, DevKit, which serves as a comprehensive
toolkit for developers. DevKit streamlines your workflow
with popular programming languages, build tools, and
databases to enhance your development experience.

Available Commands:
    devkit install => Install all development tools
    devkit remove  => Remove all installed tools

For more information, visit:
    https://docs.docker.com/go/wsl2/

============================================================
POSTER

  # Create the marker file to indicate the poster has been shown
  touch "$MARKER_FILE"
else
  clear && fastfetch
fi
