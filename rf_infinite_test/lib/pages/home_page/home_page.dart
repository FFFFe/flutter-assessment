import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rf_infinite_test/blocs/contact/contact_bloc.dart';
import 'package:rf_infinite_test/cubits/media_selector/media_selector_cubit.dart';
import 'package:rf_infinite_test/gen/assets.gen.dart';
import 'package:rf_infinite_test/pages/home_page/add_contact_widget.dart';
import 'package:rf_infinite_test/pages/home_page/contact_widget.dart';
import 'package:rf_infinite_test/pages/home_page/filter_widget.dart';
import 'package:rf_infinite_test/pages/home_page/search_widget.dart';
import 'package:rf_infinite_test/utils/debounce.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Debounce debounce = Debounce(milliseconds: 3000);

  @override
  void initState() {
    super.initState();
    // debounce.run(() {
    //   context.read<ContactBloc>().add(const FetchContactEvent());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state.contactStatus == ContactStatus.loading) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    content: Row(children: const [
                      Text('Synchonizing contacts...'),
                      SizedBox(width: 10.0),
                      SizedBox.square(
                        dimension: 25.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    ]),
                  ));
        } else if (state.contactStatus == ContactStatus.loaded) {
          Navigator.pop(context);
        } else if (state.contactStatus == ContactStatus.error) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(
                      state.customError.errMsg,
                      style: const TextStyle(height: 1.5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      )
                    ],
                  ));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          title: const Text(
            'My Contacts',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            InkResponse(
              onTap: () {
                context.read<ContactBloc>().add(const FetchContactEvent());
              },
              radius: 20.0,
              child: Assets.images.refreshIcon.image(),
            ),
          ],
        ),
        body: Column(
          children: [
            SearchWidget(),
            const FilterWidget(),
            const Expanded(child: ContactWidget()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newContact = await showModalBottomSheet(
              isScrollControlled: true,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0))),
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return BlocProvider<MediaSelectorCubit>(
                  create: (context) => MediaSelectorCubit(),
                  child: Builder(builder: (context) {
                    return const AddContactWidget();
                  }),
                );
              },
            );

            if (mounted && newContact != null) {
              context.read<ContactBloc>().add(
                    AddContactEvent(
                      contact: newContact,
                    ),
                  );
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
