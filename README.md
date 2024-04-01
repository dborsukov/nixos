[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

Dead simple NixOS config declared with Flakes.  
Home environment is managed by standalone [home-manager][].

Deployment:
1. Get [just][]: `nix-shell -p just`
2. Rebuild system: `just rs`
2. Rebuild home: `just rh`

See `legacy` branch for old [stow] based configs.

[home-manager]: https://github.com/nix-community/home-manager
[just]: https://just.systems/
[stow]: https://www.gnu.org/software/stow/
