import 'package:appcollect/Model/Benefit/Benefit.dart';
import 'package:appcollect/Model/District/District.dart';
import 'package:appcollect/Model/Genre/Genre.dart';
import 'package:appcollect/Model/ProjectArea/ProjectArea.dart';
import 'package:appcollect/View/FormComponents/MultiSelectComponent.dart';
import 'package:appcollect/View/FormComponents/NumberComponent.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../View/FormComponents/LabelComponent.dart';
import '../../View/FormComponents/SelectComponent.dart';
import '../../View/FormComponents/TextComponent.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../Model/Benificiary/Benificiary.dart';
import '../../Controller/BenificiaryController.dart';

class BenificiaryForm extends StatefulWidget {
  const BenificiaryForm({Key? key, this.benificiaryForEdit}) : super(key: key);
  final Benificiary? benificiaryForEdit;
  @override
  _BenificiaryFormState createState() =>
      _BenificiaryFormState(benificiaryForEdit);
}

class _BenificiaryFormState extends State<BenificiaryForm> {
  _BenificiaryFormState(this.benificiaryForEdit);
  final _formKey = GlobalKey<FormState>();
  Benificiary? benificiaryForEdit;
  var benificiary;
  List<Benefit> selectedBenefits = [];
  List<ProjectArea> selectedProjectAreas = [];

