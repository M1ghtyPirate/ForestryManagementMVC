using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class TreeQualityGroup
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? TreeQualityGroupID { get; set; }
        public Guid ForestryID { get; set; }
        public Guid TreeSpeciesID { get; set; }
        public Guid QualityClassID { get; set; }
        public Guid? SectionID { get; set; }
    }
}
