class PinVerifyState {
  final String pin;
  final bool isVerified;
  final bool isVerifying;
  final String? errMsg;

  const PinVerifyState({
    this.pin = "",
    this.isVerified = false,
    this.isVerifying = false,
    this.errMsg,
  });

  PinVerifyState copyWith({
    String? pin,
    bool? isVerified,
    bool? isVerifying,
    String? errMsg,
  }) {
    return PinVerifyState(
      pin: pin ?? this.pin,
      isVerified: isVerified ?? this.isVerified,
      isVerifying: isVerifying ?? this.isVerifying,
      errMsg: errMsg ?? this.errMsg,
    );
  }
}
