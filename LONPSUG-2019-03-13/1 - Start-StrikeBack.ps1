function Start-StrikeBack 
{
    [console]::beep(440,500)
    [console]::beep(440,500)
    [console]::beep(440,500)
    [console]::beep(349,350)
    [console]::beep(523,150)
    [console]::beep(440,500)
    [console]::beep(349,350)
    [console]::beep(523,150)
    [console]::beep(440,1000)
    [console]::beep(659,500)
    [console]::beep(659,500)
    [console]::beep(659,500)
    [console]::beep(698,350)
    [console]::beep(523,150)
    [console]::beep(415,500)
    [console]::beep(349,350)
    [console]::beep(523,150)
    [console]::beep(440,1000)
}

1..2 | % {Start-StrikeBack}
