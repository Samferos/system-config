{ lib, ... }:
{
  config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "dropbox"
      "firefox-bin"
      "firefox-bin-unwrapped"
      "discord"
      "blender"
      "aseprite"
      "cuda_cudart"
      "cuda_cccl"
      "cuda_nvcc"
      "android-studio"
      "android-studio-stable"
      "android-studio-for-platform"
      "sublimetext4"
      "libcublas"
    ];

  overlays = [
    (final: prev: {
      discord = prev.discord.override { withVencord = true; };
      vencord = prev.vencord.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./ressources/patches/Revert-Delete-Moyai-plugin.patch
        ];
      });
    })
  ];
}
