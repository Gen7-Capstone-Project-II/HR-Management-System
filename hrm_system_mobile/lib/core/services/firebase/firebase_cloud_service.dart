// // ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:human_resource_management_system/core/consts/app_const.dart';
// import 'package:human_resource_management_system/core/consts/firebase_const.dart';
// import 'package:human_resource_management_system/core/enums/enums.dart';
// import 'package:human_resource_management_system/core/helpers/date_helper.dart';
// import 'package:human_resource_management_system/core/helpers/file_helper.dart';
// import 'package:human_resource_management_system/core/helpers/token_helper.dart';
// import 'package:human_resource_management_system/core/services/http/http_config.dart';
// import 'package:human_resource_management_system/core/widgets/chat_widget/models/chat_message.dart';
// import 'package:path/path.dart' as path;
// import '../../../modules/user/models/user_model.dart';
// import 'firebase_service.dart';

// abstract class FirebaseContentModel {
//   bool? isProductionMode;
//   Map<String?, dynamic> toJson();
// }

// /*
//  * FirebaseUserModel
//  */
// class FirebaseUserModel extends FirebaseContentModel {
//   String? id;
//   String? name;
//   String? nameEn;
//   String? gender;
//   String? gateway;
//   String? deviceToken;
//   String? chattingWith;
//   bool? isActive;
//   String? avatar;
//   Color? color;
//   Color? containerColor;
//   String? lastLoginDate;

//   FirebaseUserModel({this.id, this.name, this.nameEn, this.gender, this.gateway, this.deviceToken, this.chattingWith, this.isActive, this.color, this.containerColor, this.avatar, this.lastLoginDate});

//   factory FirebaseUserModel.fromJson(Map<String?, dynamic> json) => FirebaseUserModel(
//         id: json["id"] ??= "",
//         name: json["name"] ??= "",
//         nameEn: json["nameEn"] ??= "",
//         gender: json["gender"] ??= "",
//         avatar: json['avatar'] ??= "",
//         gateway: json["gateway"] ??= "",
//         deviceToken: json["deviceToken"] ??= "",
//         chattingWith: json["chattingWith"] ??= "",
//         isActive: json["isActive"] ??= false,
//         containerColor: json['containerColor'] != null ? Color(json['containerColor']) : null,
//         color: json['color'] != null ? Color(json['color']) : null,
//         lastLoginDate: json['lastLoginDate'],
//       );

//   @override
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "nameEn": nameEn,
//         "gender": gender,
//         "avatar": avatar,
//         "gateway": gateway,
//         "deviceToken": deviceToken,
//         "chattingWith": chattingWith,
//         "isActive": isActive,
//         'containerColor': containerColor != null ? containerColor!.value : null,
//         'color': color != null ? color!.value : null,
//         'lastLoginDate': lastLoginDate,
//         'isProductionMode': AppConst.APP_PRODUCTION_MODE
//       };
// }

// /*
//  * FirebaseUserLoginHistory
//  */
// class FirebaseUserLoginHistory {
//   FirebaseUserLoginHistory({
//     this.userId,
//     this.date,
//     this.deviceName,
//     this.devicePlatform,
//     this.deviceToken,
//     this.ipAddress,
//     this.latitude,
//     this.longitude,
//   });

//   String? userId;
//   String? date;
//   String? deviceName;
//   String? devicePlatform;
//   String? deviceToken;
//   String? ipAddress;
//   double? latitude;
//   double? longitude;

//   factory FirebaseUserLoginHistory.fromRawJson(String? str) => FirebaseUserLoginHistory.fromJson(json.decode(str!));

//   String? toRawJson() => json.encode(toJson());

//   factory FirebaseUserLoginHistory.fromJson(Map<String?, dynamic> json) => FirebaseUserLoginHistory(
//         userId: json["user_id"],
//         date: json["date"],
//         deviceName: json["device_name"],
//         devicePlatform: json["device_platform"],
//         deviceToken: json["device_token"],
//         ipAddress: json["ip_address"],
//         // ignore: prefer_null_aware_operators
//         latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
//         // ignore: prefer_null_aware_operators
//         longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
//       );

