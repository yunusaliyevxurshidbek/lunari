import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/setup/setup_bloc.dart';

void saveToFirebase(BuildContext context) async {
  final setupBloc = context.read<SetupBloc>();
  final state = setupBloc.state;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in!"))
    );
    return;
  }

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'name': state.name,
    'birthday': state.birthday,
    'weight': state.weight,
    'height': state.height,
    'period': state.period,
    'cycle': state.cycleType ? state.cycleMin : [state.cycleMin, state.cycleMax],
    'last': state.last,
  },);

  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data saved!"))
  );
}
