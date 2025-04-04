# ubuntu
Tools to install when ubuntu distro is installed

1. Install ZSH

```
sudo apt install zsh 
zsh --version
```

- Make it default

```bash
chsh -s $(which zsh)
chsh -s /bin/zsh $USER
```

- To verify
```
# Is your shell set to zsh? Last field of
grep $USER /etc/passwd

# Is Zsh a valid login shell? 
grep zsh /etc/shells
```

- Restart and check which is the default SHELL

```bash
echo $SHELL
```
2. Install Git

```bash
sudo apt install git-all
```
- GH

```bash
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```    


2. After installing ZSH install basic packages

- Brew

    - Prerequisites  to install brew
    ```bash
    sudo apt-get install build-essential procps curl file git
    ```
    - Installing brew
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

    ```
    brew install zsh-autosuggestions
    brew install zsh-syntax-highlighting
    ```
    ```
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ```

- Starship
    - Prerequisites to install starship
        - Install a JEtBrains Mono Font
        ```
        brew install --cask font-jetbrains-mono-nerd-font 
        ```

            1. Navigate to the Font Directory  
            ```
            cd /home/gowtham/Downloads/JetBrainsMono
            ```
            2. Copy Font Files to System Fonts Directory
            ```bash
            sudo cp *.ttf /usr/share/fonts/truetype/
            ```
            3. Update Font Cache
            ```bash
            fc-cache -f -v
            fc-list | grep "JetBrainsMonoNerdFont"    
            ```
            4. edit in vscode in setting.json
            ```json
            {
            "editor.fontFamily": "'JetBrainsMono Nerd Font', 'monospace'",
            "editor.formatOnType": true,
            "terminal.integrated.fontFamily": "'JetBrainsMono Nerd Font', 'monospace'",
            "editor.fontLigatures": true,
            "editor.minimap.enabled": false,
            "terminal.integrated.fontLigatures.enabled": true
            }
            ```
            5. Icons
            ```
            brew install g-ls
            ```

    - Install starship
    ```
    brew install starship
    ```
    
- AWS Cli
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
- terraform
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
- To update tf
```
brew upgrade hashicorp/tap/terraform
```  

- Docker
```bash

```
- Kubernetes
```bash
   brew install kubectl
   kubectl version --client
```

3. Embelish the terminal: https://www.josean.com/posts/7-amazing-cli-tools 

- fzf
    - Install fzf
    ```
    brew install fzf
    ```
    - Setup key binding in zsh

    ```bash
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --zsh)"
    ```
    ```verify
    code ctl+T to open in vscode

    ctl+R to search and filter using fzf

    Examples of what you can do with it:
    Example 	Description
    CTRL-t 	Look for files and directories
    CTRL-r 	Look through command history
    Enter 	Select the item
    Ctrl-j or Ctrl-n or Down arrow 	Go down one result
    Ctrl-k or Ctrl-p or Up arrow 	Go up one result
    Tab 	Mark a result
    Shift-Tab 	Unmark a result
    cd **Tab 	Open up fzf to find directory
    export **Tab 	Look for env variable to export
    unset **Tab 	Look for env variable to unset
    unalias **Tab 	Look for alias to unalias
    ssh **Tab 	Look for recently visited host names
    kill -9 **Tab 	Look for process name to kill to get pid
    any command (like nvim or code) + **Tab 	Look for files & directories to complete command
    ```
        
- fd
    - Install fd

        ```bash
        brew install fd
        ```
    - KeyBinding

        ```bash
        # -- Use fd instead of fzf --

        export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
        # - The first argument to the function ($1) is the base path to start traversal
        # - See the source code (completion.{bash,zsh}) for the details.
        _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
        }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
        }
        ```

    - Git binding fzf-git repo (for list of shortcuts): https://bit.ly/3Unwgzm

        ```bash
        cd ~
        git clone https://github.com/junegunn/fzf-git.sh.git
        ```
        ```bash
        source ~/fzf-git.sh/fzf-git.sh
        ```
- bat

    - Install bat

        ```bash
        brew install bat
        ```
    - Theme

    ```
    bat --list-themes | fzf --preview="bat --theme={} --color=always /home/gowtham/ubuntu/dotfiles/starship.toml"
    ```

        ```bash
        mkdir -p "$(bat --config-dir)/themes"
        ```
    - Install theme
    ```
    curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme

    bat cache --build

    # And then add the following to your ~/.zshrc:

    export BAT_THEME=tokyonight_night
    ```    

- eza (better ls)

    Install it:

    ```bash
    brew install eza
    ```
    Update zshrc

    ```bash
    alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
    ```

- tldr (user-friendly man pages)

    Install tldr
    ```
    brew install tldr
    ```
    Now you can use it just like man to learn more about a tool.

    For example to learn more about eza:
    ```
    tldr eza
    ```
 -thefuck is a really nice tool to auto correct mistyped commands

   ```
   brew install thefuck
   ```    
    ```
    # thefuck alias
    eval $(thefuck --alias fk)
    ```





























```bash


```
