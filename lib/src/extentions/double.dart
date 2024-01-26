extension DoubleToString on double {
  String amt() {
    return amount(prefix: '', sufix: '');
  }

  String amount({
    String prefix = '₹', //'\u20B9',
    String sufix = '',
  }) {
    return prefix + toStringAsFixed(2) + sufix;
  }

  String amountRounded({
    String prefix = '₹', //'\u20B9',
    String sufix = '',
  }) {
    return prefix + roundIf() + sufix;
  }

  String roundIf() {
    //if there is decimal points, return with 2 decimal, else return rounded.
    if (this % 1 != 0) {
      return toStringAsFixed(2);
    } else {
      return toStringAsFixed(0);
    }
  }
}
