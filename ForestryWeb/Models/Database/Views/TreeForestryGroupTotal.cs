using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class TreeForestryGroupTotal
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
    }
}
