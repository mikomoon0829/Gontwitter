class FirebaseUsersKey {
  //Userコレクション関連
  static String usersCollection = 'users';
  static String userId = 'userId';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';
  static String userName = 'userName';
  static String imageUrl = 'imageUrl';
  static String profile = 'profile';
}

class FirebasePostsKey {
  //tasksコレクション関連
  static String postsCollection = 'posts';
  static String postId = 'postId';
  static String userId = 'userId';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';
  static String imageUrl = 'imageUrl';
  static String postText = 'postText';
}

class FirebaseLikedByKey {
  //usersコレクション関連
  static String likedByCollection = 'likedBy';
  static String likedById = 'likedById';

  static String userId = 'userId';
  static String postId = 'postId';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';
}

class FirebaseSavePostsKey {
  //usersコレクション関連
  static String savePostsCollection = 'savePosts';

  static String savePostId = 'savePostId';
  static String userId = 'userId';
  static String postId = 'postId';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';
}
