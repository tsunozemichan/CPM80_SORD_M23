# build_and_update_cpm.ps1 - SORD M23 CP/M BIOS Build & Update Script
# Usage: .\build_and_update_cpm.ps1 <bios.z80> [cpm.d88]

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$BiosSource,
    
    [Parameter(Mandatory=$false, Position=1)]
    [string]$D88Image
)

# Stop on error
$ErrorActionPreference = "Stop"

# ========== Function Definitions ==========
function Write-Header {
    param([string]$Message)
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Step {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Yellow
}

function Write-Success {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Green
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Red
}

# ========== Main Process ==========

# Check BIOS source file exists
if (-not (Test-Path $BiosSource)) {
    Write-ErrorMsg "Error: BIOS file '$BiosSource' not found"
    exit 1
}

# Get base filename without extension
$BaseName = [System.IO.Path]::GetFileNameWithoutExtension($BiosSource)
$BinFile = "$BaseName.bin"
$LstFile = "$BaseName.lst"
$CpmSys = "CPM.SYS"

Write-Header "SORD M23 CP/M BIOS Build & Update Script"
Write-Host "BIOS Source : $BiosSource"
Write-Host "Output BIN  : $BinFile"
Write-Host "Output LST  : $LstFile"
if ($D88Image) {
    Write-Host "D88 Image   : $D88Image"
} else {
    Write-Host "D88 Image   : (not specified)"
}
Write-Host ""

# ========== Step 1: Assemble ==========
Write-Step "[1/3] Assembling BIOS..."
Write-Host "Command: AILZ80ASM.exe $BiosSource -bin $BinFile -lst $LstFile -f"
Write-Host ""

& .\AILZ80ASM.exe $BiosSource -bin $BinFile -lst $LstFile -f

if ($LASTEXITCODE -ne 0) {
    Write-ErrorMsg "Error: Assembly failed (exit code: $LASTEXITCODE)"
    exit 1
}

if (-not (Test-Path $BinFile)) {
    Write-ErrorMsg "Error: $BinFile was not created"
    exit 1
}

Write-Success "Assembly successful: $BinFile created"
Write-Host ""

# ========== Step 2: Create CPM.SYS ==========
Write-Step "[2/3] Creating CPM.SYS..."
Write-Host "Command: python.exe makeCPMsys.py $BinFile"
Write-Host ""

& python.exe .\makeCPMsys.py $BinFile

if ($LASTEXITCODE -ne 0) {
    Write-ErrorMsg "Error: CPM.SYS creation failed (exit code: $LASTEXITCODE)"
    exit 1
}

if (-not (Test-Path $CpmSys)) {
    Write-ErrorMsg "Error: $CpmSys was not created"
    exit 1
}

Write-Success "CPM.SYS creation successful"
Write-Host ""

# ========== Step 3: Update d88 image ==========
if ($D88Image) {
    Write-Step "[3/3] Updating d88 image..."
    
    if (-not (Test-Path $D88Image)) {
        Write-Host "Warning: d88 image '$D88Image' not found" -ForegroundColor Yellow
        Write-Host "Skipping d88 image update" -ForegroundColor Yellow
    } else {
        Write-Host "Command: python.exe change_cpmsys_d88.py $D88Image $CpmSys"
        Write-Host ""
        
        & python.exe .\change_cpmsys_d88.py $D88Image $CpmSys
        
        if ($LASTEXITCODE -ne 0) {
            Write-ErrorMsg "Error: d88 image update failed (exit code: $LASTEXITCODE)"
            exit 1
        }
        
        Write-Success "d88 image update successful"
    }
} else {
    Write-Step "[3/3] Skipping d88 image update (not specified)"
}

# ========== Complete ==========
Write-Host ""
Write-Header "All processes completed successfully!"
Write-Host "Generated files:"
Write-Host "  - $BinFile (BIOS binary)" -ForegroundColor Green
Write-Host "  - $LstFile (listing file)" -ForegroundColor Green
Write-Host "  - $CpmSys (CP/M system file)" -ForegroundColor Green
if ($D88Image -and (Test-Path $D88Image)) {
    Write-Host "  - $D88Image (updated d88 image)" -ForegroundColor Green
}
Write-Host ""

exit 0
