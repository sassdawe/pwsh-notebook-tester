﻿try { Import-Module $PSScriptRoot\..\..\ImportExcel.psd1 } catch { throw ; return}

# This example is using Excel generated by Highlight-DiffCells.ps1
# The displayed rule should be the same as in the PS script

function Get-ConditionalFormatting {
    param (
        [string] $xlSourcefile
    )
    $excel = Open-ExcelPackage -Path $xlSourcefile

    $excel.Workbook.Worksheets | ForEach-Object {
        $wsNme = $_.Name
        $_.ConditionalFormatting | ForEach-Object {
            "Add-ConditionalFormatting -Worksheet `$excel[""$wsNme""]  -Range '$($_.Address)'  -ConditionValue '=$($_.Formula)' -RuleType $($_.Type) "
        }
    }
}

$xlSourcefile = "$PSScriptRoot\GetConditionalFormatting.xlsx"
Get-ConditionalFormatting -xlSourcefile $xlSourcefile