  int _currentIndex = 1;
  @override
  void initState() {
    if (benificiaryForEdit != null) {
      benificiary = benificiaryForEdit!.toJson();
    } else {
      benificiary = new Benificiary(
              uuid: Uuid().v4(),
              formNumber: 0,
              age: 0,
              genreUuid: "",
              qualification: "",
              districtUuid: "",
              zone: "",
              location: "",
              projectAreas: [],
              benefits: [],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              fullName: '')
          .toJson();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var benefits = Syncronization.getBenefits().values.toList();
    if (benefits.isNotEmpty) {
      benefits
          .sort((a, b) => a.name.codeUnitAt(0).compareTo(b.name.codeUnitAt(0)));
    }
    var districts = Syncronization.getDistricts().values.toList();

    if (districts.isNotEmpty) {
      districts
          .sort((a, b) => a.name.codeUnitAt(0).compareTo(b.name.codeUnitAt(0)));
    }

    var genres = Syncronization.getGenres().values.toList();
    if (genres.isNotEmpty) {
      genres
          .sort((a, b) => a.name.codeUnitAt(0).compareTo(b.name.codeUnitAt(0)));
    }

    var projectAreas = Syncronization.getProjectAreas().values.toList();
    if (projectAreas.isNotEmpty) {
      projectAreas
          .sort((a, b) => a.name.codeUnitAt(0).compareTo(b.name.codeUnitAt(0)));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black45,
        elevation: 1,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelComponent(labelText: "Número de inquerito"),
              NumberComponent(
                hintText: "Número de inquerito",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o número de inquerito';
                  }
                  return null;
                },
                initialValue: benificiaryForEdit != null
                    ? "${benificiaryForEdit!.formNumber}"
                    : "0",
                onChanged: (formNumber) {
                  setState(() {
                    this.benificiary['form_number'] =
                        int.tryParse(formNumber) ?? 0;
                  });
                },
                onSaved: (formNumber) {
                  setState(() {
                    this.benificiary['form_number'] =
                        int.tryParse("${formNumber ?? 0}") ?? 0;
                  });
                },
              ),
              LabelComponent(labelText: "Nome do participante"),
              TextComponent(
                hintText: "Nome do participante",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o nome do participante';
                  }
                  return null;
                },
                initialValue: benificiaryForEdit != null
                    ? benificiaryForEdit!.fullName
                    : "",
                onChanged: (nomeCompleto) {
                  setState(() {
                    this.benificiary['full_name'] = nomeCompleto;
                  });
                },
                onSaved: (nomeCompleto) {
                  setState(() {
                    if (nomeCompleto != null) {
                      this.benificiary['full_name'] = nomeCompleto;
                    }
                  });
                },
              ),
              LabelComponent(labelText: "Idade"),
              NumberComponent(
                hintText: "Idade",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a idade';
                  }
                  return null;
                },
                initialValue: benificiaryForEdit != null
                    ? "${benificiaryForEdit!.age}"
                    : "",
                onChanged: (age) {
                  setState(() {
                    this.benificiary['age'] = int.tryParse(age) ?? 0;
                  });
                },
                onSaved: (age) {
                  setState(() {
                    this.benificiary['age'] = int.tryParse("${age ?? 0}") ?? 0;
                  });
                },
              ),
              LabelComponent(labelText: "Gênero"),
              SelectComponent(
                hintText: "Sexo",
                validator: (Genre? item) {
                  if (item == null)
                    return "Por favor selecione o gênero";
                  else
                    return null;
                },
                selectedItem:
                    Syncronization.getGenres().values.toList().isNotEmpty
                        ? (Syncronization.getGenres()
                                .values
                                .toList()
                                .where((element) {
                            if (benificiaryForEdit != null) {
                              return "${benificiaryForEdit!.genreUuid}" ==
                                  "${element.uuid}";
                            }
                            return false;
                          }).isNotEmpty
                            ? Syncronization.getGenres()
                                .values
                                .toList()
                                .where((element) {
                                return "${benificiaryForEdit!.genreUuid}" ==
                                    "${element.uuid}";
                              }).first
                            : null)
                        : null,
                items: Syncronization.getGenres().values.toList().isNotEmpty
                    ? Syncronization.getGenres().values.toList()
                    : <Genre>[],
                onChanged: (Genre? sexo) {
                  setState(() {
                    if (sexo != null) {
                      this.benificiary['genre_uuid'] = sexo.uuid;
                    }
                  });
                },
                onSaved: (Genre? sexo) {
                  setState(() {
                    if (sexo != null) {
                      this.benificiary['genre_uuid'] = sexo.uuid;
                    }
                  });
                },
              ),
              LabelComponent(
                  labelText: "Qualificações acadêmicas/profissionais"),
              TextComponent(
                hintText: "Qualificações acadêmicas/profissionais",
                initialValue: benificiaryForEdit != null
                    ? benificiaryForEdit!.qualification
                    : "",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira qualificações';
                  }
                  return null;
                },
                onChanged: (qualification) {
                  setState(() {
                    this.benificiary['qualification'] = qualification;
                  });
                },
                onSaved: (qualification) {
                  setState(() {
                    if (qualification != null) {
                      this.benificiary['qualification'] = qualification;
                    }
                  });
                },
              ),
              LabelComponent(labelText: "Distrito"),
              SelectComponent(
                hintText: "Distrito",
                showSearchBox: true,
                validator: (District? item) {
                  if (item == null)
                    return "Por favor selecione o distrito";
                  else
                    return null;
                },
                mode: Mode.DIALOG,
                selectedItem: districts.isNotEmpty
                    ? (Syncronization.getDistricts()
                            .values
                            .toList()
                            .where((element) {
                        if (benificiaryForEdit != null) {
                          return "${benificiaryForEdit!.districtUuid}" ==
                              "${element.uuid}";
                        }
                        return false;
                      }).isNotEmpty
                        ? Syncronization.getDistricts()
                            .values
                            .toList()
                            .where((element) {
                            return "${benificiaryForEdit!.districtUuid}" ==
                                "${element.uuid}";
                          }).first
                        : null)
                    : null,
                items: Syncronization.getDistricts().values.toList().isNotEmpty
                    ? districts
                    : <District>[],
                onChanged: (District? distrito) {
                  setState(() {
                    if (distrito != null) {
                      this.benificiary['district_uuid'] = distrito.uuid;
                    }
                  });
                },
                onSaved: (District? distrito) {
                  setState(() {
                    if (distrito != null) {
                      this.benificiary['district_uuid'] = distrito.uuid;
                    }
                  });
                },
              ),
              LabelComponent(labelText: "Localidade"),
              TextComponent(
                hintText: "Localidade",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a localidade';
                  }
                  return null;
                },
                initialValue: benificiaryForEdit != null
                    ? benificiaryForEdit!.location
                    : "",
                onChanged: (location) {
                  this.benificiary['location'] = location;
                },
                onSaved: (location) {
                  this.benificiary['location'] = location;
                },
              ),
              LabelComponent(labelText: "Bairro"),
              TextComponent(
                hintText: "Bairro",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o bairro';
                  }
                  return null;
                },
                initialValue:
                    benificiaryForEdit != null ? benificiaryForEdit!.zone : "",
                onChanged: (zone) {
                  this.benificiary['zone'] = zone;
                },
                onSaved: (zone) {
                  this.benificiary['zone'] = zone;
                },
              ),
              LabelComponent(labelText: "Area do projecto"),
              MultiSelectComponent(
                hintText: "Area do projecto",
                showSearchBox: true,
                mode: Mode.DIALOG,
                validator: (items) => items == null || items.isEmpty
                    ? "Por favor selecione as areas do projecto"
                    : null,
                selectedItems: projectAreas.isNotEmpty
                    ? (Syncronization.getProjectAreas()
                            .values
                            .toList()
                            .where((element) {
                        if (benificiaryForEdit != null) {
                          return benificiaryForEdit!.projectAreas
                              .contains(element);
                        }
                        return false;
                      }).isNotEmpty
                        ? Syncronization.getProjectAreas()
                            .values
                            .toList()
                            .where((element) {
                            return benificiaryForEdit!.projectAreas
                                .contains(element);
                          }).toList()
                        : [])
                    : [],
                items:
                    Syncronization.getProjectAreas().values.toList().isNotEmpty
                        ? projectAreas
                        : <ProjectArea>[],
                onChanged: (projectAreas) {
                  setState(() {
                    if (projectAreas != null) {
                      this.benificiary['project_areas'] = List.generate(
                          projectAreas.length,
                          (index) =>
                              (projectAreas[index] as ProjectArea).toJson());
                    }
                  });
                },
                onSaved: (projectAreas) {
                  setState(() {
                    if (projectAreas != null) {
                      this.benificiary['project_areas'] = List.generate(
                          projectAreas.length,
                          (index) =>
                              (projectAreas[index] as ProjectArea).toJson());
                    }
                  });
                },
              ),
              LabelComponent(labelText: "Benefício recebido"),
              MultiSelectComponent(
                hintText: "Benefício recebido",
                showSearchBox: true,
                validator: (items) {
                  if (items == null)
                    return "Por favor selecione o benefícios recebido";
                  else
                    return null;
                },
                mode: Mode.DIALOG,
                selectedItems: benefits.isNotEmpty
                    ? (Syncronization.getBenefits()
                            .values
                            .toList()
                            .where((element) {
                        if (benificiaryForEdit != null) {
                          return benificiaryForEdit!.benefits.contains(element);
                        }
                        return false;
                      }).isNotEmpty
                        ? Syncronization.getBenefits()
                            .values
                            .toList()
                            .where((element) {
                            return benificiaryForEdit!.benefits
                                .contains(element);
                          }).toList()
                        : [])
                    : [],
                items: Syncronization.getBenefits().values.toList().isNotEmpty
                    ? benefits
                    : <Benefit>[],
                onChanged: (benefit) {
                  setState(() {
                    if (benefit != null) {
                      this.benificiary['benefits'] = List.generate(
                          benefit.length,
                          (index) => (benefit[index] as Benefit).toJson());
                    }
                  });
                },
                onSaved: (benefit) {
                  setState(() {
                    if (benefit != null) {
                      benefit = benefit as List<Benefit>;
                      this.benificiary['benefits'] = List.generate(
                          benefit!.length,
                          (index) => (benefit![index] as Benefit).toJson());
                    }
                  });
                },
              ),
              LabelComponent(labelText: "Fim do inquerito"),
              LabelComponent(labelText: ""),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() {
          this._currentIndex = index;
          if (_formKey.currentState!.validate()) {
            if (index == 1) {
              _formKey.currentState!.save();

              if (this.benificiaryForEdit != null) {
                debugPrint(benificiaryForEdit!.toJson().toString());
                if (Syncronization.addUdated(
                    Benificiary.fromJson(benificiary))) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Benificiario Actualizado com sucesso',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Erro ao actualizar benificiario',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
              } else {
                debugPrint(benificiary.toString());

                if (Syncronization.addCreated(
                    Benificiary.fromJson(benificiary))) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Benificiario criado com sucesso',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Erro ao criar benificiario',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
              }
            } else {
              Navigator.of(context).pop();
            }
          }
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.block),
            title: Text('Cancelar'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.save),
            title: Text('Guardar'),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
