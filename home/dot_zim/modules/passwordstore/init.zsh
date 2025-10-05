# modules-local/passwordstore/init.zsh

# === Passwordstore async pull ===
PASS_PULL_LOG="/tmp/passstore-pull.log"
PASS_PULL_LOCK="/tmp/passstore-pull.lock"

# Fonction pour lancer le pull async
_passwordstore_async_pull() {
  # Si le répertoire existe et qu'aucun pull n'est en cours
  [[ -d "$PASSWORD_STORE_DIR" ]] || return
  if [[ ! -f "$PASS_PULL_LOCK" ]]; then
    # Création d'un lock pour éviter les pulls simultanés
    touch "$PASS_PULL_LOCK"
    (
      cd "$PASSWORD_STORE_DIR" || exit
      # Vérifie la connectivité avant pull
      if git ls-remote &>/dev/null; then
        git pull --ff-only &>> "$PASS_PULL_LOG"
      fi
      rm -f "$PASS_PULL_LOCK"
    ) & disown
  fi
}

# Lancer au démarrage
_passwordstore_async_pull

