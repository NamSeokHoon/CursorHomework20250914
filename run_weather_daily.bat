@echo off
REM 매일 아침 7시에 날씨 정보를 출력하는 배치 파일
REM 이 파일은 Windows 작업 스케줄러에서 실행됩니다.

REM Python 스크립트 경로 설정
set PYTHON_SCRIPT=C:\Users\seokh\weather_daily.py

REM 로그 파일 경로 설정 (선택사항)
set LOG_FILE=C:\Users\seokh\weather_log.txt

REM 현재 시간을 로그에 기록
echo %date% %time% - 날씨 정보 실행 시작 >> "%LOG_FILE%"

REM Python 스크립트 실행
python "%PYTHON_SCRIPT%" --api-key YOUR_API_KEY_HERE

REM 실행 결과를 로그에 기록
if %errorlevel% equ 0 (
    echo %date% %time% - 날씨 정보 실행 완료 >> "%LOG_FILE%"
) else (
    echo %date% %time% - 날씨 정보 실행 실패 (오류 코드: %errorlevel%) >> "%LOG_FILE%"
)

REM 잠시 대기 (로그 파일이 제대로 기록되도록)
timeout /t 2 /nobreak > nul
