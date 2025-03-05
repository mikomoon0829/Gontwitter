// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$savePostStreamHash() => r'1cef2df153dc3d29dfdb1e401ae13738769be859';

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

/// See also [savePostStream].
@ProviderFor(savePostStream)
const savePostStreamProvider = SavePostStreamFamily();

/// See also [savePostStream].
class SavePostStreamFamily extends Family<AsyncValue<SavePost>> {
  /// See also [savePostStream].
  const SavePostStreamFamily();

  /// See also [savePostStream].
  SavePostStreamProvider call(
    String postId,
    String userId,
  ) {
    return SavePostStreamProvider(
      postId,
      userId,
    );
  }

  @override
  SavePostStreamProvider getProviderOverride(
    covariant SavePostStreamProvider provider,
  ) {
    return call(
      provider.postId,
      provider.userId,
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
  String? get name => r'savePostStreamProvider';
}

/// See also [savePostStream].
class SavePostStreamProvider extends AutoDisposeStreamProvider<SavePost> {
  /// See also [savePostStream].
  SavePostStreamProvider(
    String postId,
    String userId,
  ) : this._internal(
          (ref) => savePostStream(
            ref as SavePostStreamRef,
            postId,
            userId,
          ),
          from: savePostStreamProvider,
          name: r'savePostStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$savePostStreamHash,
          dependencies: SavePostStreamFamily._dependencies,
          allTransitiveDependencies:
              SavePostStreamFamily._allTransitiveDependencies,
          postId: postId,
          userId: userId,
        );

  SavePostStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
    required this.userId,
  }) : super.internal();

  final String postId;
  final String userId;

  @override
  Override overrideWith(
    Stream<SavePost> Function(SavePostStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SavePostStreamProvider._internal(
        (ref) => create(ref as SavePostStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SavePost> createElement() {
    return _SavePostStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SavePostStreamProvider &&
        other.postId == postId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SavePostStreamRef on AutoDisposeStreamProviderRef<SavePost> {
  /// The parameter `postId` of this provider.
  String get postId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _SavePostStreamProviderElement
    extends AutoDisposeStreamProviderElement<SavePost> with SavePostStreamRef {
  _SavePostStreamProviderElement(super.provider);

  @override
  String get postId => (origin as SavePostStreamProvider).postId;
  @override
  String get userId => (origin as SavePostStreamProvider).userId;
}

String _$savePostsStreamHash() => r'e9ebb41e236dd0adedb0b0e8dd1e79fa29bae064';

/// See also [savePostsStream].
@ProviderFor(savePostsStream)
const savePostsStreamProvider = SavePostsStreamFamily();

/// See also [savePostsStream].
class SavePostsStreamFamily extends Family<AsyncValue<List<SavePost>>> {
  /// See also [savePostsStream].
  const SavePostsStreamFamily();

  /// See also [savePostsStream].
  SavePostsStreamProvider call(
    String userId,
  ) {
    return SavePostsStreamProvider(
      userId,
    );
  }

  @override
  SavePostsStreamProvider getProviderOverride(
    covariant SavePostsStreamProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'savePostsStreamProvider';
}

/// See also [savePostsStream].
class SavePostsStreamProvider
    extends AutoDisposeStreamProvider<List<SavePost>> {
  /// See also [savePostsStream].
  SavePostsStreamProvider(
    String userId,
  ) : this._internal(
          (ref) => savePostsStream(
            ref as SavePostsStreamRef,
            userId,
          ),
          from: savePostsStreamProvider,
          name: r'savePostsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$savePostsStreamHash,
          dependencies: SavePostsStreamFamily._dependencies,
          allTransitiveDependencies:
              SavePostsStreamFamily._allTransitiveDependencies,
          userId: userId,
        );

  SavePostsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<SavePost>> Function(SavePostsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SavePostsStreamProvider._internal(
        (ref) => create(ref as SavePostsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<SavePost>> createElement() {
    return _SavePostsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SavePostsStreamProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SavePostsStreamRef on AutoDisposeStreamProviderRef<List<SavePost>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _SavePostsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<SavePost>>
    with SavePostsStreamRef {
  _SavePostsStreamProviderElement(super.provider);

  @override
  String get userId => (origin as SavePostsStreamProvider).userId;
}

String _$saveRepoHash() => r'5dcc084aafbd3ac65a7468d9067f7fc390329737';

abstract class _$SaveRepo
    extends BuildlessAutoDisposeNotifier<CollectionReference<SavePost>> {
  late final String userId;

  CollectionReference<SavePost> build(
    String userId,
  );
}

/// See also [SaveRepo].
@ProviderFor(SaveRepo)
const saveRepoProvider = SaveRepoFamily();

/// See also [SaveRepo].
class SaveRepoFamily extends Family<CollectionReference<SavePost>> {
  /// See also [SaveRepo].
  const SaveRepoFamily();

  /// See also [SaveRepo].
  SaveRepoProvider call(
    String userId,
  ) {
    return SaveRepoProvider(
      userId,
    );
  }

  @override
  SaveRepoProvider getProviderOverride(
    covariant SaveRepoProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'saveRepoProvider';
}

/// See also [SaveRepo].
class SaveRepoProvider extends AutoDisposeNotifierProviderImpl<SaveRepo,
    CollectionReference<SavePost>> {
  /// See also [SaveRepo].
  SaveRepoProvider(
    String userId,
  ) : this._internal(
          () => SaveRepo()..userId = userId,
          from: saveRepoProvider,
          name: r'saveRepoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveRepoHash,
          dependencies: SaveRepoFamily._dependencies,
          allTransitiveDependencies: SaveRepoFamily._allTransitiveDependencies,
          userId: userId,
        );

  SaveRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  CollectionReference<SavePost> runNotifierBuild(
    covariant SaveRepo notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(SaveRepo Function() create) {
    return ProviderOverride(
      origin: this,
      override: SaveRepoProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SaveRepo, CollectionReference<SavePost>>
      createElement() {
    return _SaveRepoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveRepoProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SaveRepoRef
    on AutoDisposeNotifierProviderRef<CollectionReference<SavePost>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _SaveRepoProviderElement extends AutoDisposeNotifierProviderElement<
    SaveRepo, CollectionReference<SavePost>> with SaveRepoRef {
  _SaveRepoProviderElement(super.provider);

  @override
  String get userId => (origin as SaveRepoProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
