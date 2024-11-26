import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grow_fund/models/fund_group.dart';

class DatabaseService {
  final String? uid;
  final String? fg_id;
  DatabaseService({this.uid, this.fg_id});

  // collection reference
  final CollectionReference fundGroupCollection =
      FirebaseFirestore.instance.collection('fund_group');

  Future<void> createFundGroup(int? fund, int? maxUsers, int? perGap) async {
    // Generate a new document reference to get its ID
    DocumentReference docRef = fundGroupCollection.doc();
    return await fundGroupCollection.doc().set({
      'fg_id': docRef.id, // Add the document ID as the 'id' field
      'manager': uid,
      'name': 'New Group',
      'fund': fund,
      'max_users': maxUsers,
      'per_gap': perGap,
    });
  }

  Future<void> updateFundGroup(String? name, int? fund, int? maxUsers,
      int? perGap, String? fg_id) async {
    try {
      // Query the Firestore collection to find the document with the specified fg_id
      QuerySnapshot query =
          await fundGroupCollection.where('fg_id', isEqualTo: fg_id).get();

      if (query.docs.isNotEmpty) {
        // Assuming fg_id is unique and there is only one matching document
        DocumentReference docRef = query.docs.first.reference;
        // Update the document
        await docRef.update({
          if (name != null) 'name': name,
          if (fund != null) 'fund': fund,
          if (maxUsers != null) 'max_users': maxUsers,
          if (perGap != null) 'per_gap': perGap,
        });

        print('Fund group updated successfully!');
      } else {
        print('No document found with fg_id: $fg_id');
      }
    } catch (e) {
      print('Error updating fund group: $e');
    }
  }

//manager group list form snapshots
  List<FundGroup> _managerGroupFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // Use doc.data() to access the data as a map
      final data = doc.data() as Map<String, dynamic>;

      return FundGroup(
        fg_id: data['fg_id'] ?? '',
        manager: data['manager'] ?? '',
        name: data['name'] ?? '',
        fund: data['fund'] ?? 0,
        maxUsers: data['max_users'] ?? 0,
        perGap: data['per_gap'] ?? 0,
      );
    }).toList(); // Convert Iterable to List
  }

//get manager group list
  Stream<List<FundGroup>> get getManagerGroup {
    return fundGroupCollection
        .where('manager', isEqualTo: uid)
        .snapshots()
        .map(_managerGroupFromSnapshot);
  }

  // //manager gp id form snapshots
  // List<FundGroup> _FundGroupFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     // Use doc.data() to access the data as a map
  //     final data = doc.data() as Map<String, dynamic>;

  //     return FundGroup(
  //       fg_id: data['id'] ?? '',
  //       manager: data['manager'] ?? '',
  //       name: data['name'] ?? '',
  //       fund: data['fund'] ?? 0,
  //       maxUsers: data['maxUsers'] ?? 0,
  //       perGap: data['perGap'] ?? 0,
  //     );
  //   }).toList(); // Convert Iterable to List
  // }

  // //get a fund group by fund group id
  // Stream<List<FundGroup>> get getFundGroupByFundGroupId {
  //   return fundGroupCollection
  //       .where('fg_id', isEqualTo: fg_id)
  //       .snapshots()
  //       .map(_FundGroupFromSnapshot);
  // }

  // Fetch a document by ID
  Future<Map<String, dynamic>?> getFundGroupById(String docId) async {
    try {
      // Reference the specific document
      DocumentSnapshot documentSnapshot =
          await fundGroupCollection.doc(docId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Return the document data as a map
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }
}
