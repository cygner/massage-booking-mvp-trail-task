import {
  HttpException,
  HttpStatus,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateBookingDto } from './dto/create-booking.dto';
import { Booking } from './entities/booking.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/entities/user.entity';
import { Massage } from 'src/massage/entities/massage.entity';

@Injectable()
export class BookingService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,

    @InjectRepository(Booking)
    private bookingRepository: Repository<Booking>,

    @InjectRepository(Massage)
    private massageRepository: Repository<Massage>,
  ) {}

  async create(
    createBookingDto: CreateBookingDto,
  ): Promise<{ booking_ref_id: number }> {
    const { booking_time, email, massage_id } = createBookingDto;

    const user = await this.usersRepository.findOne({
      where: { email },
    });

    const massage = await this.massageRepository.findOne({
      where: { id: massage_id },
    });

    if (!user) {
      throw new NotFoundException('User with this email not found');
    }

    if (!massage) {
      throw new NotFoundException('Selected massage not found');
    }

    try {
      const bookingObject = this.bookingRepository.create({
        booking_time,
        user_id: user.id,
        massage_id,
      });
      const booking = await this.bookingRepository.save(bookingObject);
      return { booking_ref_id: booking.id };
    } catch (error) {
      throw new HttpException(
        {
          status: HttpStatus.INTERNAL_SERVER_ERROR,
          error: 'Internal server error',
        },
        HttpStatus.INTERNAL_SERVER_ERROR,
        {
          cause: error,
        },
      );
    }
  }

  async findAll() {
    return await this.bookingRepository
      .createQueryBuilder('booking')
      .leftJoinAndSelect('booking.massage_id', 'massage')
      .leftJoinAndSelect('booking.user_id', 'user')
      .getMany();
  }

  findOne(id: number) {
    return `This action returns a #${id} booking`;
  }
}
