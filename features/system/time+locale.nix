{ ... }: {
  time = {
    timeZone = "Europe/Kiev";
    hardwareClockInLocalTime = true; # for windows dual-boot
  };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "uk_UA.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };
}
