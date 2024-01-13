# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mk = {
    isNormalUser = true;
    description = "mk";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vim
      wget
      git
    ];
  };
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    }
  };
}
