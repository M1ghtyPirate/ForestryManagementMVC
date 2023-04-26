using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class GrowthRate
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? GrowthRateID { get; set; }
        public Guid TreeSpeciesID { get; set; }
        public Guid QualityClassID { get; set; }
        public int Age { get; set; }
        public double AvgHeight { get; set; }
        public double AvgDiameter { get; set; }
        public double VolumePerHectare { get; set; }
        public double AvgGrowth { get; set; }
        public double? CurrentGrowth { get; set; }
    }
}
