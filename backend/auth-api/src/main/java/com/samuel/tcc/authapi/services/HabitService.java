package com.samuel.tcc.authapi.services;

import com.samuel.tcc.authapi.dto.habit.HabitDTO;
import com.samuel.tcc.authapi.dto.habit.HabitRecordDTO;
import com.samuel.tcc.authapi.entities.habit.Habit;
import com.samuel.tcc.authapi.entities.habit.HabitRecord;
import com.samuel.tcc.authapi.infra.gateways.MotivationMessagesClient;
import com.samuel.tcc.authapi.infra.mappers.HabitMapper;
import com.samuel.tcc.authapi.repositories.HabitRecordRepository;
import com.samuel.tcc.authapi.repositories.HabitRepository;
import com.samuel.tcc.authapi.services.exceptions.HabitNotFoundException;
import com.samuel.tcc.authapi.services.exceptions.UserHasHabitRegisteredException;
import com.samuel.tcc.authapi.services.exceptions.UserNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HabitService {
    private final HabitRepository _repository;
    private final HabitRecordRepository _recordRepository;
    private final UserService _userService;
    private final HabitMapper _mapper;
    private final MotivationMessagesClient _client;


    @Transactional
    public HabitDTO registerHabit(String userEmail, String reason) {
        var user = _userService.getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);

        var optHabit = _repository.findById(user.getId());
        if(optHabit.isPresent()) throw new UserHasHabitRegisteredException();


        Habit habit = new Habit();
        habit.setReason(reason);
        habit.setUser(user);

        var responseDto = _client.getMotivation(_mapper.entityToDTO(habit));
        habit.setMotivation(responseDto.motivation());

        _repository.save(habit);

        return _mapper.entityToDTO(habit);
    }

    @Transactional
    public HabitDTO generateNewMotivation(String userEmail) {
        var user = _userService.getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);
        var habit = _repository.findById(user.getId()).orElseThrow(HabitNotFoundException::new);

        var lastDayModified = habit.getLastModified();
        if(lastDayModified.compareTo(new Date()) <= 0) return _mapper.entityToDTO(habit);

        var responseDTO = _client.getMotivation(_mapper.entityToDTO(habit));
        habit.setMotivation(responseDTO.motivation());

        _repository.save(habit);

        return _mapper.entityToDTO(habit);
    }

    @Transactional
    public void recordHabit(String email) {
        Date today = new Date();

        Habit habit = _repository.findByUserEmail(email).orElseThrow(HabitNotFoundException::new);
        var optRecord = _recordRepository.findByUserEmailAndRecordDate(email, today);
        if(optRecord.isPresent()) return;

        HabitRecord habitRecord = new HabitRecord();
        habitRecord.setHabit(habit);
        habitRecord.setRecordDate(today);
        _recordRepository.save(habitRecord);
    }

    public List<HabitRecordDTO> getHabitRecords(String userEmail, int month, int year) {
        var records = _recordRepository.findByUserEmailAndRecordMonth(userEmail, month, year);

        return _mapper.recordEntityToDTO(records);
    }
}
