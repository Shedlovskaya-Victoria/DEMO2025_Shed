using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelDB;

public partial class AllUser
{
    public int UserId { get; set; }

    public int RoleId { get; set; }

    public string Fio { get; set; } = null!;

    public string Login { get; set; } = null!;

    public string Password { get; set; } = null!;
}
