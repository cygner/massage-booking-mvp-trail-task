import { Controller, Get } from '@nestjs/common';
import { MassageService } from './massage.service';

@Controller('massage')
export class MassageController {
  constructor(private readonly massageService: MassageService) {}

  @Get()
  findAll() {
    return this.massageService.findAll();
  }
}
