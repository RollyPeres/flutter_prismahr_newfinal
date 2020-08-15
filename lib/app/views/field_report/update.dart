import 'package:flutter/material.dart';

class FieldReportUpdateScreen extends StatelessWidget {
  const FieldReportUpdateScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Edit feature not available yet.'),
      ),
    );
  }
}

// import 'dart:typed_data';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_prismahr/app/bloc/field_report_update/field_report_update_bloc.dart';
// import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';
// import 'package:flutter_prismahr/app/components/form_input.dart';
// import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
// import 'package:flutter_prismahr/app/data/models/field_report_form_validation_exception_model.dart';
// import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
// import 'package:flutter_prismahr/app/data/models/user_model.dart';
// import 'package:flutter_prismahr/app/data/repositories/user_repository.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:random_color/random_color.dart';

// class FieldReportUpdateScreen extends StatefulWidget {
//   final FieldReport fieldReport;

//   FieldReportUpdateScreen({
//     Key key,
//     @required this.fieldReport,
//   }) : super(key: key);

//   @override
//   _FieldReportUpdateScreenState createState() =>
//       _FieldReportUpdateScreenState();
// }

// class _FieldReportUpdateScreenState extends State<FieldReportUpdateScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _participantController = TextEditingController();
//   final TextEditingController _chronologyController = TextEditingController();

//   final FocusNode _titleFocusNode = FocusNode();
//   final FocusNode _participantFocusNode = FocusNode();
//   final FocusNode _chronologyFocusNode = FocusNode();

//   final int _maxImages = 6;
//   final int _maxChips = 6;

//   FieldReportUpdateBloc _fieldReportUpdateBloc;
//   FieldReportFormValidationException _errors;

//   List<Asset> _images = <Asset>[];
//   List<User> _users = <User>[];
//   List<User> _participants = <User>[];
//   UserRepository _repository = UserRepository();

//   bool get _hasReachedMaxChips => _participants.length == _maxChips;
//   bool get _currentThemeIsLight =>
//       BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.light;

//   @override
//   void initState() {
//     super.initState();
//     _fieldReportUpdateBloc = FieldReportUpdateBloc();
//     _errors = FieldReportFormValidationException();
//     _titleController.text = widget.fieldReport.title;
//     _chronologyController.text = widget.fieldReport.chronology;
//     _participants = widget.fieldReport.participants;
//     _fetchUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).cardColor,
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Theme.of(context).cardColor,
//             title: Text(
//               'Add Field Report',
//               style: Theme.of(context)
//                   .textTheme
//                   .headline6
//                   .copyWith(fontWeight: FontWeight.w900),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: Form(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildImageGridView(),
//                     _buildTitleInput(),
//                     _buildParticipantInput(),
//                     _buildChronologyInput(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: BlocProvider(
//         create: (context) => _fieldReportUpdateBloc,
//         child: BlocListener<FieldReportUpdateBloc, FieldReportUpdateState>(
//           listener: (context, state) {
//             if (state is FieldReportUpdateInvalid) {
//               setState(() {
//                 _errors = state.exception;
//               });
//             }

//             if (state is FieldReportUpdateFailure) {
//               final snackBar = SnackBar(
//                 backgroundColor: Colors.red,
//                 content: Text(
//                   "Can't communicate with the server, "
//                   "make sure you're connected to the internet.",
//                 ),
//               );

//               Scaffold.of(context).showSnackBar(snackBar);
//             }