//   Map<String?, dynamic> toJson() => {
//         "user_id": userId,
//         "date": date,
//         "device_name": deviceName,
//         "device_platform": devicePlatform,
//         "device_token": deviceToken,
//         "ip_address": ipAddress,
//         "latitude": latitude,
//         "longitude": longitude,
//       };
// }

// /*
//  * FirebaseVideoTutorialModel
//  */
// class FirebaseVideoTutorialModel extends FirebaseContentModel {
//   String? title;
//   String? titleEn;
//   String? videoUrl;
//   int? actorType;
//   int? sortIndex;

//   FirebaseVideoTutorialModel({this.title, this.titleEn, this.videoUrl, this.actorType, this.sortIndex});

//   factory FirebaseVideoTutorialModel.fromJson(Map<String?, dynamic> json) => FirebaseVideoTutorialModel(
//         title: json["title"],
//         titleEn: json["titleEn"],
//         videoUrl: json["videoUrl"],
//         actorType: json["actorType"],
//         sortIndex: json["sortIndex"],
//       );

//   @override
//   Map<String?, dynamic> toJson() => {"title": title, "titleEn": titleEn, "videoUrl": videoUrl, "actorType": actorType, "sortIndex": sortIndex, "isProductionMode": AppConst.APP_PRODUCTION_MODE};
// }

// class FirebaseRecentChatUserModel extends FirebaseContentModel {
//   String? idFrom;
//   String? idTo;
//   ChatMessage? message;
//   DateTime? date;

//   FirebaseRecentChatUserModel({this.idFrom, this.idTo, this.message, this.date});

//   factory FirebaseRecentChatUserModel.fromJson(Map<String?, dynamic> json) => FirebaseRecentChatUserModel(
//         idFrom: json["idFrom"],
//         idTo: json["idTo"],
//         message: json["message"] == null ? null : ChatMessage.fromJson(json["message"]),
//         date: json["date"] == null ? null : DateTime.parse(json['date']),
//       );

//   @override
//   Map<String, dynamic> toJson() => {
//         "idFrom": idFrom,
//         "idTo": idTo,
//         "message": message == null ? null : message!.toJson(),
//         "date": date == null ? null : date!.toIso8601String(),
//       };
// }

// class FirebaseChatGroupModel {
//   FirebaseChatGroupModel({
//     this.groupId,
//     this.groupName,
//     this.groupIcon,
//     this.admin,
//     this.recentMessage,
//     this.recentMessageSender,
//     this.recentMessageTime,
//     this.createdAt,
//     this.isGroupActive,
//     this.members,
//   });

//   String? groupId;
//   String? groupName;
//   String? groupIcon;
//   String? admin;
//   String? recentMessage;
//   String? recentMessageSender;
//   DateTime? recentMessageTime;
//   DateTime? createdAt;
//   bool? isGroupActive;
//   List<String>? members;

//   factory FirebaseChatGroupModel.fromJson(Map<String, dynamic> json) => FirebaseChatGroupModel(
//         groupId: json["groupId"],
//         groupName: json["groupName"],
//         groupIcon: json["groupIcon"],
//         admin: json["admin"],
//         recentMessage: json["recentMessage"],
//         recentMessageSender: json["recentMessageSender"] == "" ? null : json["recentMessageSender"],
//         recentMessageTime: json["recentMessageTime"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["recentMessageTime"]),
//         createdAt: json["createdAt"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
//         isGroupActive: json["isGroupActive"] ??= true,
//         members: json["members"] == null ? null : List<String>.from(json["members"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "groupId": groupId,
//         "groupName": groupName,
//         "groupIcon": groupIcon,
//         "admin": admin,
//         "recentMessage": recentMessage ??= "",
//         "recentMessageSender": recentMessageSender ??= "",
//         "recentMessageTime": recentMessageTime == null ? DateTime.now().millisecondsSinceEpoch : recentMessageTime!.millisecondsSinceEpoch,
//         "createdAt": createdAt == null ? null : createdAt!.millisecondsSinceEpoch,
//         "isGroupActive": isGroupActive,
//         "members": members == null ? null : List<dynamic>.from(members!.map((x) => x)),
//       };
// }

