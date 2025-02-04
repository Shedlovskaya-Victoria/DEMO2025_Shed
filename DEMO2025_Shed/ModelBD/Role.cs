using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelBD;

public partial class Role
{
    public int RoleId { get; set; }

    public string Title { get; set; } = null!;

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
