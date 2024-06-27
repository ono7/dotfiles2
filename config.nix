# configuration for nix on devcontainers
{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "myPackages";
      paths = [
        bash-completion
        neovim
        starship
        fd
        ripgrep
        fzf
        python3
        ruff
        gnumake
      ];
    };
  };
}
