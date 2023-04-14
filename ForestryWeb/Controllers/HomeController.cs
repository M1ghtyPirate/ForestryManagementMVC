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

        [HttpPost]
        public async Task<IActionResult> AddForestry(Forestry forestry)
        {
            forestry.AuthorID = new Guid("d2c08496-de7e-4277-b068-b642b832b14d");
            db.Forestries.Add(forestry);
            await db.SaveChangesAsync();
            return RedirectToAction("Forestries");
        }

        public async Task<IActionResult> Forestry(Guid ID)
        {
            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var user = await db.Users.FirstOrDefaultAsync(u => u.UserID == forestry.AuthorID);
            return View(new Tuple<Forestry, User>(forestry, user));
        }

        public async Task<IActionResult> ForestryAreas(Guid ID)
        {
            var forestryAreas = await db.view_ForestryAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var forestryAreasPercentage = await db.view_ForestryAreasPercentage.FirstOrDefaultAsync(f => f.ForestryID == ID);
            return View(new Tuple<ForestryAreas, ForestryAreasPercentage>(forestryAreas, forestryAreasPercentage));
        }

        public async Task<IActionResult> ForestryTreeGroups(Guid ID)
        {
            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var treeAgeGroupsTotal = await db.view_TreeAgeGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryAgeGroupsTotal = await db.view_TreeForestryAgeGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryGroupsTotal = await db.view_TreeForestryGroupsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var treeQualityGroupsTotal = await db.view_TreeQualityGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeSpeciesGroupsTotal = await db.view_TreeSpeciesGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<TreeGroup>, List<TreeQualityGroupTotal>, List<TreeAgeGroupTotal>, List<TreeSpeciesGroupTotal>, List<TreeForestryAgeGroupTotal>, TreeForestryGroupTotal>
                (treeGroups, treeQualityGroupsTotal, treeAgeGroupsTotal, treeSpeciesGroupsTotal, treeForestryAgeGroupsTotal, treeForestryGroupsTotal));
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