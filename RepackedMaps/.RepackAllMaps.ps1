function Invoke-Repack() {
	# Find all .bsp files in current directory and save them in a variable
	$foundFiles = (Get-ChildItem *.bsp).FullName

	# If there's no files, we inform the user and cancel
	if ($foundFiles.Length -eq 0) {
		Write-Host "No maps were found in $(Get-Location)! Are you sure you're running this in the right place?"
		return
	}

	# List found files so the user can verify
	Write-Host "The following maps maps will be repackaged:"
	$foundFiles | ForEach-Object {
		Write-Host "- $_"
	}

	# Ask for user permission to start repackaging
	if(Read-Host "That's $($foundFiles.Length) maps, the process will take some time. Do you want to proceed? Y/n" -eq "n") {
		Write-Host "Repackaging cancelled."
		return
	}

	# Repackage all maps
	$foundFiles | ForEach-Object {
		Invoke-Expression "..\.\bspzip.exe -repack `"$_`"" # Run Valve's repackaging command with the path of the found file
	}

	# Show that export process was completed
	Write-Host -ForegroundColor green "Repacking complete!"
}

Invoke-Repack
Write-Host "Press ENTER to close..."
Read-Host