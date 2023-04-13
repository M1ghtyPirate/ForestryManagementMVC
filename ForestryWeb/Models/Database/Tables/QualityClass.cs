using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class QualityClass
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? QualityClassID { get; set; }
        public int Number { get; set; }
        public bool IsHigh { get; set; }
    }
}
