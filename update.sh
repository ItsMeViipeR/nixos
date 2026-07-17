#!/usr/bin/env bash

# On s'assure qu'on est dans le bon répertoire
cd /etc/nixos || exit 1

echo "🔄 Mise à jour du flake.lock..."
sudo nix flake update

echo "⚙️  Calcul de la nouvelle configuration..."
# On utilise nix run pour jq, avec -r pour un chemin sans guillemets
NEW_SYSTEM=$(nix build .#nixosConfigurations.nixos.config.system.build.toplevel --no-link --json | nix run nixpkgs#jq -- -r '.[0].outputs.out')

# Si le build échoue ou renvoie du vide, on stop le script
if [ -z "$NEW_SYSTEM" ] || [ "$NEW_SYSTEM" = "null" ]; then
    echo "❌ Erreur : Impossible de calculer la nouvelle configuration."
    exit 1
fi

echo "📊 Analyse des changements (Diff) :"
echo "------------------------------------------------"
# On stocke le diff dans une variable pour pouvoir l'analyser ET l'afficher
DIFF_TEXT=$(nix run nixpkgs#nvd -- diff /run/current-system "$NEW_SYSTEM" 2>&1)
echo "$DIFF_TEXT"
echo "------------------------------------------------"

# Si nvd dit qu'il n'y a aucun changement, on s'arrête là !
if echo "$DIFF_TEXT" | grep -q "No version or selection state changes"; then
    echo "✨ Ton système est déjà opérationnel et à jour à 100 %. Rien à faire !"
    exit 0
fi

# Alerte Kernel automatique
if echo "$DIFF_TEXT" | grep -iq "linux"; then
    echo "⚠️  Note : Une mise à jour du Kernel Linux a été détectée. Un reboot sera conseillé."
fi

# La question s'affiche UNIQUEMENT s'il y a de vrais changements
read -p "👉 Appliquer les changements avec nixos-rebuild switch ? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Application de la configuration..."
    sudo nixos-rebuild switch --flake .#nixos
else
    echo "❌ Switch annulé. Le fichier flake.lock a quand même été mis à jour."
fi
