let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  home-manager = {
    users.mado = {
      programs.git.signing.key = "C5FF0C6F823C620404B9E9872D2F0C76BF6A80D4";
      home.packages = with unstable; [ dolphinEmuMaster ];
    };
  };
}
