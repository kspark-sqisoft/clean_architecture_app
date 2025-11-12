# Product Requirements Document

## 1. 개요

- **제품 이름:** Clean Architecture Flutter Sample (DummyJSON 기반 Todo/Product/Auth 데모)
- **목적:** 클린 아키텍처와 Feature-first 구조를 학습·실습하려는 팀/개발자를 위한 교육용 앱
- **핵심 가치:** 의존성 역전·레이어 분리·Riverpod DI·Freezed immutable 패턴 등을 실제 코드로 익히도록 돕는 샘플
- **목표 사용자:**
  - Flutter Clean Architecture 입문/중급 개발자
  - 사내 Flutter 교육 콘텐츠 담당자
  - 클린 아키텍처 적용 여부를 검토하는 기술 리드

## 2. 핵심 기능

| 기능 영역 | 요구 사항                                     | 세부 내용                                                                                                                                 |
| --------- | --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Todo      | DummyJSON `/todos` API를 활용한 CRUD 데모     | - 전체 목록, 사용자별 목록, 랜덤 Todo<br>- 추가/수정/삭제 요청 (DummyJSON 특성상 mock 형태)<br>- Presentation ↔ Domain ↔ Data 레이어 분리 |
| Product   | DummyJSON `/products` API 브라우징            | - 목록 조회, 검색, 상세, 카테고리 필터<br>- 메인 페이지에서 진입 가능한 카드로 제공<br>- 목록/상세 라우트 분리                            |
| Auth      | DummyJSON `/auth` API 기반 인증               | - 로그인, 토큰 리프레시, 프로필 조회<br>- 토큰 상태 보관 및 AuthController 관리<br>- Failure/Either 패턴 기반 오류 처리                   |
| 테마      | 라이트/다크 테마 토글                         | - Material 3 기반 미니멀 테마<br>- 앱바에서 라이트/다크 전환 (Riverpod StateNotifier)<br>- ThemeData 공통 베이스 구성                     |
| 로깅      | logger 기반 구조화 로그                       | - `appLogger` 전역 사용<br>- Dio 요청/응답 커스텀 인터셉터 (`LoggerInterceptor`)<br>- README에 사용법 제공                                |
| 라우팅    | Home → Todo/Product/Auth                      | - GoRouter 기반 선언적 라우팅<br>- 각 Feature별 `routes` 정의<br>- 헤더 카드 스타일 일관화                                                |
| 문서      | README / CODE_GENERATION_GUIDE / .cursorrules | - 프로젝트 구성·빌드·의존성 안내<br>- build_runner 이슈 대응 가이드<br>- 전역/프로젝트별 규칙 공유 (.cursorrules)                         |

## 3. 비기능 요구 사항

- **아키텍처:** Clean Architecture 원칙, Feature-first 구조
- **상태 관리:** Riverpod + Riverpod Generator
- **데이터 처리:** Dio HTTP, Freezed, JsonSerializable, Dartz Either
- **로깅:** logger 패키지 (SimplePrinter 기반 구조화 로그)
- **디자인:** Material 3 / 미니멀 UI / CardRadius+Elevation 통일
- **테스트:** DataSource, Repository, UseCase 단위 테스트 (mocktail 기반)
- **문서화:** 코드 주석(한글), README, PRD, .cursorrules 작성

## 4. 사용자 시나리오

1. **아키텍처 학습자 – Todo 기능**

   - 홈 화면 카드에서 `Todos` 진입
   - Todo 목록을 검사하며 `TodoRepository` 흐름 확인
   - `GetAllTodos` UseCase / Provider 구조를 통해 클린 아키텍처 학습
   - Either<Failure, Entity> 처리 방식 확인

2. **상용화 검토 팀 – Product 기능**

   - `Products` 기능 선택
   - 목록/검색/카테고리를 보며 구조 확장성 평가
   - `ProductRepositoryImpl`이 DataSource → Model → Entity 변환 흐름 확인
   - `product_list_provider`로 프레젠테이션 레이어 상태 관리 방법 파악

