import 'dart:async';

import 'package:meta/meta.dart';
import 'package:timetrackerfirebase/Services/firestore_service.dart';
import 'package:timetrackerfirebase/app/home/models/job.dart';

import 'api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final DatabaseService _service = FirestoreService.instance;

  Future<void> createJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}

abstract class DatabaseService {
  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
  });
  Future<void> setData({String path, Map<String, dynamic> data});
}
