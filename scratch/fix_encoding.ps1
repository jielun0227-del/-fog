$files = Get-ChildItem -Path "articles\*.html"
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    # Fix garbled navbar brand
    $text = $text -replace '鏈哄満鎺ㄨ崘涓庢祴璇', '机场推荐与测评'
    $text = $text -replace '鎼滅储鏂囩珷銆佸師鐞嗘垨瀵规瘮...', '搜索文章、原理或对比...'
    $text = $text -replace '鏈哄満鎺ㄨ崘', '机场推荐'
    $text = $text -replace '鐭ヨ瘑搴', '知识库'
    $text = $text -replace '鏂囩珷绉戞櫘', '文章科普'
    $text = $text -replace '璇︾粏璇勬祴', '详细评测'
    $text = $text -replace '鍒囨崲娣辫壊/娴呰壊妯″紡', '切换深色/浅色模式'
    $text = $text -replace '棣栭〉', '首页'
    $text = $text -replace '2026骞\?鏈堟洿鏂', '2026年9月更新'
    $text = $text -replace '娣卞害闃呰涓庢寚鍗', '深度阅读与指南'
    
    # Remove any remaining raw garbled emojis
    $text = $text -replace '馃攳', '🔍'
    $text = $text -replace '鈽€锔', '☀️'
    $text = $text -replace '馃寵', '🌙'
    $text = $text -replace '鈥', '•'
    
    [System.IO.File]::WriteAllText($f.FullName, $text, [System.Text.Encoding]::UTF8)
}
Write-Host "Encoding fix completed."
