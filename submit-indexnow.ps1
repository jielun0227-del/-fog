# IndexNow 批量自动提交脚本 (支持 Bing / Yandex / IndexNow)
param(
    [string]$SitemapPath = ".\sitemap.xml",
    [string]$HostName = "jichangfog.com",
    [string]$Key = "7e57d4f99b04fc495054ded150df2c3"
)

if (-not (Test-Path $SitemapPath)) {
    Write-Error "找不到网站地图文件: $SitemapPath"
    exit 1
}

[xml]$xml = Get-Content $SitemapPath
$urls = @($xml.urlset.url.loc)
Write-Host "解析到 $($urls.Count) 个 URL，准备提交至 IndexNow..." -ForegroundColor Cyan

$body = @{
    host = $HostName
    key = $Key
    keyLocation = "https://$HostName/$Key.txt"
    urlList = $urls
} | ConvertTo-Json -Depth 5

$endpoints = @(
    "https://api.indexnow.org/indexnow",
    "https://www.bing.com/indexnow"
)

foreach ($endpoint in $endpoints) {
    try {
        $response = Invoke-WebRequest -Uri $endpoint -Method POST -ContentType "application/json; charset=utf-8" -Body $body -UseBasicParsing -TimeoutSec 20
        Write-Host "[$endpoint] 提交成功: 状态码 $($response.StatusCode)" -ForegroundColor Green
    } catch {
        Write-Host "[$endpoint] 提交失败: $_" -ForegroundColor Red
    }
}
Write-Host "IndexNow 提交完成！" -ForegroundColor Green
