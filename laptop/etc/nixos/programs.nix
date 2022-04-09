{
  programs = {
    thefuck.enable = true;
    dconf.enable = true;
    corectrl.enable = true;
    steam.enable = true;
    gnupg.agent.enable = true;

    nano = {
      syntaxHighlight = true;

      nanorc = ''
        set nowrap
        set tabstospaces
        set tabsize 2
      '';
    };

    gamemode = {
      enable = true;
      settings.general.renice = 10;
    };
  };
}
