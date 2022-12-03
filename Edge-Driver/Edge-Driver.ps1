# https://www.selenium.dev/ja/documentation/webdriver/getting_started/first_script/
using namespace OpenQA.Selenium

# set current directory
Set-Location $PSScriptRoot

# Create New EdgeSession
Function EdgeSession() {
    # Load WebDriver.dll
    $ret = [Reflection.Assembly]::LoadFile((Join-Path (Get-Location) "WebDriver.dll"))

    # msedgedriver.exe の絶対パスを登録
    $svc = [Edge.EdgeDriverService]::CreateDefaultService((Get-Location))

    Write-Host $ret
    
    $opt = New-Object Edge.EdgeOptions
    # $opt.AddArguments("headless","disable-gpu")


    $driver = New-Object Edge.EdgeDriver($svc, $opt)
    $driver.Manage().Timeouts().ImplicitWait = [System.TimeSpan]::FromSeconds(4) #暗黙的な待機4秒

    return $driver
}

$driver = EdgeSession


$driver.Url = "https://www.google.co.jp"   
$queryArea = $driver.FindElement([By]::Name("q")).SendKeys("ニュース")
$driver.FindElement([By]::Name("btnK")).Click()