// class FirebaseChatGroupMemberModel {
//   FirebaseChatGroupMemberModel({
//     this.userId,
//     this.userName,
//     this.userProfile,
//     this.groupChatId,
//     this.invitedBy,
//     this.joinedAt,
//     this.lastSeenMessage,
//     this.enableNotification,
//     this.lastSeenAt,
//   });

//   String? userId;
//   String? userName;
//   String? userProfile;
//   String? groupChatId;
//   String? invitedBy;
//   String? joinedAt;
//   String? lastSeenMessage;
//   bool? enableNotification;
//   DateTime? lastSeenAt;

//   factory FirebaseChatGroupMemberModel.fromJson(Map<String, dynamic> json) => FirebaseChatGroupMemberModel(
//         userId: json["userId"],
//         userName: json["userName"],
//         userProfile: json["userProfile"],
//         groupChatId: json["groupChatId"],
//         invitedBy: json["invitedBy"],
//         joinedAt: json["joinedAt"],
//         lastSeenMessage: json["lastSeenMessage"],
//         enableNotification: json["enableNotification"],
//         lastSeenAt: json["lastSeenAt"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json['lastSeenAt']),
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId ??= "",
//         "userName": userName ??= "",
//         "userProfile": userProfile ??= "",
//         "groupChatId": groupChatId ??= "",
//         "invitedBy": invitedBy ??= "",
//         "joinedAt": joinedAt ??= "",
//         "lastSeenMessage": lastSeenMessage ??= "",
//         "enableNotification": enableNotification ??= true,
//         "lastSeenAt": lastSeenAt == null ? DateTime.now().millisecondsSinceEpoch : lastSeenAt!.millisecondsSinceEpoch,
//       };
// }

// /*
//  * FirebaseCloudChatService
//  */
// class FirebaseCloudChatService {
//   static FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

//   /*
//    * 
//    */
//   static void addChatMessage(ChatMessage message, FirebaseRecentChatUserModel firebaseRecentChatUserModel, {Function? onComplete}) {
//     fireStore.collection(CHAT_COLLECTION).doc(DateTime.now().millisecondsSinceEpoch.toString()).set(message.toJson()).then((_) {
//       fireStore.collection(RECENT_CHAT_COLLECTION).where("message.$GROUP_CHAT_ID", isEqualTo: firebaseRecentChatUserModel.message!.groupChatId).get().then((querySnapshot) {
//         if (querySnapshot.docs.isNotEmpty) {
//           fireStore.collection(RECENT_CHAT_COLLECTION).doc(querySnapshot.docs[querySnapshot.docs.length - 1].id).update({
//             "message": firebaseRecentChatUserModel.message!.toJson(),
//           });
//         } else {
//           fireStore.collection(RECENT_CHAT_COLLECTION).doc(DateTime.now().millisecondsSinceEpoch.toString()).set(firebaseRecentChatUserModel.toJson());
//         }
//       });

//       Future.delayed(const Duration(seconds: 1), () {
//         if (onComplete != null) {
//           onComplete();
//         }
//       });
//     });
//   }

//   /*
//    * 
//    */
//   static Stream<QuerySnapshot> getChatCollection(String groupChatId, {bool isChatGroup = false}) {
//     if (isChatGroup) {
//       return fireStore.collection(CHAT_COLLECTION).where(GROUP_CHAT_ID, isEqualTo: groupChatId).snapshots();
//     } else {
//       return fireStore.collection(CHAT_COLLECTION).where(GROUP_CHAT_ID, isEqualTo: groupChatId).snapshots();
//     }
//   }

//   /*
//    *  filterId can be idFrom or idTo
//    */
//   static Stream<QuerySnapshot> getUserMessage(String filterID, String userId) {
//     return fireStore.collection(CHAT_COLLECTION).where(filterID, isEqualTo: userId).snapshots();
//   }

