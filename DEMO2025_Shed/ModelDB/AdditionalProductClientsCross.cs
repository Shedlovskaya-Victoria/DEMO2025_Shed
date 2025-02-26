using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelDB;

public partial class AdditionalProductClientsCross
{
    public int CrossId { get; set; }

    public int UserId { get; set; }

    public DateOnly PaymentDate { get; set; }

    public int AdditionalProductId { get; set; }

    public virtual AdditionalProduct AdditionalProduct { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
