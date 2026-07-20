{ config, pkgs, ... }:

{
  # Indique à Home Manager les informations de base
  home.username = "viiper";
  home.homeDirectory = "/home/viiper";

  # Doit correspondre à ta version de NixOS (ex: "26.05")
  home.stateVersion = "26.05"; 

  # Active et configure Fastfetch de manière propre pour ton utilisateur
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "nixos";
        padding = { right = 4; };
      };
      display = {
        separator = "  ➔  ";
        bar = {
          charElapsed = "▬";
          charTotal = "─";
          width = 12;
        };
        percent = { type = 2; };
      };
      modules = [
        { type = "title"; key = " 🚀 fastfetch"; keyColor = "orange"; }
        { type = "os"; key = " ├── 🐧 Linux"; keyColor = "orange"; }
        { type = "kernel"; key = " ├── ⚙️  Kernel"; keyColor = "orange"; }
        { type = "shell"; key = " ├── 🐚 Shell"; keyColor = "orange"; }
        { type = "terminal"; key = " ├── 💻 Terminal"; keyColor = "orange"; }
        { type = "packages"; key = " └── 📦 Packages"; keyColor = "orange"; }
        "break"
        { type = "custom"; format = "🛠️  Hardware"; outputColor = "blue"; }
        { type = "cpu"; key = " ├── 🧠 CPU"; keyColor = "blue"; }
        { type = "gpu"; key = " ├── 🎮 GPU"; keyColor = "blue"; }
        { type = "display"; key = " ├── 📺 Display"; keyColor = "blue"; }
        { type = "memory"; key = " ├── 📊 RAM"; keyColor = "blue"; }
        { type = "disk"; key = " └── 💾 Disk"; keyColor = "blue"; }
        "break"
        "colors"
      ];
    };
  };

  # Laisse Home Manager gérer son propre cycle
  programs.home-manager.enable = true;
}
