{
  rpi-linux-6_12-src,
  ...
}:
final: prev:
{
  rpi5-kernel = prev.buildLinux {
    modDirVersion = "6.12.34";
    version = "6.12.34";
    pname = "linux-rpi5";
    src = rpi-linux-6_12-src;
    defconig = "bcm2712_defconfig";
    features.efiBootStub = false;
  };
}
