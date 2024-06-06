package com.samuel.tcc.authapi.infra.mappers;

import com.samuel.tcc.authapi.dto.habit.HabitDTO;
import com.samuel.tcc.authapi.dto.habit.HabitRecordDTO;
import com.samuel.tcc.authapi.entities.habit.Habit;
import com.samuel.tcc.authapi.entities.habit.HabitRecord;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface HabitMapper {
    HabitDTO entityToDTO(Habit entity);
    List<HabitDTO> entityToDTO(List<Habit> entity);

    @Mapping(source = "recordDate", target = "date")
    HabitRecordDTO recordEntityToDTO(HabitRecord entity);
    @Mapping(source = "recordDate", target = "date")

    List<HabitRecordDTO> recordEntityToDTO(List<HabitRecord> entity);

}
