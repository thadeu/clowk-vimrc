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
5. Runs `:PlugClean!` to remove plugins that the config does not use.

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
| `--no-clean` | Keeps plugins that the config does not use (no `:PlugClean`) |
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

`vim` 9.0 or later is necessary for the fuzzbox fuzzy finder. With an older vim,
the config does not install fuzzbox and `Space Space` uses fzf.

These tools are not necessary. When one of them is absent, the config does not
install the plugins that need it, so vim starts with no error messages:

| Tool | Plugins that need it |
| --- | --- |
| `node` | coc.nvim, copilot.vim, markdown-preview.nvim |
| `go` | vim-go |
| `ripgrep` (`rg`) | Not necessary. It makes fuzzbox faster and makes it obey `.gitignore` |
| `jq` | Not a plugin. The JSON format maps (`<Leader>fj`) need it |
| A Nerd Font in your terminal | vim-devicons, vim-airline symbols |

The installer shows which tools are absent at the end.

### Minimal containers and servers

The plugin list has conditions, so the same `~/.vimrc` works on a full
workstation and in a small Docker image:

```vim
if executable('node')      " coc.nvim, copilot.vim, markdown-preview.nvim
if executable('go')        " vim-go
if has('nvim')             " plenary.nvim, image.nvim
if v:version >= 900        " fuzzbox.vim
```

Install `node` later and run the installer again: `:PlugInstall` adds coc.nvim
and copilot to the same machine.

## Main key maps

The leader key is `Space`.

| Key | Action |
| --- | --- |
| `Space Space` | Find files in the project root — like `Cmd+P` in VSCode |
| `<Leader>f` | Find files with fzf, from the start directory |
| `<Leader>fb` / `<Leader>fg` / `<Leader>fr` | fuzzbox: buffers / grep / recent files |
| `<Leader>e` | NERDTree, open or close |
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
| `ga` | EasyAlign (`gaip=` aligns a paragraph on `=`) |

Git maps use vim-fugitive: `<Leader>ga` (write), `<Leader>gb` (blame),
`<Leader>gca` (amend), `<Leader>gco` (checkout).

## Fuzzy finder

`Space Space` opens [fuzzbox](https://github.com/vim-fuzzbox/fuzzbox.vim) with
`:FuzzyFilesRoot`, which lists the files of the project (VCS) root, like `Cmd+P`
in VSCode. Fuzzbox is written in vim9script and uses the native popup windows of
Vim, so it needs no external program.

Inside the finder: `Ctrl-n` / `Ctrl-p` move, `Enter` opens, `Ctrl-v` opens a
vertical split, `Ctrl-t` opens a tab, `Esc` closes.

Fuzzbox adds more maps: `<Leader>fb` (buffers), `<Leader>fg` (grep),
`<Leader>fh` (help), `<Leader>fi` (in buffer), `<Leader>fr` (recent files),
`<Leader>fp` (previous search). It does not replace the maps of this config, so
`<Leader>ff` stays with ALEFix and `<Leader>f` stays with fzf.

To use the prompt at the bottom of the window, set `g:fuzzbox_dropdown = 0`.

## Files

| File | Content |
| --- | --- |
| `vimrc` | The config. It becomes `~/.vimrc` |
| `install.sh` | The installer |

The config comes from this gist:
<https://gist.github.com/thadeu/191f1b2444b519c6f3678b0dfaaf702e>
