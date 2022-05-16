// import 'package:dio/dio.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// import 'user_model.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'dropdownSearch Demo',
//       //enable this line if you want test Dark Mode
//       //theme: ThemeData.dark(),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
//   final _multiKey = GlobalKey<DropdownSearchState<String>>();
//   final _userEditTextController = TextEditingController(text: 'Mrs');

//   var mySelectedItems = ["Brazil", "Tunisia", 'Canada'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("DropdownSearch Demo")),
//       body: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: ListView(
//             padding: EdgeInsets.all(4),
//             children: <Widget>[
//               DropdownSearch<String>.multiSelection(
//                 popupProps: PopupPropsMultiSelection.menu(
//                   //backgroundColor: Colors.red,
//                   showSearchBox: true,
//                   searchFieldProps: TextFieldProps(
//                     autofocus: true,
//                   ),
//                 ),
//                 showClearButton: true,
//                 items: List.generate(10, (index) => "$index"),
//               ),
//               Divider(),
//               DropdownSearch<String>(
//                 popupProps: PopupProps.menu(
//                   showSelectedItems: true,
//                   disabledItemFn: (String s) => s.startsWith('I'),
//                 ),
//                 items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Menu mode",
//                   hintText: "country in menu mode",
//                 ),
//                 onChanged: print,
//                 selectedItem: "Brazil",
//               ),
//               Divider(),

