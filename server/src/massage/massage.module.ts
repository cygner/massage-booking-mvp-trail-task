import { Module } from '@nestjs/common';
import { MassageService } from './massage.service';
import { MassageController } from './massage.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Massage } from './entities/massage.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Massage])],
  controllers: [MassageController],
  providers: [MassageService],
  exports: [MassageService],
})
export class MassageModule {}
