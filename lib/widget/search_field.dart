import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchFieldWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  // final TextEditingController _searchController;


  const SearchFieldWidget({
    Key? key,
     this.onChanged,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffE8E8E8),
      ),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(Icons.search),
          Flexible(
            child: CupertinoTextField(
              placeholder: 'Enter nickname',
              clearButtonMode: OverlayVisibilityMode.editing,
              textInputAction: TextInputAction.search,
              decoration: BoxDecoration(color: Colors.transparent),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
