import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichess_mobile/src/model/common/id.dart';
import 'package:lichess_mobile/src/model/puzzle/puzzle_difficulty.dart';
import 'package:lichess_mobile/src/model/settings/preferences.dart';
import 'package:lichess_mobile/src/model/settings/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'puzzle_preferences.freezed.dart';
part 'puzzle_preferences.g.dart';

@riverpod
class PuzzlePreferences extends _$PuzzlePreferences
    with SessionPreferencesStorage<PuzzlePrefs> {
  // ignore: avoid_public_notifier_properties
  @override
  final prefCategory = PrefCategory.puzzle;

  @override
  PuzzlePrefs build() {
    return fetch();
  }

  Future<void> setDifficulty(PuzzleDifficulty difficulty) async {
    save(state.copyWith(difficulty: difficulty));
  }

  Future<void> setAutoNext(bool autoNext) async {
    save(state.copyWith(autoNext: autoNext));
  }
}

@Freezed(fromJson: true, toJson: true)
class PuzzlePrefs with _$PuzzlePrefs implements SerializablePreferences {
  const factory PuzzlePrefs({
    required UserId? id,
    required PuzzleDifficulty difficulty,

    /// If `true`, will show next puzzle after successful completion. This has
    /// no effect on puzzle streaks, which always show next puzzle. Defaults to
    /// `false`.
    @Default(false) bool autoNext,
  }) = _PuzzlePrefs;

  factory PuzzlePrefs.defaults({UserId? id}) => PuzzlePrefs(
        id: id,
        difficulty: PuzzleDifficulty.normal,
        autoNext: false,
      );

  factory PuzzlePrefs.fromJson(Map<String, dynamic> json) =>
      _$PuzzlePrefsFromJson(json);
}