//               ///Menu Mode with no searchBox MultiSelection
//               DropdownSearch<String>.multiSelection(
//                 key: _multiKey,
//                 validator: (List<String>? v) {
//                   return v == null || v.isEmpty ? "required field" : null;
//                 },
//                 popupProps: PopupPropsMultiSelection.menu(
//                   showSelectedItems: true,
//                   popupSelectionWidget: (cnt, String item, bool isSelected) {
//                     return isSelected
//                         ? Icon(
//                             Icons.check_circle,
//                             color: Colors.green[500],
//                           )
//                         : Container();
//                   },
//                   popupCustomMultiSelectionWidget: (context, list) {
//                     return Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8),
//                           child: OutlinedButton(
//                             onPressed: () {
//                               // How should I unselect all items in the list?
//                               _multiKey.currentState?.closeDropDownSearch();
//                             },
//                             child: const Text('Cancel'),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8),
//                           child: OutlinedButton(
//                             onPressed: () {
//                               // How should I select all items in the list?
//                               _multiKey.currentState?.popupSelectAllItems();
//                             },
//                             child: const Text('All'),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8),
//                           child: OutlinedButton(
//                             onPressed: () {
//                               // How should I unselect all items in the list?
//                               _multiKey.currentState?.popupDeselectAllItems();
//                             },
//                             child: const Text('None'),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                   disabledItemFn: (String s) => s.startsWith('I'),
//                 ),
//                 dropdownBuilder: (context, selectedItems) {
//                   Widget item(String i) => Container(
//                         height: 32,
//                         padding: EdgeInsets.only(left: 6),
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 2,
//                           vertical: 1,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Theme.of(context).primaryColorLight,
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               i,
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context).textTheme.subtitle2,
//                             ),
//                             MaterialButton(
//                               height: 20,
//                               shape: const CircleBorder(),
//                               padding: EdgeInsets.all(0),
//                               color: Colors.red[200],
//                               minWidth: 20,
//                               onPressed: () {
//                                 _multiKey.currentState?.removeItem(i);
//                               },
//                               child: Icon(
//                                 Icons.close_outlined,
//                                 size: 18,
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                   return Wrap(
//                     children: selectedItems.map((e) => item(e)).toList(),
//                   );
//                 },
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText: "Select a country",
//                   labelText: "Menu mode multiSelection*",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//                 showClearButton: true,
//                 onChanged: print,

//                 //clearButtonSplashRadius: 20,
//                 selectedItems: ["Tunisia"],
//               ),
//               Divider(),

//               ///Menu Mode with no searchBox
//               DropdownSearch<String>(
//                 validator: (v) => v == null ? "required field" : null,
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText: "Select a country",
//                   labelText: "Menu mode *",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//                 showClearButton: true,
//                 onChanged: print,
//                 popupProps: PopupProps.menu(
//                   showSelectedItems: true,
//                   disabledItemFn: (String s) => s.startsWith('I'),
//                 ),
//                 //clearButtonSplashRadius: 20,
//                 selectedItem: "Tunisia",
//                 onBeforeChange: (a, b) {
//                   if (b == null) {
//                     AlertDialog alert = AlertDialog(
//                       title: Text("Are you sure..."),
//                       content: Text("...you want to clear the selection"),
//                       actions: [
//                         TextButton(
//                           child: Text("OK"),
//                           onPressed: () {
//                             Navigator.of(context).pop(true);
//                           },
//                         ),
//                         TextButton(
//                           child: Text("NOT OK"),
//                           onPressed: () {
//                             Navigator.of(context).pop(false);
//                           },
//                         ),
//                       ],
//                     );

//                     return showDialog<bool>(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return alert;
//                         });
//                   }

//                   return Future.value(true);
//                 },
//               ),
//               Divider(),

//               ///Menu Mode with no searchBox
//               DropdownSearch<String>(
//                 validator: (v) => v == null ? "required field" : null,
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText: "Select a country",
//                   labelText: "Menu mode with helper *",
//                   helperText: 'positionCallback example usage',
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ["Brazil", "Italia", "Tunisia", 'Canada'],
//                 onChanged: print,
//                 selectedItem: "Tunisia",
//                 popupProps: PopupProps.menu(
//                   showSelectedItems: true,
//                   menuProps: MenuProps(
//                     positionCallback: (popupButtonObject, overlay) {
//                       final decorationBox = _findBorderBox(popupButtonObject);

//                       double translateOffset = 0;
//                       if (decorationBox != null) {
//                         translateOffset = decorationBox.size.height -
//                             popupButtonObject.size.height;
//                       }

//                       // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
//                       final RenderBox overlay = Overlay.of(context)!
//                           .context
//                           .findRenderObject() as RenderBox;
//                       // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
//                       return RelativeRect.fromSize(
//                         Rect.fromPoints(
//                           popupButtonObject
//                               .localToGlobal(
//                                   popupButtonObject.size
//                                       .bottomLeft(Offset.zero),
//                                   ancestor: overlay)
//                               .translate(0, translateOffset),
//                           popupButtonObject.localToGlobal(
//                               popupButtonObject.size.bottomRight(Offset.zero),
//                               ancestor: overlay),
//                         ),
//                         Size(overlay.size.width, overlay.size.height),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Divider(),

//               ///Menu Mode with overriden icon and dropdown buttons
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: DropdownSearch<String>(
//                       validator: (v) => v == null ? "required field" : null,
//                       popupProps: PopupProps.menu(
//                         showSelectedItems: true,
//                         disabledItemFn: (String s) => s.startsWith('I'),
//                       ),
//                       dropdownSearchDecoration: InputDecoration(
//                         hintText: "Select a country",
//                         labelText: "Menu mode *",
//                         filled: true,
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF01689A)),
//                         ),
//                       ),
//                       clearButtonProps: IconButtonProps(
//                         icon: Icon(Icons.cancel),
//                       ),
//                       dropdownButtonProps: IconButtonProps(
//                         icon: Icon(Icons.arrow_circle_down_outlined),
//                       ),
//                       items: [
//                         "Brazil",
//                         "Italia (Disabled)",
//                         "Tunisia",
//                         'Canada'
//                       ],
//                       showClearButton: true,
//                       onChanged: print,
//                       selectedItem: "Tunisia",
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.image),
//                         filled: true,
//                         labelText: "Menu mode *",
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Color(0xFF01689A),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Divider(),
//               DropdownSearch<UserModel>.multiSelection(
//                 popupProps: PopupPropsMultiSelection.bottomSheet(
//                   showSelectedItems: true,
//                   itemBuilder: _customPopupItemBuilderExample2,
//                   scrollbarProps: ScrollbarProps(
//                     thumbVisibility: true,
//                     thickness: 7,
//                   ),
//                   showSearchBox: true,
//                   searchFieldProps: TextFieldProps(
//                     controller: _userEditTextController,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.clear),
//                         onPressed: () {
//                           _userEditTextController.clear();
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 isFilteredOnline: true,
//                 showClearButton: true,
//                 compareFn: (item, selectedItem) => item.id == selectedItem.id,
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: 'User *',
//                   filled: true,
//                   fillColor: Theme.of(context).inputDecorationTheme.fillColor,
//                 ),
//                 autoValidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (u) =>
//                     u == null || u.isEmpty ? "user field is required " : null,
//                 asyncItems: (String? filter) => getData(filter),
//                 onChanged: (data) {
//                   print(data);
//                 },
//                 dropdownBuilder: _customDropDownExampleMultiSelection,
//               ),
//               Divider(),

