# otherwise programs like VirtualBox Guest Additions do not start correctly if file association of exefile is changed


$key_autoruns = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run';
Get-Item -Path $key_autoruns  |   Select-Object -ExpandProperty Property |ForEach-Object {
  $value = $_;
  $command = (Get-ItemProperty -Path $key_autoruns -Name $value).$value
  Remove-ItemProperty -Path $key_autoruns -Name $value
  $action = New-ScheduledTaskAction -Execute $command;
  $trigger = New-ScheduledTaskTrigger -AtLogon;
  $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries;
  Register-ScheduledTask $value -Action $action -Trigger $trigger -Settings $settings;
}

# FIXME: redo the same for (at least) current user
