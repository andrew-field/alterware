{
  lib,
  buildPythonPackage,
  click,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "click-option-group";
  version = "0.5.6";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "click-contrib";
    repo = "click-option-group";
    tag = "v${version}";
    hash = "sha256-uR5rIZPPT6pRk/jJEy2rZciOXrHWVWN6BfGroQ3znas=";
  };

  build-system = [ setuptools ];

  dependencies = [ click ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "click_option_group" ];

  disabledTests = [
    # https://github.com/click-contrib/click-option-group/issues/65
    "test_missing_group_decl_first_api"
  ];

  meta = with lib; {
    description = "Option groups missing in Click";
    longDescription = ''
      Option groups are convenient mechanism for logical structuring
      CLI, also it allows you to set the specific behavior and set the
      relationship among grouped options (mutually exclusive options
      for example). Moreover, argparse stdlib package contains this
      functionality out of the box.
    '';
    homepage = "https://github.com/click-contrib/click-option-group";
    license = licenses.bsd3;
    maintainers = with maintainers; [ hexa ];
  };
}
