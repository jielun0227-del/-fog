# IndexNow Batch URL Submission Script (Bing / Yandex / IndexNow)
param(
    [string]$SitemapPath = ".\sitemap.xml",
    [string]$HostName = "jichangfog.com",
    [string]$Key = "7e57d4f99b04fc495054ded150df2c3"
)

if (-not (Test-Path $SitemapPath)) {
    Write-Error "Cannot find sitemap file: $SitemapPath"
    exit 1
}

[xml]$xml = Get-Content $SitemapPath
$urls = @($xml.urlset.url.loc)
Write-Host "Found $($urls.Count) URLs from sitemap. Submitting to IndexNow..." -ForegroundColor Cyan

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
        Write-Host "[$endpoint] Success: HTTP $($response.StatusCode)" -ForegroundColor Green
    } catch {
        Write-Host "[$endpoint] Failed: $_" -ForegroundColor Red
    }
}
Write-Host "IndexNow submission completed!" -ForegroundColor Green
