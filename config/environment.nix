{lib, pkgs, ...}: {
  personal.environment = {
    enable = true;
    locale.enable = true;
  };
  programs.bash.promptInit = ''
    PS1="\n\[\033[1;32m\][\[\e]0;\u@$(hostname -f): \w\a\]\u@$(hostname -f):\w]\$\[\033[0m\] "
  '';
  console = {
    earlySetup = true;
    font = lib.mkForce "ter-v32n";
    packages = with pkgs; [ terminus_font ];
  };
}
