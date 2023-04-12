using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class ForestryAreasPercentage
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public double? ForestLocal { get; set; }
        public double? ForestTotal { get; set; }
        public double? FellingLocal { get; set; }
        public double? FellingTotal { get; set; }
        public double? BurntLocal { get; set; }
        public double? BurntTotal { get; set; }
        public double? EmptyLocal { get; set; }
        public double? EmptyTotal { get; set; }
        public double? ThinLocal { get; set; }
        public double? ThinTotal { get; set; }
        public double? NonForestForestLocal { get; set; }
        public double? NonForestForestTotal { get; set; }
        public int? TotalForestLocal { get; set; }
        public double? TotalForestTotal { get; set; }
        public double? FieldLocal { get; set; }
        public double? FieldTotal { get; set; }
        public double? PastureLocal { get; set; }
        public double? PastureTotal { get; set; }
        public double? WaterLocal { get; set; }
        public double? WaterTotal { get; set; }
        public double? RoadLocal { get; set; }
        public double? RoadTotal { get; set; }
        public double? HouseLocal { get; set; }
        public double? HouseTotal { get; set; }
        public double? SwampLocal { get; set; }
        public double? SwampTotal { get; set; }
        public double? OtherLocal { get; set; }
        public double? OtherTotal { get; set; }
        public int? TotalNonForestLocal { get; set; }
        public double? TotalNonForestTotal { get; set; }
        public int? TotalAreaLocal { get; set; }
        public int? TotalAreaTotal { get; set; }
    }
}
