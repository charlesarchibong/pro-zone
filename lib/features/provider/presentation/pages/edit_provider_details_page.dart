import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/core/notice/flush_bar_notice.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';
import 'package:prozone_app/features/provider/presentation/widgets/custom_button_widget.dart';
import 'package:prozone_app/features/provider/presentation/widgets/custom_text_form_widget.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EditProviderDetailsPage extends StatefulWidget {
  final ProviderEntity providerEntity;
  const EditProviderDetailsPage({
    Key key,
    @required this.providerEntity,
  }) : super(key: key);
  @override
  _EditProviderDetailsPageState createState() =>
      _EditProviderDetailsPageState();
}

class _EditProviderDetailsPageState extends State<EditProviderDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  ValueNotifier<double> _rating = ValueNotifier(0.0);
  ValueNotifier<String> _activeStatus = ValueNotifier('Pending');
  ProviderTypeEntity selectedProviderType;
  StateEntity selectedStateEntity;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, serviceProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            title: Text(
              "Edit Provider",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: serviceProvider.loading,
                  builder: (context, loading, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldWidget(
                          controller: _nameController,
                          hintText: 'Provider Name',
                          obscureText: false,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFieldWidget(
                          controller: _descriptionController,
                          hintText: 'Provider Description',
                          obscureText: false,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFieldWidget(
                          controller: _addressController,
                          hintText: 'Provider Address',
                          obscureText: false,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Provider Rating',
                          style: TextStyle(
                            color: Color(0xff323232),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _rating,
                          builder: (context, rating, child) {
                            return SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (v) {
                                //print(v);
                                _rating.value = v;
                              },
                              starCount: 5,
                              rating: rating,
                              size: 40.0,
                              isReadOnly: false,
                              color: Colors.green,
                              borderColor: Colors.green,
                              spacing: 0.0,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Provider Active Status',
                          style: TextStyle(
                            color: Color(0xff323232),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _dropDownSelectWidget(
                          ValueListenableBuilder(
                            valueListenable: _activeStatus,
                            builder: (context, status, child) {
                              return DropdownButton<String>(
                                items: <String>['Active', 'Pending']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                isExpanded: true,
                                underline: SizedBox(),
                                value: status,
                                onChanged: (value) {
                                  _activeStatus.value = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select Provider Type',
                          style: TextStyle(
                            color: Color(0xff323232),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _dropDownSelectWidget(
                          SearchableDropdown<ProviderTypeEntity>.single(
                            value: selectedProviderType,
                            isExpanded: true,
                            hint: Text('Select Provider Type'),
                            items: serviceProvider.providerTypes
                                .map((ProviderTypeEntity value) {
                              return new DropdownMenuItem<ProviderTypeEntity>(
                                value: value,
                                child: new Text(value.name),
                              );
                            }).toList(),
                            searchHint: "Search Provider Type",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              // height: -4,
                              color: Color(
                                0xFF29304D,
                              ),
                            ),
                            onChanged: (_) {
                              setState(() {
                                selectedProviderType = _;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Provider Provider State',
                          style: TextStyle(
                            color: Color(0xff323232),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _dropDownSelectWidget(
                          SearchableDropdown<StateEntity>.single(
                            value: selectedStateEntity,
                            isExpanded: true,
                            hint: Text('Select Provider Type'),
                            items:
                                serviceProvider.states.map((StateEntity value) {
                              return new DropdownMenuItem<StateEntity>(
                                value: value,
                                child: new Text(value.name),
                              );
                            }).toList(),
                            searchHint: "Search Provider State",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              // height: -4,
                              color: Color(
                                0xFF29304D,
                              ),
                            ),
                            onChanged: (_) {
                              setState(() {
                                selectedStateEntity = _;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtonWidget(
                          buttonText: 'Submit',
                          onTap: loading
                              ? null
                              : () {
                                  _submit();
                                },
                        ),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  Widget _dropDownSelectWidget(Widget child) {
    return Container(
      // height: 50,
      decoration: BoxDecoration(
        color: Color(0xfff0eded),
        borderRadius: BorderRadius.circular(6),
        border: new Border.all(
          color: Colors.white60,
          width: 1.0,
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          // top: 2.5,
          left: 10,
        ),
        child: child,
      ),
    );
  }

  void _submit() async {
    final validated = Provider.of<ServiceProvider>(context, listen: false)
        .validateAddProviderForm(
      address: _addressController.text,
      description: _descriptionController.text,
      name: _nameController.text,
      providerTypeEntity: selectedProviderType,
      stateEntity: selectedStateEntity,
    );
    validated.fold((l) {
      FlushBarNotification.showErrorMessage(
        context: context,
        message: FailureToMessage.mapFailureToMessage(l),
        title: "Error",
      );
    }, (r) async {
      ProviderEntity providerEntity = ProviderEntity(
        address: _addressController.text,
        id: widget.providerEntity.id,
        name: _nameController.text,
        rating: _rating.value.toInt(),
        activeStatus: _activeStatus.value,
        description: _descriptionController.text,
        providerTypeEntity: selectedProviderType,
        state: selectedStateEntity,
      );
      final added = await Provider.of<ServiceProvider>(context, listen: false)
          .editProvider(providerEntity);
      added.fold((l) {
        FlushBarNotification.showErrorMessage(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
          title: "Error",
        );
      }, (r) {
        FlushBarNotification.showSuccessMessage(
          context: context,
          message: 'Provider was added successfully',
          title: "Success",
        );
      });
    });
  }

  void _loadData() async {
    _nameController.text = widget.providerEntity.name;
    _descriptionController.text = widget.providerEntity.description;
    _addressController.text = widget.providerEntity.address;
    _activeStatus.value = widget.providerEntity.activeStatus;
    _rating.value = widget.providerEntity.rating == null
        ? 0.0
        : widget.providerEntity.rating.toDouble();
    selectedProviderType = widget.providerEntity.providerTypeEntity;
    selectedStateEntity = widget.providerEntity.state;

    final states = await Provider.of<ServiceProvider>(context, listen: false)
        .getStateList();
    states.fold((l) {
      FlushBarNotification.showErrorMessage(
        context: context,
        message: FailureToMessage.mapFailureToMessage(l),
        title: "Error",
      );
    }, (r) => print(r.length));

    final providerType =
        await Provider.of<ServiceProvider>(context, listen: false)
            .getProviderTypeList();
    providerType.fold((l) {
      FlushBarNotification.showErrorMessage(
        context: context,
        message: FailureToMessage.mapFailureToMessage(l),
        title: "Error",
      );
    }, (r) => print(r.length));
  }
}
