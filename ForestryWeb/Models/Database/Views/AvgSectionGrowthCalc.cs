using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class AvgSectionGrowthCalc
    {
        public Guid TreeSpeciesID { get; set; }
        public string TreeSpeciesName { get; set; }
        public Guid QualityClassID { get; set; }
        public int QualityClass { get; set; }
        public int Age { get; set; }
        public double AvgHeight { get; set; }
        public double AvgDiameter { get; set; }
        public double AvgGrowth { get; set; }
        public double? CurrentGrowth { get; set; }
        public double VolumePerHectare { get; set; }
        public double? LargeOutputPercent { get; set; }
        public double? LargeVolume { get; set; }
        public double? LargeAvgGrowth { get; set; }
        public double? MediumOutputPercent { get; set; }
        public double? MediumVolume { get; set; }
        public double? MediumAvgGrowth { get; set; }
        public double? AvgProductGrowth { get; set; }
    }
}
