// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_by_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likedBysStreamHash() => r'ad6e242c0ea9e0c900f194e34ab451b8a48cc46d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [likedBysStream].
@ProviderFor(likedBysStream)
const likedBysStreamProvider = LikedBysStreamFamily();

/// See also [likedBysStream].
class LikedBysStreamFamily extends Family<AsyncValue<List<LikedBy>>> {
  /// See also [likedBysStream].
  const LikedBysStreamFamily();

  /// See also [likedBysStream].
  LikedBysStreamProvider call(
    String taskId,
  ) {
    return LikedBysStreamProvider(
      taskId,
    );
  }

  @override
  LikedBysStreamProvider getProviderOverride(
    covariant LikedBysStreamProvider provider,
  ) {
    return call(
      provider.taskId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'likedBysStreamProvider';
}

/// See also [likedBysStream].
class LikedBysStreamProvider extends AutoDisposeStreamProvider<List<LikedBy>> {
  /// See also [likedBysStream].
  LikedBysStreamProvider(
    String taskId,
  ) : this._internal(
          (ref) => likedBysStream(
            ref as LikedBysStreamRef,
            taskId,
          ),
          from: likedBysStreamProvider,
          name: r'likedBysStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likedBysStreamHash,
          dependencies: LikedBysStreamFamily._dependencies,
          allTransitiveDependencies:
              LikedBysStreamFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  LikedBysStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final String taskId;

  @override
  Override overrideWith(
    Stream<List<LikedBy>> Function(LikedBysStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LikedBysStreamProvider._internal(
        (ref) => create(ref as LikedBysStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<LikedBy>> createElement() {
    return _LikedBysStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikedBysStreamProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LikedBysStreamRef on AutoDisposeStreamProviderRef<List<LikedBy>> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _LikedBysStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<LikedBy>>
    with LikedBysStreamRef {
  _LikedBysStreamProviderElement(super.provider);

  @override
  String get taskId => (origin as LikedBysStreamProvider).taskId;
}

String _$likedByRepoHash() => r'93b21515d41a546582c5418ec9f4153528b8cbfb';

abstract class _$LikedByRepo
    extends BuildlessAutoDisposeNotifier<CollectionReference<LikedBy>> {
  late final String taskId;

  CollectionReference<LikedBy> build(
    String taskId,
  );
}

/// See also [LikedByRepo].
@ProviderFor(LikedByRepo)
const likedByRepoProvider = LikedByRepoFamily();

/// See also [LikedByRepo].
class LikedByRepoFamily extends Family<CollectionReference<LikedBy>> {
  /// See also [LikedByRepo].
  const LikedByRepoFamily();

  /// See also [LikedByRepo].
  LikedByRepoProvider call(
    String taskId,
  ) {
    return LikedByRepoProvider(
      taskId,
    );
  }

  @override
  LikedByRepoProvider getProviderOverride(
    covariant LikedByRepoProvider provider,
  ) {
    return call(
      provider.taskId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'likedByRepoProvider';
}

/// See also [LikedByRepo].
class LikedByRepoProvider extends AutoDisposeNotifierProviderImpl<LikedByRepo,
    CollectionReference<LikedBy>> {
  /// See also [LikedByRepo].
  LikedByRepoProvider(
    String taskId,
  ) : this._internal(
          () => LikedByRepo()..taskId = taskId,
          from: likedByRepoProvider,
          name: r'likedByRepoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likedByRepoHash,
          dependencies: LikedByRepoFamily._dependencies,
          allTransitiveDependencies:
              LikedByRepoFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  LikedByRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final String taskId;

  @override
  CollectionReference<LikedBy> runNotifierBuild(
    covariant LikedByRepo notifier,
  ) {
    return notifier.build(
      taskId,
    );
  }

  @override
  Override overrideWith(LikedByRepo Function() create) {
    return ProviderOverride(
      origin: this,
      override: LikedByRepoProvider._internal(
        () => create()..taskId = taskId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LikedByRepo, CollectionReference<LikedBy>>
      createElement() {
    return _LikedByRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikedByRepoProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LikedByRepoRef
    on AutoDisposeNotifierProviderRef<CollectionReference<LikedBy>> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _LikedByRepoProviderElement extends AutoDisposeNotifierProviderElement<
    LikedByRepo, CollectionReference<LikedBy>> with LikedByRepoRef {
  _LikedByRepoProviderElement(super.provider);

  @override
  String get taskId => (origin as LikedByRepoProvider).taskId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
