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
  massage_id: number;

  @Column()
  user_id: number;

  @Column('datetime')
  booking_time: Date;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

  @ManyToOne(() => Massage, (massage) => massage.booking)
  @JoinColumn({ name: 'massage_id' })
  massage: Massage;

  @ManyToOne(() => User, (user) => user.booking)
  @JoinColumn({ name: 'user_id' })
  user: User;
}