//   /*
//    * 
//    */
//   static Stream<QuerySnapshot> getRecentUserSendTo(String? userId) {
//     return fireStore.collection(RECENT_CHAT_COLLECTION).where(ID_FROM, isEqualTo: userId).snapshots();
//   }

//   /*
//    * 
//    */
//   static Stream<QuerySnapshot> getRecentUserSendFrom(String? userId) {
//     return fireStore.collection(RECENT_CHAT_COLLECTION).where(ID_TO, isEqualTo: userId).snapshots();
//   }

//   /*
//    * 
//    */
//   // static Stream<List<QuerySnapshot>> getRecentChatUser(String? userId) {
//   //   return CombineLatestStream.list([getRecentUserSendTo(userId), getRecentUserSendFrom(userId)]);
//   // }

//   static Future<List<FirebaseUserModel>> getRecentChatUsers(String? userId) async {
//     List<FirebaseUserModel> users = [];

//     QuerySnapshot querySnapshot = await fireStore.collection(CHAT_COLLECTION).where(ID_FROM, isEqualTo: userId).get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     List<ChatMessage> messages = documents.map((i) => ChatMessage.fromJson(i.data() as Map<String, dynamic>)).toList();

//     for (var message in messages) {
//       FirebaseUserModel chatUser = message.toUser!;
//       if (users.isNotEmpty) {
//         bool isFound = false;
//         for (var user in users) {
//           if (chatUser.id == user.id) {
//             isFound = true;
//             continue;
//           }
//         }
//         if (!isFound) {
//           users.add(chatUser);
//         }
//       } else {
//         users.add(chatUser);
//       }
//     }

//     querySnapshot = await fireStore.collection(CHAT_COLLECTION).where(ID_TO, isEqualTo: userId).get();
//     documents = querySnapshot.docs;
//     messages = documents.map((i) => ChatMessage.fromJson(i.data() as Map<String, dynamic>)).toList();

//     for (var message in messages) {
//       FirebaseUserModel chatUser = message.user!;
//       if (users.isNotEmpty) {
//         bool isFound = false;
//         for (var user in users) {
//           if (chatUser.id == user.id) {
//             isFound = true;
//             continue;
//           }
//         }
//         if (!isFound) {
//           users.add(chatUser);
//         }
//       } else {
//         users.add(chatUser);
//       }
//     }

//     return users;
//   }

//   /*
//    *  
//    */
//   static Stream<QuerySnapshot> getUserUnReadMessage(String? groupChatId, String? userId) {
//     return fireStore.collection(CHAT_COLLECTION).where(GROUP_CHAT_ID, isEqualTo: groupChatId).where(IS_READ, isEqualTo: false).where(USER_ID, isEqualTo: userId).snapshots();
//   }

//   /*
//    * 
//    */
//   static Stream<QuerySnapshot> getCountUserUnReadMessage(String? toUserId) {
//     return fireStore.collection(CHAT_COLLECTION).where(IS_READ, isEqualTo: false).where(ID_TO, isEqualTo: toUserId).snapshots();
//   }

//   /*
//    * 
//    */
//   static Future<bool?> uploadFile(String chatCollection, String userId, File fileUpload, {bool isVoice = false, Function(String fileName, String url)? onComplete}) async {
//     String? _fileName = path.basename(fileUpload.path);
//     Reference storageRef = firebaseStorage.ref().child(chatCollection).child(userId).child(path.basename(fileUpload.path));
//     UploadTask uploadTask = isVoice ? storageRef.putFile(fileUpload, SettableMetadata(contentType: 'wav')) : storageRef.putFile(fileUpload);

//     TaskSnapshot download = await uploadTask;
//     String? url = await download.ref.getDownloadURL();
//     if (onComplete != null) {
//       onComplete(_fileName, url);
//     }
//     return true;
//   }

//   /*
//    * Group chat service
//    */

//   static Stream<QuerySnapshot> getUserGroupChat(String userId) {
//     return fireStore.collection(CHAT_GROUP_COLLECTION).where("members", arrayContains: userId).snapshots();
//   }

