// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postRepositoryHash() => r'2d8787c62df4183bd518eb8900b05fb898e52e6e';

/// See also [postRepository].
@ProviderFor(postRepository)
final postRepositoryProvider = AutoDisposeProvider<PostService>.internal(
  postRepository,
  name: r'postRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PostRepositoryRef = AutoDisposeProviderRef<PostService>;
String _$postsHash() => r'1dceef07743722934974421362922b5bbe0682f9';

/// See also [posts].
@ProviderFor(posts)
final postsProvider = FutureProvider<List<Post>>.internal(
  posts,
  name: r'postsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PostsRef = FutureProviderRef<List<Post>>;
String _$usersPostsHash() => r'56941e57306456692dab9d33f07bbf7f1d18efe6';

/// See also [usersPosts].
@ProviderFor(usersPosts)
final usersPostsProvider = FutureProvider<List<Post>>.internal(
  usersPosts,
  name: r'usersPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UsersPostsRef = FutureProviderRef<List<Post>>;
String _$postByIdHash() => r'8bea99eedd7fb6e26f13b07840989d4e0cc233b2';

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

/// See also [postById].
@ProviderFor(postById)
const postByIdProvider = PostByIdFamily();

/// See also [postById].
class PostByIdFamily extends Family<AsyncValue<Post>> {
  /// See also [postById].
  const PostByIdFamily();

  /// See also [postById].
  PostByIdProvider call(
    String id,
  ) {
    return PostByIdProvider(
      id,
    );
  }

  @override
  PostByIdProvider getProviderOverride(
    covariant PostByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'postByIdProvider';
}

/// See also [postById].
class PostByIdProvider extends FutureProvider<Post> {
  /// See also [postById].
  PostByIdProvider(
    String id,
  ) : this._internal(
          (ref) => postById(
            ref as PostByIdRef,
            id,
          ),
          from: postByIdProvider,
          name: r'postByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postByIdHash,
          dependencies: PostByIdFamily._dependencies,
          allTransitiveDependencies: PostByIdFamily._allTransitiveDependencies,
          id: id,
        );

  PostByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Post> Function(PostByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostByIdProvider._internal(
        (ref) => create(ref as PostByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  FutureProviderElement<Post> createElement() {
    return _PostByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostByIdRef on FutureProviderRef<Post> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PostByIdProviderElement extends FutureProviderElement<Post>
    with PostByIdRef {
  _PostByIdProviderElement(super.provider);

  @override
  String get id => (origin as PostByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
