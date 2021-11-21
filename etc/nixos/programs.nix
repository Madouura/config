{
  programs = {
    thefuck.enable = true;
    dconf.enable = true;
    corectrl.enable = true;
    steam.enable = true;

    nano = {
      syntaxHighlight = true;

      nanorc = ''
        set nowrap
        set tabstospaces
        set tabsize 2
      '';
    };
  };
}
