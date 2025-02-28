// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_collection_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mySavePostsStreamHash() => r'85e32578b0f6bd7ef704879d93371431a13c1ef8';

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

/// See also [mySavePostsStream].
@ProviderFor(mySavePostsStream)
const mySavePostsStreamProvider = MySavePostsStreamFamily();

/// See also [mySavePostsStream].
class MySavePostsStreamFamily extends Family<AsyncValue<List<SavePosts>>> {
  /// See also [mySavePostsStream].
  const MySavePostsStreamFamily();

  /// See also [mySavePostsStream].
  MySavePostsStreamProvider call(
    String postId,
  ) {
    return MySavePostsStreamProvider(
      postId,
    );
  }

  @override
  MySavePostsStreamProvider getProviderOverride(
    covariant MySavePostsStreamProvider provider,
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
  String? get name => r'mySavePostsStreamProvider';
}

/// See also [mySavePostsStream].
class MySavePostsStreamProvider
    extends AutoDisposeStreamProvider<List<SavePosts>> {
  /// See also [mySavePostsStream].
  MySavePostsStreamProvider(
    String postId,
  ) : this._internal(
          (ref) => mySavePostsStream(
            ref as MySavePostsStreamRef,
            postId,
          ),
          from: mySavePostsStreamProvider,
          name: r'mySavePostsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mySavePostsStreamHash,
          dependencies: MySavePostsStreamFamily._dependencies,
          allTransitiveDependencies:
              MySavePostsStreamFamily._allTransitiveDependencies,
          postId: postId,
        );

  MySavePostsStreamProvider._internal(
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
    Stream<List<SavePosts>> Function(MySavePostsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MySavePostsStreamProvider._internal(
        (ref) => create(ref as MySavePostsStreamRef),
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
  AutoDisposeStreamProviderElement<List<SavePosts>> createElement() {
    return _MySavePostsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MySavePostsStreamProvider && other.postId == postId;
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
mixin MySavePostsStreamRef on AutoDisposeStreamProviderRef<List<SavePosts>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _MySavePostsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<SavePosts>>
    with MySavePostsStreamRef {
  _MySavePostsStreamProviderElement(super.provider);

  @override
  String get postId => (origin as MySavePostsStreamProvider).postId;
}

String _$saveCollectionGroupRepoHash() =>
    r'8b1cf90f48df55dac033cd2899fdc8ec33c16243';

/// See also [SaveCollectionGroupRepo].
@ProviderFor(SaveCollectionGroupRepo)
final saveCollectionGroupRepoProvider = AutoDisposeNotifierProvider<
    SaveCollectionGroupRepo, Query<SavePosts>>.internal(
  SaveCollectionGroupRepo.new,
  name: r'saveCollectionGroupRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveCollectionGroupRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveCollectionGroupRepo = AutoDisposeNotifier<Query<SavePosts>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
