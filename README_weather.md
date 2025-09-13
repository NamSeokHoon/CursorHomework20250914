# 매일 아침 날씨 정보 자동 출력 프로그램

매일 아침 7시에 터미널에 오늘의 날씨 정보를 자동으로 출력해주는 프로그램입니다.

## 기능

- 🌤️ 현재 날씨 정보 (온도, 습도, 기압, 풍속 등)
- 📋 오늘의 시간별 날씨 예보
- 💡 날씨에 따른 옷차림 및 활동 조언
- 🌍 한국어 지원 및 이모지 표시
- 📝 실행 로그 기록

## 설치 및 설정

### 1. Python 패키지 설치

```bash
pip install -r requirements.txt
```

### 2. OpenWeatherMap API 키 발급

1. [OpenWeatherMap](https://openweathermap.org/api) 사이트에 접속
2. 무료 계정 생성
3. API 키 발급 (무료 버전으로도 충분)

### 3. API 키 설정

다음 중 하나의 방법으로 API 키를 설정하세요:

#### 방법 1: 환경변수 설정 (권장)
```bash
# Windows PowerShell
$env:OPENWEATHER_API_KEY="your_api_key_here"

# Windows 명령 프롬프트
set OPENWEATHER_API_KEY=your_api_key_here
```

#### 방법 2: 배치 파일 수정
`run_weather_daily.bat` 파일을 열어서 `YOUR_API_KEY_HERE` 부분을 실제 API 키로 교체하세요.

#### 방법 3: 명령행 옵션 사용
```bash
python weather_daily.py --api-key your_api_key_here
```

### 4. Windows 작업 스케줄러 설정

1. **작업 스케줄러 열기**
   - Windows 키 + R → `taskschd.msc` 입력 → Enter

2. **기본 작업 만들기**
   - 오른쪽 패널에서 "기본 작업 만들기" 클릭
   - 이름: "매일 아침 날씨 정보"
   - 설명: "매일 아침 7시에 날씨 정보 출력"

3. **트리거 설정**
   - "매일" 선택
   - 시작 시간: 오전 7:00
   - 반복: 매일

4. **동작 설정**
   - "프로그램 시작" 선택
   - 프로그램/스크립트: `C:\Users\seokh\run_weather_daily.bat`
   - 시작 위치: `C:\Users\seokh`

5. **완료**
   - 설정 확인 후 "완료" 클릭

## 사용법

### 수동 실행
```bash
# 기본 설정으로 실행 (서울 날씨)
python weather_daily.py

# 다른 도시 날씨 확인
python weather_daily.py --city "Busan" --country "KR"
python weather_daily.py --city "Tokyo" --country "JP"
python weather_daily.py --city "New York" --country "US"

# API 키를 직접 지정
python weather_daily.py --api-key your_api_key_here
```

### 자동 실행
Windows 작업 스케줄러가 설정되면 매일 아침 7시에 자동으로 실행됩니다.

## 출력 예시

```
============================================================
🌅 오늘의 날씨 정보
============================================================
📅 날짜: 2024년 01월 15일 Monday
🕐 시간: 07:00
📍 위치: Seoul, KR

☀️ 날씨: 맑음
🌡️  온도: 2.3°C
🌡️  체감온도: -1.2°C
📊 최고/최저: 5.1°C / -2.4°C
💧 습도: 65%
🔽 기압: 1023 hPa
💨 풍속: 2.1 m/s
🧭 풍향: 북서

💡 오늘의 날씨 조언
------------------------------
🧥 쌀쌀하니 가벼운 외투를 준비하세요.
☀️ 맑은 날씨입니다! 야외 활동하기 좋은 날이에요.

📋 오늘의 시간별 예보
----------------------------------------
09:00 ☀️ 3.2°C 맑음
12:00 ☀️ 4.8°C 맑음
15:00 ☀️ 5.1°C 맑음
18:00 ⛅ 3.9°C 약간 흐림
21:00 ⛅ 2.1°C 약간 흐림

============================================================
좋은 하루 되세요! 🌟
============================================================
```

## 파일 구조

```
C:\Users\seokh\
├── weather_daily.py          # 메인 Python 스크립트
├── run_weather_daily.bat     # Windows 배치 파일
├── requirements.txt          # Python 패키지 목록
├── README_weather.md         # 사용법 가이드
└── weather_log.txt           # 실행 로그 (자동 생성)
```

## 문제 해결

### API 키 오류
- API 키가 올바른지 확인
- OpenWeatherMap 계정이 활성화되어 있는지 확인
- 무료 계정의 경우 일일 호출 제한(1000회) 확인

### 네트워크 오류
- 인터넷 연결 상태 확인
- 방화벽 설정 확인

### Python 오류
- Python이 설치되어 있는지 확인
- 필요한 패키지가 설치되어 있는지 확인: `pip install requests`

### 작업 스케줄러 오류
- 배치 파일 경로가 올바른지 확인
- Python 경로가 시스템 PATH에 등록되어 있는지 확인

## 커스터마이징

### 다른 도시 설정
배치 파일에서 `--city`와 `--country` 옵션을 수정하세요:
```batch
python "%PYTHON_SCRIPT%" --api-key YOUR_API_KEY_HERE --city "Busan" --country "KR"
```

### 실행 시간 변경
작업 스케줄러에서 트리거 시간을 원하는 시간으로 변경하세요.

### 출력 형식 수정
`weather_daily.py` 파일의 출력 함수들을 수정하여 원하는 형식으로 변경할 수 있습니다.

## 라이선스

이 프로그램은 개인 사용을 위한 무료 소프트웨어입니다.
