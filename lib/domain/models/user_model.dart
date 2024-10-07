class ProfileResponse {
  bool status;
  List<UserData>? data;
  String message;

  ProfileResponse(
      {required this.status, required this.data, required this.message});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'],
      data: List<UserData>.from(json['data'].map((x) => UserData.fromJson(x))),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((x) => x.toJson()).toList(),
      'message': message,
    };
  }
}

class UserData {
  int id;
  String kidName;
  String pFirstName;
  String pLastName;
  String country;
  String birthdate;
  String email;
  int userVerified;
  UserProfile? userProfile; // Nullable UserProfile
  List<UserTimeActive> userTimeActive;
  String? package;
  String? plan;
  String? startAt;
  String? endAt;
  int gender;

  UserData(
      {required this.id,
      required this.kidName,
      required this.pFirstName,
      required this.pLastName,
      required this.country,
      required this.birthdate,
      required this.email,
      required this.userVerified,
      this.userProfile, // userProfile is now nullable
      required this.userTimeActive,
      required this.package,
      required this.plan,
      required this.startAt,
      required this.endAt,
      required this.gender});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        kidName: json['kid_name'],
        pFirstName: json['p_first_name'],
        pLastName: json['p_last_name'],
        country: json['country'],
        birthdate: json['birthdate'],
        email: json['email'],
        userVerified: json['user_verified'],
        userProfile: json['user_profile'] != null
            ? UserProfile.fromJson(json['user_profile'])
            : null, // Handle null userProfile
        userTimeActive: List<UserTimeActive>.from(
            json['user_time_active'].map((x) => UserTimeActive.fromJson(x))),
        package: json['package'],
        plan: json['plan'],
        startAt: json['start_at'],
        endAt: json['end_at'],
        gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kid_name': kidName,
      'p_first_name': pFirstName,
      'p_last_name': pLastName,
      'country': country,
      'birthdate': birthdate,
      'email': email,
      'user_verified': userVerified,
      'user_profile': userProfile?.toJson(), // Handle null in toJson
      'user_time_active': userTimeActive.map((x) => x.toJson()).toList(),
      'package': package,
      'plan': plan,
      'start_at': startAt,
      'end_at': endAt,
      'gender': gender
    };
  }
}

class UserProfile {
  int id;
  int userId;
  String image;
  String cover;
  String? song;
  int songActive;
  String createdAt;
  String updatedAt;

  UserProfile({
    required this.id,
    required this.userId,
    required this.image,
    required this.cover,
    this.song,
    required this.songActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      userId: json['user_id'],
      image: json['image'] == ""
          ? "https://img.freepik.com/premium-vector/cute-boy-smiling-cartoon-kawaii-boy-illustration-boy-avatar-happy-kid_1001605-3453.jpg"
          : json['image'],
      cover: json['cover'] == ""
          ? "https://img.freepik.com/free-photo/3d-cartoon-background-children_23-2150473128.jpg"
          : json['cover'],
      song: json['song'],
      songActive: json['song_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'image': image,
      'cover': cover,
      'song': song,
      'song_active': songActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class UserTimeActive {
  int id;
  int userId;
  String start;
  String end;
  String createdAt;
  String updatedAt;

  UserTimeActive({
    required this.id,
    required this.userId,
    required this.start,
    required this.end,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserTimeActive.fromJson(Map<String, dynamic> json) {
    return UserTimeActive(
      id: json['id'],
      userId: json['user_id'],
      start: json['start'],
      end: json['end'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'start': start,
      'end': end,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
