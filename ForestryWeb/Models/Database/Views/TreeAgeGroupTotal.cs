using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class TreeAgeGroupTotal
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid TreeSpeciesID { get; set; }
        public string TreeSpeciesName { get; set; }
        public Guid AgeClassID { get; set; }
        public int AgeClass { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
    }
}
