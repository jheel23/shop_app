import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product-page';

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _keyforsubmit = GlobalKey<FormState>();
  var _editProduct =
      Product(id: '', imageUrl: '', description: '', price: 0.0, title: '');
  var _isInit =
      true; //just a marker because didchangeDependencies runs multiple times so to make sure modalroute doesn't run every time
  //because we need the data only once
  var _initValues = {
    'title': '',
    'id': '',
    'description': '',
    'price': '',
  };
  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    _imageController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        _editProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId as String);
        _initValues = {
          'title': _editProduct.title,
          'id': _editProduct.id,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
        };
        _imageController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  //To avoid memory leak due to FocusNode() we must use dispose()
//Below We are doing a next level safety protocol💀⚠️⚠️
  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _imageController.removeListener(_updateImageUrl);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus || !_imageController.text.isEmpty) {
      setState(() {});
    }
  }

//VALIDATION and SAVING
  void _saveForm() {
    final isValid = _keyforsubmit.currentState!.validate();
    if (!isValid) {
      return;
    }
    _keyforsubmit.currentState!.save(); //Saving the form
    if (_editProduct.id != '') {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editProduct)
          .then((_) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _keyforsubmit,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 10),
                TextFormField(
                  initialValue: _initValues['title'],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Title!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        isFavorite: _editProduct.isFavorite,
                        id: _editProduct.id,
                        imageUrl: _editProduct.imageUrl,
                        description: _editProduct.description,
                        price: _editProduct.price,
                        title: value.toString());
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 15),
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'anton',
                      color: Colors.white,
                    ),
                    hintText: 'Enter the product name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    floatingLabelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'anton',
                      color: Colors.orange,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: Colors
                          .white), //This will set the colors of user input text/value
                  cursorHeight: 25,
                  cursorColor: Colors.white,

                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  onSaved: (value) {
                    _editProduct = Product(
                        isFavorite: _editProduct.isFavorite,
                        id: _editProduct.id,
                        imageUrl: _editProduct.imageUrl,
                        description: _editProduct.description,
                        price: double.parse(value as String),
                        title: _editProduct.title);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Price!';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter a valid Price';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter a price greater than zero';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 15),
                    labelText: 'Price',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'anton',
                      color: Colors.white,
                    ),
                    hintText: 'Enter the price of product',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    floatingLabelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'anton',
                      color: Colors.orange,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  cursorHeight: 25,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  onSaved: (value) {
                    _editProduct = Product(
                        isFavorite: _editProduct.isFavorite,
                        id: _editProduct.id,
                        imageUrl: _editProduct.imageUrl,
                        description: value.toString(),
                        price: _editProduct.price,
                        title: _editProduct.title);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Description!';
                    }
                    if (value.length < 10) {
                      return 'Please describe it in  more than 10 Characters!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 15),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'anton',
                      color: Colors.white,
                    ),
                    hintText: 'Enter the product description',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    floatingLabelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'anton',
                      color: Colors.orange,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  style: TextStyle(color: Colors.white),
                  cursorHeight: 25,
                  cursorColor: Colors.white,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: _imageController.text.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Enter the Image URL First!',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(_imageController.text),
                                ),
                              )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      //Here we added expanded because TextField by default take as much space as it can and since we are using it
                      child: TextFormField(
                        //we cant use InitialValue here coz we are ae using a tectcontroller for imageUrl thats why !!
                        //solution is inside didChangeDependencies
                        onSaved: (value) {
                          _editProduct = Product(
                              isFavorite: _editProduct.isFavorite,
                              id: _editProduct.id,
                              imageUrl: value.toString(),
                              description: _editProduct.description,
                              price: _editProduct.price,
                              title: _editProduct.title);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a ImageUrl';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Enter a valid URL.';
                          }
                          if (!value.endsWith('.jpg') &&
                              !value.endsWith('.png')) {
                            return 'Make Sure URL is in PNG or JPG format.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 15),
                          errorMaxLines: 2,
                          labelText: 'Image',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'anton',
                            color: Colors.white,
                          ),
                          hintText: 'Input image URL',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          floatingLabelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'anton',
                            color: Colors.orange,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _imageController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        style: TextStyle(color: Colors.white),
                        cursorHeight: 25,
                        cursorColor: Colors.white,
                        focusNode: _imageFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) => _saveForm(),
                      ),
                    ),
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
