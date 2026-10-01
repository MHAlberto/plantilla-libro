$ErrorActionPreference = 'Stop'

if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    Write-Error 'No se encontró latexmk. Instala MiKTeX o TeX Live con latexmk y comprueba que sus ejecutables estén en PATH.'
    exit 1
}

Push-Location $PSScriptRoot
try {
    & latexmk -xelatex -interaction=nonstopmode -file-line-error -halt-on-error main.tex
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
    Write-Host 'PDF actualizado: main.pdf'
}
finally {
    Pop-Location
}
