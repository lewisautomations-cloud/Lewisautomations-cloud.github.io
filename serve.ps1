<#
    Local web server for the Yohan Lewis site.

    Run it:      powershell -ExecutionPolicy Bypass -File .\serve.ps1
    Then open:   http://localhost:8080
    Stop it:     press Ctrl+C in this window

    Why bother instead of double-clicking index.html?
    Opening the file directly uses a file:// address, and browsers refuse to
    give a file:// page a microphone. http://localhost counts as a secure
    origin, so Justice's voice input works here and nowhere else locally.
#>

param(
    [int]$Port = 8080,
    [string]$Root = $PSScriptRoot,
    [switch]$NoBrowser
)

$ErrorActionPreference = "Stop"

if (-not $Root) { $Root = (Get-Location).Path }
$Root = (Resolve-Path -LiteralPath $Root).Path

$types = @{
    ".html" = "text/html; charset=utf-8"
    ".htm"  = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "text/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".svg"  = "image/svg+xml"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".webp" = "image/webp"
    ".gif"  = "image/gif"
    ".ico"  = "image/x-icon"
    ".woff" = "font/woff"
    ".woff2"= "font/woff2"
    ".pdf"  = "application/pdf"
    ".txt"  = "text/plain; charset=utf-8"
}

# Find a free port, starting at the one requested.
$listener = $null
for ($p = $Port; $p -lt ($Port + 20); $p++) {
    try {
        $candidate = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback, $p)
        $candidate.Start()
        $listener = $candidate
        $Port = $p
        break
    } catch {
        if ($candidate) { try { $candidate.Stop() } catch {} }
    }
}
if (-not $listener) { throw "No free port between $Port and $($Port + 19)." }

$url = "http://localhost:$Port/"
Write-Host ""
Write-Host "  Serving $Root"
Write-Host "  at      $url"
Write-Host "  Ctrl+C to stop."
Write-Host ""

if (-not $NoBrowser) { Start-Process $url | Out-Null }

function Send-Response {
    param($Stream, [int]$Code, [string]$Reason, [string]$ContentType, [byte[]]$Body)
    $header = "HTTP/1.1 $Code $Reason`r`n" +
              "Content-Type: $ContentType`r`n" +
              "Content-Length: $($Body.Length)`r`n" +
              "Cache-Control: no-store`r`n" +
              "Connection: close`r`n`r`n"
    $hb = [System.Text.Encoding]::ASCII.GetBytes($header)
    $Stream.Write($hb, 0, $hb.Length)
    if ($Body.Length -gt 0) { $Stream.Write($Body, 0, $Body.Length) }
    $Stream.Flush()
}

try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        try {
            $stream = $client.GetStream()
            $stream.ReadTimeout = 5000

            # Read the request line only; headers are irrelevant for static files.
            $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII)
            $requestLine = $reader.ReadLine()
            if (-not $requestLine) { $client.Close(); continue }

            $parts = $requestLine -split ' '
            $method = $parts[0]
            $target = if ($parts.Count -gt 1) { $parts[1] } else { "/" }

            if ($method -ne "GET" -and $method -ne "HEAD") {
                Send-Response $stream 405 "Method Not Allowed" "text/plain; charset=utf-8" ([System.Text.Encoding]::UTF8.GetBytes("Only GET is served here."))
                $client.Close(); continue
            }

            # Strip query and fragment, decode, normalise.
            $path = ($target -split '[?#]')[0]
            $path = [System.Uri]::UnescapeDataString($path)
            if ($path -eq "/" -or $path -eq "") { $path = "/index.html" }
            $rel = $path.TrimStart('/').Replace('/', '\')

            $full = Join-Path $Root $rel
            $resolved = $null
            try { $resolved = (Resolve-Path -LiteralPath $full).Path } catch {}

            # Never serve anything outside the site folder.
            $inside = $resolved -and $resolved.StartsWith($Root, [System.StringComparison]::OrdinalIgnoreCase)

            if ($inside -and (Test-Path -LiteralPath $resolved -PathType Leaf)) {
                $ext = [System.IO.Path]::GetExtension($resolved).ToLowerInvariant()
                $ct = $types[$ext]
                if (-not $ct) { $ct = "application/octet-stream" }
                $bytes = [System.IO.File]::ReadAllBytes($resolved)
                if ($method -eq "HEAD") { $bytes = New-Object byte[] 0 }
                Send-Response $stream 200 "OK" $ct $bytes
                Write-Host ("  200  " + $path)
            } else {
                $msg = [System.Text.Encoding]::UTF8.GetBytes("Not found: $path")
                Send-Response $stream 404 "Not Found" "text/plain; charset=utf-8" $msg
                Write-Host ("  404  " + $path)
            }
        } catch {
            # A browser preconnect that never sends a request lands here. Ignore it.
        } finally {
            try { $client.Close() } catch {}
        }
    }
} finally {
    try { $listener.Stop() } catch {}
    Write-Host "`n  Server stopped."
}
