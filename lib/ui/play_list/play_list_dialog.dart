import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

 dialogContent(List<String> name, Function onTap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[



      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: name
            .map((e) => ListTile(
                  title: Text(
                    e,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    onTap(e);
                  },
                )
        )
            .toList(),
      ),

    ],
  );
}

void registerCustomDialogUi() {
  var dialogService = getIt<DialogService>();


  var controller = TextEditingController();
  var key = GlobalKey<FormState>();

  dialogService.registerCustomDialogUi((context, dialogRequest) => Dialog(
        insetPadding: EdgeInsets.fromLTRB(34, 30, 30, 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.only(bottom: 30, top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Playlist name",
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 24,
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25
                ),
                child: Form(
                  key: key,
                  child: TextFormField(
                    controller:  controller,
                    validator: (s){

                      if(controller.text.isEmpty || controller.text.length < 3){
                        return "Invalid name";
                      }

                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        dialogService
                            .completeDialog(DialogResponse(confirmed: false));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 38,
                  ),
                  InkWell(
                    onTap: () {
                      if(!key.currentState.validate()){
                        return;
                      }

                      dialogService.completeDialog(
                          DialogResponse(confirmed: true, responseData: [controller.text])
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Ok",
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
}
