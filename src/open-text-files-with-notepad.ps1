# changes default file association for all script types
# those files can be executed by invoking the program that parses and executes them directly
#
# * foo.bat -> cmd /c foo.bat
# * foo.cmd -> cmd /c foo.cmd
# * foo.ps1 -> powershell -File foo.ps1
# * foo.reg -> regedit foo.reg
# * ...

$filetypes = @( # files that also happens to be text
  , "batfile", "cmdfile"
  # , "Microsoft.PowerShellScript.1" # already opens by default with an editor
  , "regfile"
  , "JSFile", "htafile", "WSFFile", "VBSFile", "VBEFile"
);

$editor = "`"C:\Windows\System32\notepad.exe`""
foreach ($filetype in $filetypes) {
  $key_run = (Join-Path (Join-Path Registry::HKEY_CLASSES_ROOT $filetype) shell\Run);
  if (Test-Path $key_run) {
    # if run entry already exist, we probably already changed the default action
    continue;
  }
  $key_open = (Join-Path (Join-Path Registry::HKEY_CLASSES_ROOT $filetype) shell\open);
  Rename-Item -Path "$key_open" -NewName "Run";
  $key_open_command = (Join-Path $key_open command);
  New-Item -Force $key_open_command;
  Set-ItemProperty -Path "$key_open_command" -name '(Default)' -Value "$editor `"%1`"";

  $key_edit_command = (Join-Path (Join-Path Registry::HKEY_CLASSES_ROOT $filetype) shell\edit\command);
  if (Test-Path $key_edit_command) {
    Copy-Item -Path "$key_edit_command" -Destination "$key_open"
  }
}