//   static Stream<QuerySnapshot> getGroupChatMembers(String chatGroupId) {
//     return fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).snapshots();
//   }

//   static Stream<QuerySnapshot> getChatGroupMemberUnreadMessage(String chatGroupId, int lastSeenAt) {
//     return fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_COLLECTION).where("createdAt", isGreaterThan: lastSeenAt).snapshots();
//   }

//   static Stream<DocumentSnapshot>? getMemberGroupNotification(String chatGroupId, String memberId) {
//     if (chatGroupId != "") {
//       return fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).doc(memberId).snapshots();
//     }
//     return null;
//   }

//   static Future<int?> getChatGroupMemberLastSeen(String chatGroupId, String memberId) {
//     return fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).doc(memberId).get().then((DocumentSnapshot<Map<String, dynamic>> ds) {
//       if (ds.exists) {
//         Map<String, dynamic> data = ds.data()!;
//         return data['lastSeenAt'];
//       }
//       return null;
//     });
//   }

//   static Future<int> getUserUnreadChatGroupMessage(String chatGroupId, String userId) async {
//     int lastSeenTime = 0;
//     await getChatGroupMemberLastSeen(chatGroupId, userId).then((value) {
//       lastSeenTime = value ?? 0;
//     });
//     QuerySnapshot totalItems = await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_COLLECTION).where("createdAt", isGreaterThan: lastSeenTime).get();

//     return totalItems.docs.length;
//   }

//   static Future<int> getCountTotalUnreadChatGroupMessages(String userId) async {
//     int totalUnreadMessages = 0;

//     QuerySnapshot querySnapshot = await fireStore.collection(CHAT_GROUP_COLLECTION).where('members', arrayContains: userId).get();

//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     List<FirebaseChatGroupModel> messages = documents.map((i) => FirebaseChatGroupModel.fromJson(i.data() as Map<String, dynamic>)).toList();

//     for (int i = 0; i < messages.length; i++) {
//       await getUserUnreadChatGroupMessage(messages[i].groupId!, userId).then((value) {
//         totalUnreadMessages += value;
//       });
//     }
//     return totalUnreadMessages;
//   }

//   static void createGroupChat(FirebaseChatGroupModel groupChatModel, String adminName, {required List<FirebaseChatGroupMemberModel> memberList, Function? onComplete, bool isEdit = false}) {
//     if (!isEdit) {
//       fireStore.collection(CHAT_GROUP_COLLECTION).doc(groupChatModel.groupId).set(groupChatModel.toJson()).then((_) {
//         sendGroupMessage(
//           ChatMessage(
//             text: "$adminName has create group",
//             groupChatId: groupChatModel.groupId,
//             user: FirebaseUserModel(),
//             toUser: FirebaseUserModel(),
//             messageType: E_MESSAGE_TYPE.HISTORY.toString().split(".").last,
//           ),
//           groupChatModel.groupId!,
//           memberList[0].userId!,
//         );
//         addChatGroupMember(chatGroupId: groupChatModel.groupId!, adminName: adminName, memberList: memberList).then((_) {
//           if (onComplete != null) {
//             onComplete();
//           }
//         });
//       });
//     } else {
//       fireStore.collection(CHAT_GROUP_COLLECTION).doc(groupChatModel.groupId).update({
//         "groupName": groupChatModel.groupName,
//         "groupIcon": groupChatModel.groupIcon,
//       }).then((_) {
//         if (onComplete != null) {
//           onComplete();
//         }
//       });
//     }
//   }

//   static Future<void> addChatGroupMember({required String chatGroupId, required String adminName, required List<FirebaseChatGroupMemberModel> memberList}) async {
//     List<String> memberIds = [];
//     for (var element in memberList) {
//       memberIds.add(element.userId!);
//     }
//     fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).update({'members': FieldValue.arrayUnion(memberIds)});

