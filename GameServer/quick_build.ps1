# 快速编译脚本 - 自动处理常见问题
# 用法: .\quick_build.ps1

Write-Host "=== 快速编译脚本 ===" -ForegroundColor Cyan
Write-Host ""

# 设置编译参数
$solution = "NNOGameServer.sln"
$config = "Debug"
$platform = "Win32"
$logFile = "build_errors.txt"

# 检查 MSBuild
$msbuildPaths = @(
    "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe",
    "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
)

$msbuild = $null
foreach ($path in $msbuildPaths) {
    if (Test-Path $path) {
        $msbuild = $path
        break
    }
}

if (-not $msbuild) {
    Write-Host "错误: 未找到 MSBuild" -ForegroundColor Red
    Write-Host "请使用开发者命令提示符运行此脚本" -ForegroundColor Yellow
    exit 1
}

Write-Host "找到 MSBuild: $msbuild" -ForegroundColor Green
Write-Host ""

# 编译并保存错误日志
Write-Host "开始编译..." -ForegroundColor Yellow
Write-Host "配置: $config | 平台: $platform" -ForegroundColor White
Write-Host ""

& $msbuild $solution `
    /p:Configuration=$config `
    /p:Platform=$platform `
    /v:minimal `
    /nologo `
    /fl `
    /flp:logfile=$logFile;verbosity=detailed `
    2>&1 | Tee-Object -Variable buildOutput

Write-Host ""
Write-Host "=== 编译完成 ===" -ForegroundColor Cyan

# 分析错误
$errorCount = 0
$warningCount = 0
$errors = @()

foreach ($line in $buildOutput) {
    if ($line -match "error\s+(C\d+|MSB\d+):") {
        $errorCount++
        $errors += $line
    }
    if ($line -match "warning\s+(C\d+|MSB\d+):") {
        $warningCount++
    }
}

Write-Host "错误数: $errorCount" -ForegroundColor $(if ($errorCount -eq 0) { "Green" } else { "Red" })
Write-Host "警告数: $warningCount" -ForegroundColor $(if ($warningCount -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

if ($errorCount -gt 0) {
    Write-Host "=== 前10个错误 ===" -ForegroundColor Red
    $errors | Select-Object -First 10 | ForEach-Object {
        Write-Host $_ -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "完整错误日志已保存到: $logFile" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "常见错误类型:" -ForegroundColor Cyan
    $errorTypes = @{}
    foreach ($error in $errors) {
        if ($error -match "error\s+(C\d+):") {
            $code = $matches[1]
            if (-not $errorTypes.ContainsKey($code)) {
                $errorTypes[$code] = 0
            }
            $errorTypes[$code]++
        }
    }
    $errorTypes.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5 | ForEach-Object {
        Write-Host "  $($_.Key): $($_.Value) 次" -ForegroundColor White
    }
} else {
    Write-Host "编译成功！" -ForegroundColor Green
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

