$ErrorActionPreference = "Stop"

$target="win10-x64"
[xml]$proj = Get-Content src\MinEdLauncher\MinEdLauncher.fsproj
$version=$proj.Project.PropertyGroup[0].Version
$release_name="min-ed-launcher-$version-$target"

dotnet publish src\MinEdLauncher\MinEdLauncher.fsproj -r "$target" --self-contained true -o "artifacts\$release_name" -c ReleaseWindows
dotnet publish src\MinEdLauncher.Bootstrap\MinEdLauncher.Bootstrap.csproj -r "$target" --self-contained true -o "artifacts\$release_name" -c Release
rm "artifacts\$release_name\*" -include *.json, *.pdb

Compress-Archive -Path "artifacts\$release_name" -DestinationPath "artifacts\$release_name.zip" -Force

rm -r "artifacts\$release_name"
