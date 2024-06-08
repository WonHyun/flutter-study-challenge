import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/states/code_verify_state.dart';
import 'package:twitter_clone/tests/mock.dart';

class CodeVerifyNotifier extends StateNotifier<CodeVerifyState> {
  CodeVerifyNotifier(super.state);

  Future<void> verifyCode() async {
    updateIsVerifying(true);
    //TODO: verifying code logic (await)
    await Future.delayed(const Duration(seconds: 3));
    updateIsVerifying(false);
    updateIsVerified(state.code == testConfirmationCode);
  }

  void updateCode(String code) {
    state = state.copyWith(code: code);
  }

  void updateIsVerified(bool isVerified) {
    state = state.copyWith(isVerified: isVerified);
  }

  void updateIsVerifying(bool isVerifying) {
    state = state.copyWith(isVerifying: isVerifying);
  }
}
