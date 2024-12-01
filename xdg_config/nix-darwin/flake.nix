{
  description = "Darwin nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # https://search.nixos.org/packages
      environment.systemPackages =
        [ 
          pkgs.neovim
          pkgs.direnv
          pkgs.fzf
          pkgs.bat
          pkgs.cmake
          pkgs.gh
          pkgs.aerospace
          pkgs.nushell
          pkgs.wezterm
          pkgs.wireshark
        ];

      homebrew.enable = true;
      homebrew.brews = [
        "jpeg-xl"
      	"aom"
      	"openssl@3"
      	"autoconf"
      	"awscli"
      	"azure-cli"
      	"python@3.12"
      	"glib"
      	"clifm"
      	"cloudflared"
      	"cmake"
      	"php"
      	"composer"
      	"wxwidgets"
      	"elixir-ls"
      	"fd"
      	"flyctl"
      	"fnm"
      	"openjdk"
      	"fop"
      	"gawk"
      	"gcc"
      	"git-delta"
      	"gnu-sed"
      	"gnu-tar"
      	"gnutls"
      	"gnupg"
      	"gradle"
      	"helix"
      	"jq"
      	"openblas"
      	"julia"
      	"kdoctor"
      	"kotlin"
      	"libxslt"
      	"llvm"
      	"lua"
      	"luarocks"
      	"mise"
      	"nasm"
      	"oha"
      	"opam"
      	"parallel"
      	"pinentry-mac"
      	"postgresql@15"
      	"railway"
      	"ripgrep"
      	"rlwrap"
      	"rustup"
      	"shellcheck"
      	"socat"
      	"tlrc"
      	"tmux"
      	"tree"
      	"websocat"
      	"wget"
      	"zellij"
      	"pkgxdev/made/pkgx"
      	"pulumi/tap/pulumi"
      	"sst/tap/sst"
      	"stripe/stripe-cli/stripe"
      	"tursodatabase/tap/turso"
      ];
      homebrew.casks = [
        "1password-cli"
      ];

      services.nix-daemon.enable = true;
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # https://mynixos.com/options/system
      # system settings
      system.defaults = {
        dock = { 
          autohide = true;
        };

        finder = {
          FXPreferredViewStyle = "clmv";
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          FXEnableExtensionChangeWarning = false;
        };

        trackpad = {
          Clicking = true;
          TrackpadRightClick = true;
        };

        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.AppleKeyboardUIMode = 3;
        NSGlobalDomain."com.apple.keyboard.fnState" = true;
        NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
        screencapture.location = "~/Pictures/screenshots";
        screencapture.show-thumbnail = false;

        CustomUserPreferences = {
          "com.apple.finder" = {
            # When performing a search, search the current folder by default
            FXDefaultSearchScope = "SCcf";
          };

          "com.apple.spaces" = {
            # Aerospace
            "spans-displays" = 0;
          };
          "com.apple.dock" = {
            # Aerospace
            "expose-group-apps" = 0;
          };
        };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."main" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    darwinPackages = self.darwinConfigurations."main".pkgs;
  };
}
