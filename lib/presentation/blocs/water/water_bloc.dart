import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/water/water_event.dart';
import 'package:lunari/presentation/blocs/water/water_state.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WaterBloc() : super(const WaterState()) {
    on<AddWater>(_onAddWater);
    on<LoadWaterData>(_onLoadWaterData);
    on<UpdateWaterFromAddLog>(_onUpdateWaterFromAddLog);
  }

  void _onAddWater(AddWater event, Emitter<WaterState> emit) async {
    final newState = state.copyWith(
      totalWaterConsumed: state.totalWaterConsumed + event.amount,
      lastConsumedWater: event.amount,
      lastConsumedIcon: event.icon,
    );

    emit(newState);

    final user = _auth.currentUser;
    if (user != null) {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('AddLog')
          .doc(today)
          .set({
        'totalWaterConsumed': newState.totalWaterConsumed,
        'lastConsumedWater': newState.lastConsumedWater,
        'lastConsumedIcon': newState.lastConsumedIcon,
      }, SetOptions(merge: true));
    }
  }
  void _onLoadWaterData(LoadWaterData event, Emitter<WaterState> emit) async {
    final user = _auth.currentUser;
    if (user != null) {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('AddLog')
          .doc(today)
          .get();

      if (doc.exists) {
        final data = doc.data();
        emit(state.copyWith(
          totalWaterConsumed: data?['totalWaterConsumed'] ?? 0,
          lastConsumedWater: data?['lastConsumedWater'] ?? 0,
          lastConsumedIcon: data?['lastConsumedIcon'] ?? '',
        ));
      }
    }
  }


  void _onUpdateWaterFromAddLog(UpdateWaterFromAddLog event, Emitter<WaterState> emit) {
    emit(state.copyWith(
      totalWaterConsumed: event.totalWater,
      lastConsumedWater: event.lastConsumedWater,
      lastConsumedIcon: event.lastConsumedIcon,
    ));
  }
}