using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class ForestryAreas
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public double? Forest { get; set; }
        public double? Felling { get; set; }
        public double? Burnt { get; set; }
        public double? Empty { get; set; }
        public double? Thin { get; set; }
        public double? NonForestForest { get; set; }
        public double? TotalForest { get; set; }
        public double? Field { get; set; }
        public double? Pasture { get; set; }
        public double? Water { get; set; }
        public double? Road { get; set; }
        public double? House { get; set; }
        public double? Swamp { get; set; }
        public double? Other { get; set; }
        public double? TotalNonForest { get; set; }
        public double? TotalArea { get; set; }
    }
}
