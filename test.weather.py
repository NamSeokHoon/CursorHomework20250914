#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
날씨 프로그램 테스트 스크립트
API 키 없이도 프로그램의 기본 기능을 테스트할 수 있습니다.
"""

import sys
import os

# 현재 디렉토리를 Python 경로에 추가
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from weather_daily import WeatherReporter

def test_weather_reporter():
    """날씨 리포터의 기본 기능을 테스트합니다."""
    print("🧪 날씨 프로그램 테스트를 시작합니다...")
    print()
    
    # API 키 없이 WeatherReporter 인스턴스 생성 테스트
    print("1. WeatherReporter 클래스 초기화 테스트")
    try:
        # API 키가 없어도 클래스는 생성되어야 함
        reporter = WeatherReporter.__new__(WeatherReporter)
        print("   ✅ WeatherReporter 클래스 생성 성공")
    except Exception as e:
        print(f"   ❌ WeatherReporter 클래스 생성 실패: {e}")
        return False
    
    # 이모지 매핑 테스트
    print("2. 날씨 이모지 매핑 테스트")
    try:
        reporter = WeatherReporter.__new__(WeatherReporter)
        reporter.get_weather_emoji = WeatherReporter.get_weather_emoji.__get__(reporter)
        
        test_cases = [
            (800, "☀️"),  # 맑음
            (801, "⛅"),  # 약간 흐림
            (500, "🌧️"),  # 비
            (600, "❄️"),  # 눈
        ]
        
        for weather_id, expected_emoji in test_cases:
            result = reporter.get_weather_emoji(weather_id)
            if result == expected_emoji:
                print(f"   ✅ 날씨 ID {weather_id}: {result}")
            else:
                print(f"   ❌ 날씨 ID {weather_id}: 예상 {expected_emoji}, 실제 {result}")
    except Exception as e:
        print(f"   ❌ 이모지 매핑 테스트 실패: {e}")
        return False
    
    # 온도 포맷팅 테스트
    print("3. 온도 포맷팅 테스트")
    try:
        reporter = WeatherReporter.__new__(WeatherReporter)
        reporter.format_temperature = WeatherReporter.format_temperature.__get__(reporter)
        
        test_temps = [25.5, -10.0, 0.0, 30.123]
        for temp in test_temps:
            result = reporter.format_temperature(temp)
            expected = f"{temp:.1f}°C"
            if result == expected:
                print(f"   ✅ {temp}°C → {result}")
            else:
                print(f"   ❌ {temp}°C → 예상 {expected}, 실제 {result}")
    except Exception as e:
        print(f"   ❌ 온도 포맷팅 테스트 실패: {e}")
        return False
    
    # 풍향 변환 테스트
    print("4. 풍향 변환 테스트")
    try:
        reporter = WeatherReporter.__new__(WeatherReporter)
        reporter.get_wind_direction = WeatherReporter.get_wind_direction.__get__(reporter)
        
        test_directions = [
            (0, "북"), (45, "북동"), (90, "동"), (135, "남동"),
            (180, "남"), (225, "남서"), (270, "서"), (315, "북서")
        ]
        
        for degrees, expected in test_directions:
            result = reporter.get_wind_direction(degrees)
            if result == expected:
                print(f"   ✅ {degrees}° → {result}")
            else:
                print(f"   ❌ {degrees}° → 예상 {expected}, 실제 {result}")
    except Exception as e:
        print(f"   ❌ 풍향 변환 테스트 실패: {e}")
        return False
    
    print()
    print("🎉 모든 테스트가 완료되었습니다!")
    print()
    print("📝 다음 단계:")
    print("   1. OpenWeatherMap에서 API 키를 발급받으세요")
    print("   2. run_weather_daily.bat 파일에서 API 키를 설정하세요")
    print("   3. setup_scheduler.ps1을 관리자 권한으로 실행하여 자동 스케줄링을 설정하세요")
    print("   4. 또는 수동으로 python weather_daily.py --api-key YOUR_KEY로 테스트하세요")
    
    return True

if __name__ == "__main__":
    test_weather_reporter()
