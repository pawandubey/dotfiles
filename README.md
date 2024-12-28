# config and setup files for the system

> [!NOTE]
> Mac-specific settings live in the `mac-specific` branch

## Setting up with gnu-stow

- Clone repo
- Switch to the `mac-specific` branch if required
- Install gnu stow
- `cd` into repo and run `stow <module>` to symlink files inside that package to the home directory. e.g. `show bash` will create links for all dotfiles inside the `bash` directory.
- `stow bash git emacs` should do the trick
- `stow -R bash git emacs` will "restow" the packages. See [manual](https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow).
- May need to install packages manually, e.g. emacs and source-code-pro font.

## Setting up with nix and home-manager

This is an alternate, home-manager based approach. It will also install packages (like emacs and fonts)

See instructions in the [directory](./nix).

## Additional settings

- Need to install the correct font and also call `M-x all-the-icons-install-fonts` in emacs to get all the fonts e.g. for LSP headerline working.


