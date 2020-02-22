# ensure all submodules are currently checked out to the latest tag
git submodule update --init --recursive
Get-ChildItem ./ext -Directory | ForEach-Object {
    $path = $_.FullName

    git -C "$path" fetch --tags
    $lastTag = (git -C "$path" describe --tags $(git -C "$path" rev-list --tags --max-count=1))  | Out-String
    $lastTag = $lastTag.Trim()

    Write-Host "$path => $lastTag"
    git -C "$path" reset --hard "$lastTag" --
}

docfx