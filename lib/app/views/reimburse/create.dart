import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/reimburse_create/reimburse_create_bloc.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_searchable.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/multi_image_picker_component.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_model.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_type_model.dart';
import 'package:flutter_prismahr/app/data/repositories/reimburse_type_repository.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ReimburseCreateScreen extends StatefulWidget {
  ReimburseCreateScreen({Key key}) : super(key: key);

  @override
  _ReimburseCreateScreenState createState() => _ReimburseCreateScreenState();
}

class _ReimburseCreateScreenState extends State<ReimburseCreateScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final FocusNode _reasonFocus = FocusNode();
  final FocusNode _nominalFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();

  DateTime _selectedDate;
  List<Asset> _receipts;
  ReimburseCreateBloc _reimburseCreateBloc;
  ReimburseFormValidationException _errors;
  ReimburseTypeRepository _reimburseTypeRepository;
  ReimburseType _reimburseType;

  @override
  void initState() {
    super.initState();
    _receipts = const <Asset>[];
    _selectedDate = DateTime.now();
    _reimburseCreateBloc = ReimburseCreateBloc();
    _errors = ReimburseFormValidationException();
    _reimburseTypeRepository = ReimburseTypeRepository();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _nominalController.dispose();
    _detailsController.dispose();
    _reasonFocus.dispose();
    _nominalFocus.dispose();
    _detailsFocus.dispose();
    _reimburseCreateBloc.close();
    super.dispose();
  }

  void _handleImageChanges(List<Asset> images) {
    setState(() {
      _receipts = images;
    });
  }

  void _handleReimburseTypeChanges(ReimburseType value) {
    setState(() {
      _reimburseType = value;
    });
  }

  Future<List<ReimburseType>> _onFindReimburseType(String value) async {
    return await _reimburseTypeRepository.find(value);
  }

  bool _reimburseTypeFilterFn(ReimburseType reimburseType, String value) {
    if (value.isEmpty) return true;
    return reimburseType.name.toLowerCase().contains(value.toLowerCase());
  }

  void _submit() async {
    List<MultipartFile> receipts = <MultipartFile>[];

    if (_receipts.isNotEmpty) {
      for (var image in _receipts) {
        final ByteData byteData = await image.getByteData(quality: 50);
        final List<int> imageData = byteData.buffer.asUint8List();
        final MultipartFile receipt = MultipartFile.fromBytes(
          imageData,
          filename: image.name,
          contentType: MediaType('image', 'png'),
        );

        receipts.add(receipt);
      }
    }

    final String date = DateFormat('yyyy-MM-dd').format(_selectedDate);
    _reimburseCreateBloc.add(SubmitButtonPressed(
      reason: _reasonController.text,
      date: date,
      nominal: int.parse(_nominalController.text),
      details: _detailsController.text,
      receipts: receipts,
      reimburseTypeId: _reimburseType.id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Request Reimburse')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CalendarDatePicker(
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      initialDate: _selectedDate,
                      onDateChanged: (DateTime value) {
                        setState(() {
                          _selectedDate = value;
                        });
                      },
                    ),
                  ),
                  MultiImagePickerComponent(
                    onImageChanged: _handleImageChanges,
                    subject: "Receipts",
                    maxImages: 6,
                  ),
                  FormDropdownSearchable<ReimburseType>(
                    label: 'Category',
                    searchBoxHintText: 'Find category',
                    selectedItem: _reimburseType,
                    onChanged: _handleReimburseTypeChanges,
                    onFind: _onFindReimburseType,
                    filterFn: _reimburseTypeFilterFn,
                    dropdownBuilder: _reimburseTypeDropdownBuilder,
                    popupItemBuilder: _reimburseTypeDropdownPopupBuilder,
                  ),
                  FormInput(
                    controller: _reasonController,
                    focusNode: _reasonFocus,
                    label: 'Reason',
                    hintText: 'Reimburse for a business trip to...',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    errorText: _errors.reason?.first,
                    maxLines: 1,
                    maxLength: 100,
                    onChanged: (_) {
                      setState(() {
                        _errors.reason = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_nominalFocus);
                    },
                  ),
                  FormInput(
                    controller: _nominalController,
                    focusNode: _nominalFocus,
                    label: 'Nominal',
                    hintText: 'The overall of your expenses',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    errorText: _errors.nominal?.first,
                    onChanged: (_) {
                      setState(() {
                        _errors.nominal = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_detailsFocus);
                    },
                  ),
                  FormInput(
                    controller: _detailsController,
                    focusNode: _detailsFocus,
                    label: 'Details',
                    hintText: 'Explain what happened...',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 5,
                    errorText: _errors.details?.first,
                    maxLines: null,
                    maxLength: 3500,
                    onChanged: (_) {
                      setState(() {
                        _errors.details = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: BlocProvider(
          create: (context) => _reimburseCreateBloc,
          child: BlocListener<ReimburseCreateBloc, ReimburseCreateState>(
            listener: (context, state) {
              if (state is ReimburseCreateInvalid) {
                setState(() {
                  _errors = state.exception;
                });
              }

              if (state is ReimburseCreateSuccess) {
                Navigator.of(context).pop(state.data);
              }

              if (state is ReimburseCreateFailure) {
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
            child: BlocBuilder<ReimburseCreateBloc, ReimburseCreateState>(
              builder: (context, state) {
                return RaisedButton(
                  child: state is ReimburseCreateLoading
                      ? _buildLoadingButtonText()
                      : Text('Send Request'),
                  onPressed: state is ReimburseCreateLoading ? null : _submit,
                );
              },
            ),
          ),
        ),
      ),
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

  Widget _reimburseTypeDropdownBuilder(
    BuildContext context,
    ReimburseType reimburseType,
    String itemDesignation,
  ) {
    return Container(
      child: (reimburseType?.name == null)
          ? SizedBox()
          : Text(
              StringUtils.capitalize(reimburseType.name, allWords: true),
              style: TextStyle(fontSize: 16),
            ),
    );
  }

  Widget _reimburseTypeDropdownPopupBuilder(
    BuildContext context,
    ReimburseType reimburseType,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        selected: isSelected,
        title: Text(
          StringUtils.capitalize(reimburseType.name, allWords: true),
        ),
      ),
    );
  }
}
