# Build the Quartz website
Write-Host "Building Quartz..."
npx quartz build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Quartz build failed. Stopping."
    exit 1
}

# Replace the old published site with the new build
Write-Host "Updating docs..."
Remove-Item -Recurse -Force .\docs\*
Copy-Item -Path .\public\* -Destination .\docs\ -Recurse

# GitHub Pages should not process the site with Jekyll
New-Item -ItemType File -Path .\docs\.nojekyll -Force | Out-Null

# Stage source notes and generated website
Write-Host "Staging changes..."
git add content/ docs/

Write-Host ""
Write-Host "Finished. Current Git status:"
git status