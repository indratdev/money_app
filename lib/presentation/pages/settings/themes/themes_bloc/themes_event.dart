part of 'themes_bloc.dart';

abstract class ThemesEvent extends Equatable {
  const ThemesEvent();

  @override
  List<Object> get props => [];
}

class ReadThemesEvent extends ThemesEvent {}

class UpdateThemesEvent extends ThemesEvent {
  ThemesEnum value;

  UpdateThemesEvent({required this.value});
}
