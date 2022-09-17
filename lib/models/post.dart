import 'package:flutter/material.dart';

class PostInfo{
  int id;
  int category;

  PostInfo(this.id, this.category);
}

class PostData{

  PostInfo postInfo;

  String title;
  String content;
  int likes;
  int views;
  int comments;

  PostData(this.postInfo, this.title, this.content, this.likes, this.views, this.comments);
}