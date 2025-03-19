import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/presentation/blocs/global_auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/entites/user.dart';
part 'sign_up_state.dart';


class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit(this.authRepository) : super(SignUpInitialState());


  Future<void> userSignUp({required String userEmail,required String firstName,required String lastName,required String mobile, required String password}) async {
    emit(SignUpLoadingState());

    final result = await authRepository.signUp(userEmail,firstName,lastName,mobile,password);

    result.fold(
          (failure) {
        emit(SignUpFailureState(failure.message));
      },
          (success) {
        if (success) {
          emit(const SignUpSuccessState());
        } else {
          emit(const SignUpFailureState('Sign Up  failed.'));
        }
      },
    );
  }


}