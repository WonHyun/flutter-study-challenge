class PinVerifyState {
  final String pin;
  final bool isVerified;
  final bool isVerifying;

  const PinVerifyState({
    this.pin = "",
    this.isVerified = false,
    this.isVerifying = false,
  });

  PinVerifyState copyWith({
    String? pin,
    bool? isVerified,
    bool? isVerifying,
  }) {
    return PinVerifyState(
      pin: pin ?? this.pin,
      isVerified: isVerified ?? this.isVerified,
      isVerifying: isVerifying ?? this.isVerifying,
    );
  }
}
