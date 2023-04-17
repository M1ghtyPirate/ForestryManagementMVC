using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class AgeClass
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? AgeClassID { get; set; }
        public int Number { get; set; }
        public int DeciduousMidAge { get; set; }
        public int ConiferousMidAge { get; set; }
    }
}
