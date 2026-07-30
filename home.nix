{ config, pkgs, inputs, ... }:

{
  home.username = "viiper";
  home.homeDirectory = "/home/viiper";

  home.stateVersion = "26.05"; 

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "nixos";
        padding = { right = 4; };
      };
      display = {
        separator = " ➔ ";
        bar = {
          "char.elapsed" = "▬";
          "char.total" = "─";
          width = 12;
        };
        percent = { type = 2; };
      };
      modules = [
        # SYSTEM (Les clés avec 🐧/⚙️ prennent peu d'octets)
        { type = "title"; key = " 🚀 fastfetch               "; keyColor = "yellow"; }
        { type = "os"; key = " ├── 🐧 Linux               "; keyColor = "yellow"; format = "{3} {12}"; }
        { type = "kernel"; key = " ├── ⚙️  Kernel              "; keyColor = "yellow"; }
        { type = "shell"; key = " ├── 🐚 Shell               "; keyColor = "yellow"; }
        { type = "terminal"; key = " ├── 💻 Terminal            "; keyColor = "yellow"; }
        { type = "packages"; key = " ├── 📦 Packages            "; keyColor = "yellow"; }
	{ type = "wm"; key = " ├── 🪟 WM                  "; keyColor = "yellow"; }
	{ type = "command"; key = " └── 🌤️  Météo               "; keyColor = "yellow"; text = "curl -s 'wttr.in/Aulnay-sous-Bois?format=%c+%t'"; }
        "break"

        # HARDWARE (Les emojis 🧠/🎮/📺 font 4 octets UTF-8, on retire 1 ou 2 espaces pour compenser)
        { type = "custom"; format = " 🛠️  Hardware"; outputColor = "blue"; }
        { type = "cpu"; key = " ├── 🧠 CPU                 "; keyColor = "blue"; format = "{1}"; }
        { type = "gpu"; key = " ├── 🎮 GPU                 "; keyColor = "blue"; format = "{2}"; }
        { type = "display"; key = " ├── 📺 Display             "; keyColor = "blue"; format = "{width}x{height} in {inch}\", {refresh-rate} Hz"; }
        { type = "memory"; key = " ├── 📊 RAM                 "; keyColor = "blue"; }
        { type = "disk"; key = " ├── 💾 Disk (/)            "; keyColor = "blue"; folders = "/"; }
        { type = "disk"; key = " └── 💾 Disk (/mnt/Jeux)    "; keyColor = "blue"; folders = "/mnt/Jeux"; }
        "break"

        # NETWORK (L'icône NerdFont 󰩟 prend aussi plus d'octets)
        { type = "custom"; format = " 🌐 Network"; outputColor = "cyan"; }
        { type = "localip"; key = " ├── 󰩟  Local IP            "; keyColor = "cyan"; showIpv4 = true; showIpv6 = false; }
        { type = "dns"; key = " └── 󰒋  DNS                 "; keyColor = "cyan"; }
        "break"

        # DEVELOPMENT
        { type = "custom"; format = " 🦫 Development"; outputColor = "magenta"; }
        { type = "uptime"; key = " └── 󰔚  Uptime              "; keyColor = "magenta"; }
        "break"
        "colors"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autocd = true;

    shellAliases = {
      c = "clear";
      eza = "eza --ignore-glob=\"target|.git|node_modules|dist|build\" --icons --group-directories-first --git --git-ignore --color=always --header --time-style=long-iso";
    };

    initContent = ''
      export DIRENV_LOG_FORMAT=""
      
      countdown() {
        local cible="$1"
        local jours=$(( ( $(date -d "$cible" +%s) - $(date +%s) ) / 86400 ))
        echo "Il reste ''${jours} jours avant le ''${cible}."
      }

      weather() {
        curl -s "wttr.in/''${1}?format=%c+%t"
        echo ""
      }

      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      initNixGo() {
        cat <<'EOF' > flake.nix
{
  description = "Environnement de dev Go";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.''${system};
    in
    {
      devShells.''${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          git
          go
          gopls
          air
        ];

        shellHook = \'\'
          export GOBIN=$PWD/.bin
          export PATH=$GOBIN:$PATH

          mkdir -p $GOBIN
        \'\';
      };
    };
}
EOF
        cat <<'EOF' > .envrc
use flake
EOF
        echo "flake.nix généré avec succès !"
        direnv allow
      }
    '';
  };

  home.packages = [
    inputs.concord.packages.${pkgs.system}.default
  ];

  programs.home-manager.enable = true;
}
