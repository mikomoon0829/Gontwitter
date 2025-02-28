// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_by_collection_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myLikedBysStreamHash() => r'b5d15ec73ffb2cb6a3c08b766d0a6393c76af034';

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

/// See also [myLikedBysStream].
@ProviderFor(myLikedBysStream)
const myLikedBysStreamProvider = MyLikedBysStreamFamily();

/// See also [myLikedBysStream].
class MyLikedBysStreamFamily extends Family<AsyncValue<List<LikedBy>>> {
  /// See also [myLikedBysStream].
  const MyLikedBysStreamFamily();

  /// See also [myLikedBysStream].
  MyLikedBysStreamProvider call(
    String postId,
  ) {
    return MyLikedBysStreamProvider(
      postId,
    );
  }

  @override
  MyLikedBysStreamProvider getProviderOverride(
    covariant MyLikedBysStreamProvider provider,
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
  String? get name => r'myLikedBysStreamProvider';
}

/// See also [myLikedBysStream].
class MyLikedBysStreamProvider
    extends AutoDisposeStreamProvider<List<LikedBy>> {
  /// See also [myLikedBysStream].
  MyLikedBysStreamProvider(
    String postId,
  ) : this._internal(
          (ref) => myLikedBysStream(
            ref as MyLikedBysStreamRef,
            postId,
          ),
          from: myLikedBysStreamProvider,
          name: r'myLikedBysStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myLikedBysStreamHash,
          dependencies: MyLikedBysStreamFamily._dependencies,
          allTransitiveDependencies:
              MyLikedBysStreamFamily._allTransitiveDependencies,
          postId: postId,
        );

  MyLikedBysStreamProvider._internal(
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
    Stream<List<LikedBy>> Function(MyLikedBysStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyLikedBysStreamProvider._internal(
        (ref) => create(ref as MyLikedBysStreamRef),
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
    return _MyLikedBysStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyLikedBysStreamProvider && other.postId == postId;
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
mixin MyLikedBysStreamRef on AutoDisposeStreamProviderRef<List<LikedBy>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _MyLikedBysStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<LikedBy>>
    with MyLikedBysStreamRef {
  _MyLikedBysStreamProviderElement(super.provider);

  @override
  String get postId => (origin as MyLikedBysStreamProvider).postId;
}

String _$likedByCollectionGroupRepoHash() =>
    r'45824ef3bc1804e31be19d743e02cc4eb93b6dd0';

/// See also [LikedByCollectionGroupRepo].
@ProviderFor(LikedByCollectionGroupRepo)
final likedByCollectionGroupRepoProvider = AutoDisposeNotifierProvider<
    LikedByCollectionGroupRepo, Query<LikedBy>>.internal(
  LikedByCollectionGroupRepo.new,
  name: r'likedByCollectionGroupRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likedByCollectionGroupRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LikedByCollectionGroupRepo = AutoDisposeNotifier<Query<LikedBy>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