//     for (int i = 0; i < memberList.length; i++) {
//       memberList[i].groupChatId = chatGroupId;
//       if (adminName != memberList[i].userName) {
//         sendGroupMessage(
//           ChatMessage(
//             text: "$adminName has invited ${memberList[i].userName}",
//             groupChatId: chatGroupId,
//             user: FirebaseUserModel(),
//             toUser: FirebaseUserModel(),
//             messageType: E_MESSAGE_TYPE.HISTORY.toString().split(".").last,
//           ),
//           chatGroupId,
//           memberList[0].userId!,
//         );
//       }
//       await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).doc(memberList[i].userId).set(memberList[i].toJson());
//     }
//   }

//   static Future<void> updateChatGroupMemberLastSeen({required String chatGroupId, required String memberId, required FirebaseChatGroupMemberModel memberModel}) async {
//     await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).doc(memberId).update({
//       "lastSeenAt": memberModel.lastSeenAt!.millisecondsSinceEpoch,
//       "lastSeenMessage": memberModel.lastSeenMessage,
//     });
//   }

//   static Future<void> enableGroupNotification(String chatGroupId, String memberId, bool enableGroupNotification) async {
//     await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).doc(memberId).update({
//       "enableNotification": enableGroupNotification,
//     });
//   }

//   static void sendGroupMessage(ChatMessage message, String chatGroupId, String userId, {Function? onComplete}) {
//     fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_COLLECTION).doc(DateTime.now().millisecondsSinceEpoch.toString()).set(message.toJson()).then((_) {
//       fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).update({
//         'recentMessage': message.text,
//         'recentMessageSender': message.user!.name,
//         'recentMessageTime': message.createdAt!.millisecondsSinceEpoch,
//       });

//       if (message.user!.id == userId) {
//         // update last seen for sender
//         updateChatGroupMemberLastSeen(
//           chatGroupId: chatGroupId,
//           memberId: userId,
//           memberModel: FirebaseChatGroupMemberModel(
//             lastSeenAt: message.createdAt,
//             lastSeenMessage: message.text,
//           ),
//         );
//       }
//       Future.delayed(const Duration(seconds: 1), () {
//         if (onComplete != null) {
//           onComplete();
//         }
//       });
//     });
//   }

//   static Future<void> disableChatGroup(String chatGroupId, {bool disable = false}) async {
//     await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).update({"isGroupActive": disable});
//   }

//   static Future<void> deleteChatGroupMember(String chatGroupId, String adminName, FirebaseChatGroupMemberModel memberModel, bool isAdminRemove) async {
//     String textMessage = "${memberModel.userName} has left the group";
//     if (isAdminRemove) {
//       textMessage = "$adminName has removed ${memberModel.userName}";
//     }
//     sendGroupMessage(
//       ChatMessage(
//         text: textMessage,
//         user: FirebaseUserModel(),
//         toUser: FirebaseUserModel(),
//         messageType: E_MESSAGE_TYPE.HISTORY.toString().split(".").last,
//       ),
//       chatGroupId,
//       memberModel.userId!,
//     );
//     await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).collection(CHAT_GROUP_MEMBERS).doc(memberModel.userId).delete();
//     await fireStore.collection(CHAT_GROUP_COLLECTION).doc(chatGroupId).update({
//       'members': FieldValue.arrayRemove([memberModel.userId])
//     });
//   }

//   static Future<bool> uploadGroupChatProfile({required String groupID, required File fileUpload, Function(String fileName, String url)? onComplete, bool isGroupProfile = false}) async {
//     String fileExtension = path.extension(path.basename(fileUpload.path)).toLowerCase();
//     String _fileName = path.basename(fileUpload.path);

//     Reference storageRef;
//     if (isGroupProfile) {
//       storageRef = firebaseStorage.ref().child(CHAT_GROUP_COLLECTION).child(groupID).child("$groupID$fileExtension");
//     } else {
//       if (FileHelper.isAllowFileExtension(FILE_AUDIO_EXT, fileExtension)) {
//         storageRef = firebaseStorage.ref().child(CHAT_GROUP_COLLECTION).child(groupID).child("voices").child(_fileName);
//       } else {
//         storageRef = firebaseStorage.ref().child(CHAT_GROUP_COLLECTION).child(groupID).child("files").child(_fileName);
//       }
//     }
//     UploadTask uploadTask = storageRef.putFile(fileUpload);

