# .zprofile

# execute .zshrc (when exist)
if [ -f ~/.zshrc ]; then
    . ~/.zshrc
fi

# setting environmental variables
# path
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/bin:$PATH
