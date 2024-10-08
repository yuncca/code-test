param (
    [string]$folder_name
)

if (-not $folder_name) {
    Write-Host "Usage: .\create_pkg.ps1 -folder_name <folder_name>"
    exit 1
}

$folder_path = Join-Path "src" $folder_name

$source_cmake_dir = "src\template"  
$source_cmake_file = Join-Path $source_cmake_dir "CMakeLists.txt"
$source_cc_file = Join-Path $source_cmake_dir "template.cc"  
$source_h_file = Join-Path $source_cmake_dir "template.h"

$launchFilePath = ".vscode\launch.json"

if (-not (Test-Path $source_cmake_file)) {
    Write-Host "Source CMakeLists.txt file does not exist: $source_cmake_file"
    exit 1
}

if (-not (Test-Path $folder_path)) {
    New-Item -ItemType Directory -Path $folder_path

    $file_name = [System.IO.Path]::GetFileName($folder_name)

    $header_file = Join-Path $folder_path "$file_name.h"
    if (Test-Path $source_h_file) {
        Copy-Item -Path $source_h_file -Destination $header_file
        Write-Host "Copied $source_h_file to $header_file"
    } else {
        Write-Host "Source .h file does not exist: $source_h_file"
        exit 1
    }

    $source_file = Join-Path $folder_path "$file_name.cc"
    if (Test-Path $source_cc_file) {
        Copy-Item -Path $source_cc_file -Destination $source_file
        Write-Host "Copied $source_cc_file to $source_file"

        $include_line = "#include `"$file_name.h`""
        if (-not (Select-String -Path $source_file -Pattern $include_line)) {
            (Get-Content $source_file) | ForEach-Object { $_ -replace '^#include.*', "$include_line`r`n$_" } | Set-Content $source_file
            Write-Host "Inserted '#include \"$file_name.h\"' in $source_file"
        } else {
            Write-Host "'#include \"$file_name.h\"' already exists in $source_file"
        }
    } else {
        Write-Host "Source .cc file does not exist: $source_cc_file"
        exit 1
    }
}else {
    Write-Host "Folder already exists: $folder_path"
}

Copy-Item -Path $source_cmake_file -Destination "$folder_path\CMakeLists.txt"
Write-Host "CMakeLists.txt has been copied to the $folder_path directory"

$launchJson = Get-Content $launchFilePath | Out-String | ConvertFrom-Json
if (-not $launchJson.inputs.options.Contains($folder_name)) {
    $launchJson.inputs | ForEach-Object {
        if ($_.id -eq "selectProgram") {
            $_.options += $folder_name
        }
    }
    $launchJson | ConvertTo-Json -Depth 100 | Set-Content $launchFilePath -Force
}

Write-Host "Project '$folder_name' has been added to launch.json"
