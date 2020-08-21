import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanSummary extends StatelessWidget {
  const LoanSummary({
    Key key,
    @required this.formatter,
    @required this.interest,
    @required this.fee,
    @required this.proposedLoan,
    @required this.installment,
    @required this.adminFee,
    @required this.fundToTransfer,
  })  : assert(formatter != null),
        assert(interest != null),
        assert(fee != null),
        assert(proposedLoan != null),
        assert(installment != null),
        assert(adminFee != null),
        assert(fundToTransfer != null),
        super(key: key);

  final NumberFormat formatter;
  final double interest;
  final double fee;
  final double proposedLoan;
  final double installment;
  final double adminFee;
  final double fundToTransfer;

  @override
  Widget build(BuildContext context) {
    String _proposedLoan = formatter.format(this.proposedLoan);
    String _monthlyInstallment = formatter.format(this.installment);
    String _adminFee = formatter.format(this.adminFee);
    String _fundToTransfer = formatter.format(this.fundToTransfer);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Proposed Loan'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              _proposedLoan,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Monthly Installment'),
                Text(_monthlyInstallment),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Interest ($interest%)',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Admin Fee ($fee%)'),
                Text(_adminFee),
              ],
            ),
          ),
          Divider(
            height: 30.0,
            color: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fund to transfer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _fundToTransfer,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
