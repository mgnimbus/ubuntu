# ubuntu
Tools to install when ubuntu distro is installed

1. After installing 
    - AWS Cli
    - terraform
    - Git
    - GH
    - Docker
    - Kubernetes
    - Brew ?

2. Install ZSH

    - Install ZSH

    ```
    sudo apt install zsh 
    zsh --version
    ```

    - Make it default

    ```
    chsh -s $(which zsh)
    sudo chsh -s /bin/zsh $USER
    echo $SHELL
    ```
    - Restart and check which is the default SHELL

3. Install Je BrainMono font

```
 cd /home/gowtham/Downloads/JetBrainsMono-2.304/fonts/ttf

 sudo cp *.ttf /usr/share/fonts/truetype/

 fc-cache -f -v 
```
