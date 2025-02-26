using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelDB;

public partial class RoomsStatus
{
    public int StatusId { get; set; }

    public string Title { get; set; } = null!;

    public virtual ICollection<RoomsFond> RoomsFonds { get; set; } = new List<RoomsFond>();
}
