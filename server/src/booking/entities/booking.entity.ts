import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { User } from '../../auth/entities/user.entity';
import { Massage } from '../../massage/entities/massage.entity';

@Entity('bookings')
export class Booking {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  booking_time: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

  @ManyToOne(() => Massage, (massage) => massage.booking)
  @JoinColumn({ name: 'massage' })
  massage_id: Massage;

  @ManyToOne(() => User, (user) => user.booking)
  @JoinColumn({ name: 'user' })
  user_id: User;
}
