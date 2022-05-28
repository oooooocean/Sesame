part of 'pet_info_page.dart';

class RowListSelection extends StatelessWidget with ThemeMixin {
  final List<String> titles;
  final int selectedIndex;
  final SelectCallBack? selectCallBack;
  const RowListSelection(
      {Key? key,
      this.titles = const <String>[],
      this.selectedIndex = 0,
      this.selectCallBack})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: titles
            .asMap()
            .entries
            .map((e) => SizedBox(
                  width: 60,
                  height: 40,
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    e.key == selectedIndex
                                        ? Colors.pink
                                        : borderColor)),
                            onPressed: () {
                              selectCallBack!(e.key);
                            },
                            child: Text(
                              e.value,
                              style: TextStyle(
                                  color: e.key == selectedIndex
                                      ? Colors.white
                                      : secondaryColor),
                            )),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ))
            .toList(),
      );
}

class PetInfoMenuItem extends StatelessWidget {
  final String title;
  final String? rightTitle;
  final int? rightSelectedIndex;
  final List<String>? rightSelectionList;
  final VoidCallback? onPressed;
  final SelectCallBack? selectCallBack;
  const PetInfoMenuItem(
      {Key? key,
      this.title = "",
      this.rightTitle,
      this.rightSelectedIndex,
      this.rightSelectionList,
      this.selectCallBack,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 12.0,
                  right: 10.0,
                  bottom: 10.0,
                ),
                child: Row(children: _rowContent)),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(
                color: Colors.black12,
              ),
            )
          ],
        ),
      );

  List<Widget> get _rowContent {
    if (rightSelectionList != null) {
      return [
        Text(title,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w200)),
        Expanded(
            flex: 1,
            child: RowListSelection(
              titles: rightSelectionList!,
              selectedIndex: rightSelectedIndex!,
              selectCallBack: (index) {
                selectCallBack!(index);
              },
            ))
      ];
    }
    return [
      Expanded(
          child: Text(
        title,
        style: const TextStyle(
            color: Colors.black54, fontSize: 16.0, fontWeight: FontWeight.w200),
      )),
      Expanded(
          child: Text(
        rightTitle!,
        textAlign: TextAlign.right,
        style: const TextStyle(
            color: Colors.black54, fontSize: 16.0, fontWeight: FontWeight.w200),
      )),
      const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      )
    ];
  }
}
