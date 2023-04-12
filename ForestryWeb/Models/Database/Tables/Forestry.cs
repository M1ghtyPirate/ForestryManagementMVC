using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class Forestry
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? ForestryID { get; set; }
        public string Name { get; set; }
        public Guid AuthorID { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime? CreationDate { get; set; }
        public DateTime? EditDate { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public bool? IsShared { get; set; }
    }
}
