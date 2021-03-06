#Store the Share Data from the CSV file into SMBShares variable.
$SmbCsv = "C:\Users\gymboss\Desktop\build-scripts\smb-shares.csv"
$SMBShares = Import-csv $SmbCsv

#Loop through each row containing user details in the CSV file 
foreach ($Folder in $SMBShares)
{
	#Read user data from each field in each row and assign the data to a variable as below
		
	$Name 			= $Folder.Name
	$Path 			= $Folder.Path
	$FullAccess 	= $Folder.FullAccess
	$ChangeAccess 	= $Folder.ChangeAccess
	$ReadAccess 	= $Folder.ReadAccess

	$arg = "-Name $Name -Path $Path -FullAccess $FullAccess"
		
	#Account will be created in the OU provided by the $OU variable read from the CSV file
    If ($ChangeAccess) {
        $arg += " -ChangeAccess $ChangeAccess"
    }

    If ($ReadAccess) {
        $arg += " -ReadAccess $ReadAccess"
    }

    If (!(Test-Path -Path $Path)){
        New-Item -ItemType Directory -Force -Path $Path
    }

	"New-SmbShare $arg" | iex
}
