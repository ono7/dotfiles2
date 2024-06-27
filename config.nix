# configuration for nix on devcontainers
{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "myPackages";
      paths = [
        bash-completion
        neovim
        go
        nodejs_22
        starship
        fd
        ripgrep
        fzf
	python3
	ruff
	# for building docker images
	docker-client
	gnumake
	git
      ];
    };
  };
}
