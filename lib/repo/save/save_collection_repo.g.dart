// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_collection_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ifISavePostsStreamHash() =>
    r'0dfa9a199b7f013858e91e026209c350ffdf0ebf';

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

/// See also [ifISavePostsStream].
@ProviderFor(ifISavePostsStream)
const ifISavePostsStreamProvider = IfISavePostsStreamFamily();

/// See also [ifISavePostsStream].
class IfISavePostsStreamFamily extends Family<AsyncValue<List<SavePost>>> {
  /// See also [ifISavePostsStream].
  const IfISavePostsStreamFamily();

  /// See also [ifISavePostsStream].
  IfISavePostsStreamProvider call(
    String postId,
  ) {
    return IfISavePostsStreamProvider(
      postId,
    );
  }

  @override
  IfISavePostsStreamProvider getProviderOverride(
    covariant IfISavePostsStreamProvider provider,
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
  String? get name => r'ifISavePostsStreamProvider';
}

/// See also [ifISavePostsStream].
class IfISavePostsStreamProvider
    extends AutoDisposeStreamProvider<List<SavePost>> {
  /// See also [ifISavePostsStream].
  IfISavePostsStreamProvider(
    String postId,
  ) : this._internal(
          (ref) => ifISavePostsStream(
            ref as IfISavePostsStreamRef,
            postId,
          ),
          from: ifISavePostsStreamProvider,
          name: r'ifISavePostsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ifISavePostsStreamHash,
          dependencies: IfISavePostsStreamFamily._dependencies,
          allTransitiveDependencies:
              IfISavePostsStreamFamily._allTransitiveDependencies,
          postId: postId,
        );

  IfISavePostsStreamProvider._internal(
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
    Stream<List<SavePost>> Function(IfISavePostsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IfISavePostsStreamProvider._internal(
        (ref) => create(ref as IfISavePostsStreamRef),
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
    return _IfISavePostsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IfISavePostsStreamProvider && other.postId == postId;
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
mixin IfISavePostsStreamRef on AutoDisposeStreamProviderRef<List<SavePost>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _IfISavePostsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<SavePost>>
    with IfISavePostsStreamRef {
  _IfISavePostsStreamProviderElement(super.provider);

  @override
  String get postId => (origin as IfISavePostsStreamProvider).postId;
}

String _$saveCollectionGroupRepoHash() =>
    r'e6b092743d8c5a7e6634e1414d8f651b7d76836e';

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
