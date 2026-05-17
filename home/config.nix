{ pkgs }:
let
  inherit (pkgs) writeTextFile;
  writeSystemdUnitUserFile = input: writeTextFile {
    inherit (input) name text;
    destination = "/share/systemd/user/${input.name}";
  };
in
{
  systemd.unit.user = {
    dropbox = writeSystemdUnitUserFile { 
      name = "dropbox.service";		  
      text = ''
      [Unit]
      Description="Dropbox service"

      [Install]
      WantedBy="default.target"

      [Service]
      ExecStart="${pkgs.dropbox}/bin/dropbox"
      Restart="on-failure"
      '';
    };
  };
}
