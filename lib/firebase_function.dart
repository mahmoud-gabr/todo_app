import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) => UserModel.fromJson(
              docSnapshot.data()!,
            ),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

  static CollectionReference<TaskModel> getTasksCollection(String userId) =>
      getUsersCollection()
          .doc(userId)
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) => TaskModel.fromJson(
              docSnapshot.data()!,
            ),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTaskToFirestore(
      {required TaskModel taskModel, required String userId}) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    DocumentReference<TaskModel> docRef = tasksCollection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getAllTasksFromFirebase(String userId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(
      String taskId, String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    return taskCollection.doc(taskId).delete();
  }

  static Future<TaskModel> getTaskById(String taskId, String userId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    DocumentSnapshot<TaskModel> docSnapshot =
        await tasksCollection.doc(taskId).get();
    return docSnapshot.data()!;
  }

  static Future<void> updateTaskInFirestore(
      {required TaskModel taskModel, required String userId}) async {
    CollectionReference<TaskModel> tasksCollection =
        getTasksCollection(taskModel.id);
    DocumentReference<TaskModel> docRef = tasksCollection.doc(taskModel.id);
    await docRef.update(taskModel.toJson());
  }

  static Future<bool> getIsDoneStatus(
      {required String taskId, required String userId}) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    DocumentSnapshot<TaskModel> docSnapshot =
        await tasksCollection.doc(taskId).get();
    bool isDone = docSnapshot.get('isDone');
    return isDone;
  }

  static Future<void> updateIsDoneStatus({
    required String taskId,
    required bool isDone,
    required userId,
  }) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    await tasksCollection.doc(taskId).update(
      {
        'isDone': isDone,
      },
    );
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
    );
    final CollectionReference<UserModel> userCollection = getUsersCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final CollectionReference<UserModel> userCollection = getUsersCollection();
    final DocumentSnapshot<UserModel> docSnapshot =
        await userCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static void logout() => FirebaseAuth.instance.signOut();
}