//     TaskSnapshot download = await uploadTask;
//     String url = await download.ref.getDownloadURL();
//     if (onComplete != null) {
//       onComplete(_fileName, url);
//     }
//     return true;
//   }
// }

// /*
//  * FirebaseCloudUserService
//  */
// class FirebaseCloudUserService {
//   static FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   /*
//    * 
//    */
//   static void updateActiveUser(UserModel userModel) async {
//     FirebaseUserModel firebaseUserModel = FirebaseUserModel(
//         id: userModel.idRef,
//         name: userModel.fullname,
//         nameEn: userModel.fullnameEn,
//         gateway: TokenHelper.getInstance().getKey(HttpConfig.CLIENT_GATEWAY_CODE),
//         gender: userModel.gender?.toString(),
//         isActive: true,
//         deviceToken: await firebaseNotifications.getDeviceToken(),
//         lastLoginDate: DateHelper.format(DateTime?.now(), DateHelper.timeFormatddMMyyyHHMMSSA));
//     await fireStore.collection(USER_COLLECTION).doc(userModel.idRef).set(firebaseUserModel.toJson());
//   }

//   static void updateUserLoginAddress(UserModel userModel) async {
//     //String? deviceIpAddress = await GetIp.ipAddress;
//     // Response<dynamic> response = await httpApiService.getDio().get("https://api.ipify.org?format=json");
//     // Map<String?, dynamic> addressInfo = response.data;

//     // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//     // Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

//     // FirebaseUserLoginHistory loginHistory = FirebaseUserLoginHistory(
//     //     userId: userModel.mobilerUserId,
//     //     date: DateHelper.format(DateTime?.now(), DateHelper.timeFormatddMMyyyHHMMSSA),
//     //     deviceName: firebaseNotifications.getDeviceName(),
//     //     devicePlatform: firebaseNotifications.getDeviceTokenPlatform(),
//     //     deviceToken: await firebaseNotifications.getDeviceToken(),
//     //     ipAddress: addressInfo != null ? addressInfo['ip'] : null,
//     //     latitude: position != null ? position.latitude : null,
//     //     longitude: position != null ? position.longitude : null);
//     // await fireStore.collection(USER_LOGIN_HISTORY_COLLECTION).document(DateTime?.now().millisecondsSinceEpoch.toString?()).setData(loginHistory.toJson());
//   }

//   /*
//    * 
//    */
//   static void updateChattingWithUser(String id, String withId) async {
//     fireStore.collection(USER_COLLECTION).doc(id).update(
//       {
//         CHATTING_WITH: withId,
//       },
//     );
//   }

//   /*
//    * 
//    */
//   static Future<void> deleteUserDocument(UserModel userModel) async {
//     await fireStore.collection(USER_COLLECTION).doc(userModel.idRef).delete();
//   }

//   /*
//    * 
//    */
//   static Future<List<FirebaseUserModel>> getActiveUsers() async {
//     print("Active Users");
//     QuerySnapshot querySnapshot = await fireStore.collection(USER_COLLECTION).where("isActive", isEqualTo: true).get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     print("Documents ${documents.length}");
//     if (documents.isNotEmpty) {
//       try {
//         print("Active ${documents.length}");
//         return documents.map((document) {
//           FirebaseUserModel user = FirebaseUserModel.fromJson(Map<String, dynamic>.from(document.data() as Map<String, dynamic>));
//           print("User ${user.name}");
//           return user;
//         }).toList();
//       } catch (e) {
//         print("Exception $e");
//         return [];
//       }
//     }
//     return [];
//   }

//   /*
//    * 
//    */
//   static Future<bool?> isUserActive(String? id) async {
//     QuerySnapshot querySnapshot = await fireStore.collection(USER_COLLECTION).where("id", isEqualTo: id).where("isActive", isEqualTo: true).get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     return documents.isNotEmpty;
//   }
// }