//               ///custom itemBuilder and dropDownBuilder
//               DropdownSearch<UserModel>(
//                 popupProps: PopupProps.menu(
//                   showSelectedItems: true,
//                 ),
//                 itemAsString: (i) => i.name,
//                 showClearButton: true,
//                 compareFn: (i, s) => i.isEqual(s),
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Person",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 asyncItems: (String filter) => getData(filter),
//                 onChanged: (data) {
//                   print(data);
//                 },
//                 dropdownBuilder: _customDropDownExample,
//               ),
//               Divider(),

//               ///BottomSheet Mode with no searchBox
//               DropdownSearch<String>(
//                 items: [
//                   "Brazil",
//                   "Italia",
//                   "Tunisia",
//                   'Canada',
//                   'Zraoua',
//                   'France',
//                   'Belgique'
//                 ],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Custom BottomShet mode",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: print,
//                 selectedItem: "Brazil",
//                 popupProps: PopupProps.bottomSheet(
//                   searchFieldProps: TextFieldProps(
//                     padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                       labelText: "Search a country1",
//                     ),
//                   ),
//                   title: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColorDark,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Country',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   bottomSheetProps: BottomSheetProps(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                       ),
//                     ),
//                   ),
//                   showSearchBox: true,
//                 ),
//               ),
//               Divider(),

//               ///show favorites on top list
//               DropdownSearch<UserModel>.multiSelection(
//                 popupProps: PopupPropsMultiSelection.menu(
//                     showSelectedItems: true,
//                     showSearchBox: true,
//                     itemBuilder: _customPopupItemBuilderExample2,
//                     favoriteItemProps: FavoriteItemProps(
//                       showFavoriteItems: true,
//                       favoriteItemsAlignment: MainAxisAlignment.start,
//                       favoriteItems: (items) {
//                         return items
//                             .where((e) => e.name.contains("Mrs"))
//                             .toList();
//                       },
//                       favoriteItemBuilder: (context, item, isSelected) {
//                         return Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.grey[100]),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "${item.name}",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(color: Colors.indigo),
//                               ),
//                               Padding(padding: EdgeInsets.only(left: 8)),
//                               isSelected
//                                   ? Icon(Icons.check_box_outlined)
//                                   : Container(),
//                             ],
//                           ),
//                         );
//                       },
//                     )),
//                 compareFn: (i, s) => i.isEqual(s),
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Person with favorite option",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 asyncItems: (filter) => getData(filter),
//                 onChanged: (data) {
//                   print(data);
//                 },
//               ),
//               Divider(),

//               ///merge online and offline data in the same list and set custom max Height
//               DropdownSearch<UserModel>(
//                 items: [
//                   UserModel(name: "Offline name1", id: "999"),
//                   UserModel(name: "Offline name2", id: "0101")
//                 ],
//                 popupProps: PopupProps.menu(showSearchBox: true),
//                 asyncItems: (String? filter) => getData(filter),
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "choose a user",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: print,
//               ),
//               Divider(),

