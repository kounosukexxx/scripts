```shell
mkdir -p ~/bin
cp main.sh ~/bin/sc
chmod +x ~/bin/sc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

sc test aaa
```