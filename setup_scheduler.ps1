# Windows 작업 스케줄러 자동 설정 스크립트
# 이 스크립트는 매일 아침 7시에 날씨 정보를 출력하는 작업을 자동으로 생성합니다.

# 관리자 권한 확인
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ 이 스크립트는 관리자 권한으로 실행해야 합니다." -ForegroundColor Red
    Write-Host "PowerShell을 관리자 권한으로 다시 실행해주세요." -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "🔧 Windows 작업 스케줄러 설정을 시작합니다..." -ForegroundColor Green

# 작업 스케줄러 서비스 시작 확인
$service = Get-Service -Name "Schedule" -ErrorAction SilentlyContinue
if ($service -and $service.Status -ne "Running") {
    Write-Host "📋 작업 스케줄러 서비스를 시작합니다..." -ForegroundColor Yellow
    Start-Service -Name "Schedule"
}

# 작업 이름과 설명
$taskName = "매일아침날씨정보"
$taskDescription = "매일 아침 7시에 날씨 정보를 터미널에 출력합니다."

# 배치 파일 경로
$batchFilePath = "C:\Users\seokh\run_weather_daily.bat"

# 배치 파일 존재 확인
if (-not (Test-Path $batchFilePath)) {
    Write-Host "❌ 배치 파일을 찾을 수 없습니다: $batchFilePath" -ForegroundColor Red
    Write-Host "먼저 run_weather_daily.bat 파일을 생성해주세요." -ForegroundColor Yellow
    pause
    exit 1
}

try {
    # 기존 작업이 있다면 삭제
    $existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
    if ($existingTask) {
        Write-Host "🗑️  기존 작업을 삭제합니다..." -ForegroundColor Yellow
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

    # 작업 동작 정의
    $action = New-ScheduledTaskAction -Execute $batchFilePath -WorkingDirectory "C:\Users\seokh"

    # 작업 트리거 정의 (매일 오전 7시)
    $trigger = New-ScheduledTaskTrigger -Daily -At "07:00"

    # 작업 설정 정의
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

    # 작업 등록
    Write-Host "📅 작업 스케줄러에 작업을 등록합니다..." -ForegroundColor Green
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Description $taskDescription -Force

    Write-Host "✅ 작업 스케줄러 설정이 완료되었습니다!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 설정된 작업 정보:" -ForegroundColor Cyan
    Write-Host "   - 작업 이름: $taskName" -ForegroundColor White
    Write-Host "   - 실행 시간: 매일 오전 7시" -ForegroundColor White
    Write-Host "   - 실행 파일: $batchFilePath" -ForegroundColor White
    Write-Host ""
    Write-Host "🔍 작업 스케줄러에서 확인하려면:" -ForegroundColor Yellow
    Write-Host "   1. Windows 키 + R → taskschd.msc 입력" -ForegroundColor White
    Write-Host "   2. '작업 스케줄러 라이브러리' → '$taskName' 확인" -ForegroundColor White
    Write-Host ""
    Write-Host "⚠️  주의사항:" -ForegroundColor Yellow
    Write-Host "   - run_weather_daily.bat 파일에서 API 키를 설정해주세요" -ForegroundColor White
    Write-Host "   - 컴퓨터가 오전 7시에 켜져 있어야 합니다" -ForegroundColor White
    Write-Host "   - 로그는 C:\Users\seokh\weather_log.txt에 기록됩니다" -ForegroundColor White

} catch {
    Write-Host "❌ 작업 스케줄러 설정 중 오류가 발생했습니다:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Write-Host "아무 키나 누르면 종료됩니다..." -ForegroundColor Gray
pause
