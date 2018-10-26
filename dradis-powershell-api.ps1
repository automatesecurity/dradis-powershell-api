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
$token = 'XXXXXXXXXX' # Use your own API token here
$headers = @{ "Authorization" = "Token $token"}
$url = https://dradis.url
$api = '/pro/api/' # TODO: endpoint array for team, projects, issues, and clients

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
        # List all projects within the database
        $response = Invoke-RestMethod -Method Get -Uri $url/$api -Headers $headers -ContentType "application/json"
        $response | Select-Object ID,Name,created_at,authors
    }
    '2' {
        # List all findings within a specific project
        $project = Read-Host "Please enter a project ID"
        $response = Invoke-RestMethod -Method Get -Uri $url -Headers @{ "Authorization" = "Token $token"; "Dradis-Project-Id" = $project} -ContentType "application/json"
        $response | Select-Object -ExpandProperty fields | Format-Table -AutoSize # | Export-Csv -Path "\\local\path\output.csv"
    }
    '3' {
        # Create a new project
        Write-Host ""
        $name = Read-Host "What is the name of the new project?"
        Write-Host "Now creating $name"
        $project = @{
            name = $name
            client_id='1' # customize this for the client the project is associated with
        }
        $json = $project | ConvertTo-Json
        $response = Invoke-RestMethod -Method Post -Uri $url -Headers $headers -Body $json -ContentType "application/json"
    }
    '4' {
        # Edit an existing project
        Write-Host ""
        $id = Read-Host "What is the id of the project you want to edit?" # TODO: Optionality for id or name
        $name = Read-Host "Please enter the new name for the project..."
        $project = @{
            name = $name
        }
        $json = $project | ConvertTo-Json
        $response = Invoke-RestMethod -Method Put -Uri $url $id -Headers $headers -Body $json -ContentType "application/json"
    }
    '5' {
        # Delete a project
        Write-Host ""
        Write-Warning "Be VERY CAREFUL DOING THIS - CHANGES ARE PERMANENT"
        $id = Read-Host "What Project ID do you want to delete from the database?"
        Write-Host "Now deleting Project $id"
        $project = @{
            id = $id
        }
        $json = $project | ConvertTo-Json
        $request = Invoke-RestMethod -Method Delete -Uri $url $id -Headers $headers -Body $json -ContentType "application/json"
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