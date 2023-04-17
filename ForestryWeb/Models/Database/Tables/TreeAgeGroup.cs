using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class TreeAgeGroup
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? TreeAgeGroupID { get; set; }
        public Guid TreeQualityGroupID { get; set; }
        public Guid AgeClassID { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Area { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Volume { get; set; }
    }
}
