using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionFellingPart
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public double? FellingOperationalArea { get; set; }
        public double? FellingOperationalVolume { get; set; }
        public double? AreaPercent { get; set; }
        public double? VolumePercent { get; set; }
    }
}
