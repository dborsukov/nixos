# vim: set ft=just ts=2 sts=2 sw=2 :

alias rs := rebuild-system
alias rh := rebuild-home

[private]
default:
  @just --list

# format *.nix files
fmt:
	nix fmt

# rebuild host
rebuild-system: fmt
	sudo nixos-rebuild switch --flake .#oberon

# rebuild home
rebuild-home: fmt
	home-manager switch --flake .#db

# update flake
up:
	nix flake update

# update specific input
upp input:
	nix flake lock --update-input {{input}}

# list all generations of the system profile
history:
  nix profile history --profile /nix/var/nix/profiles/system

# garbage collect unused nix store entries
gc:
  sudo nix store gc --debug
