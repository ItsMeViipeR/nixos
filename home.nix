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
        # On désactive le séparateur automatique car on va l'intégrer proprement
        separator = ""; 
        bar = {
          "char.elapsed" = "▬";
          "char.total" = "─";
          width = 12;
        };
        percent = { type = 2; };
      };
      modules = [
        # SECTION TITLE / OS
        { type = "title"; format = " 🚀 fastfetch   ➔ {user-name}@{host-name}"; keyColor = "yellow"; }
        { type = "os"; format = " ├── 🐧 Linux   ➔ {sys-name} {release} {architecture}"; keyColor = "yellow"; }
        { type = "kernel"; format = " ├── ⚙️  Kernel  ➔ {release}"; keyColor = "yellow"; }
        { type = "shell"; format = " ├── 🐚 Shell   ➔ {name} {version}"; keyColor = "yellow"; }
        { type = "terminal"; format = " ├── 💻 Terminal➔ {pretty-name}"; keyColor = "yellow"; }
        { type = "packages"; format = " └── 📦 Packages➔ {all}"; keyColor = "yellow"; }
        "break"
        
        # SECTION HARDWARE
        { type = "custom"; format = " 🛠️  Hardware"; keyColor = "blue"; }
        { type = "cpu"; format = " ├── 🧠 CPU      ➔ {name}"; keyColor = "blue"; }
        { type = "gpu"; format = " ├── 🎮 GPU      ➔ {name}"; keyColor = "blue"; }
        { type = "display"; format = " ├── 📺 Display  ➔ {width}x{height} in {physical-width}\", {refresh-rate} Hz"; keyColor = "blue"; }
        { type = "memory"; format = " ├── 📊 RAM      ➔ {}"; keyColor = "blue"; }
        { type = "disk"; format = " ├── 💾 Disk     ➔ {}"; keyColor = "blue"; folders = "/"; }
        { type = "disk"; format = " └── 💾 Disk     ➔ {}"; keyColor = "blue"; folders = "/home"; } # Ajuste ton second point de montage si besoin
        "break"
        
        # SECTION NETWORK
        { type = "custom"; format = " 🌐 Network"; keyColor = "cyan"; }
        { type = "localip"; format = " ├── 󰩟  Local IP ➔ {ipv4}"; keyColor = "cyan"; }
        { type = "dns"; format = " └── 󰒋  DNS      ➔ {1}"; keyColor = "cyan"; }
        "break"
        
        # SECTION DEVELOPMENT
        { type = "custom"; format = " 🦫 Development"; keyColor = "magenta"; }
        { type = "uptime"; format = " └── 󰔚  Uptime   ➔ {pretty}"; keyColor = "magenta"; }
        "break"
        "colors"
      ];
    };
  };

  programs.home-manager.enable = true;
}
