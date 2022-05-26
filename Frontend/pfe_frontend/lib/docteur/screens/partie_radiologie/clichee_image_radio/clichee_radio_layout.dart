import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:pfe_frontend/authentication/utils/colors.dart';
import 'package:pfe_frontend/docteur/utils/constant.dart';

class ClicheeRadioLayout extends StatefulWidget {
  const ClicheeRadioLayout({Key? key}) : super(key: key);

  @override
  State<ClicheeRadioLayout> createState() => _ClicheeRadioLayoutState();
}

class _ClicheeRadioLayoutState extends State<ClicheeRadioLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List ListeClichee = [] ; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
 @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: AdminColorSix,
        centerTitle: true,
        title: Text(
              'Liste des comptes-rendus',
              textAlign: TextAlign.center,
              style: kTitleStyle2,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          if(ListeClichee.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("aucun enregistrement trouvé" , style: TextStyle(color: AdminColorSix ),),
                Divider(),
                Text("les images envoyées par les radiologues se trouvent ici." , style: TextStyle(color: AdminColorSix ),)
                 ],),
                 
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: ordonnances.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         margin:  EdgeInsets.zero,
            //         child: Padding(
            //           padding: EdgeInsets.all(15),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             children: [
            //               Row(
            //                 children: [
            //                   CircleAvatar(
            //                     backgroundImage: NetworkImage('https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         ordonnances[index].docteur_id.toString(),
            //                         style: TextStyle(
            //                           color: Color(MyColors.header01),
            //                           fontWeight: FontWeight.w700,
            //                         ),
            //                       ),
            //                       SizedBox(
            //                         height: 5,
            //                       ),
            //                       Text(
            //                         ordonnances[index].description,
            //                         style: TextStyle(
            //                           color: Color(MyColors.grey02),
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Expanded(
            //                     child: ElevatedButton(
            //                       style:  ElevatedButton.styleFrom(
            //                               primary: Colors.green,
            //                               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),),
            //                       child: Text('Voir Details'),
            //                       onPressed: () => {},
            //                     ),
            //                   )
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
           
          ],
        ),
      ),
    );
  }
}
