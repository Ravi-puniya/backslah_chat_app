import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference groupcollectuion =
      FirebaseFirestore.instance.collection("group");

  Future updateUserData(String fullName, String email) async {
    return await usercollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await usercollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future getUsergroup() async {
    return usercollection.doc(uid).snapshots();
  }

  ///Creating a group
  Future creatGroup(String groupName, String id, String userName) async {
    DocumentReference GroupdocumentReference = await groupcollectuion.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
//update the member
    await GroupdocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": GroupdocumentReference.id,
    });

    DocumentReference userdocumentReference = usercollection.doc(uid);
    return await userdocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${GroupdocumentReference.id}_$groupName"])
    });
  }
}
