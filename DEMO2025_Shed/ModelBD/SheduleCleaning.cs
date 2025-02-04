using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelBD;

public partial class SheduleCleaning
{
    public int CleanId { get; set; }

    public int UserId { get; set; }

    public int RoomFondId { get; set; }

    public DateTime DateTimeStart { get; set; }

    public DateTime DateTimeEnd { get; set; }

    public virtual User User { get; set; } = null!;
}
