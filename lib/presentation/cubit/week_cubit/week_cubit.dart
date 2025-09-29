import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:lunari/presentation/cubit/week_cubit/week_state.dart';
import '../../../data/repositories/log_repository.dart';

class WeekCubit extends Cubit<WeekState> {
  final LogRepository _repo;
  final String _uid;

  WeekCubit({
    required LogRepository repo,
    required String uid,
  })  : _repo = repo,
        _uid = uid,
        super(WeekState(selectedDate: DateTime.now()));

  void loadLogsForCurrentWeek() => _fetchLogs();

  void previousWeek() {
    emit(state.copyWith(
      selectedDate: state.selectedDate.subtract(const Duration(days: 7)),
      isLoading: true,
      error: null,
    ));
    _fetchLogs();
  }

  void nextWeek() {
    emit(state.copyWith(
      selectedDate: state.selectedDate.add(const Duration(days: 7)),
      isLoading: true,
      error: null,
    ));
    _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    try {
      final logs = await _repo.fetchLogsForWeek(
        uid: _uid,
        startOfWeek: state.startOfWeek,
        endOfWeek: state.endOfWeek,
      );

      LogService.i('Week ${state.startOfWeek} – ${state.endOfWeek}');
      for (var log in logs) {
        LogService.i('• ${DateFormat('yyyy-MM-dd').format(log.date)} → '
            'temp=${log.temperature}, water=${log.totalWaterConsumed}, '
            'weight=${log.weight}');
      }

      emit(state.copyWith(
        logs: logs,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      LogService.e('Error fetching logs: ${e.toString()}');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}

