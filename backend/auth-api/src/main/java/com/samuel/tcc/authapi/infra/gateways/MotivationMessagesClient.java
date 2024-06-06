package com.samuel.tcc.authapi.infra.gateways;

import com.samuel.tcc.authapi.dto.habit.HabitDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@FeignClient(value = "llm", url = "http://localhost:8000/")
public interface MotivationMessagesClient {
    @RequestMapping(method = RequestMethod.POST, value = "messages/", produces = "application/json", consumes = "application/json")
    HabitDTO getMotivation(@RequestBody HabitDTO dto);
}
