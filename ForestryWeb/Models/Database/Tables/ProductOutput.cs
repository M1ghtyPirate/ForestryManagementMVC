using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class ProductOutput
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? ProductOutputID { get; set; }
        public Guid TreeSpeciesID { get; set; }
        public double AvgDiameter { get; set; }
        public double AvgHeight { get; set; }
        public double? LargePercent { get; set; }
        public double? MediumPercent1 { get; set; }
        public double? MediumPercent2 { get; set; }
    }
}
