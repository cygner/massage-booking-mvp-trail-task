import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  BeforeInsert,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm';
import * as crypto from 'crypto';
import { Booking } from '../../booking/entities/booking.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ unique: true })
  email: string;

  @Column()
  password: string;

  @Column({ nullable: true })
  firebase_token: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

  @OneToMany(() => Booking, (booking) => booking.user_id)
  booking: Booking[];

  @BeforeInsert()
  hashPassword() {
    const salt = crypto.randomBytes(16).toString('hex');

    const hash = crypto
      .pbkdf2Sync(this.password, salt, 1000, 64, 'sha256')
      .toString('hex');

    this.password = `${salt}:${hash}`;
  }

  comparePassword(plainPassword: string): boolean {
    const [salt, storedHash] = this.password.split(':');

    const hash = crypto
      .pbkdf2Sync(plainPassword, salt, 1000, 64, 'sha256')
      .toString('hex');

    return storedHash === hash;
  }
}
