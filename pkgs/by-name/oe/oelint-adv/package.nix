{ lib
, nix-update-script
, python3
, fetchPypi
}:

python3.pkgs.buildPythonApplication rec {
  pname = "oelint-adv";
  version = "5.3.0";
  format = "setuptools";

  src = fetchPypi {
    inherit version;
    pname = "oelint_adv";
    hash = "sha256-EAYHxp7pXXYNYRGsQ3XckRxDM1pFHgiZr+gj8fJLqa0=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    anytree
    argcomplete
    colorama
    oelint-parser
    urllib3
  ];

  pythonRelaxDeps = [ "urllib3" ];
  pythonImportsCheck = [ "oelint_adv" ];

  # Fail to run inside the code the build.
  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Advanced bitbake-recipe linter";
    mainProgram = "oelint-adv";
    homepage = "https://github.com/priv-kweihmann/oelint-adv";
    changelog = "https://github.com/priv-kweihmann/oelint-adv/releases/tag/v${version}";
    license = licenses.bsd2;
    maintainers = with maintainers; [ otavio ];
  };
}
