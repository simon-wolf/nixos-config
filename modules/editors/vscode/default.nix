#
# Visual Studio Code 
#

{ pkgs, ... }:

let
  vscode_extensions = (with pkgs.vscode-extensions; [
    jakebecker.elixir-ls
    ms-python.python
    ms-python.vscode-pylance
    stkb.rewrap
    tomoki1207.pdf
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-elixir-credo";
      publisher = "pantajoe";
      version = "0.7.2";
      sha256 = "036lknj1vs42g1zxsbzh692czl6rkzpffvqn15n5yz4ps33gvhy5";
    }
    {
      name = "phoenix";
      publisher = "phoenixframework";
      version = "0.1.1";
      sha256 = "0pd1s6f1lm96y1q9d9aj7sa8n0vc0cjrggiyyh1azwa5h59v1w01";
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
