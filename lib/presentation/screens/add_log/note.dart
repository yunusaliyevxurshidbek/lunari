import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_cubit.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_state.dart';
import 'package:lunari/presentation/screens/add_log/widget/background_box.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    final initialText = context.read<AddLogCubit>().state.note;
    noteController = TextEditingController(text: initialText);

    noteController.addListener(() {
      context.read<AddLogCubit>().updateNote(noteController.text);
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLogCubit, AddLogState>(
      builder: (context, state) {
        if (state.note != noteController.text) {
          noteController.text = state.note;
          noteController.selection = TextSelection.fromPosition(
            TextPosition(offset: noteController.text.length),
          );
        }

        return BackgroundBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15, top: 15),
                child: Text(
                  "Note".tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Add your note here...'.tr(),
                    labelStyle: const TextStyle(color: Colors.black54),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

