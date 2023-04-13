using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class ForestAreas
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? ForestAreaID { get; set; }
        public Guid ForestryID { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? Felling { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? Burnt { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? Empty { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? Thin { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? Forest { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? Total { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double? TotalNonForest { get; set; }
    }
}
