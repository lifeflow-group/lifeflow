import 'package:flutter/material.dart' show DateTimeRange;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/app_database.dart';
import '../datasources/local/dao/habit_exception_dao.dart';
import '../datasources/local/database_provider.dart';
import '../domain/models/habit_exception.dart';

final habitExceptionRepositoryProvider =
    Provider<HabitExceptionRepository>((ref) {
  final dao = ref.read(appDatabaseProvider).habitExceptionDao;
  return HabitExceptionRepository(dao);
});

class HabitExceptionRepository {
  final HabitExceptionDao _dao;

  HabitExceptionRepository(this._dao);

  Future<T> transaction<T>(Future<T> Function() action) {
    return _dao.transaction(action);
  }

  Future<bool> insertHabitException(HabitException exception) async {
    // Convert Model to Companion
    final companion = HabitExceptionsTableData.fromJson(exception.toJson())
        .toCompanion(false);
    // Call service or repository to insert the exception
    final count = await _dao.insertHabitException(companion);
    if (count == 0) return false;
    return true;
  }

  Future<bool> updateHabitException(HabitException exception) async {
    // Convert Model to Companion
    final companion = HabitExceptionsTableData.fromJson(exception.toJson())
        .toCompanion(false);

    // Call service or repository to update the exception
    return await _dao.updateHabitException(companion);
  }

  Future<void> deleteHabitException(String id) async {
    // Call service or repository to delete the HabitException by ID
    await _dao.deleteHabitException(id);
  }

  Future<int> deleteAllExceptionsInSeries(String seriesId) async {
    // Call service or repository to delete all exceptions in the specified series
    return await _dao.deleteAllExceptionsInSeries(seriesId);
  }

  Future<int> deleteFutureExceptionsInSeries(
      String seriesId, DateTime startDate) async {
    // Call service or repository to delete exceptions in the series after the given date
    return await _dao.deleteFutureExceptionsInSeries(seriesId, startDate);
  }

  Future<List<HabitException>> getHabitExceptionsForSeries(
      String seriesId) async {
    // Fetch exceptions for the specified series
    final exceptionsData = await _dao.getHabitExceptionsForSeries(seriesId);

    // Convert Companion list to Model list
    return exceptionsData
        .map((exception) => HabitException.fromJson(exception.toJson()))
        .toList();
  }

  Future<HabitException?> getHabitException(String id) async {
    // Fetch HabitException by ID from the service
    final exceptionData = await _dao.getHabitException(id);

    // Convert Companion to Model
    if (exceptionData != null) {
      return HabitException.fromJson(exceptionData.toJson());
    }
    return null;
  }

  Future<HabitException?> getHabitExceptionByIdAndDate(
      String seriesId, DateTime date) async {
    // Fetch HabitException by series ID and date from the service
    final exceptionData =
        await _dao.getHabitExceptionByIdAndDate(seriesId, date);

    // Convert Companion to Model
    if (exceptionData != null) {
      return HabitException.fromJson(exceptionData.toJson());
    }
    return null;
  }

  Future<List<HabitException>> getExceptionsAfterDate(
      String seriesId, DateTime habitDate) async {
    // Fetch exceptions after the given date for the specified series
    final exceptionsData =
        await _dao.getExceptionsAfterDate(seriesId, habitDate);

    // Convert Companion list to Model list
    return exceptionsData
        .map((exception) => HabitException.fromJson(exception.toJson()))
        .toList();
  }

  /// Get habit exceptions within a date range for specific series
  Future<List<HabitException>> getHabitExceptionsDateRange(
      DateTimeRange range, List<String> seriesIds) async {
    // Get exception data from DAO
    final exceptionData =
        await _dao.getHabitExceptionsDateRange(range, seriesIds);

    // Convert DAO data to domain models
    return exceptionData
        .map((exception) => HabitException.fromJson(exception.toJson()))
        .toList();
  }
}
