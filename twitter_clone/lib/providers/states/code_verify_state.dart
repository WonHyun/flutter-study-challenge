class CodeVerifyState {
  final String code;
  final bool isVerified;
  final bool isVerifying;

  const CodeVerifyState({
    this.code = "",
    this.isVerified = false,
    this.isVerifying = false,
  });

  CodeVerifyState copyWith({
    String? code,
    bool? isVerified,
    bool? isVerifying,
  }) {
    return CodeVerifyState(
      code: code ?? this.code,
      isVerified: isVerified ?? this.isVerified,
      isVerifying: isVerifying ?? this.isVerifying,
    );
  }
}
