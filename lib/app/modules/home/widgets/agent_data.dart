import 'package:delivery_admin_white_label/app/modules/home/widgets/profile_data_tile.dart';
import 'package:delivery_admin_white_label/app/shared/grid_scroll_behavior.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class AgentData extends StatefulWidget {
  final String agentId;
  final bool edit;
  final void Function()? onBack;

  const AgentData({
    Key? key,
    this.edit = false,
    required this.agentId,
    this.onBack,
  }) : super(key: key);

  @override
  State<AgentData> createState() => _AgentDataState();
}

class _AgentDataState extends State<AgentData> {
  Color getColor(String status, bool online) {
    if (status == "INACTIVE") {
      return Colors.grey;
    }

    if (status == "BLOCKED") {
      return Colors.yellow;
    }

    if (online) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  final MapZoomPanBehavior zoomPanBehavior = MapZoomPanBehavior();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: viewPaddingTop(context) + wXD(50, context)),
                  SizedBox(
                    height: wXD(273, context),
                    width: maxWidth(context),
                    child: SfMaps(
                      layers: [
                        MapTileLayer(
                          // controller: store.mapTileLayerController,
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          zoomPanBehavior: zoomPanBehavior,
                          // markerBuilder: (BuildContext context, int index) {
                          //   MapMarker _marker = store.mapMarkersList[index];
                          //   return _marker;
                          // },
                          // initialMarkersCount: store.mapMarkersList.length,
                          // sublayers: store.polyPoints != []
                          //     ? [
                          //         MapPolylineLayer(
                          //           polylines: {
                          //             MapPolyline(
                          //               color: Colors.red,
                          //               width: 5,
                          //               points: store.polyPoints
                          //                   .map((e) => MapLatLng(
                          //                       e.latitude, e.longitude))
                          //                   .toList(),
                          //             ),
                          //           },
                          //         ),
                          //       ]
                          //     : null,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: maxWidth(context),
                    padding: EdgeInsets.only(
                      top: wXD(20, context),
                      left: wXD(13, context),
                      right: wXD(13, context),
                      bottom: wXD(5, context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dados do usuário",
                          style: textFamily(
                            context,
                            fontSize: 16,
                            color: getColors(context).primary,
                          ),
                        ),
                        SizedBox(height: wXD(8, context)),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: wXD(10, context),
                                      bottom: wXD(8, context)),
                                  width: wXD(120, context),
                                  height: wXD(110, context),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(wXD(4, context))),
                                    child: Container(
                                      width: wXD(52, context),
                                      height: wXD(48, context),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: wXD(23, context),
                                    width: wXD(23, context),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: getColor("ACTIVE", true),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: wXD(8, context)),
                            Column(
                              children: [
                                ProfileDataTile(
                                  title: "Nome completo",
                                  hint: "Lorem ipsum dolor sit amet",
                                  short: true,
                                ),
                                ProfileDataTile(
                                  title: "Nome de usuário",
                                  hint: "Lorem ipsum dolor sit amet",
                                  short: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ProfileDataTile(
                    title: "Data de nascimento",
                    hint: "Lorem ipsum dolor sit amet",
                  ),
                  ProfileDataTile(
                    title: "CPF",
                    hint: "Lorem ipsum dolor sit amet",
                  ),
                  ProfileDataTile(
                    title: "Telefone",
                    hint: "Lorem ipsum dolor sit amet",
                  ),
                  ProfileDataTile(
                    title: "Órgão emissor",
                    hint: "Lorem ipsum dolor sit amet",
                  ),
                  ProfileDataTile(
                    title: "RG",
                    hint: "Lorem ipsum dolor sit amet",
                  ),
                  ProfileDataTile(
                    title: "Gênero",
                    hint: "Lorem ipsum dolor sit amet",
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          DefaultAppBar(
            "Agente",
            onPop: () {
              widget.onBack != null ? widget.onBack!() : Modular.to.pop();
            },
          ),
        ],
      ),
    );
  }
}
