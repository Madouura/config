{ pkgs, ... }:

{
  home-manager = {
    users.mado = {
      programs.git.signing.key = "7AB4C6220EADFC24AA32DC66802073DF725597CA";
      home.packages = [ pkgs.dolphinEmuMaster ];
    };
  };
}
