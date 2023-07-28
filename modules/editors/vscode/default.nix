#
# Visual Studio Code 
#

{ pkgs, ... }:

let
  vscode_extensions = (with pkgs.vscode-extensions; [
    bradlc.vscode-tailwindcss
    jakebecker.elixir-ls
    ms-python.python
    ms-python.vscode-pylance
    phoenixframework.phoenix
    stkb.rewrap
    tomoki1207.pdf
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-elixir-credo";
      publisher = "pantajoe";
      version = "0.8.3";
#      sha256 = "0000000000000000000000000000000000000000000000000000";
      sha256 = "sha256-l4IlCd/S4NSwpY+/fhHOshj621Op8n5N1G0GvCVzzsE=";
    }
    {
      name = "uuid-generator";
      publisher = "netcorext";
      version = "0.0.5";
      sha256 = "01mhzmc8ck2rk8nr9pqgkp2qk508ssx8asis27ll9vjmw38liiys";
    }
  ];

  vscode_with_extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = vscode_extensions;
  };
in {
  programs = {
    vscode = {
      enable = true;
      package = vscode_with_extensions;
    };
  };
}
