{ config, lib, ... }: {
  options.my.codeDir.enable = lib.mkEnableOption "Create ~/code directory";

  config = lib.mkIf config.my.codeDir.enable {
    home.activation.createCodedir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.home.homeDirectory}/code"
    '';
  };
}