//             if (state is FieldReportUpdateSuccess) {
//               Navigator.of(context).pop(state.data);
//             }
//           },
//           child: BlocBuilder<FieldReportUpdateBloc, FieldReportUpdateState>(
//             builder: (context, state) {
//               return FloatingActionButton(
//                 tooltip: 'Send Field Report',
//                 child: state is FieldReportUpdateLoading
//                     ? SizedBox(
//                         height: 24,
//                         width: 24,
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation(Colors.white),
//                         ),
//                       )
//                     : Icon(Icons.save),
//                 onPressed: state is FieldReportUpdateLoading ? null : _submit,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitleInput() {
//     return FormInput(
//       controller: _titleController,
//       focusNode: _titleFocusNode,
//       label: 'Title',
//       keyboardType: TextInputType.text,
//       textInputAction: TextInputAction.next,
//       errorText: _errors.title?.first,
//       onChanged: (_) {
//         setState(() {
//           _errors.title = null;
//         });
//       },
//       onFieldSubmitted: (_) {
//         _participantFocusNode.requestFocus();
//       },
//     );
//   }

//   Widget _buildParticipantInput() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Text('Participants'),
//               Text('${_participants.length} of $_maxChips'),
//             ],
//           ),
//         ),
//         Padding(
//           padding: _participants.isNotEmpty
//               ? const EdgeInsets.only(bottom: 8.0)
//               : EdgeInsets.zero,
//           child: Wrap(
//             spacing: 4.0,
//             runSpacing: 0.0,
//             children: _participants.map((participant) {
//               final RandomColor randomColor = RandomColor(participant.id);
//               final Color chipBackgroundColor = _currentThemeIsLight
//                   ? randomColor.randomMaterialColor().shade50
//                   : randomColor.randomMaterialColor().shade900;

