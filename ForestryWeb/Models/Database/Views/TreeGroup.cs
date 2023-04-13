using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class TreeGroup
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid TreeSpeciesID { get; set; }
        public string TreeSpeciesName { get; set; }
        public bool IsDeciduous { get; set; }
        public Guid QualityClassID { get; set; }
        public int QualityClass { get; set; }
        public bool IsHigh { get; set; }
        public Guid AgeClassID { get; set; }
        public int AgeClass { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
        public Guid? SectionID { get; set; }
    }
}
