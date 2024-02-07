# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  users.users.josh = {
    isNormalUser  = true;
    home  = "/home/josh";
    description  = "Josh Thomas";
    extraGroups  = [ "wheel" "networkmanager" "josh" ];
    uid = 1000;
  };
  users.groups.josh.gid = 1000;

  wsl.enable = true;
  wsl.defaultUser = "josh";
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  time.timeZone = "America/Chicago";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    htop
    neovim
    vim
  ];
}
