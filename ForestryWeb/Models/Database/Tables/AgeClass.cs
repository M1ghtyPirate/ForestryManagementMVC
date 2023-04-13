using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class AgeClass
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? AgeClassID { get; set; }
        public int Number { get; set; }
        public double DeciduousMidAge { get; set; }
        public double ConiferuousMidAge { get; set; }
    }
}
