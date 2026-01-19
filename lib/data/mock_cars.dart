import '../models/car.dart';

class MockCars {
  static List<Car> getCars() {
    return [
      Car(
        id: '1',
        make: 'Toyota',
        model: 'Camry',
        year: 2023,
        color: 'Silver',
        pricePerDay: 45.99,
        imageUrl: 'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=800&h=600&fit=crop',
        available: true,
        transmission: 'Automatic',
        seats: 5,
        fuelType: 'Petrol',
        features: [
          'GPS Navigation',
          'Bluetooth',
          'Air Conditioning',
          'Backup Camera',
          'Cruise Control',
        ],
        description:
            'A reliable and comfortable sedan perfect for city driving and long trips.',
      ),
      Car(
        id: '2',
        make: 'Honda',
        model: 'CR-V',
        year: 2024,
        color: 'Black',
        pricePerDay: 65.99,
        imageUrl: 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800&h=600&fit=crop',
        available: true,
        transmission: 'Automatic',
        seats: 5,
        fuelType: 'Hybrid',
        features: [
          'GPS Navigation',
          'Bluetooth',
          'Air Conditioning',
          'Backup Camera',
          'Cruise Control',
          'Sunroof',
          'Leather Seats',
        ],
        description:
            'Spacious SUV with excellent fuel economy, ideal for families and outdoor adventures.',
      ),
      Car(
        id: '3',
        make: 'BMW',
        model: '3 Series',
        year: 2023,
        color: 'Blue',
        pricePerDay: 89.99,
        imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&h=600&fit=crop',
        available: true,
        transmission: 'Automatic',
        seats: 5,
        fuelType: 'Petrol',
        features: [
          'GPS Navigation',
          'Bluetooth',
          'Air Conditioning',
          'Backup Camera',
          'Cruise Control',
          'Sunroof',
          'Leather Seats',
          'Premium Sound System',
          'Heated Seats',
        ],
        description:
            'Luxury sedan with premium features and exceptional driving performance.',
      ),
    ];
  }
}
