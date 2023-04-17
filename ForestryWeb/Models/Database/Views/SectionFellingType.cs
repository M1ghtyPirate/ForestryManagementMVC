﻿using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionFellingType
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public double? FellingOperationalVolume { get; set; }
        public double? Area { get; set; }
        public double? OperationalVolumePerHectare { get; set; }
        public double? AvgGrowth { get; set; }
        public double? AvgGrowthPerHectare { get; set; }
        public string FellingType { get; set; }
    }
}
