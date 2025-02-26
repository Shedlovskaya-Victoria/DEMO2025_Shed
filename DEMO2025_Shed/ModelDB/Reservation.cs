using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelDB;

public partial class Reservation
{
    public int ReservId { get; set; }

    public int UsertId { get; set; }

    public int RoomsFondId { get; set; }

    public byte[]? PaymenRoomDocument { get; set; }

    public decimal? CostRoom { get; set; }

    public string? Comments { get; set; }

    public decimal? Discount { get; set; }

    public DateOnly DateIn { get; set; }

    public DateOnly? DateOut { get; set; }

    public virtual User Usert { get; set; } = null!;
}
