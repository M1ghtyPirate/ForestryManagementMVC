using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class NonForestAreas
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? NonForestAreaID { get; set; }
        public Guid ForestryID { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Field { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Pasture { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Water { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Road { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double House { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Other { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public double Swamp { get; set; }
        //[DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        //public double Total { get; set; }
    }
}
