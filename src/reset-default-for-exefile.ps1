# changes default file association for executables


$editor = "`"C:\Windows\System32\notepad.exe`""
$filetype = "exefile"

$key_run = (Join-Path (Join-Path Registry::HKEY_CLASSES_ROOT $filetype) shell\Run);
$key_open = (Join-Path (Join-Path Registry::HKEY_CLASSES_ROOT $filetype) shell\open);
if (Test-Path $key_run) {
  Remove-Item -Path $key_open
  Rename-Item -Path "$key_run" -NewName "open";
} else {
  $key_open_command = (Join-Path $key_open command);
  New-Item -Force $key_open_command;
  Set-ItemProperty -Path "$key_open_command" -name '(Default)' -Value "`"%1`" %*";
  Set-ItemProperty -Path "$key_open_command" -name 'IsolatedCommand' -Value "`"%1`" %*";
}
