import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/preferences/preferences_event.dart';
import 'package:lunari/presentation/blocs/preferences/preferences_state.dart';
import '../../../core/utils/storage_utils.dart';
import '../../../data/repositories/preferences_repository.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _repo;

  @override
  void onTransition(Transition<PreferencesEvent, PreferencesState> transition) {
    super.onTransition(transition);
    if (transition.event is LoadPreferences) {
      _calculateCacheSize();
    }
  }

  Future<void> _calculateCacheSize() async {
    final sharedPrefsSize = await StorageUtils.calculateSharedPreferencesSize();
    final cacheSize = await StorageUtils.calculateAppCacheSize();
    final totalSize = sharedPrefsSize + cacheSize;

    add(CacheSizeCalculated(totalSize));
  }

  PreferencesBloc(this._repo) : super(const PreferencesState()) {
    on<LoadPreferences>(_onLoadPreferences);
    on<WeightUnitChanged>(_onWeightUnitChanged);
    on<HeightUnitChanged>(_onHeightUnitChanged);
    on<TemperatureUnitChanged>(_onTemperatureUnitChanged);
    on<WaterGoalChanged>(_onWaterGoalChanged);
    on<CupUnitChanged>(_onCupUnitChanged);
    on<FirstDayChanged>(_onFirstDayChanged);
    on<TimeFormatChanged>(_onTimeFormatChanged);
    on<BmiToggled>(_onBmiToggled);
    on<DayResetTimeChanged>(_onDayResetTimeChanged);
    on<CacheSizeCalculated>(_onCacheSizeCalculated);
  }

  Future<void> _onCacheSizeCalculated(
      CacheSizeCalculated event,
      Emitter<PreferencesState> emit,
      ) async {
    emit(state.copyWith(cacheSizeMB: event.sizeMB));
  }

  Future<void> _onLoadPreferences(
      LoadPreferences event, Emitter<PreferencesState> emit) async {
    final prefs = await _repo.loadPreferences();
    emit(prefs);
  }

  Future<void> _onWeightUnitChanged(
      WeightUnitChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(weightUnit: event.value));
    await _repo.savePreference(PreferencesRepository.keyWeight, event.value);
  }

  Future<void> _onHeightUnitChanged(
      HeightUnitChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(heightUnit: event.value));
    await _repo.savePreference(PreferencesRepository.keyHeight, event.value);
  }

  Future<void> _onTemperatureUnitChanged(
      TemperatureUnitChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(temperatureUnit: event.value));
    await _repo.savePreference(PreferencesRepository.keyTemperature, event.value);
  }

  Future<void> _onWaterGoalChanged(
      WaterGoalChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(waterGoal: event.value));
    await _repo.savePreference(PreferencesRepository.keyWaterGoal, event.value);
  }

  Future<void> _onCupUnitChanged(
      CupUnitChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(cupUnit: event.value));
    await _repo.savePreference(PreferencesRepository.keyCup, event.value);
  }

  Future<void> _onFirstDayChanged(
      FirstDayChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(firstDay: event.value));
    await _repo.savePreference(PreferencesRepository.keyFirstDay, event.value);
  }

  Future<void> _onTimeFormatChanged(
      TimeFormatChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(timeFormat: event.value));
    await _repo.savePreference(PreferencesRepository.keyTimeFormat, event.value);
  }

  Future<void> _onBmiToggled(
      BmiToggled event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(isBmiEnabled: event.value));
    await _repo.savePreference(PreferencesRepository.keyBmi, event.value);
  }

  Future<void> _onDayResetTimeChanged(
      DayResetTimeChanged event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(dayResetTimeInMinutes: event.value));
    await _repo.savePreference(PreferencesRepository.keyDayReset, event.value);
  }

}
