import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/presentation/blocs/global_auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/entites/user.dart';
part 'sign_up_state.dart';


class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  final GlobalAuthCubit authCubit;

  SignUpCubit(this.authRepository, this.authCubit) : super(SignUpInitialState());

  Future<void> userSignUp({required String userName, required String password}) async {
    emit(SignUpLoadingState());
    final response = await authRepository.signIn(userName, password);
    await response.fold(
          (error) {
        emit(SignUpFailureState(error.message));
      },
          (loginData) async {
        await authCubit.initialize();
        emit(SignUpSuccessState(loginData));
      },
    );
  }
}