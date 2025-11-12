// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoListHash() => r'33459f53f29d390c1b53acb9824954c552eec958';

/// ============================================================================
/// TodoList 상태 관리 Provider
/// ============================================================================
///
/// **AsyncNotifier란?**
/// - 비동기 상태를 관리하는 Riverpod의 클래스입니다
/// - AsyncValue<T> 타입으로 로딩/데이터/에러 상태를 관리합니다
/// - StateNotifier의 비동기 버전입니다
///
/// **AsyncValue의 3가지 상태:**
/// 1. **Loading**: 데이터를 불러오는 중
/// 2. **Data**: 데이터 로드 성공
/// 3. **Error**: 데이터 로드 실패
///
/// **사용 예시 (UI):**
/// ```dart
/// final todoList = ref.watch(todoListProvider);
/// todoList.when(
///   loading: () => CircularProgressIndicator(),
///   data: (todos) => ListView(...),
///   error: (err, stack) => Text('Error: $err'),
/// );
/// ```
///
/// Copied from [TodoList].
@ProviderFor(TodoList)
final todoListProvider =
    AutoDisposeAsyncNotifierProvider<TodoList, List<TodoEntity>>.internal(
      TodoList.new,
      name: r'todoListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todoListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodoList = AutoDisposeAsyncNotifier<List<TodoEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
