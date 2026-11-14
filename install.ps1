# pm-book-skills installer for Windows (PowerShell 5.1+ / 7+).
# Copies the mom-test and continuous-discovery skills into Codex and Claude Code.
#
# Online (run in a normal PowerShell window, NOT inside Codex):
#   irm https://raw.githubusercontent.com/wineny/pm-book-skills/main/install.ps1 | iex
#
# Offline (from the folder that contains this install.ps1):
#   powershell -ExecutionPolicy Bypass -File .\install.ps1
#
# Messages are ASCII on purpose: Windows PowerShell 5.1 garbles non-ASCII in
# scripts saved without a BOM.
# The body runs inside & { } and never calls `exit`, so under `irm | iex` it does
# not close the user's window or leave settings behind in their session.

$pmbsScriptRoot = $PSScriptRoot
$pmbsOk = & {
  $ErrorActionPreference = 'Stop'
  $Skills = @('mom-test', 'continuous-discovery')
  $ZipUrl = 'https://github.com/wineny/pm-book-skills/archive/refs/heads/main.zip'
  $tmp = $null
  $staged = $null
  try {
    # 1. Find the skills source: next to this script (offline) or download the zip.
    if ($pmbsScriptRoot -and (Test-Path (Join-Path $pmbsScriptRoot 'skills\mom-test\SKILL.md'))) {
      $src = Join-Path $pmbsScriptRoot 'skills'
      Write-Host "Using local files: $src"
    } else {
      $tmp = Join-Path ([IO.Path]::GetTempPath()) ("pm-book-skills-" + [Guid]::NewGuid().ToString('N'))
      New-Item -ItemType Directory -Force $tmp | Out-Null
      $zip = Join-Path $tmp 'repo.zip'
      Write-Host "Downloading $ZipUrl"
      try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
      } catch {}
      try {
        Invoke-WebRequest -Uri $ZipUrl -OutFile $zip -UseBasicParsing
      } catch {
        Write-Host ""
        Write-Host "Download failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "If you ran this inside Codex, Codex blocks the internet. Run it in a normal PowerShell window."
        Write-Host "No internet? Get pm-book-skills-main.zip (see README), unzip it, open the folder"
        Write-Host "that contains install.ps1, and run:"
        Write-Host "  powershell -ExecutionPolicy Bypass -File .\install.ps1"
        return $false
      }
      Expand-Archive -Path $zip -DestinationPath $tmp -Force
      $src = Get-ChildItem $tmp -Directory | ForEach-Object { Join-Path $_.FullName 'skills' } |
        Where-Object { Test-Path (Join-Path $_ 'mom-test\SKILL.md') } | Select-Object -First 1
      if (-not $src) { throw "skills folder not found in the downloaded zip" }
    }

    # 2. Copy to Codex (always) and Claude Code (if ~/.claude exists).
    $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
    $dests = @(Join-Path $codexHome 'skills')
    if (Test-Path (Join-Path $HOME '.claude')) { $dests += (Join-Path $HOME '.claude\skills') }

    $missing = @()
    foreach ($dest in $dests) {
      New-Item -ItemType Directory -Force $dest | Out-Null
      foreach ($s in $Skills) {
        $target = Join-Path $dest $s
        $staged = "$target.new"
        if (Test-Path $staged) { Remove-Item $staged -Recurse -Force }
        Copy-Item (Join-Path $src $s) $staged -Recurse
        if (Test-Path $target) {
          $item = Get-Item $target -Force
          if ($item.LinkType) { [IO.Directory]::Delete($target) } else { Remove-Item $target -Recurse -Force }
        }
        Rename-Item $staged $s
        $staged = $null
        $md = Join-Path $target 'SKILL.md'
        if (Test-Path $md) { Write-Host "OK  $md" -ForegroundColor Green } else { $missing += $md }
      }
    }

    if ($missing.Count -gt 0) {
      Write-Host "Missing: $($missing -join ', ')" -ForegroundColor Red
      return $false
    }

    Write-Host ""
    Write-Host "Done. Close Codex completely and open it again (skills load only at start)."
    Write-Host "Then ask: mom-test skill, check my interview questions."
    return $true
  } catch {
    if ($staged) { Remove-Item $staged -Recurse -Force -ErrorAction SilentlyContinue }
    Write-Host "Install failed: $($_.Exception.Message)" -ForegroundColor Red
    return $false
  } finally {
    if ($tmp) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }
  }
}

# Exit code only when run as a file (-File); under iex, exiting would close the window.
if ($pmbsScriptRoot -and -not $pmbsOk) { exit 1 }
Remove-Variable pmbsScriptRoot, pmbsOk -ErrorAction SilentlyContinue
