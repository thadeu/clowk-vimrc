# clowk-vimrc

A single `~/.vimrc` for servers, VMs and EC2 instances. One command installs the
config, [vim-plug](https://github.com/junegunn/vim-plug) and all plugins.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/thadeu/clowk-vimrc/main/install.sh | bash
```

The installer does these steps:

1. Installs `vim`, `git` and `curl` if they are not present
   (apt, dnf, yum, apk, pacman, zypper or brew).
2. Copies `vimrc` to `~/.vimrc`. An existing file becomes `~/.vimrc.bak.<timestamp>`.
3. Installs vim-plug in `~/.vim/autoload/plug.vim`.
4. Runs `:PlugInstall` without a user interface.

Run the same command again to update the config.

## Options

Give the options after `-s --` when you use a pipe:

```bash
curl -fsSL https://raw.githubusercontent.com/thadeu/clowk-vimrc/main/install.sh | bash -s -- --no-plugins
```

| Option | Result |
| --- | --- |
| `--ref <ref>` | Installs from a branch, tag or commit (default: `main`) |
| `--no-deps` | Does not install system packages |
| `--no-plugins` | Copies the config only, does not run `:PlugInstall` |
| `--no-backup` | Writes over `~/.vimrc` with no backup copy |
| `--uninstall` | Removes `~/.vimrc`, `~/.vim/plugged` and vim-plug |
| `-h`, `--help` | Shows the help text |

These environment variables do the same:
`CLOWK_VIMRC_REPO`, `CLOWK_VIMRC_REF`, `CLOWK_VIMRC_DEST`.

## Install from a clone

```bash
git clone https://github.com/thadeu/clowk-vimrc.git
cd clowk-vimrc
./install.sh
```

When the script finds a `vimrc` file in its own directory, it uses that file and
does not download one.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/thadeu/clowk-vimrc/main/install.sh | bash -s -- --uninstall
```

Backup files stay in your home directory.

## Requirements

Necessary: `vim` 8.0 or later, `git`, `curl`.

These tools are not necessary, but some plugins need them:

| Tool | Plugins |
| --- | --- |
| `node` | coc.nvim, copilot.vim, markdown-preview.nvim |
| `go` | vim-go |
| `jq` | JSON format maps (`<Leader>fj`) |
| A Nerd Font in your terminal | vim-devicons, vim-airline symbols |

The other plugins work without them. The installer shows a list of the tools
that are not installed.

## Main key maps

The leader key is `Space`.

| Key | Action |
| --- | --- |
| `<Leader>f` | Find files (fzf) |
| `<Leader>nt` / `<Leader>nf` | NERDTree toggle / find current file |
| `<Leader>t` | Floating terminal |
| `<Leader>ff` | Fix the file with ALE |
| `<Leader>fj` / `<Leader>fcj` | Format JSON, pretty / compact |
| `<Leader>n` | Stop the search highlight |
| `<Leader>y` / `<Leader>p` | Copy / paste with the system clipboard |
| `<Leader>1` … `<Leader>9` | Go to buffer 1 … 9 |
| `Ctrl-s` | Save |
| `Ctrl-h/j/k/l` | Move between splits |
| `Alt-j` / `Alt-k` | Move the line or the selected block |
| `F6` | Remove all spaces at the end of the lines |
| `<Leader>w` | EasyMotion, go to a word |

Git maps use vim-fugitive: `<Leader>ga` (write), `<Leader>gb` (blame),
`<Leader>gca` (amend), `<Leader>gco` (checkout).

## Files

| File | Content |
| --- | --- |
| `vimrc` | The config. It becomes `~/.vimrc` |
| `install.sh` | The installer |

The config comes from this gist:
<https://gist.github.com/thadeu/191f1b2444b519c6f3678b0dfaaf702e>