3. **인증 환경 구축 담당 – Auth 기능**

   - `Auth` 선택 후 로그인 시나리오 테스트
   - 토큰/세션 관리, 실패 처리 메시지 확인
   - AuthController → UseCase → Repository → DataSource 흐름 이해

4. **UI/UX 담당 – 테마 토글**

   - 헤더 액션에서 라이트/다크 테마 전환
   - Card/버튼/UI 요소의 일관성 확인
   - ThemeMode 상태가 글로벌로 반영되는지 확인

5. **DevOps / 로깅 담당 – 로그 점검**
   - 앱 동작 중 콘솔에서 요청/응답 로그 확인
   - `LoggerInterceptor` 로깅 포맷 점검
   - logger 패키지 설정 (필터/프린터) 커스터마이즈 검토

## 5. 성공 지표 (Acceptance Criteria)

- ✅ Todo / Product / Auth 주요 플로우 정상 동작 (DummyJSON API 활용)
- ✅ 라이트/다크 테마 전환 직관적 제공
- ✅ logger 기반 HTTP/일반 로그 확인 가능
- ✅ 테스트 케이스: Auth/Todo/Product의 DataSource·Repository·UseCase UT 통과
- ✅ README 기반 셋업/실행/코드 생성 안내 충족
- ✅ `.cursorrules`에 명시된 컨벤션과 구조 유지
- ✅ PRD/문서/주석(한글)로 학습 용도 충족

## 6. 출시 범위 (MVP)

- Todo/Product/Auth 3개 Feature, 각 기능의 핵심 플로우
- 라우팅, 테마, 로깅, 테스트, 문서
- build_runner 호환 이슈에 대한 가이드 문서 포함 (`docs/CODE_GENERATION_GUIDE.md`)

## 7. 확장 아이디어 (향후)

- 실제 백엔드 연동 / Token 저장소
- 오프라인 캐시 및 에러 리트라이
- UI 데모 강화 (예: 다크 테마 컬러 시스템 추가)
- Storybook/Widgetbook 연동
- 더 세분화된 로깅 (analytics, crash reporting)
- i18n(국/영) 텍스트 변환

## 8. 리스크 & 대응 전략

| 리스크                              | 영향           | 대응 전략                                               |
| ----------------------------------- | -------------- | ------------------------------------------------------- |
| DummyJSON API 가용성                | 기능 데모 중단 | API 응답 Mock 레이어 추가 고려                          |
| build_runner & analyzer 호환성      | 코드 생성 실패 | README 및 CODE_GENERATION_GUIDE 가이드 제공 / 버전 관리 |
| 클린 아키텍처 이해 부족             | 잘못된 활용    | README, 주석, PRD로 구조 의도 명시                      |
| 패키지 버전 상향 시 breaking change | 빌드 실패 위험 | `pubspec.yaml` 버전 명시, `flutter pub outdated` 가이드 |
| 로깅 데이터 과다                    | 공연량 문제    | logger 필터/레벨 조정 옵션 제공                         |

## 9. 릴리스 노트 (v1.0.0)

- Feature-first Clean Architecture 구조 도입
- Todo/Product/Auth Feature 구현 및 라우팅 연결
- Riverpod 상태 관리 + DI + Codegen (`*.g.dart`, `riverpod_generator`)
- Freezed/JsonSerializable 모델 및 Entity 변환
- Dio + logger 기반 HTTP 로깅
- 라이트/다크 테마 토글
- README / CODE_GENERATION_GUIDE / .cursorrules / PRD 문서 완성
- UT: DataSource, Repository, UseCase 테스트 포함

## 10. 참고 문서

- README.md
- `docs/CODE_GENERATION_GUIDE.md`
- `.cursorrules`
- DummyJSON API Docs
- 본 PRD 문서
