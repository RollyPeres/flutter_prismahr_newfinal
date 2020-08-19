import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/loan_create/loan_create_bloc.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_searchable.dart';
import 'package:flutter_prismahr/app/components/selectable_outline_buttons.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/data/repositories/loan_purpose_repository.dart';
import 'package:flutter_prismahr/app/views/loan/widgets/loan_summary.dart';
import 'package:intl/intl.dart';

class LoanCreateScreen extends StatefulWidget {
  LoanCreateScreen({Key key}) : super(key: key);

  @override
  _LoanCreateScreenState createState() => _LoanCreateScreenState();
}

class _LoanCreateScreenState extends State<LoanCreateScreen> {
  List<LoanTenor> _loanTenors = <LoanTenor>[];
  LoanCreateBloc _loanCreateBloc;
  LoanFormValidationException _errors;
  LoanPurposeRepository _loanPurposeRepository;
  LoanPurpose _selectedLoanPurpose;
  LoanTenor _selectedLoanTenor;

  NumberFormat _formatter = NumberFormat.currency(decimalDigits: 0);
  double _minProposedLoan;
  double _maxProposedLoan;
  double _proposedLoan;
  double _interest;
  double _tenor;
  double _fee;

  double get installment => _calculatedMonthlyInstallment();
  double get adminFee => _calculatedAdminFee();
  double get fundToTransfer => _calculatedFundToTransfer();

  @override
  void initState() {
    super.initState();
    _minProposedLoan = 0.0;
    _maxProposedLoan = 10000000.00;
    _proposedLoan = 0.0;
    _interest = 0.0;
    _tenor = 0.0;
    _fee = 0.0;
    _loanCreateBloc = LoanCreateBloc();
    _loanPurposeRepository = LoanPurposeRepository();
    _loanCreateBloc.add(LoanCreateScreenInitialized());
  }

  @override
  void dispose() {
    _loanCreateBloc.close();
    super.dispose();
  }

  double _calculatedLoanWithInterest() {
    double loanWithInterest = (_proposedLoan * _interest) / 100;
    return loanWithInterest;
  }

  double _calculatedMonthlyInstallment() {
    double installment = _calculatedLoanWithInterest() + _proposedLoan / _tenor;
    return installment;
  }

  double _calculatedAdminFee() {
    double adminFee = (_proposedLoan * _fee) / 100;
    return adminFee;
  }

  double _calculatedFundToTransfer() {
    double fund = _proposedLoan - _calculatedAdminFee();
    return fund;
  }

  void _handleSlideAction(double value) {
    setState(() {
      _proposedLoan = value;
    });
  }

  void _handleTenorChanges(LoanTenor tenor) {
    final double minProposedLoan = tenor.minProposedLoan.toDouble();

    setState(() {
      if (_proposedLoan < minProposedLoan) _proposedLoan = _minProposedLoan;
      _minProposedLoan = minProposedLoan;
      _tenor = tenor.tenor.toDouble();
      _fee = tenor.adminFee;
      _interest = tenor.interest;
      _selectedLoanTenor = tenor;
    });
  }

  void _submit() {
    _loanCreateBloc.add(SubmitButtonPressed(
      loanPurposeId: _selectedLoanPurpose.id,
      loanTenorId: _selectedLoanTenor.id,
      nominal: _proposedLoan.toInt(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Loan'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.help_outline),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _loanCreateBloc,
        child: BlocConsumer<LoanCreateBloc, LoanCreateState>(
          listener: (context, state) {
            if (state is LoanCreateLoaded) {
              setState(() {
                _loanTenors = state.loanTenors;
              });
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoanSummary(
                      interest: _interest,
                      fee: _fee,
                      formatter: _formatter,
                      adminFee: adminFee,
                      fundToTransfer: fundToTransfer,
                      installment: installment,
                      proposedLoan: _proposedLoan,
                    ),
                    Spacer(),
                    _buildTenorSelector(),
                    _buildLoanPurposeDropdown(),
                    _buildLoanControl(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        // color: Colors.grey,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: BlocProvider(
          create: (context) => _loanCreateBloc,
          child: BlocListener<LoanCreateBloc, LoanCreateState>(
            listener: (context, state) {
              if (state is LoanCreateInvalid) {
                setState(() {
                  _errors = state.exception;
                });
              }

              if (state is LoanCreateSuccess) {
                Navigator.of(context).pop(state.data);
              }

              if (state is LoanCreateFailure) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Oops, something went wrong. "
                    "Make sure you're connected to the internet.",
                  ),
                );

                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            child: BlocBuilder<LoanCreateBloc, LoanCreateState>(
              builder: (context, state) {
                String prompt;

                if (_tenor == 0.0) {
                  prompt = 'Please choose a tenor';
                } else if (_selectedLoanPurpose == null) {
                  prompt = 'Please choose loan purpose';
                } else if (_proposedLoan == 0.0) {
                  prompt = 'Please adjust your loan';
                } else {
                  prompt = 'Send Request';
                }

                return RaisedButton(
                  child: state is LoanCreateSubmitting
                      ? _buildLoadingButtonText()
                      : Text(prompt),
                  onPressed: state is LoanCreateSubmitting ||
                          _tenor == 0.0 ||
                          _proposedLoan == 0.0 ||
                          _selectedLoanPurpose == null
                      ? null
                      : _submit,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoanControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Slide to adjust loan'),
          ),
          Slider(
            value: _proposedLoan,
            divisions: 5,
            min: _minProposedLoan,
            max: _maxProposedLoan,
            label: _formatter.format(_proposedLoan),
            onChanged: _tenor == 0.0 ? null : _handleSlideAction,
          ),
        ],
      ),
    );
  }

  Widget _buildLoanPurposeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FormDropdownSearchable<LoanPurpose>(
        label: 'Loan Purpose',
        hintText: 'Choose loan purpose',
        searchBoxHintText: 'Find loan purpose',
        selectedItem: _selectedLoanPurpose,
        filterFn: (LoanPurpose purpose, String value) {
          return purpose.name.toLowerCase().contains(value.toLowerCase());
        },
        onFind: (String name) {
          return _loanPurposeRepository.find(name);
        },
        onChanged: (LoanPurpose value) {
          setState(() {
            _selectedLoanPurpose = value;
          });
        },
        itemAsString: (LoanPurpose purpose) => StringUtils.capitalize(
          purpose.name,
          allWords: true,
        ),
      ),
    );
  }

  Widget _buildTenorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 8.0),
          child: Text('Choose Tenor'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SelectableOutlineButtons<LoanTenor>(
            buttonActiveColor: Theme.of(context).primaryColor,
            items: _loanTenors,
            buttonChildBuilder: (tenor) => Text(
              '${tenor.tenor} Month (${tenor.interest}% Interest)',
            ),
            onChanged: _handleTenorChanges,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingButtonText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Sending Request...'),
        SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ],
    );
  }
}
