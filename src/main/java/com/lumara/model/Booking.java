package com.lumara.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Booking {
    private int id;
    private String name;
    private String roomType;
    private Date checkIn;
    private Date checkOut;
    private Timestamp createdAt;

    // Getter functios
    public int getId() { return id; }
    public String getName() { return name; }
    public String getRoomType() { return roomType; }
    public Date getCheckIn() { return checkIn; }
    public Date getCheckOut() { return checkOut; }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters functions
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setRoomType(String roomType) { this.roomType = roomType; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    
}