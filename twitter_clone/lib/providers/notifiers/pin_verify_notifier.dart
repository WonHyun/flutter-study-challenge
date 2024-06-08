import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/states/pin_verify_state.dart';
import 'package:twitter_clone/tests/mock.dart';

class PinVerifyNotifier extends StateNotifier<PinVerifyState> {
  PinVerifyNotifier(super.state);

  Future<void> verifyPin(String pin) async {
    updateCode(pin);
    updateIsVerifying(true);
    //TODO: verifying code logic (await)
    await Future.delayed(const Duration(seconds: 3));
    updateIsVerifying(false);
    updateIsVerified(state.pin == testConfirmationPin);
  }

  void resetVerifyState() {
    updateCode("");
    updateIsVerified(false);
    updateIsVerifying(false);
  }

  void updateCode(String pin) {
    state = state.copyWith(pin: pin);
  }

  void updateIsVerified(bool isVerified) {
    state = state.copyWith(isVerified: isVerified);
  }

  void updateIsVerifying(bool isVerifying) {
    state = state.copyWith(isVerifying: isVerifying);
  }
}
