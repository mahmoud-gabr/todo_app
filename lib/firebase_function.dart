import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<TaskModel>(
          fromFirestore: (docSnapshot, _) => TaskModel.fromJson(
            docSnapshot.data()!,
          ),
          toFirestore: (taskModel, _) => taskModel.toJson(),
        );
  }

  static Future<void> addTaskToFirestore({required TaskModel taskModel}) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    DocumentReference<TaskModel> docRef = tasksCollection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getAllTasksFromFirebase() async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<TaskModel> getTaskById(String taskId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    DocumentSnapshot<TaskModel> docSnapshot =
        await tasksCollection.doc(taskId).get();
    return docSnapshot.data()!;
  }

  static Future<void> updateTaskInFirestore(
      {required TaskModel taskModel}) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    DocumentReference<TaskModel> docRef = tasksCollection.doc(taskModel.id);
    await docRef.update(taskModel.toJson());
  }
}
