import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/task.dart';

class FirebaseUtils {

  static CollectionReference<Task> getTasksCollection(String uId){
    return getUsersCollection().doc(uId).collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,options) => task.toFireStore()
    );
  }

  static Future<void> addTaskToFireStore(Task task, String uId){
    var taskCollectionRef = getTasksCollection(uId);     //collection
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();    //document
    task.id = taskDocRef.id;   //auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId){
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
        fromFirestore: ((snapshot, options) => MyUser.fromFireStore(snapshot.data())),
        toFirestore: (myUser , options) => myUser.toFireStore()
    );
  }

   static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
   }

   static Future<MyUser?> readUserFromFireStore(String uId) async{
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
   }
}
// {} JSON object
// [] JSON array
