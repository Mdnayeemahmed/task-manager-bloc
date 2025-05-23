part of 'splash_screen_cubit.dart';

// Define the different states for the splash screen.
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {}
