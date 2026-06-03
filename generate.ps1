# 扫描 photos 文件夹，自动生成照片数据
# 用法：右键 generate.bat 运行，或在 PowerShell 中运行此脚本

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

$photosDir = "photos"
$outputFile = "photos.js"

$imageExts = @('.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp')
$videoExts = @('.mp4', '.webm', '.mov', '.avi', '.mkv')
$allExts = $imageExts + $videoExts

Write-Host ""
Write-Host "🔍 正在扫描 photos 文件夹..." -ForegroundColor Cyan

$files = Get-ChildItem $photosDir -File | Where-Object {
    $allExts -contains $_.Extension.ToLower()
} | Sort-Object Name

if ($files.Count -eq 0) {
    Write-Host "❌ photos 文件夹里没有图片或视频！" -ForegroundColor Red
    Write-Host "   请先把照片放到 photos 文件夹里" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "📁 找到 $($files.Count) 个文件" -ForegroundColor Green
Write-Host ""

$shell = New-Object -ComObject Shell.Application
$folderObj = $shell.Namespace((Get-Item $photosDir).FullName)

$entries = @()
$count = 0

foreach ($file in $files) {
    $count++
    $ext = $file.Extension.ToLower()
    $isVideo = $videoExts -contains $ext
    $type = if ($isVideo) { "video" } else { "image" }

    # 标题 = 文件名去后缀
    $title = $file.BaseName -replace "'", "\'" -replace '"', '\"'

    # 获取视频时长
    $duration = ""
    if ($isVideo) {
        try {
            $shellFile = $folderObj.ParseName($file.Name)
            $durationRaw = $folderObj.GetDetailsOf($shellFile, 27)
            if ($durationRaw -and $durationRaw -match '\d+:\d+') {
                $duration = $durationRaw
            }
        } catch { }
    }

    $entry = '  { type: "' + $type + '", src: "photos/' + $file.Name + '", title: "' + $title + '", subtitle: "", category: "other", tagText: "' + $(if ($isVideo) { '视频' } else { '照片' }) + '"' + $(if ($duration) { ', duration: "' + $duration + '"' } else { '' }) + ' }'
    $entries += $entry

    $icon = if ($isVideo) { "🎬" } else { "📷" }
    Write-Host "  $icon [$count/$($files.Count)] $($file.Name)" -ForegroundColor Gray
}

$jsContent = @"
// 📸 自动生成 — 由 generate.ps1 扫描 photos 文件夹生成
// 如需重新生成，双击 generate.bat 即可
// 生成时间：$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
// 文件总数：$($files.Count)

window.PHOTO_DATA = [
$($entries -join ",`n")
];
"@

# 无 BOM 的 UTF-8
[System.IO.File]::WriteAllText("$scriptDir\$outputFile", $jsContent, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "✅ 已生成 photos.js！共 $($files.Count) 个文件（$($files.Where({$videoExts -contains $_.Extension.ToLower()}).Count) 个视频，$($files.Where({$imageExts -contains $_.Extension.ToLower()}).Count) 张照片）" -ForegroundColor Green
Write-Host "📺 刷新浏览器即可看到你的照片" -ForegroundColor Cyan
Write-Host ""
pause
