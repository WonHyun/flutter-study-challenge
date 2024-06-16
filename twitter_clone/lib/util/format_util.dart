String formatNumberWithSuffix(int num) {
  if (num >= 100000000) {
    return '${(num / 100000000).toStringAsFixed(1)}B';
  } else if (num >= 1000000) {
    return '${(num / 1000000).toStringAsFixed(1)}M';
  } else if (num >= 1000) {
    return '${(num / 1000).toStringAsFixed(1)}K';
  } else {
    return num.toString();
  }
}
