using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class Section
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? SectionID { get; set; }
        public string Name { get; set; }
    }
}
