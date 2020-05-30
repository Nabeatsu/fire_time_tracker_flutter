import 'dart:async';

import 'package:meta/meta.dart';
import 'package:timetrackerfirebase/Services/firestore_service.dart';
import 'package:timetrackerfirebase/app/home/models/job.dart';

import 'api_path.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final DatabaseService _service = FirestoreService.instance;

  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );
}

abstract class DatabaseService {
  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
  });
  Future<void> setData({String path, Map<String, dynamic> data});
}
