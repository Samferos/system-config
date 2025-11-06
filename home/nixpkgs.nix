{ lib, ... }:
{
  config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "blender"
      "aseprite"
      "cuda_cudart"
      "cuda_cccl"
      "cuda_nvcc"
      "android-studio-stable"
      "android-studio-for-platform"
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
