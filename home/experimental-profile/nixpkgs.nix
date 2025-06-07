{ lib, ... }:
{
  config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "blender"
      "cuda_cudart"
      "cuda_cccl"
      "cuda_nvcc"
      "android-studio-stable"
    ];

  overlays = [
    (final: prev: {
      discord = prev.discord.override { withVencord = true; };
      vencord = prev.vencord.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ../ressources/patches/Revert-Delete-Moyai-plugin.patch
        ];
      });
    })
  ];
}
