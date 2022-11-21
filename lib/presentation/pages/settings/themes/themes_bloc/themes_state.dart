part of 'themes_bloc.dart';

abstract class ThemesState extends Equatable {
  const ThemesState();

  @override
  List<Object> get props => [];
}

abstract class FailureState extends ThemesState {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

class ThemesInitial extends ThemesState {}

class FailureReadThemes extends FailureState {
  FailureReadThemes({required super.messageError});
}

class SuccessReadThemes extends ThemesState {
  // final bool result;
  final AppTheme result;

  SuccessReadThemes({required this.result});

  @override
  List<Object> get props => [result];
}

class SuccessUpdateThemes extends ThemesState {
  final bool result;

  SuccessUpdateThemes({required this.result});

  @override
  List<Object> get props => [result];
}

class SuccessChangeThemes extends ThemesState {
  final AppTheme appTheme;

  SuccessChangeThemes({required this.appTheme});

  @override
  List<Object> get props => [appTheme];
}

class FailureChangeThemes extends FailureState {
  FailureChangeThemes({required super.messageError});
}
