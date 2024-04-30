{
  services.mako = {
    enable = true;
    icons = true;
    font = "Noto Sans 11";
    format = "<b>%s</b>\\n%b";
    defaultTimeout = 1000;
    borderSize = 1;
    borderRadius = 1;
    borderColor = "#3DAEE9FF";
    backgroundColor = "#31363BFF";
    height = 100;
    width = 300;
    textColor = "#FFFFFFFF";
    progressColor = "#BDC3C7FF";
    padding = "5";
    maxVisible = 5;
    maxIconSize = 64;
    markup = true;
    margin = "10";
    layer = "overlay";
    anchor = "top-right";
    actions = true;
    ignoreTimeout = false;
    sort = "-time";
    extraConfig = ''
      max-history=5
      on-button-left=invoke-default-action
      on-button-right=dismiss
      on-touch=dismiss
      outer-margin=0
      icon-location=left
      history=1
      text-alignment=left
    '';
  };
}
