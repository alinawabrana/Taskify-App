import 'package:flutter/material.dart';

class ACloudHelperFunctions {
  /// Helper function to check the state of a single database record.
  ///
  /// Returns a Widget based on the state of the snapshot
  /// Id data is still loading, it returns a CircularProgressIndicator
  /// If no data is found, it returns a generic 'No Data Found' message.
  /// If an error occurs, It returns a generic error message
  /// Otherwise, it returns null.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasError || snapshot.data == null) {
      return const Center(child: Text('No Data Found'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Helper function to check the state of multiple (list) database record
  ///
  /// Returns a Widget based on the state of the snapshot
  /// Id data is still loading, it returns a CircularProgressIndicator
  /// If no data is found, it returns a generic 'No Data Found' message.
  /// If an error occurs, It returns a generic error message
  /// Otherwise, it returns null.
  static Widget? checkMultipleRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }
}
