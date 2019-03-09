function New-TextFile
{
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $FilePath,

        [Parameter(Mandatory = $true)]
        [String]
        $FileName,

        [Parameter(Mandatory = $true)]
        [String]
        $Contents
    )

    if (-Not (Get-ChildItem -Path $FilePath -ErrorAction SilentlyContinue))
    {
        New-Item -ItemType File -Path $FilePath -Name $FileName
    }
    
    if ((Get-Content -Path "$FilePath\$FileName") -ne $Contents)
    {
        Set-Content -Path "$FilePath\$FileName" -Value $Contents
    }
}

$params = @{
    FilePath = "C:\temp\60"
    FileName = "Test.txt"
    Contents = "Hello LONPSUG!"
}

New-TextFile @params