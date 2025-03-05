// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_by_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likedBysStreamHash() => r'0a4794e850720ef6df28b1febf1528ae6ee3e91b';

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
    String postId,
  ) {
    return LikedBysStreamProvider(
      postId,
    );
  }

  @override
  LikedBysStreamProvider getProviderOverride(
    covariant LikedBysStreamProvider provider,
  ) {
    return call(
      provider.postId,
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
    String postId,
  ) : this._internal(
          (ref) => likedBysStream(
            ref as LikedBysStreamRef,
            postId,
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
          postId: postId,
        );

  LikedBysStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

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
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<LikedBy>> createElement() {
    return _LikedBysStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikedBysStreamProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LikedBysStreamRef on AutoDisposeStreamProviderRef<List<LikedBy>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _LikedBysStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<LikedBy>>
    with LikedBysStreamRef {
  _LikedBysStreamProviderElement(super.provider);

  @override
  String get postId => (origin as LikedBysStreamProvider).postId;
}

String _$likedByRepoHash() => r'67977a3a282865d3bc63e2f030945f9269c99ef5';

abstract class _$LikedByRepo
    extends BuildlessAutoDisposeNotifier<CollectionReference<LikedBy>> {
  late final String postId;

  CollectionReference<LikedBy> build(
    String postId,
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
    String postId,
  ) {
    return LikedByRepoProvider(
      postId,
    );
  }

  @override
  LikedByRepoProvider getProviderOverride(
    covariant LikedByRepoProvider provider,
  ) {
    return call(
      provider.postId,
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
    String postId,
  ) : this._internal(
          () => LikedByRepo()..postId = postId,
          from: likedByRepoProvider,
          name: r'likedByRepoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likedByRepoHash,
          dependencies: LikedByRepoFamily._dependencies,
          allTransitiveDependencies:
              LikedByRepoFamily._allTransitiveDependencies,
          postId: postId,
        );

  LikedByRepoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  CollectionReference<LikedBy> runNotifierBuild(
    covariant LikedByRepo notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(LikedByRepo Function() create) {
    return ProviderOverride(
      origin: this,
      override: LikedByRepoProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
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
    return other is LikedByRepoProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LikedByRepoRef
    on AutoDisposeNotifierProviderRef<CollectionReference<LikedBy>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _LikedByRepoProviderElement extends AutoDisposeNotifierProviderElement<
    LikedByRepo, CollectionReference<LikedBy>> with LikedByRepoRef {
  _LikedByRepoProviderElement(super.provider);

  @override
  String get postId => (origin as LikedByRepoProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
