{ config, pkgs, ... }:

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
        { type = "title"; key = " 🚀 fastfetch       "; keyColor = "yellow"; }
        { type = "os"; key = " ├── 🐧 Linux       "; keyColor = "yellow"; format = "{3} {12}"; }
        { type = "kernel"; key = " ├── ⚙️  Kernel      "; keyColor = "yellow"; }
        { type = "shell"; key = " ├── 🐚 Shell       "; keyColor = "yellow"; }
        { type = "terminal"; key = " ├── 💻 Terminal    "; keyColor = "yellow"; }
        { type = "packages"; key = " └── 📦 Packages    "; keyColor = "yellow"; }
        "break"

        # HARDWARE (Les emojis 🧠/🎮/📺 font 4 octets UTF-8, on retire 1 ou 2 espaces pour compenser)
        { type = "custom"; format = " 🛠️  Hardware"; outputColor = "blue"; }
        { type = "cpu"; key = " ├── 🧠 CPU         "; keyColor = "blue"; format = "{1}"; }
        { type = "gpu"; key = " ├── 🎮 GPU         "; keyColor = "blue"; format = "{2}"; }
        { type = "display"; key = " ├── 📺 Display     "; keyColor = "blue"; format = "{1}x{2} in {3}\", {11} Hz"; }
        { type = "memory"; key = " ├── 📊 RAM         "; keyColor = "blue"; }
        { type = "disk"; key = " ├── 💾 Disk        "; keyColor = "blue"; folders = "/"; }
        { type = "disk"; key = " └── 💾 Disk        "; keyColor = "blue"; folders = "/home"; }
        "break"

        # NETWORK (L'icône NerdFont 󰩟 prend aussi plus d'octets)
        { type = "custom"; format = " 🌐 Network"; outputColor = "cyan"; }
        { type = "localip"; key = " ├── 󰩟  Local IP    "; keyColor = "cyan"; showIpv4 = true; showIpv6 = false; }
        { type = "dns"; key = " └── 󰒋  DNS         "; keyColor = "cyan"; }
        "break"

        # DEVELOPMENT
        { type = "custom"; format = " 🦫 Development"; outputColor = "magenta"; }
        { type = "uptime"; key = " └── 󰔚  Uptime      "; keyColor = "magenta"; }
        "break"
        "colors"
      ];
    };
  };

  programs.home-manager.enable = true;
}
