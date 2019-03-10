configuration TestFile {

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    
    Node 'localhost' 
    {
        File TestFile 
        {
            Ensure = "Present" 
            Type = "File"
            Force = $True
            Recurse = $True
            DestinationPath = 'C:\temp\TestDsc.txt'
            Contents = "Hi LONPSUG!"
        }
    }
}

TestFile -OutputPath C:\temp
Start-DscConfiguration -Path C:\temp -Wait -Verbose
