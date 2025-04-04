import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Massage } from './entities/massage.entity';
import { Repository } from 'typeorm';

@Injectable()
export class MassageService {
  constructor(
    @InjectRepository(Massage)
    private massageRepository: Repository<Massage>,
  ) {}

  async findAll() {
    return await this.massageRepository.find();
  }
}