//               ///open dropdown programmatically
//               DropdownSearch<String>(
//                 items: ["no action", "confirm in the next dropdown"],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "open another dropdown programmatically",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (v) {
//                   if (v == "confirm in the next dropdown") {
//                     _openDropDownProgKey.currentState?.openDropDownSearch();
//                   }
//                 },
//               ),
//               Padding(padding: EdgeInsets.all(4)),
//               DropdownSearch<String>(
//                 popupProps: PopupProps.modalBottomSheet(
//                   showSelectedItems: true,
//                 ),
//                 validator: (value) => value == null ? "empty" : null,
//                 key: _openDropDownProgKey,
//                 items: ["Yes", "No"],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "confirm",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {
//                         _openDropDownProgKey.currentState?.openDropDownSearch();
//                       },
//                       child: Text("Open dropdownSearch")),
//                   ElevatedButton(
//                       onPressed: () {
//                         _openDropDownProgKey.currentState
//                             ?.changeSelectedItem("No");
//                       },
//                       child: Text("set to 'NO'")),
//                   Material(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           _openDropDownProgKey.currentState
//                               ?.changeSelectedItem("Yes");
//                         },
//                         child: Text("set to 'YES'")),
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         _openDropDownProgKey.currentState
//                             ?.changeSelectedItem('Blabla');
//                       },
//                       child: Text("set to 'Blabla'")),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _customDropDownExampleMultiSelection(
//       BuildContext context, List<UserModel?> selectedItems) {
//     if (selectedItems.isEmpty) {
//       return ListTile(
//         contentPadding: EdgeInsets.all(0),
//         leading: CircleAvatar(),
//         title: Text("No item selected"),
//       );
//     }

//     return Wrap(
//       children: selectedItems.map((e) {
//         return Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Container(
//             child: ListTile(
//               contentPadding: EdgeInsets.all(0),
//               leading: CircleAvatar(
//                   // this does not work - throws 404 error
//                   // backgroundImage: NetworkImage(item.avatar ?? ''),
//                   ),
//               title: Text(e?.name ?? ''),
//               subtitle: Text(
//                 e?.createdAt.toString() ?? '',
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   RenderBox? _findBorderBox(RenderBox box) {
//     RenderBox? borderBox;

//     box.visitChildren((child) {
//       if (child is RenderCustomPaint) {
//         borderBox = child;
//       }

//       final box = _findBorderBox(child as RenderBox);
//       if (box != null) {
//         borderBox = box;
//       }
//     });

//     return borderBox;
//   }

//   Widget _customDropDownExample(BuildContext context, UserModel? item) {
//     if (item == null) {
//       return Container();
//     }

//     return Container(
//       child: (item.avatar == null)
//           ? ListTile(
//               contentPadding: EdgeInsets.all(0),
//               leading: CircleAvatar(),
//               title: Text("No item selected"),
//             )
//           : ListTile(
//               contentPadding: EdgeInsets.all(0),
//               leading: CircleAvatar(
//                   // this does not work - throws 404 error
//                   // backgroundImage: NetworkImage(item.avatar ?? ''),
//                   ),
//               title: Text(item.name),
//               subtitle: Text(
//                 item.createdAt.toString(),
//               ),
//             ),
//     );
//   }

//   Widget _customPopupItemBuilderExample2(
//       BuildContext context, UserModel? item, bool isSelected) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: !isSelected
//           ? null
//           : BoxDecoration(
//               border: Border.all(color: Theme.of(context).primaryColor),
//               borderRadius: BorderRadius.circular(5),
//               color: Colors.white,
//             ),
//       child: ListTile(
//         selected: isSelected,
//         title: Text(item?.name ?? ''),
//         subtitle: Text(item?.createdAt?.toString() ?? ''),
//         leading: CircleAvatar(
//             // this does not work - throws 404 error
//             // backgroundImage: NetworkImage(item.avatar ?? ''),
//             ),
//       ),
//     );
//   }

//   Future<List<UserModel>> getData(filter) async {
//     var response = await Dio().get(
//       "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
//       queryParameters: {"filter": filter},
//     );

//     final data = response.data;
//     if (data != null) {
//       return UserModel.fromJsonList(data);
//     }

//     return [];
//   }
// }