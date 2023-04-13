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
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? LargePercent { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? MediumPercent1 { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? MediumPercent2 { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? MediumPercentTotal { get; set; }
    }
}
