import { User } from '../auth/entities/user.entity';
import { Booking } from '../booking/entities/booking.entity';
import { Massage } from '../massage/entities/massage.entity';
import { DataSource } from 'typeorm';

class MassageSeederService {
  private dataSource: DataSource;

  constructor() {
    this.dataSource = new DataSource({
      type: 'sqlite',
      database: './database/booking_app.sqlite',
      entities: [Massage, Booking, User],
      synchronize: true,
    });
  }

  async initialize() {
    if (!this.dataSource.isInitialized) {
      await this.dataSource.initialize();
    }
  }

  async seed() {
    await this.initialize();

    const massageRepository = this.dataSource.getRepository(Massage);
    await massageRepository.clear();

    const massages = [
      { name: 'relax', price: 800 },
      { name: 'oil', price: 1000 },
      { name: 'thai', price: 1200 },
    ] as Massage[];

    await massageRepository.save(massages);

    console.log(`Seeded ${massages.length} massages successfully!`);
  }

  async close() {
    await this.dataSource.destroy();
  }
}

async function runSeeder() {
  const seeder = new MassageSeederService();

  try {
    await seeder.seed();
  } catch (error) {
    console.error('Seeding failed:', error);
  } finally {
    await seeder.close();
  }
}

// eslint-disable-next-line @typescript-eslint/no-floating-promises
runSeeder();
