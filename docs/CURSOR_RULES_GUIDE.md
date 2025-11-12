# Cursor Rules 사용 가이드

이 프로젝트의 `.cursorrules` 파일을 다른 프로젝트에서도 사용하는 방법을 안내합니다.

## 방법 1: 전역 규칙으로 사용 (추천)

모든 Flutter 프로젝트에 자동으로 적용하려면:

```bash
# 홈 디렉토리에 전역 규칙 파일 생성
cp .cursorrules ~/.cursorrules
```

이렇게 하면 새로운 프로젝트를 열 때도 자동으로 이 규칙이 적용됩니다.

## 방법 2: 프로젝트별 규칙 사용

특정 프로젝트에만 적용하려면:

```bash
# 다른 프로젝트의 루트 디렉토리에 복사
cp .cursorrules /path/to/other/project/.cursorrules
```

## 방법 3: 프로젝트별 커스터마이징

프로젝트에 따라 다른 설정이 필요한 경우:

1. `.cursorrules` 파일을 프로젝트에 복사
2. `[프로젝트별 설정]` 섹션을 수정
3. 프로젝트에서 사용하는 라이브러리에 맞게 규칙 조정

### 예시: 다른 상태 관리 라이브러리 사용 시

```markdown
### 7. 상태 관리 사용 규칙 (프로젝트별 수정)

- **Bloc 사용**: `@riverpod` 대신 `BlocBuilder` 사용
- Provider는 `{feature}_bloc.dart` 파일에 정의
- State는 `freezed`로 정의하여 `{feature}_state.dart`에 위치
```

## 규칙 적용 확인

Cursor에서 규칙이 적용되었는지 확인하려면:

1. Cursor 설정에서 "Rules" 확인
2. AI 어시스턴트에게 "프로젝트 규칙을 확인해줘" 요청
3. 코드 생성 시 규칙을 따르는지 확인

## 규칙 업데이트

규칙을 업데이트한 후:

1. 전역 규칙 사용 시: `~/.cursorrules` 파일 업데이트
2. 프로젝트별 규칙 사용 시: 각 프로젝트의 `.cursorrules` 파일 업데이트

## 문제 해결

### 규칙이 적용되지 않는 경우

1. **파일 위치 확인**: `.cursorrules` 파일이 프로젝트 루트에 있는지 확인
2. **파일 이름 확인**: `.cursorrules` (점으로 시작, 확장자 없음)
3. **Cursor 재시작**: Cursor를 재시작하여 규칙 재로드
4. **캐시 클리어**: Cursor 설정에서 캐시 클리어

### 프로젝트별 규칙 우선순위

Cursor는 다음 순서로 규칙을 적용합니다:

1. 프로젝트 루트의 `.cursorrules` (최우선)
2. `~/.cursorrules` (전역 규칙)
3. 기본 설정

## 커스터마이징 예시

### React Native 프로젝트용

```markdown
# React Native Clean Architecture 규칙

## 프로젝트 개요

이 규칙은 Clean Architecture를 기반으로 한 React Native 프로젝트용입니다.
Flutter 버전과 구조는 유사하지만, 라이브러리가 다릅니다:

- React Query / Zustand (상태 관리)
- Axios (HTTP 클라이언트)
- React Navigation (라우팅)
```

### 백엔드 프로젝트용

```markdown
# Clean Architecture Backend 프로젝트 규칙

## 프로젝트 개요

이 규칙은 Clean Architecture를 기반으로 한 백엔드 프로젝트용입니다.

- NestJS / Express (프레임워크)
- TypeORM / Prisma (ORM)
- Jest (테스트)
```

## 추가 참고사항

- 규칙은 Markdown 형식으로 작성됩니다
- 주석과 예시 코드를 포함하여 AI가 이해하기 쉽게 작성
- 프로젝트 특정 정보는 `[프로젝트별 설정]` 섹션에 명시
- 정기적으로 규칙을 업데이트하여 최신 패턴 반영
