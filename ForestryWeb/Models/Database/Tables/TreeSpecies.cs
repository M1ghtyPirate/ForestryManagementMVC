using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class TreeSpecies
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? TreeSpeciesID { get; set; }
        public string Name { get; set; }
        public bool IsDeciduous { get; set; }
        public int OperationalAgeClass { get; set; }
        public int OptimalFellingAge { get; set; }
    }
}
