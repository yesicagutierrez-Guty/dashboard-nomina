# Script para publicar dashboard-nomina en GitHub Pages
# Ejecutar en PowerShell: .\publicar-github-pages.ps1

Write-Host "=== Publicando Dashboard Nomina en GitHub Pages ===" -ForegroundColor Cyan

# 1. Verificar autenticación
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "No estas autenticada. Iniciando login..." -ForegroundColor Yellow
    gh auth login --hostname github.com --git-protocol https --web
}

# 2. Ir a la carpeta
Set-Location "C:\Users\1020744588\Documents\Squad agentes IA 2\Workspace\Nomina"

# 3. Limpiar remote si existe
git remote remove origin 2>$null

# 4. Asegurar que estamos en branch main
git branch -M main

# 5. Crear repo y push
Write-Host "Creando repositorio en GitHub..." -ForegroundColor Green
gh repo create dashboard-nomina --public --source=. --remote=origin --push

# 6. Habilitar GitHub Pages
Write-Host "Habilitando GitHub Pages..." -ForegroundColor Green
Start-Sleep -Seconds 3
gh api repos/yesicagutierrez-Guty/dashboard-nomina/pages -X POST -f "build_type=legacy" -f "source[branch]=main" -f "source[path]=/"

# 7. Resultado
Write-Host ""
Write-Host "=== LISTO! ===" -ForegroundColor Green
Write-Host "Tu dashboard estara disponible en 1-2 minutos en:" -ForegroundColor Cyan
Write-Host "https://yesicagutierrez-guty.github.io/dashboard-nomina/" -ForegroundColor Yellow
Write-Host ""
Read-Host "Presiona Enter para cerrar"
