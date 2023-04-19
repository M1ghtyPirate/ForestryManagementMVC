using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class SectionAllocation
    {
        public Guid ForestryID { get; set; }
        public Guid TreeSpeciesID { get; set; }
        public int QualityClass { get; set; }
        public string SectionName { get; set; }
    }
}
