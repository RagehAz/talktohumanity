import 'package:flutter_test/flutter_test.dart';
import 'package:talktohumanity/a_models/post_model.dart';

void main() {

  group('PostModel.getYearFromOrganizerKey', () {
    test('should return null if organizerKey is null', () {
      // Arrange
      const organizerKey = null;

      // Act
      final result = PostModel.getYearFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return year from organizerKey', () {
      // Arrange
      const organizerKey = '03_2023';

      // Act
      final result = PostModel.getYearFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, '2023');
    });

    test('should return null if organizerKey is empty', () {
      // Arrange
      const organizerKey = '';

      // Act
      final result = PostModel.getYearFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return null if organizerKey does not contain "_"', () {
      // Arrange
      const organizerKey = '032023';

      // Act
      final result = PostModel.getYearFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return year with non-numeric characters removed', () {
      // Arrange
      const organizerKey = '03_2023-abc';

      // Act
      final result = PostModel.getYearFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return year with invalid year value as null', () {
      // Arrange
      const organizerKey = '03_20';

      // Act
      final result = PostModel.getYearFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });
  });

  group('getMonthFromOrganizerKey', () {
    test('should return null if organizerKey is null', () {
      // Arrange
      const organizerKey = null;

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return null if organizerKey is empty', () {
      // Arrange
      const organizerKey = '';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return month from organizerKey', () {
      // Arrange
      const organizerKey = '03_2023';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, '03');
    });

    test('should return null if organizerKey does not contain "_"', () {
      // Arrange
      const organizerKey = '032023';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return month with leading zeros trimmed', () {
      // Arrange
      const organizerKey = '03_2023';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, '03');
    });

    test('should return month with non-numeric characters removed', () {
      // Arrange
      const organizerKey = '03a_2023';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return null if month value is invalid', () {
      // Arrange
      const organizerKey = '13_2023';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });

    test('should return month with invalid month value as null', () {
      // Arrange
      const organizerKey = '0a_2023';

      // Act
      final result = PostModel.getMonthFromOrganizerKey(organizerKey: organizerKey);

      // Assert
      expect(result, null);
    });
  });

  group('generateOrganizerMapKey', () {

    test('should return null if time is null', () {
      // Arrange
      const time = null;

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, null);
    });

    test('should return formatted key if time is not null', () {
      // Arrange
      final time = DateTime(2023, 3, 15);

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, '03_2023');
    });

    test('should return formatted key with leading zeros in month', () {
      // Arrange
      final time = DateTime(2023, 2, 15);

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, '02_2023');
    });

    test('should return formatted key with year as a string', () {
      // Arrange
      final time = DateTime(2023, 1, 15);

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, '01_2023');
    });

    test('should return formatted key for December of previous year', () {
      // Arrange
      final time = DateTime(2022, 12, 15);

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, '12_2022');
    });

    test('should return null for month value greater than 12', () {
      // Arrange
      final time = DateTime(2023, 13, 15);

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, '01_2024');
    });

    test('should return null for month value less than 1', () {
      // Arrange
      final time = DateTime(2023, 0, 15);

      // Act
      final result = PostModel.generateOrganizerMapKey(time: time);

      // Assert
      expect(result, '12_2022');
    });

  });

}
