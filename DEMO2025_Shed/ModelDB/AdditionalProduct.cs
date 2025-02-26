using System;
using System.Collections.Generic;

namespace DEMO2025_Shed.ModelDB;

public partial class AdditionalProduct
{
    public int AdditionalProductId { get; set; }

    public string Title { get; set; } = null!;

    public string? Description { get; set; }

    public decimal Cost { get; set; }

    public virtual ICollection<AdditionalProductClientsCross> AdditionalProductClientsCrosses { get; set; } = new List<AdditionalProductClientsCross>();
}
