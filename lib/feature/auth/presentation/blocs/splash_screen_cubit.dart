import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../common/presentation/blocs/global_auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
part 'splash_screen_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;
  final GlobalAuthCubit authCubit;

  SplashCubit(this.authRepository,this.authCubit) : super(SplashInitial());

  Future<void> checkAuthentication() async {
    // Simulate a delay for splash screen.
    await Future.delayed(const Duration(seconds: 2));

    // Check if the user is logged in (you need to implement this check in AuthController).
    bool? isUserLoggedIn = await authRepository.isUserLogin();

    // Emit the corresponding state based on authentication status.
    if (isUserLoggedIn) {
      await authCubit.initialize();

      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
