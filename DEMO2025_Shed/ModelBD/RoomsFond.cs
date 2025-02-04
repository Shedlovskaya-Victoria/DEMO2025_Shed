using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelBD;

public partial class RoomsFond
{
    public int RoomsFondId { get; set; }

    public int Floor { get; set; }

    public int CategoryRoomId { get; set; }

    public int? Number { get; set; }

    public int RoomStatusId { get; set; }

    public decimal Price { get; set; }

    public virtual CategoriesRoom CategoryRoom { get; set; } = null!;

    public virtual RoomsStatus RoomStatus { get; set; } = null!;
}
