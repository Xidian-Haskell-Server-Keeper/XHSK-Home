cabal install
Start-Process -FilePath ./.cabal-sandbox/bin/XHSK-Home.Bin.exe
Start-Process -FilePath http://localhost:3000/
Write-Host "Press Any Key!"
$null = [Console]::ReadKey('?')
$server=Get-Process XHSK-Home.Bin
Stop-Process  $server
exit
