import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';

class FirebaseUtils {

  static CollectionReference<Task> getTasksCollection(){
    return  FirebaseFirestore.instance.collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,options) => task.toFireStore()
    );
  }

  static Future<void> addTaskToFireStore(Task task){
    var taskCollectionRef = getTasksCollection();     //collection
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();    //document
    task.id = taskDocRef.id;   //auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task){
    return getTasksCollection().doc(task.id).delete();
  }
}
// {} JSON object
// [] JSON array
