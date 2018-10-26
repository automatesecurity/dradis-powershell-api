<#
.SYNOPSIS
    Dradis PowerShell API Client is a lightweight wrapper written in PowerShell to interact with the Dradis API

.DESCRIPTION
    This script currently provides 5 different features:
    1. Listing all projects contained within the Dradis database
    2. The ability to view any specific project, given it's project number
    3. The ability to create a new project via the API
    4. The ability to edit an existing project based on the inputs provided (currently JSON blob)
    5. The ability to delete any project within the database

.NOTES
    This is an experimental API client; don't blindly trust it.
    
    Filename: dradis-powershell-api.ps1
    Author: Daniel Wood
    Last Updated: 10-23-2018    

.LINK
    https://github.com/automatesecurity
#>


# Setup Variables
# $token = 'XXXXXXXXXX' # Use your own API token here
function Invoke-Menu
{
    param (
        [string]$Title = "Dradis API Client"
    )
    Clear-Host
    Write-Host "======== $Title ========"
    Write-Host "1: List All Projects"
    Write-Host "2: View A Specific Project"
    Write-Host "3: Create A New Project"
    Write-Host "4: Edit An Existing Project"
    Write-Host "5: Delete An Existing Project"
    Write-Host "Q: Quit"
    Write-Host ""
}

Invoke-Menu
$selection = Read-Host "Please make a selection"
switch ($selection) {
    '1' {

    }
    '2' {

    }
    '3' {

    }
    '4' {

    }
    '5' {

    }
    'Q' {
        Write-Host "Quitting" -ForegroundColor Red
        Return
    }
    default {
        Write-Host "I don't understand, please try again" -ForegroundColor Yellow
        sleep -Milliseconds 750
    }
}