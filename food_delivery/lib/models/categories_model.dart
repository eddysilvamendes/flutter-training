// ignore_for_file: prefer_collection_literals, unnecessary_this

class Categories {
  int? _totalSize;
  int? _parent_id;
  int? _offset;
  late List<CategoriesModel> _categories;
  List<CategoriesModel> get categories => _categories;

  Categories({
    required totalSize,
    required parent_id,
    required offset,
    required categories,
  }) {
    this._totalSize = totalSize;
    this._parent_id = parent_id;
    this._offset = offset;
    this._categories = categories;
  }

  Categories.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _parent_id = json['parent_id'];
    _offset = json['offset'];
    if (json['categories'] != null) {
      _categories = <CategoriesModel>[];
      json['categories'].forEach((v) {
        _categories.add(CategoriesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_size'] = _totalSize;
    data['parent_id'] = _parent_id;
    data['offset'] = _offset;
    if (_categories != null) {
      data['categories'] = _categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesModel {
  int? id;
  String? title;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  int? order;
  String? description;

  CategoriesModel({
    this.id,
    this.title,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.description,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    order = json['order'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['parentId'] = parentId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['order'] = order;
    data['description'] = description;
    return data;
  }
}
