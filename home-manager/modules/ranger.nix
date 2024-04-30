{
  programs.ranger = {
    enable = true;
    plugins = [
      {
        name = "ranger_devicons";
        src = builtins.fetchGit {
          url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
          rev = "a8d626485ca83719e1d8d5e32289cd96a097c861";
        };
      }
    ];
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
      show_hidden = true;
    };
  };
}
