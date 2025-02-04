using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelBD;

public partial class CategoriesRoom
{
    public int CategoryId { get; set; }

    public string Title { get; set; } = null!;

    public virtual ICollection<RoomsFond> RoomsFonds { get; set; } = new List<RoomsFond>();
}