//               return SizedBox(
//                 width: 122,
//                 child: Chip(
//                   backgroundColor: chipBackgroundColor,
//                   key: ObjectKey(participant),
//                   avatar: RoundedRectangleAvatar(
//                     url: participant.avatar,
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                   label: Text(participant.name),
//                   onDeleted: () {
//                     setState(() {
//                       _participants.remove(participant);
//                     });
//                   },
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         !_hasReachedMaxChips
//             ? _buildTypeAheadField()
//             : Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
//                 child: Text(
//                   'Remove at least one of them to show the search input again.',
//                   style: Theme.of(context).textTheme.caption,
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _buildTypeAheadField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: TypeAheadFormField<User>(
//         itemBuilder: _itemBuilder,
//         debounceDuration: Duration(milliseconds: 500),
//         textFieldConfiguration: TextFieldConfiguration(
//           controller: _participantController,
//           enabled: !_hasReachedMaxChips,
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 15,
//             ),
//             filled: true,
//             hintText: 'Find by user name',
//             helperText:
//                 'This field will dissapear once you reach the maximum tag',
//             prefixIcon: Icon(Icons.search),
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         onSuggestionSelected: (User participant) {
//           setState(() => _participants.add(participant));
//           _participantController.clear();
//         },
//         suggestionsCallback: (String name) {
//           return _users.where((user) {
//             return user.name.toLowerCase().contains(name.toLowerCase()) &&
//                 !_participants.contains(user);
//           }).toList(growable: false);
//         },
//         suggestionsBoxDecoration: SuggestionsBoxDecoration(
//           elevation: 4.0,
//           constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _itemBuilder(BuildContext context, User user) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(
//         vertical: 5.0,
//         horizontal: 13.0,
//       ),
//       leading: RoundedRectangleAvatar(
//         url: user.avatar,
//         height: 45,
//         width: 45,
//         borderRadius: BorderRadius.circular(100),
//       ),
//       title: Text(
//         user.name,
//         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//       ),
//       trailing: Text(
//         'UI/UX Designer',
//         style: TextStyle(fontSize: 10, color: Color(0xff707070)),
//       ),
//     );
//   }

//   Widget _buildChronologyInput() {
//     return FormInput(
//       maxLines: 10,
//       controller: _chronologyController,
//       focusNode: _chronologyFocusNode,
//       label: 'Chronology',
//       hintText: 'Explain what happened...',
//       keyboardType: TextInputType.multiline,
//       textInputAction: TextInputAction.next,
//       errorText: _errors.chronology?.first,
//       onChanged: (_) {
//         setState(() {
//           _errors.chronology = null;
//         });
//       },
//       onFieldSubmitted: (_) {},
//     );
//   }

//   Widget _buildImageGridView() {
//     if (_images != null && _images.length > 0) {
//       return Container(
//         padding: const EdgeInsets.only(bottom: 20.0),
//         child: Stack(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10.00),
//               child: GridView.count(
//                 padding: EdgeInsets.zero,
//                 crossAxisCount: 3,
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 primary: false,
//                 children: List.generate(_images.length, (index) {
//                   Asset asset = _images[index];
//                   return Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       child: AssetThumb(
//                         asset: asset,
//                         width: 300,
//                         height: 300,
//                       ),
//                       onTap: () async {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Dialog(
//                               child: InkWell(
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15.00,
//                                     vertical: 20.00,
//                                   ),
//                                   child: Text('Remove this image'),
//                                 ),
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                   setState(() {
//                                     _images.remove(_images[index]);
//                                   });
//                                 },
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             Positioned(
//               top: 5.00,
//               right: 10.00,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 8.00, vertical: 4.00),
//                 decoration: BoxDecoration(
//                   color: Colors.black54,
//                   borderRadius: BorderRadius.circular(10.00),
//                 ),
//                 child: Center(
//                   child: Text(
//                     '${_images.length}/$_maxImages',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 5.00,
//               right: 10.00,
//               child: _images.length < _maxImages
//                   ? RaisedButton(
//                       color: Colors.black54,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.00)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(right: 5.00),
//                             child: Icon(
//                               Icons.add_a_photo,
//                               size: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             'Add more images',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ],
//                       ),
//                       onPressed: loadAssets,
//                     )
//                   : Container(),
//             ),
//           ],
//         ),
//       );
//     }
//     return _buildFullWidthImagePicker();
//   }

//   Widget _buildFullWidthImagePicker() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10.00),
//         child: Material(
//           color: Theme.of(context).inputDecorationTheme.fillColor,
//           child: InkWell(
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 50.00,
//                 horizontal: 20.00,
//               ),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 5.00),
//                       child: Icon(
//                         Icons.add_a_photo,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                     Text(
//                       'Add Images',
//                       style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             onTap: loadAssets,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _fieldReportUpdateBloc.close();
//     super.dispose();
//   }

//   void _fetchUsers() async {
//     final users = await _repository.fetch();
//     setState(() {
//       _users = users;
//     });
//   }

//   Future<void> loadAssets() async {
//     List<Asset> resultList;

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         // We need to calculate the limit of image picker based on the maximum
//         // images subtracted by the total of current selected images.
//         maxImages: _maxImages - _images.length,
//         enableCamera: true,
//       );
//     } on Exception catch (e) {
//       debugPrint(e.toString());
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     // If there is any selected _images, add the images with the current
//     // selected images.
//     if (resultList != null) {
//       setState(() {
//         _images = [..._images, ...resultList];
//       });
//     }
//   }

//   void _submit() async {
//     final List<int> participants = _participants.map((p) => p.id).toList();

//     List<MultipartFile> images = <MultipartFile>[];
//     for (var image in _images) {
//       final ByteData byteData = await image.getByteData(quality: 50);
//       final List<int> imageData = byteData.buffer.asUint8List();
//       final MultipartFile file = MultipartFile.fromBytes(
//         imageData,
//         filename: image.name,
//         contentType: MediaType('image', 'png'),
//       );

//       images.add(file);
//     }

//     _unfocus();
//     _fieldReportUpdateBloc.add(FieldReportUpdateSubmitButtonPressed(
//       id: widget.fieldReport.id,
//       images: images,
//       title: _titleController.text,
//       chronology: _chronologyController.text,
//       participants: participants,
//     ));
//   }

//   void _unfocus() {
//     _titleFocusNode.unfocus();
//     _participantFocusNode.unfocus();
//     _chronologyFocusNode.unfocus();
//   }
// }
