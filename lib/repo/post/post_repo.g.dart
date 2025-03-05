// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postStreamHash() => r'c0693c65c96f56fbd6257ef5174ccba2affb574a';

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

/// See also [postStream].
@ProviderFor(postStream)
const postStreamProvider = PostStreamFamily();

/// See also [postStream].
class PostStreamFamily extends Family<AsyncValue<Post>> {
  /// See also [postStream].
  const PostStreamFamily();

  /// See also [postStream].
  PostStreamProvider call(
    String postId,
  ) {
    return PostStreamProvider(
      postId,
    );
  }

  @override
  PostStreamProvider getProviderOverride(
    covariant PostStreamProvider provider,
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
  String? get name => r'postStreamProvider';
}

/// See also [postStream].
class PostStreamProvider extends AutoDisposeStreamProvider<Post> {
  /// See also [postStream].
  PostStreamProvider(
    String postId,
  ) : this._internal(
          (ref) => postStream(
            ref as PostStreamRef,
            postId,
          ),
          from: postStreamProvider,
          name: r'postStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postStreamHash,
          dependencies: PostStreamFamily._dependencies,
          allTransitiveDependencies:
              PostStreamFamily._allTransitiveDependencies,
          postId: postId,
        );

  PostStreamProvider._internal(
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
    Stream<Post> Function(PostStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostStreamProvider._internal(
        (ref) => create(ref as PostStreamRef),
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
  AutoDisposeStreamProviderElement<Post> createElement() {
    return _PostStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostStreamProvider && other.postId == postId;
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
mixin PostStreamRef on AutoDisposeStreamProviderRef<Post> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _PostStreamProviderElement extends AutoDisposeStreamProviderElement<Post>
    with PostStreamRef {
  _PostStreamProviderElement(super.provider);

  @override
  String get postId => (origin as PostStreamProvider).postId;
}

String _$postsStreamHash() => r'e8bc129ceaf1b04dfaae7951a0ec6fc6106f4170';

/// See also [postsStream].
@ProviderFor(postsStream)
final postsStreamProvider = AutoDisposeStreamProvider<List<Post>>.internal(
  postsStream,
  name: r'postsStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PostsStreamRef = AutoDisposeStreamProviderRef<List<Post>>;
String _$myPostsStreamHash() => r'1dc8cfeb8843827f1f39921ebf15ef5c9af1390b';

/// See also [myPostsStream].
@ProviderFor(myPostsStream)
final myPostsStreamProvider = AutoDisposeStreamProvider<List<Post>>.internal(
  myPostsStream,
  name: r'myPostsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myPostsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyPostsStreamRef = AutoDisposeStreamProviderRef<List<Post>>;
String _$postRepoHash() => r'514ccdd646a1266d52352e54931543badb7c8227';

/// See also [PostRepo].
@ProviderFor(PostRepo)
final postRepoProvider =
    AutoDisposeNotifierProvider<PostRepo, CollectionReference<Post>>.internal(
  PostRepo.new,
  name: r'postRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostRepo = AutoDisposeNotifier<CollectionReference<Post>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
