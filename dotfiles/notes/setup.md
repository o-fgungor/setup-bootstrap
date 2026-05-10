# Setup Notes

---

## Neovim

apt version is too old (0.9.5), LazyVim needs newer. Use GitHub binary.

- Download: `https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz`
- Extract to `/opt/nvim-linux-x86_64/`
- Symlink: `sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim`

---

## LazyVim

Clone the starter, delete .git, move to dotfiles:

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
cp -r ~/.config/nvim ~/dotfiles/nvim
rm -rf ~/.config/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim
```

On new machines Ansible puts the symlink, LazyVim installs itself on first `nvim` launch.

---

## LSP

Syntax highlighting works out of the box via Treesitter — downloads and compiles parsers on first open.

For autocomplete, go-to-definition, error checking etc. you need a language server per language. Run `:Mason` inside nvim:

- Python → `pyright`
- JavaScript/TypeScript → `tsserver`
- C/C++ → `clangd`
- Java → `jdtls`
- Ansible → `ansible-language-server`

---

## Treesitter and build-essential

Treesitter compiles parsers with a C compiler. If `build-essential` is not installed, nvim throws errors on startup. Always install it.

---

## lazygit

No PPA for Ubuntu 24.04. Use GitHub binary:

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf /tmp/lazygit.tar.gz -C /tmp/lazygit/
sudo install /tmp/lazygit/lazygit -D -t /usr/local/bin/
```

---

## Starship

Not in apt. Install via official script:

```bash
curl -sS https://starship.rs/install.sh | sh
```

`eval "$(starship init zsh)"` must be in `.zshrc`.

---

## Ghostty

No official Ubuntu package. Use mkasberg's PPA:

```bash
sudo add-apt-repository ppa:mkasberg/ghostty
sudo apt install ghostty
```

Config: `~/.config/ghostty/config` — keep in dotfiles.

---

## Nerd Fonts

Not in apt. Download zip from GitHub, extract manually:

- URL: `https://github.com/ryanoasis/nerd-fonts/releases/download/v{VERSION}/{FontName}.zip`
- Extract to `/usr/local/share/fonts/`
- Run `fc-cache -f`

---

## Ansible Notes

- Short module names (`apt`, `git`, `shell`) not FQCN (`ansible.builtin.apt`)
- `become` is set per role in `site.yml` — system roles `yes`, dotfiles `no`
- `ansible_user` comes from inventory / `group_vars/all.yml`
- YAML values with `{{ }}` must be quoted
- Idempotency: use `stat` + `when`, or `creates:` where available
