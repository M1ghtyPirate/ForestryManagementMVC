using ForestryWeb.Models;
using ForestryWeb.Models.Database;
using ForestryWeb.Models.Database.MVCViews;
using ForestryWeb.Models.Database.Tables;
using ForestryWeb.Models.Database.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Diagnostics;
using System.Linq;

namespace ForestryWeb.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private ApplicationContext db;

        public HomeController(ILogger<HomeController> logger, ApplicationContext context)
        {
            _logger = logger;
            db = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        public async Task<IActionResult> Forestries()
        {
            var forestries = await db.Forestries.ToListAsync();
            var users = await db.Users.ToListAsync();
            var forestriesInfo = new List<Tuple<Forestry, User>>();
            foreach(var f in forestries)
                forestriesInfo.Add(new Tuple<Forestry, User>(f, users.FirstOrDefault(u => u.UserID == f.AuthorID)));
            return View(forestriesInfo);
        }

        public IActionResult AddForestry()
        {
            return View();
        }

        public async Task<IActionResult> EditForestry(Guid ID)
        {
            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            return View("AddForestry", forestry);
        }

        [HttpPost]
        public async Task<IActionResult> AddForestry(Forestry forestry)
        {
            forestry.AuthorID = new Guid("d2c08496-de7e-4277-b068-b642b832b14d");
            if (forestry.ForestryID == null)
                db.Forestries.Add(forestry);
            else
            {
                var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == forestry.ForestryID);
                forestryDB.Name = forestry.Name;
            }
            await db.SaveChangesAsync();
            return RedirectToAction("Forestries");
        }

        public async Task<IActionResult> RemoveForestry(Guid ID)
        {
            var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == ID);
            if (forestryDB != null)
            {
                db.Forestries.Remove(forestryDB);
                await db.SaveChangesAsync();
            }
            return RedirectToAction("Forestries");
        }

        public async Task<IActionResult> Forestry(Guid ID)
        {
            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var user = await db.Users.FirstOrDefaultAsync(u => u.UserID == forestry.AuthorID);
            var areSectionsSet = await db.view_SectionsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID) != null;
            return View(new Tuple<Forestry, User, bool>(forestry, user, areSectionsSet));
        }

        public async Task<IActionResult> ForestryAreas(Guid ID)
        {
            var forestryAreas = await db.view_ForestryAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);
            if (forestryAreas == null)
            {
                var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
                return View("AddForestryAreas", new Tuple<Forestry, ForestryAreas>(forestry, null));
            }
            var forestryAreasPercentage = await db.view_ForestryAreasPercentage.FirstOrDefaultAsync(f => f.ForestryID == ID);
            return View(new Tuple<ForestryAreas, ForestryAreasPercentage>(forestryAreas, forestryAreasPercentage));
        }

        public async Task<IActionResult> EditForestryAreas(Guid ID)
        {
            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var forestryAreas = await db.view_ForestryAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);
            return View("AddForestryAreas", new Tuple<Forestry, ForestryAreas>(forestry, forestryAreas));
        }

        [HttpPost]
        public async Task<IActionResult> AddForestryAreas([Bind(Prefix = "Item2")]ForestryAreas forestryAreas)
        {
            var forestAreasDB = db.ForestAreas.FirstOrDefault(a => a.ForestryID == forestryAreas.ForestryID);
            var nonForestAreasDB = db.NonForestAreas.FirstOrDefault(a => a.ForestryID == forestryAreas.ForestryID);

            var forestAreas = new ForestAreas() 
            { 
                ForestryID = forestryAreas.ForestryID,
                Felling = forestryAreas.Felling ?? 0,
                Burnt = forestryAreas.Burnt ?? 0,
                Empty = forestryAreas.Empty ?? 0,
                Thin = forestryAreas.Thin ?? 0
            };

            var nonForestAreas = new NonForestAreas()
            {
                ForestryID = forestryAreas.ForestryID,
                Field = forestryAreas.Field ?? 0,
                Pasture = forestryAreas.Pasture ?? 0,
                Water = forestryAreas.Water ?? 0,
                Road = forestryAreas.Road ?? 0,
                House = forestryAreas.House ?? 0,
                Other = forestryAreas.Other ?? 0,
                Swamp = forestryAreas.Swamp ?? 0
            };

            if (forestAreasDB == null)
            {
                db.ForestAreas.Add(forestAreas);
                db.NonForestAreas.Add(nonForestAreas);
            }
            else
            {
                forestAreas.ForestAreaID = forestAreasDB.ForestAreaID;
                nonForestAreas.NonForestAreaID = nonForestAreasDB.NonForestAreaID;
                db.Entry(forestAreasDB).CurrentValues.SetValues(forestAreas);
                //forestAreasDB = forestAreas;
                db.Entry(nonForestAreasDB).CurrentValues.SetValues(nonForestAreas);
                //nonForestAreasDB = nonForestAreas;
            }
            await db.SaveChangesAsync();
            return RedirectToAction("ForestryAreas", new { ID = forestryAreas.ForestryID });
        }

        public async Task<IActionResult> ForestryTreeGroups(Guid ID)
        {
            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();

            if (treeGroups == null)
            {
                var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
                return View("AddForestryTreeGroups", new Tuple<Forestry, List<TreeGroup>>(forestry, null));
            }

            var treeAgeGroupsTotal = await db.view_TreeAgeGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryAgeGroupsTotal = await db.view_TreeForestryAgeGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryGroupsTotal = await db.view_TreeForestryGroupsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var treeQualityGroupsTotal = await db.view_TreeQualityGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeSpeciesGroupsTotal = await db.view_TreeSpeciesGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<TreeGroup>, List<TreeQualityGroupTotal>, List<TreeAgeGroupTotal>, List<TreeSpeciesGroupTotal>, List<TreeForestryAgeGroupTotal>, TreeForestryGroupTotal>
                (treeGroups, treeQualityGroupsTotal, treeAgeGroupsTotal, treeSpeciesGroupsTotal, treeForestryAgeGroupsTotal, treeForestryGroupsTotal));
        }

        public async Task<IActionResult> EditForestryTreeGroups(Guid ID)
        {
            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            return View("AddForestryTreeGroups", new Tuple<Forestry, List<TreeGroup>>(forestry, treeGroups));
        }

        [HttpPost]
        public async Task<IActionResult> AddForestryTreeGroups([Bind(Prefix = "Item2")] List<TreeGroup> treeGroups)
        {
            //Сделать: очистка значений, добавление пород.
            var forestryID = treeGroups.FirstOrDefault().ForestryID;
            treeGroups.RemoveAll(g => (g.Area == 0 || g.Area == null) && (g.Volume == 0 ||  g.Volume == null));
            var qualityClassesDB = await db.QualityClasses.ToListAsync();
            var ageClassesDB = await db.AgeClasses.ToListAsync();
            var treeQualityGroupsDB = await db.TreeQualityGroups.Where(g => g.ForestryID == forestryID).ToListAsync();
            var treeQualityGroupsIDs = treeQualityGroupsDB?.Select(g => g.TreeQualityGroupID).ToList() ?? new List<Guid?>();
            var treeAgeGroupsDB = await db.TreeAgeGroups.Where(g => treeQualityGroupsIDs.Contains(g.TreeQualityGroupID)).ToListAsync();
            foreach(var treeGroup in treeGroups)
            {
                var qualityClassID = qualityClassesDB.FirstOrDefault(c => c.Number == treeGroup.QualityClass).QualityClassID;
                var ageClassID = ageClassesDB.FirstOrDefault(c => c.Number == treeGroup.AgeClass).AgeClassID;

                var treeAgeGroup = new TreeAgeGroup() 
                { 
                    AgeClassID = (Guid)ageClassID, 
                    Area = treeGroup.Area ?? 0, 
                    Volume = treeGroup.Volume ?? 0 
                };

                var treeQualityGroupDB = treeQualityGroupsDB?.FirstOrDefault(g => g.TreeSpeciesID == treeGroup.TreeSpeciesID && g.QualityClassID == qualityClassID);

                if (treeQualityGroupDB != null) 
                {
                    treeAgeGroup.TreeQualityGroupID = (Guid)treeQualityGroupDB.TreeQualityGroupID;
                }
                else
                {
                    db.TreeQualityGroups.Add(new TreeQualityGroup()
                    { 
                        ForestryID = forestryID, 
                        TreeSpeciesID = treeGroup.TreeSpeciesID, 
                        QualityClassID = (Guid)qualityClassID
                    });
                    await db.SaveChangesAsync();
                    var newTreeQualityGroup = await db.TreeQualityGroups.FirstOrDefaultAsync(g => g.ForestryID == forestryID && g.TreeSpeciesID == treeGroup.TreeSpeciesID && g.QualityClassID == qualityClassID);
                    treeQualityGroupsDB.Add(newTreeQualityGroup);
                    treeAgeGroup.TreeQualityGroupID = (Guid)newTreeQualityGroup.TreeQualityGroupID;
                }

                var treeAgeGroupDB = treeAgeGroupsDB?.FirstOrDefault(g => g.TreeQualityGroupID == treeAgeGroup.TreeQualityGroupID && g.AgeClassID == ageClassID);

                if (treeAgeGroupDB != null)
                {
                    treeAgeGroup.TreeAgeGroupID = treeAgeGroupDB.TreeAgeGroupID;
                    db.Entry(treeAgeGroupDB).CurrentValues.SetValues(treeAgeGroup);
                }
                else
                {
                    db.TreeAgeGroups.Add(treeAgeGroup);
                }
                await db.SaveChangesAsync();
            }
            return RedirectToAction("ForestryTreeGroups", new { ID = forestryID });
        }

        public async Task<IActionResult> ForestryTreeSpecies(Guid ID)
        {
            var forestryTreeSpecies = await db.view_ForestryTreeSpecies.Where(g => g.ForestryID == ID).ToListAsync();
            var forestryTreeSpeciesTotal = await db.view_ForestryTreeSpeciesTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            return View(new Tuple<List<ForestryTreeSpecies>, ForestryTreeSpeciesTotal> (forestryTreeSpecies, forestryTreeSpeciesTotal));
        }

        public async Task<IActionResult> ForestrySectionGroups(Guid ID)
        {
            var sectionAgeGroups = await db.view_SectionAgeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionAgeGroup>, List<SectionTotal>>(sectionAgeGroups, sectionsTotal));
        }

        public async Task<IActionResult> ForestrySections(Guid ID)
        {
            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new List<SectionTotal>(sectionsTotal));
        }

        public async Task<IActionResult> AvgSectionGrowthCalc(Guid ID)
        {
            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID && (bool)g.IsHigh).ToListAsync();
            var avgSectionGrowthCalc = await db.view_AvgSectionGrowthCalc.ToListAsync();
            return View(new Tuple<List<SectionTotal>, List<AvgSectionGrowthCalc>>(sectionsTotal, avgSectionGrowthCalc));
        }

        public async Task<IActionResult> ForestryFellingSections(Guid ID)
        {
            var sectionFellingAgeGroups = await db.view_SectionFellingAgeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionsFellingVariants = await db.view_SectionsFellingVariants.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionsFellingVariant>, List<SectionFellingAgeGroup>>(sectionsFellingVariants, sectionFellingAgeGroups));
        }

        public async Task<IActionResult> ForestryFellingPeriods(Guid ID)
        {
            var forestryFellingPeriod = await db.view_ForestryFellingPeriods.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var sectionFellingPeriods = await db.view_SectionsFellingPeriods.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<ForestryFellingPeriod, List<SectionFellingPeriod>>(forestryFellingPeriod, sectionFellingPeriods));
        }

        public async Task<IActionResult> ForestrySectionFellingTypes(Guid ID)
        {
            var forestryFellingType = await db.view_ForestryFellingTypes.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var sectionFellingTypes = await db.view_SectionFellingTypes.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<ForestryFellingType, List<SectionFellingType>>(forestryFellingType, sectionFellingTypes));
        }

        public async Task<IActionResult> ForestrySectionFellingParts(Guid ID)
        {
            var forestryFellingPeriod = await db.view_ForestryFellingPeriods.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var SectionFellingParts = await db.view_SectionFellingParts.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<ForestryFellingPeriod, List<SectionFellingPart>>(forestryFellingPeriod, SectionFellingParts));
        }

        public async Task<IActionResult> ForestrySection10YFelling(Guid ID)
        {
            var sectionFelling10YAGStartAreas = await db.view_SectionFelling10YAGStartAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YAGFellingAreas = await db.view_SectionFelling10YAGFellingAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YAGRemainingAreas = await db.view_SectionFelling10YAGRemainingAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YAGMovementAreas = await db.view_SectionFelling10YAGMovementAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YAGResultAreas = await db.view_SectionFelling10YAGResultAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YTotalAreas = await db.view_SectionFelling10YTotalAreas.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionFelling10YAGStartArea>, 
                List<SectionFelling10YAGFellingArea>, 
                List<SectionFelling10YAGRemainingArea>, 
                List<SectionFelling10YAGMovementArea>, 
                List<SectionFelling10YAGResultArea>, 
                List<SectionFelling10YTotalArea>>
                (sectionFelling10YAGStartAreas, 
                sectionFelling10YAGFellingAreas, 
                sectionFelling10YAGRemainingAreas, 
                sectionFelling10YAGMovementAreas, 
                sectionFelling10YAGResultAreas, 
                sectionFelling10YTotalAreas));
        }

        public async Task<IActionResult> ForestrySection10YFellingResult(Guid ID)
        {
            var sectionFelling10YAGStartAreas = await db.view_SectionFelling10YAGStartAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YAGResultAreas = await db.view_SectionFelling10YAGResultAreas.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionFelling10YTotalAreas = await db.view_SectionFelling10YTotalAreas.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionFelling10YAGStartArea>,
                List<SectionFelling10YAGResultArea>,
                List<SectionFelling10YTotalArea>>
                (sectionFelling10YAGStartAreas,
                sectionFelling10YAGResultAreas,
                sectionFelling10YTotalAreas));
        }

        ///////////////////////////////////////////////////////////////

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}