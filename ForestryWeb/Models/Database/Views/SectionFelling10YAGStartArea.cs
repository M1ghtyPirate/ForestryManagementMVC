using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionFelling10YAGStartArea
    {
        public Guid? ForestryID { get; set; }
        public string? ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public Guid AgeClassID { get; set; }
        public int AgeClass { get; set; }
        public bool? IsDeciduous { get; set; }
        public double? Area { get; set; }
    }
}
