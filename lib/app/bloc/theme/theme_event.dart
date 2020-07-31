part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeSwitched extends ThemeEvent {
  final ThemeMode themeMode;
  ThemeSwitched({@required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
