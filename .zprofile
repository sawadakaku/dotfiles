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
export PATH=/usr/local/opt/opencv3/bin:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=/usr/local/opt/sqlite/bin:$PATH
