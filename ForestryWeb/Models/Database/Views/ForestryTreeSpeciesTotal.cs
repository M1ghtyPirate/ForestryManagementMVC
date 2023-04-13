using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class ForestryTreeSpeciesTotal
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public double? Area { get; set; }
        public double? AvgQuality { get; set; }
        public double? Volume { get; set; }
        public double? AvgVolume { get; set; }
        public double? AvgGrowth { get; set; }
        public double? AvgGrowthPerHectare { get; set; }
        public double? OperationalArea { get; set; }
        public double? OperationalVolume { get; set; }
        public double? AvgOperationalVolume { get; set; }
    }
}
