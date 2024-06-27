package com.samuel.tcc.authapi.utils;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class EpochConverter {
    public static Date convert(long millisecondsSinceEpoch) {
        Instant instant = Instant.ofEpochMilli(millisecondsSinceEpoch);

        return Date.from(instant);
    }
}
