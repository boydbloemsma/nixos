{ config, lib, ... }: {
  options.code-dir.enable = lib.mkEnableOption "Create ~/code directory";

  config = lib.mkIf config.code-dir.enable {
    home.activation.createCodedir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.home.homeDirectory}/code"
    '';
  };
}
