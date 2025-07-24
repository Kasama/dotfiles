{ ... }: {
  services.kmonad = {
    enable = true;
    keyboards.acer = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      config = builtins.readFile ./config.kbd;
    };
  };
}
