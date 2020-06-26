# changes default file association for executables


$editor = "`"C:\Windows\System32\notepad.exe`""
$filetype = "exefile"

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
