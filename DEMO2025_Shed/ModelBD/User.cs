using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelBD;

public partial class User
{
    public int UserId { get; set; }

    public int RoleId { get; set; }

    public string Fio { get; set; } = null!;

    public string Login { get; set; } = null!;

    public string Password { get; set; } = null!;

    public bool? IsBlocked { get; set; }

    public virtual ICollection<AdditionalProductClientsCross> AdditionalProductClientsCrosses { get; set; } = new List<AdditionalProductClientsCross>();

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();

    public virtual Role Role { get; set; } = null!;

    public virtual ICollection<SheduleCleaning> SheduleCleanings { get; set; } = new List<SheduleCleaning>();
}
