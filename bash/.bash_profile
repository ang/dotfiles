# .bash_profile is executed for login shells. When you log into a shell via
# `login` or `ssh`, the .bash_profile file is loaded.
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

# If there's a bashrc file, let's just load that instead.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
