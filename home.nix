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

  home.packages = [
    inputs.concord.packages.${pkgs.system}.default
  ];

  programs.home-manager.enable = true;
}
