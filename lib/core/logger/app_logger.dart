import 'package:logger/logger.dart';

/// 앱 전역 Logger 인스턴스
///
/// **사용 방법:**
/// ```dart
/// import 'package:clean_architectue_app/core/logger/app_logger.dart';
///
/// // 로그 레벨별 사용
/// appLogger.d('Debug 메시지');
/// appLogger.i('Info 메시지');
/// appLogger.w('Warning 메시지');
/// appLogger.e('Error 메시지', error: exception, stackTrace: stackTrace);
/// ```
///
/// **로그 레벨:**
/// - `d` (Debug): 개발 중 디버깅 정보
/// - `i` (Info): 일반 정보성 메시지
/// - `w` (Warning): 경고 메시지
/// - `e` (Error): 에러 메시지 (예외 포함 가능)
final Logger appLogger = Logger(
  printer: SimplePrinter(
    colors: true, // 컬러 출력
    printTime: true, // 시간 출력
  ),
  // 개발 환경에서는 모든 로그 출력, 프로덕션에서는 에러만
  level: Level.debug,
  filter: ProductionFilter(),
);

/// 간단한 로거 (스택 트레이스 없음)
///
/// **사용 시나리오:**
/// - 간단한 로그 메시지만 필요할 때
/// - 성능이 중요한 경우
final Logger simpleLogger = Logger(
  printer: SimplePrinter(colors: true, printTime: true),
  filter: ProductionFilter(),
  level: Level.debug,
);
