// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_collection_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchMySavePostStreamHash() =>
    r'fb8a0f123dcaaee5b345d13f5ee368d5ea6cf9d7';

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

/// See also [watchMySavePostStream].
@ProviderFor(watchMySavePostStream)
const watchMySavePostStreamProvider = WatchMySavePostStreamFamily();

/// See also [watchMySavePostStream].
class WatchMySavePostStreamFamily extends Family<AsyncValue<List<SavePost>>> {
  /// See also [watchMySavePostStream].
  const WatchMySavePostStreamFamily();

  /// See also [watchMySavePostStream].
  WatchMySavePostStreamProvider call(
    String postId,
  ) {
    return WatchMySavePostStreamProvider(
      postId,
    );
  }

  @override
  WatchMySavePostStreamProvider getProviderOverride(
    covariant WatchMySavePostStreamProvider provider,
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
  String? get name => r'watchMySavePostStreamProvider';
}

/// See also [watchMySavePostStream].
class WatchMySavePostStreamProvider
    extends AutoDisposeStreamProvider<List<SavePost>> {
  /// See also [watchMySavePostStream].
  WatchMySavePostStreamProvider(
    String postId,
  ) : this._internal(
          (ref) => watchMySavePostStream(
            ref as WatchMySavePostStreamRef,
            postId,
          ),
          from: watchMySavePostStreamProvider,
          name: r'watchMySavePostStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchMySavePostStreamHash,
          dependencies: WatchMySavePostStreamFamily._dependencies,
          allTransitiveDependencies:
              WatchMySavePostStreamFamily._allTransitiveDependencies,
          postId: postId,
        );

  WatchMySavePostStreamProvider._internal(
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
    Stream<List<SavePost>> Function(WatchMySavePostStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchMySavePostStreamProvider._internal(
        (ref) => create(ref as WatchMySavePostStreamRef),
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
  AutoDisposeStreamProviderElement<List<SavePost>> createElement() {
    return _WatchMySavePostStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchMySavePostStreamProvider && other.postId == postId;
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
mixin WatchMySavePostStreamRef on AutoDisposeStreamProviderRef<List<SavePost>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _WatchMySavePostStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<SavePost>>
    with WatchMySavePostStreamRef {
  _WatchMySavePostStreamProviderElement(super.provider);

  @override
  String get postId => (origin as WatchMySavePostStreamProvider).postId;
}

String _$saveCollectionGroupRepoHash() =>
    r'fecfd085c1069f70644aa4095f258212abf174b2';

/// See also [SaveCollectionGroupRepo].
@ProviderFor(SaveCollectionGroupRepo)
final saveCollectionGroupRepoProvider = AutoDisposeNotifierProvider<
    SaveCollectionGroupRepo, Query<SavePost>>.internal(
  SaveCollectionGroupRepo.new,
  name: r'saveCollectionGroupRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveCollectionGroupRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveCollectionGroupRepo = AutoDisposeNotifier<Query<SavePost>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
