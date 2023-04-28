using ForestryWeb.Models;
using ForestryWeb.Models.Database;
using ForestryWeb.Models.Database.DataSets;
using ForestryWeb.Models.Database.MVCViews;
using ForestryWeb.Models.Database.Tables;
using ForestryWeb.Models.Database.Views;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;
using ForestryWeb.Utils;

namespace ForestryWeb.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private ApplicationContext db;

        public HomeController(ILogger<HomeController> logger, ApplicationContext context)
        {
            _logger = logger;
            db = context;
            
        }

        #region UtilityMethods

        /// <summary>
        /// Проверка наличия доступа у текущего пользователя к лесничеству.
        /// </summary>
        /// <param name="forestryID"></param>
        /// <returns></returns>
        private bool isUserAuthorized(Guid forestryID, out string forestryName)
        {
            var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == forestryID);
            forestryName = forestryDB?.Name;
            if (HttpContext.User.FindFirst(ClaimTypes.Role)?.Value != "Admin")
            {
                if(forestryDB?.IsShared == false && forestryDB?.AuthorID + "" != HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier))
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary>
        /// Обновление даты изменения лесничества.
        /// </summary>
        /// <param name="forestryID"></param>
        private void updateForestryEditDate(Guid forestryID)
        {
            var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == forestryID);
            if(forestryDB == null)
            {
                return;
            }
            forestryDB.EditDate = DateTime.Now;
            db.SaveChanges();
        }

        #endregion

        /// <summary>
        /// Отображение главной страницы
        /// </summary>
        /// <returns></returns>
        public IActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Отображение лесничеств.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> Forestries()
        {
            var forestries = await db.Forestries.ToListAsync();
            var users = await db.Users.ToListAsync();
            var forestriesInfo = new List<Tuple<Forestry, User>>();
            foreach(var f in forestries)
                forestriesInfo.Add(new Tuple<Forestry, User>(f, users.FirstOrDefault(u => u.UserID == f.AuthorID)));
            return View(forestriesInfo);
        }


        /// <summary>
        /// Добавление лесничества
        /// </summary>
        /// <returns></returns>
        public IActionResult AddForestry()
        {
            return View();
        }

        /// <summary>
        /// Редактирование лесничества
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> EditForestry(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);

            return View("AddForestry", forestry);
        }

        /// <summary>
        /// Добавление лесничества.
        /// </summary>
        /// <param name="forestry"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> AddForestry(Forestry forestry)
        {
            forestry.AuthorID = new Guid(HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier));
            if (forestry.ForestryID == null)
                db.Forestries.Add(forestry);
            else
            {
                var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == forestry.ForestryID);

                if (!isUserAuthorized((Guid)forestry.ForestryID, out string forestryName))
                {
                    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
                }

                forestryDB.Name = forestry.Name;

                if(HttpContext.User.FindFirstValue(ClaimTypes.Role) == "Admin" || forestryDB.AuthorID == forestry.AuthorID)
                {
                    forestryDB.IsShared = forestry.IsShared;
                }

                updateForestryEditDate((Guid)forestry.ForestryID);
            }
            await db.SaveChangesAsync();

            return RedirectToAction("Forestries");
        }

        /// <summary>
        /// Удаление лесничества.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> RemoveForestry(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == ID);
            if (forestryDB != null)
            {

                var forestAreasDB = await db.ForestAreas.FirstOrDefaultAsync(g => g.ForestryID == ID);
                var nonForestAreasDB = await db.NonForestAreas.FirstOrDefaultAsync(g => g.ForestryID == ID);
                var treeQualityGroupsDB = await db.TreeQualityGroups.Where(g => g.ForestryID == ID).ToListAsync();
                var treeQualityGroupsIDs = treeQualityGroupsDB?.Select(g => g.TreeQualityGroupID).ToList() ?? new List<Guid?>();
                var sectionIDs = treeQualityGroupsDB?.Select(g => g.SectionID).ToList() ?? new List<Guid?>();
                var treeAgeGroupsDB = await db.TreeAgeGroups.Where(g => treeQualityGroupsIDs.Contains(g.TreeQualityGroupID)).ToListAsync();
                var sectionsDB = await db.Sections.Where(s => sectionIDs.Contains(s.SectionID)).ToListAsync();

                if(forestAreasDB != null)
                {
                    db.Remove(forestAreasDB);
                }

                if (nonForestAreasDB != null)
                {
                    db.Remove(nonForestAreasDB);
                }

                foreach (var treeAgeGroup in treeAgeGroupsDB)
                {
                    db.Remove(treeAgeGroup);
                }
                await db.SaveChangesAsync();

                foreach (var treeQualityGroup in treeQualityGroupsDB)
                {
                    db.Remove(treeQualityGroup);
                }
                await db.SaveChangesAsync();

                foreach (var section in sectionsDB)
                {
                    db.Remove(section);
                }
                await db.SaveChangesAsync();

                db.Forestries.Remove(forestryDB);
                await db.SaveChangesAsync();
            }
            return RedirectToAction("Forestries");
        }

        /// <summary>
        /// Отображение лесничества.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> Forestry(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var user = await db.Users.FirstOrDefaultAsync(u => u.UserID == forestry.AuthorID);
            var areTreeGroupsSet = await db.view_TreeGroups.FirstOrDefaultAsync(g => g.ForestryID == ID) != null;
            var areSectionsSet = await db.view_SectionsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID) != null;
            var anyFellingAreas = await db.view_SectionsMainFellingAgeCalc.FirstOrDefaultAsync(g => g.ForestryID == ID && g.MainFellingAge != null) != null;
            return View(new Tuple<Forestry, User, bool, bool, bool>(forestry, user, areTreeGroupsSet, areSectionsSet, anyFellingAreas));
        }

        /// <summary>
        /// Отображение территорий, перенаправление на добавление.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryAreas(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var forestryAreas = await db.view_ForestryAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);

            //if (forestryAreas == null)
            //{
            //    //var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            //    //return View("AddForestryAreas", new Tuple<Forestry, ForestryAreas>(forestry, null));
            //    return RedirectToAction("EditForestryAreas", new { ID = ID });
            //}

            if(forestryAreas == null)
            {
                var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
                if (forestry == null)
                {
                    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = $"лесничество {ID} не найдено" });
                }
                forestryAreas = new ForestryAreas() { ForestryID = ID, ForestryName = forestry.Name };
            }
            var forestryAreasPercentage = await db.view_ForestryAreasPercentage.FirstOrDefaultAsync(f => f.ForestryID == ID);
            return View(new Tuple<ForestryAreas, ForestryAreasPercentage>(forestryAreas, forestryAreasPercentage));
        }

        /// <summary>
        /// Изменение территорий.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> EditForestryAreas(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var forestryAreas = await db.view_ForestryAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);
            return View("AddForestryAreas", new Tuple<Forestry, ForestryAreas>(forestry, forestryAreas));
        }

        /// <summary>
        /// Добавление, изменение территорий.
        /// </summary>
        /// <param name="forestryAreas"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> AddForestryAreas([Bind(Prefix = "Item2")]ForestryAreas forestryAreas)
        {
            if (!isUserAuthorized(forestryAreas.ForestryID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

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

            updateForestryEditDate(forestryAreas.ForestryID);

            return RedirectToAction("ForestryAreas", new { ID = forestryAreas.ForestryID });
        }

        /// <summary>
        /// Удаление распределения площадей.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> RemoveForestryAreas(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var forestAreasDB = await db.ForestAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var nonForestAreasDB = await db.NonForestAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);

            if (forestAreasDB != null)
            {
                db.ForestAreas.Remove(forestAreasDB);
            }

            if(nonForestAreasDB != null)
            {
                db.NonForestAreas.Remove(nonForestAreasDB);
            }

            if (forestAreasDB!= null || nonForestAreasDB != null)
            {
                updateForestryEditDate(ID);
            }

            return RedirectToAction("ForestryAreas", new { ID = ID});
        }

        /// <summary>
        /// Отображение групп деревьев по возрасту, перенаправление на добавление.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryTreeGroups(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            List<TreeGroup> treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();

            //if (treeGroups.Count() == 0)
            //{
            //    //var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            //    //return View("AddForestryTreeGroups", new Tuple<Forestry, List<TreeGroup>>(forestry, null));
            //    return RedirectToAction("EditForestryTreeGroups", new { ID = ID });
            //}

            if (treeGroups.Count == 0)
            {
                var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
                if (forestry == null)
                {
                    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = $"лесничество {ID} не найдено" });
                }
                treeGroups = new List<TreeGroup>();
                treeGroups.Add(new TreeGroup() { ForestryID = ID, ForestryName = forestry.Name });
            }

            var treeAgeGroupsTotal = await db.view_TreeAgeGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryAgeGroupsTotal = await db.view_TreeForestryAgeGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryGroupsTotal = await db.view_TreeForestryGroupsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var treeQualityGroupsTotal = await db.view_TreeQualityGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            var treeSpeciesGroupsTotal = await db.view_TreeSpeciesGroupsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<TreeGroup>, List<TreeQualityGroupTotal>, List<TreeAgeGroupTotal>, List<TreeSpeciesGroupTotal>, List<TreeForestryAgeGroupTotal>, TreeForestryGroupTotal>
                (treeGroups, treeQualityGroupsTotal, treeAgeGroupsTotal, treeSpeciesGroupsTotal, treeForestryAgeGroupsTotal, treeForestryGroupsTotal));
        }

        /// <summary>
        /// Изменение групп деревьев по возрасту.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> EditForestryTreeGroups(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            //treeGroups = treeGroups.Count() == 0 ? null : treeGroups;
            var treeSpecies = await db.TreeSpecies.ToListAsync();
            return View("AddForestryTreeGroups", new Tuple<Forestry, List<TreeGroup>, List<TreeSpecies>>(forestry, treeGroups, treeSpecies));
        }

        /// <summary>
        /// Добавление, изменение или удаление групп деревьев по возрасту.
        /// </summary>
        /// <param name="treeGroups"></param>
        /// <returns></returns>
        [HttpPost, DisableRequestSizeLimit, RequestFormLimits(MultipartBodyLengthLimit = Int32.MaxValue, ValueLengthLimit = Int32.MaxValue, ValueCountLimit = Int32.MaxValue)]
        public async Task<IActionResult> AddForestryTreeGroups([Bind(Prefix = "Item2")] List<TreeGroup> treeGroups)
        {
            var forestryID = treeGroups.FirstOrDefault().ForestryID;

            if (!isUserAuthorized(forestryID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            Func<TreeAgeGroup, List<TreeQualityGroup>, List<QualityClass>, int?> getQualityClass = (a, l, n) => n.FirstOrDefault(v => l.FirstOrDefault(q => q.TreeQualityGroupID == a.TreeQualityGroupID)?.QualityClassID == v.QualityClassID)?.Number;
            Func<TreeAgeGroup, List<AgeClass>, int?> getAgeClass = (a, n) => n.FirstOrDefault(v => v.AgeClassID == a.AgeClassID)?.Number;
            Func<TreeAgeGroup, List<TreeQualityGroup>, Guid?> getTreeSpeciesID = (a, l) => l.FirstOrDefault(q => q.TreeQualityGroupID == a.TreeQualityGroupID)?.TreeSpeciesID;

            var treeSpeciesID = Guid.Empty;
            foreach (var treeGroup in treeGroups)
            {
                if (treeGroup.QualityClass == 1 && treeGroup.AgeClass == 1)
                {
                    treeSpeciesID = treeGroup.TreeSpeciesID;
                }
                else
                {
                    treeGroup.TreeSpeciesID = treeSpeciesID;
                }
            }

            treeGroups.RemoveAll(g => g.TreeSpeciesID == Guid.Empty || (g.Area == 0 || g.Area == null) && (g.Volume == 0 ||  g.Volume == null));
            var qualityClassesDB = await db.QualityClasses.ToListAsync();
            var ageClassesDB = await db.AgeClasses.ToListAsync();
            var treeQualityGroupsDB = await db.TreeQualityGroups.Where(g => g.ForestryID == forestryID).ToListAsync();
            var treeQualityGroupsForDeletion = new List<TreeQualityGroup>();
            var treeQualityGroupsIDs = treeQualityGroupsDB?.Select(g => g.TreeQualityGroupID).ToList() ?? new List<Guid?>();
            var treeAgeGroupsDB = await db.TreeAgeGroups.Where(g => treeQualityGroupsIDs.Contains(g.TreeQualityGroupID)).ToListAsync();
            var treeAgeGroupsForDeletion = treeAgeGroupsDB
                .Where(a => !treeGroups
                .Any(g => g.TreeSpeciesID == getTreeSpeciesID(a, treeQualityGroupsDB) 
                && g.QualityClass == getQualityClass(a, treeQualityGroupsDB, qualityClassesDB) 
                && g.AgeClass == getAgeClass(a, ageClassesDB)))
                .ToList();

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
                if (treeAgeGroupDB != null && treeAgeGroupDB.Area == treeAgeGroup.Area && treeAgeGroupDB.Volume == treeAgeGroup.Volume)
                {
                    continue;
                }

                if (treeAgeGroupDB != null)
                {
                    treeAgeGroup.TreeAgeGroupID = treeAgeGroupDB.TreeAgeGroupID;
                    db.Entry(treeAgeGroupDB).CurrentValues.SetValues(treeAgeGroup);
                }
                else
                {
                    db.TreeAgeGroups.Add(treeAgeGroup);
                    treeAgeGroupsDB.Add(treeAgeGroup);
                }
            }

            foreach (var treeAgeGroup in treeAgeGroupsForDeletion)
            {
                db.TreeAgeGroups.Remove(treeAgeGroup);
                treeAgeGroupsDB.Remove(treeAgeGroup);
                var treeQualityGroup = treeQualityGroupsDB.FirstOrDefault(g => g.TreeQualityGroupID == treeAgeGroup.TreeQualityGroupID && !treeAgeGroupsDB.Any(a => a.TreeQualityGroupID == g.TreeQualityGroupID));
                if (treeQualityGroup != null)
                {
                    //db.TreeQualityGroups.Remove(treeQualityGroup);
                    treeQualityGroupsForDeletion.Add(treeQualityGroup);
                    treeQualityGroupsDB.Remove(treeQualityGroup);
                }
            }
            await db.SaveChangesAsync();

            var sectionIDsForDeletion = new List<Guid>();
            foreach (var treeQualityGroup in treeQualityGroupsForDeletion)
            {
                db.TreeQualityGroups.Remove(treeQualityGroup);
                if (treeQualityGroup.SectionID != null && treeQualityGroup.SectionID != Guid.Empty && !sectionIDsForDeletion.Any(s => s == treeQualityGroup.SectionID))
                {
                    sectionIDsForDeletion.Add((Guid)treeQualityGroup.SectionID);
                }
            }
            await db.SaveChangesAsync();

            var sectionsForDeletion = await db.Sections.Where(s => sectionIDsForDeletion.Any(i => i == (Guid)s.SectionID)).ToListAsync();
            foreach (var sectionForDeletion in sectionsForDeletion)
            {
                if (!treeQualityGroupsDB.Any(g => g.SectionID == sectionForDeletion.SectionID))
                {
                    db.Sections.Remove(sectionForDeletion);
                }
            }
            await db.SaveChangesAsync();

            updateForestryEditDate(forestryID);

            return RedirectToAction("ForestryTreeGroups", new { ID = forestryID });
        }

        /// <summary>
        /// Удаление групп насаждений.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> RemoveForestryTreeGroups(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var treeQualityGroupsDB = await db.TreeQualityGroups.Where(q => q.ForestryID == ID).ToListAsync();
            var treeQualityGroupsIDs = treeQualityGroupsDB?.Select(g => g.TreeQualityGroupID).ToList() ?? new List<Guid?>();
            var treeAgeGroupsDB = await db.TreeAgeGroups.Where(g => treeQualityGroupsIDs.Contains(g.TreeQualityGroupID)).ToListAsync();

            if (treeAgeGroupsDB.Count > 0)
            {
                db.TreeAgeGroups.RemoveRange(treeAgeGroupsDB);
                db.TreeQualityGroups.RemoveRange(treeQualityGroupsDB);
                updateForestryEditDate(ID);
            }

            return RedirectToAction("ForestryTreeGroups", new { ID = ID });
        }

        /// <summary>
        /// Отображение распределения групп бонитета по секциям.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryTreeGroupsAllocation(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryGroupsTotal = await db.view_TreeForestryGroupsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var sectionsDB = await db.Sections.ToListAsync();
            var forestrySections = sectionsDB.Where(s => treeGroups.Any(g => g.SectionID == s.SectionID)).ToList();
            return View(new Tuple<List<TreeGroup>, TreeForestryGroupTotal, List<Section>> (treeGroups, treeForestryGroupsTotal, forestrySections));
        }

        /// <summary>
        /// Изменение распределения групп бонитета по секциям.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> EditForestryTreeGroupsAllocation(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var treeForestryGroupsTotal = await db.view_TreeForestryGroupsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var sectionsDB = await db.Sections.ToListAsync();
            var forestrySections = sectionsDB.Where(s => treeGroups.Any(g => g.SectionID == s.SectionID)).ToList();
            return View(new Tuple<List<TreeGroup>, TreeForestryGroupTotal, List<Section>>(treeGroups, treeForestryGroupsTotal, forestrySections));
        }


        /// <summary>
        /// Назначение секций группам бонитета.
        /// </summary>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        [HttpPost, DisableRequestSizeLimit, RequestFormLimits(MultipartBodyLengthLimit = Int32.MaxValue, ValueLengthLimit = Int32.MaxValue, ValueCountLimit = Int32.MaxValue)]
        public async Task<IActionResult> AddForestryTreeGroupsAllocation([Bind(Prefix = "SectionAllocations")] List<SectionAllocation> sectionAllocations)
        {
            var forestryID = sectionAllocations.FirstOrDefault().ForestryID;

            if (!isUserAuthorized(forestryID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var qualityClasses = await db.QualityClasses.ToDictionaryAsync(q => q.Number, q => q.QualityClassID);
            var forestryTreeQualityGroupsDB = await db.TreeQualityGroups.Where(g => g.ForestryID == forestryID).ToListAsync();
            var sectionsDB = await db.Sections.ToListAsync();
            var forestrySectionsDB = sectionsDB.Where(s => forestryTreeQualityGroupsDB.Any(g => g.SectionID == s.SectionID)).ToList();

            foreach(var sectionAllocation in sectionAllocations)
            {
                sectionAllocation.SectionName = sectionAllocation.SectionName?.Trim();
                var sectionID = forestrySectionsDB.FirstOrDefault(s => s.Name == sectionAllocation.SectionName)?.SectionID;

                if (sectionID == null && !string.IsNullOrEmpty(sectionAllocation.SectionName))
                {
                    var newSection = new Section()
                    {
                        Name = sectionAllocation.SectionName
                    };
                    newSection.SectionID = db.Sections.Add(newSection).Entity.SectionID;
                    forestrySectionsDB.Add(newSection);
                    sectionID = newSection.SectionID;
                }

                var treeQulaityGroupDB = forestryTreeQualityGroupsDB.FirstOrDefault(g => g.TreeSpeciesID == sectionAllocation.TreeSpeciesID && g.QualityClassID == (Guid)qualityClasses[sectionAllocation.QualityClass]);
                var treeQualityGroup = new TreeQualityGroup()
                {
                    TreeQualityGroupID = treeQulaityGroupDB.TreeQualityGroupID,
                    ForestryID = forestryID,
                    TreeSpeciesID = sectionAllocation.TreeSpeciesID,
                    QualityClassID = (Guid)qualityClasses[sectionAllocation.QualityClass],
                    SectionID = sectionID
                };
                db.Entry(treeQulaityGroupDB).CurrentValues.SetValues(treeQualityGroup);
                treeQulaityGroupDB.SectionID = sectionID;
            }
            await db.SaveChangesAsync();

            foreach (var sectionForDeletion in forestrySectionsDB)
            {
                if (!forestryTreeQualityGroupsDB.Any(g => g.SectionID == sectionForDeletion.SectionID))
                {
                    db.Remove(sectionForDeletion);
                }
            }
            await db.SaveChangesAsync();

            updateForestryEditDate(forestryID);

            return RedirectToAction("ForestryTreeGroupsAllocation", new { ID = forestryID });
        }

        /// <summary>
        /// Удаление распределения по секциям.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> RemoveForestryTreeGroupsAllocation(Guid ID)
        {
            if (!isUserAuthorized(ID, out string forestryName))
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            }

            var treeQualityGroupsDB = await db.TreeQualityGroups.Where(q => q.ForestryID == ID).ToListAsync();

            foreach (var treeQualityGroupDB in treeQualityGroupsDB)
            {
                treeQualityGroupDB.SectionID = null;
            }

            if (treeQualityGroupsDB.Count > 0)
            {
                updateForestryEditDate(ID);
            }

            return RedirectToAction("ForestryTreeGroupsAllocation", new { ID = ID });
        }

        /// <summary>
        /// Основные показатели по лесному фонду
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryTreeSpecies(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var forestryTreeSpecies = await db.view_ForestryTreeSpecies.Where(g => g.ForestryID == ID).ToListAsync();
            var forestryTreeSpeciesTotal = await db.view_ForestryTreeSpeciesTotal.FirstOrDefaultAsync(g => g.ForestryID == ID);
            return View(new Tuple<List<ForestryTreeSpecies>, ForestryTreeSpeciesTotal> (forestryTreeSpecies, forestryTreeSpeciesTotal));
        }

        /// <summary>
        /// Распределение насаждений хозсекций по классам возраста.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySectionGroups(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var sectionAgeGroups = await db.view_SectionAgeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionAgeGroup>, List<SectionTotal>>(sectionAgeGroups, sectionsTotal));
        }

        /// <summary>
        /// Схема организации лесного хозяйства
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySections(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new List<SectionTotal>(sectionsTotal));
        }

        /// <summary>
        /// Расчет среднего прироста сортиментов для определения технической спелости.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> AvgSectionGrowthCalc(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID && (bool)g.IsHigh).ToListAsync();
            var avgSectionGrowthCalc = await db.view_AvgSectionGrowthCalc.ToListAsync();
            return View(new Tuple<List<SectionTotal>, List<AvgSectionGrowthCalc>>(sectionsTotal, avgSectionGrowthCalc));
        }

        /// <summary>
        /// Расчет возраста главной рубки.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySectionsMainFelling(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var sectionsMainFelingAgeCalc = await db.view_SectionsMainFellingAgeCalc.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionAgeGroups = await db.view_SectionAgeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionMainFellingAgeCalc>, List<SectionAgeGroup>>(sectionsMainFelingAgeCalc, sectionAgeGroups));
        }

        /// <summary>
        /// Распределение площадей и запасов по классам возраста
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryFellingSections(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var sectionFellingAgeGroups = await db.view_SectionFellingAgeGroups.Where(g => g.ForestryID == ID).ToListAsync();
            var sectionsFellingVariants = await db.view_SectionsFellingVariants.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<List<SectionsFellingVariant>, List<SectionFellingAgeGroup>>(sectionsFellingVariants, sectionFellingAgeGroups));
        }

        /// <summary>
        /// Срок использования эксплуатационного фонда
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryFellingPeriods(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var forestryFellingPeriod = await db.view_ForestryFellingPeriods.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var sectionFellingPeriods = await db.view_SectionsFellingPeriods.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<ForestryFellingPeriod, List<SectionFellingPeriod>>(forestryFellingPeriod, sectionFellingPeriods));
        }

        /// <summary>
        /// Сравнение размера главного пользования лесом с его средним приростом на 1 га
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySectionFellingTypes(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var forestryFellingType = await db.view_ForestryFellingTypes.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var sectionFellingTypes = await db.view_SectionFellingTypes.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<ForestryFellingType, List<SectionFellingType>>(forestryFellingType, sectionFellingTypes));
        }

        /// <summary>
        /// Удельный вес хозсекций в общем размере главного пользования
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySectionFellingParts(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

            var forestryFellingPeriod = await db.view_ForestryFellingPeriods.FirstOrDefaultAsync(g => g.ForestryID == ID);
            var SectionFellingParts = await db.view_SectionFellingParts.Where(g => g.ForestryID == ID).ToListAsync();
            return View(new Tuple<ForestryFellingPeriod, List<SectionFellingPart>>(forestryFellingPeriod, SectionFellingParts));
        }

        /// <summary>
        /// Площади древостоев по классам возраста на начало и конец ревизионного периода
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySection10YFelling(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

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

        /// <summary>
        /// Распределение площадей насаждений в пределах хозсекций по классам возраста на начало и конец ревизионного периода
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestrySection10YFellingResult(Guid ID)
        {
            //if (!isUserAuthorized(ID, out string forestryName))
            //{
            //    return RedirectToAction("AccessDenied", "Authorization", new { resourceName = forestryName });
            //}

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

        #region UserSettings

        /// <summary>
        /// Обновление информации пользователя.
        /// </summary>
        /// <returns></returns>
        public IActionResult EditUser()
        {
            return View();
        }

        /// <summary>
        /// Обновление информации пользователя.
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> EditUser(UserInfoUpdate userInfoUpdate)
        {
            userInfoUpdate.Email = userInfoUpdate.Email?.Trim().ToLower() ?? "";
            var userDB = await db.Users.FirstOrDefaultAsync(u => u.UserID + "" == HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier));
            if (userDB == null)
            {
                return View();
            }
            if (!Enumerable.SequenceEqual(userDB.PasswordHashed, UserInfo.EncodePassword(userInfoUpdate.CurrentPassword, userDB.UserID)))
            {
                userInfoUpdate.CurrentPassword = null;
                return View(userInfoUpdate);
            }
            if (!string.IsNullOrEmpty(userInfoUpdate.NewPassword))
            {
                var newPasswordArr = UserInfo.EncodePassword(userInfoUpdate.NewPassword, userDB.UserID);
                userDB.PasswordHashed = newPasswordArr;
            }
            if (userInfoUpdate.Email != userDB.Email)
            {
                userDB.Email = userInfoUpdate.Email;

                var claimsIdentity = HttpContext.User.Identity as ClaimsIdentity;
                claimsIdentity.RemoveClaim(claimsIdentity.FindFirst(ClaimTypes.Email));
                claimsIdentity.AddClaim(new Claim(ClaimTypes.Email, userInfoUpdate.Email));
                var authProperties = HttpContext.Features.Get<IAuthenticateResultFeature>().AuthenticateResult.Properties;
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme, 
                    new ClaimsPrincipal(claimsIdentity),
                    new AuthenticationProperties() { IsPersistent = authProperties.IsPersistent, ExpiresUtc = authProperties.ExpiresUtc });
            }
            db.SaveChanges();
            return View();
        }

        #endregion

        #region DirectoryViews

        /// <summary>
        /// Список справочников.
        /// </summary>
        /// <returns></returns>
        public IActionResult Directories()
        {
            return View();
        }

        /// <summary>
        /// Породы деревьев.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> TreeSpeciesDirectory()
        {
            var treeSpecies = await db.TreeSpecies.ToListAsync();
            return View(treeSpecies);
        }

        /// <summary>
        /// Страница редактирования списка пород.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> EditTreeSpeciesDirectory()
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin")
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            var treeSpecies = await db.TreeSpecies.ToListAsync();
            return View(treeSpecies);
        }

        /// <summary>
        /// Редактирование списка пород.
        /// </summary>
        /// <returns></returns>
        [HttpPost, DisableRequestSizeLimit, RequestFormLimits(MultipartBodyLengthLimit = Int32.MaxValue, ValueLengthLimit = Int32.MaxValue, ValueCountLimit = Int32.MaxValue)]
        public async Task<IActionResult> EditTreeSpeciesDirectory([Bind(Prefix = "TreeSpecies")] List<TreeSpecies> treeSpecies)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin")
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            treeSpecies?.RemoveAll(t => string.IsNullOrEmpty(t.Name = t.Name?.Trim()) || t.OperationalAgeClass == 0 || t.OptimalFellingAge == 0);
            var treespeciesDB = await db.TreeSpecies.ToListAsync();

            foreach(var treeSpeciesRow in treeSpecies)
            {
                var treeSpeciesRowDB = treespeciesDB.FirstOrDefault(t => t.TreeSpeciesID == treeSpeciesRow.TreeSpeciesID);
                var treeSpeciesRowDuplicateDB = treespeciesDB.FirstOrDefault(t => t.Name.ToLower() == treeSpeciesRow.Name.ToLower() && t.TreeSpeciesID != treeSpeciesRow.TreeSpeciesID);
                if (treeSpeciesRowDB != null && treeSpeciesRowDuplicateDB == null)
                {
                    db.Entry(treeSpeciesRowDB).CurrentValues.SetValues(treeSpeciesRow);
                }
                else if(treeSpeciesRowDuplicateDB == null)
                {
                    treespeciesDB.Add(db.TreeSpecies.Add(treeSpeciesRow).Entity);
                }
            }

            await db.SaveChangesAsync();

            return RedirectToAction("TreeSpeciesDirectory");
        }


        /// <summary>
        /// Удаление породы из справочника.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> RemoveTreeSpecies(Guid ID)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin")
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }

            var treeSpeciesDB = db.TreeSpecies.FirstOrDefault(t => t.TreeSpeciesID == ID);
            try
            {
                db.TreeSpecies.Remove(treeSpeciesDB);
                await db.SaveChangesAsync();
            }
            catch
            {
                return RedirectToAction("AccessDenied", "Authorization", new { resourceName = $"{treeSpeciesDB.Name} используется в представлениях, каскадное удаление пород запрещено"});
            }
               
            return RedirectToAction("TreeSpeciesDirectory");
        }

        /// <summary>
        /// Товарная таблица.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> ProductOutputDirectory()
        {
            var productOutput = await db.ProductOutput.ToListAsync();
            var treeSpecies = await db.TreeSpecies.ToListAsync();
            return View(new Tuple<List<ProductOutput>, List<TreeSpecies>>(productOutput, treeSpecies));
        }

        /// <summary>
        /// Страница редактирования товарной таблицы.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> EditProductOutputDirectory(Guid ID)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin" || ID == Guid.Empty)
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            var productOutput = await db.ProductOutput.Where(g => g.TreeSpeciesID == ID)?.ToListAsync();
            var treeSpecies = await db.TreeSpecies.FirstOrDefaultAsync(t => t.TreeSpeciesID == ID);
            return View(new Tuple<List<ProductOutput>, TreeSpecies>(productOutput, treeSpecies));
        }


        /// <summary>
        /// Редактирования товарной таблицы.
        /// </summary>
        /// <returns></returns>
        [HttpPost, DisableRequestSizeLimit, RequestFormLimits(MultipartBodyLengthLimit = Int32.MaxValue, ValueLengthLimit = Int32.MaxValue, ValueCountLimit = Int32.MaxValue)]
        public async Task<IActionResult> EditProductOutputDirectory([Bind(Prefix = "ProductOutput")] List<ProductOutput> productOutputs)
        {
            var treeSpeciesID = productOutputs.FirstOrDefault()?.TreeSpeciesID;
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin" || productOutputs == null || treeSpeciesID == Guid.Empty)
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }

            var productOutputsDB = await db.ProductOutput.Where(g => g.TreeSpeciesID == treeSpeciesID).ToListAsync();

            productOutputs.RemoveAll(g => g.AvgHeight == 0 || g.AvgDiameter == 0 || (g.LargePercent == 0 && g.MediumPercent1 == 0 && g.MediumPercent2 == 0));

            var productOutputsForDeletion = productOutputsDB.Where(gDB => !productOutputs.Any(g => g.AvgDiameter == gDB.AvgDiameter && g.AvgHeight == gDB.AvgHeight));

            foreach (var productOutput in productOutputs)
            {
                productOutput.LargePercent = productOutput.LargePercent ?? 0;
                productOutput.MediumPercent1 = productOutput.MediumPercent1 ?? 0;
                productOutput.MediumPercent2 = productOutput.MediumPercent2 ?? 0;
                var productOutputDB = productOutputsDB.FirstOrDefault(g => g.AvgDiameter == productOutput.AvgDiameter && g.AvgHeight == productOutput.AvgHeight);
                if (productOutputDB != null)
                {
                    productOutput.ProductOutputID = productOutputDB.ProductOutputID;
                    db.Entry(productOutputDB).CurrentValues.SetValues(productOutput);
                }
                else
                {
                    productOutputsDB.Add(db.ProductOutput.Add(productOutput).Entity);
                }
            }

            foreach (var productOutput in productOutputsForDeletion)
            {
                db.ProductOutput.Remove(productOutput);
            }

            await db.SaveChangesAsync();

            return RedirectToAction("ProductOutputDirectory");
        }

        /// <summary>
        /// Удаление товарной таблицы породы.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> RemoveProductOutputDirectory(Guid ID)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin" || ID == Guid.Empty)
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            var productOutput = await db.ProductOutput.Where(g => g.TreeSpeciesID == ID)?.ToListAsync();
            if (productOutput?.Count > 0)
            {
                db.RemoveRange(productOutput);
                await db.SaveChangesAsync();
            }
            return RedirectToAction("ProductOutputDirectory");
        }

        /// <summary>
        /// Таблица хода роста.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> GrowthRateDirectory()
        {
            var growthRate = await db.GrowthRate.ToListAsync();
            var treeSpecies = await db.TreeSpecies.ToListAsync();
            var qualityClasses = await db.QualityClasses.ToListAsync();
            return View(new Tuple<List<GrowthRate>, List<TreeSpecies>, List<QualityClass>>(growthRate, treeSpecies, qualityClasses));
        }

        /// <summary>
        /// Страница редактирования таблицы хода роста.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> EditGrowthRateDirectory(Guid ID)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin" || ID == Guid.Empty)
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            var growthRate = await db.GrowthRate.Where(g => g.TreeSpeciesID == ID)?.ToListAsync();
            var treeSpecies = await db.TreeSpecies.FirstOrDefaultAsync(t => t.TreeSpeciesID == ID);
            var qualityClasses = await db.QualityClasses.ToListAsync();
            return View(new Tuple<List<GrowthRate>, TreeSpecies, List<QualityClass>>(growthRate, treeSpecies, qualityClasses));
        }

        /// <summary>
        /// Редактирование таблицы хода роста
        /// </summary>
        /// <param name="growthRate"></param>
        /// <returns></returns>
        [HttpPost, DisableRequestSizeLimit, RequestFormLimits(MultipartBodyLengthLimit = Int32.MaxValue, ValueLengthLimit = Int32.MaxValue, ValueCountLimit = Int32.MaxValue)]
        public async Task<IActionResult> EditGrowthRateDirectory([Bind(Prefix="GrowthRate")]List<GrowthRate> growthRates)
        {
            var treeSpeciesID = growthRates.FirstOrDefault()?.TreeSpeciesID;
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin" || growthRates == null || treeSpeciesID == Guid.Empty)
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }

            var growthRatesDB = await db.GrowthRate.Where(g => g.TreeSpeciesID ==  treeSpeciesID).ToListAsync();

            growthRates.RemoveAll(g => g.AvgHeight == 0 || g.AvgDiameter == 0 || (g.VolumePerHectare == 0 && g.AvgGrowth == 0 && g.CurrentGrowth == 0));

            var growthRatesForDeletion = growthRatesDB.Where(gDB => !growthRates.Any(g => g.QualityClassID == gDB.QualityClassID && g.Age == gDB.Age));

            foreach(var growthRate in growthRates)
            {
                growthRate.CurrentGrowth = growthRate.CurrentGrowth ?? 0;
                var growthRateDB = growthRatesDB.FirstOrDefault(g => g.QualityClassID == growthRate.QualityClassID && g.Age == growthRate.Age);
                if (growthRateDB != null)
                {
                    growthRate.GrowthRateID = growthRateDB.GrowthRateID;
                    db.Entry(growthRateDB).CurrentValues.SetValues(growthRate);
                }
                else
                {
                    growthRatesDB.Add(db.GrowthRate.Add(growthRate).Entity);
                }
            }

            foreach(var growthRate in growthRatesForDeletion)
            {
                db.GrowthRate.Remove(growthRate);
            }

            await db.SaveChangesAsync();

            return RedirectToAction("GrowthRateDirectory");
        }

        /// <summary>
        /// Удаление таблицы хода роста породы.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> RemoveGrowthRateDirectory(Guid ID)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin" || ID == Guid.Empty)
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            var growthRate = await db.GrowthRate.Where(g => g.TreeSpeciesID == ID)?.ToListAsync();
            if (growthRate?.Count > 0)
            {
                db.RemoveRange(growthRate);
                await db.SaveChangesAsync();
            }
            return RedirectToAction("GrowthRateDirectory");
        }

        #endregion

        #region AdminViews

        /// <summary>
        /// Список пользователей.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> Users()
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin")
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }
            var usersDB = await db.Users.ToListAsync();
            return View(usersDB);
        }

        /// <summary>
        /// Выдача админских прав.
        /// </summary>
        /// <param name="users"></param>
        /// <returns></returns>
        [HttpPost, DisableRequestSizeLimit, RequestFormLimits(MultipartBodyLengthLimit = Int32.MaxValue, ValueLengthLimit = Int32.MaxValue, ValueCountLimit = Int32.MaxValue)]
        public async Task<IActionResult> Users([Bind(Prefix = "Users")] List<User> users)
        {
            if (HttpContext.User.FindFirstValue(ClaimTypes.Role) != "Admin")
            {
                return RedirectToAction("AccessDenied", "Authorization");
            }

            var usersDB = await db.Users.ToListAsync();

            foreach(var user in users)
            {
                var userDB = usersDB.FirstOrDefault(u => u.UserID == user.UserID);
                if(userDB == null || userDB.Login == "admin" && HttpContext.User.Identity.Name != "admin")
                {
                    continue;
                }

                if (userDB.Login != "admin" && userDB.Login != HttpContext.User.Identity?.Name)
                {
                    userDB.IsAdmin = user.IsAdmin;
                }
            }

            db.SaveChanges();

            return RedirectToAction("Users");
        }

        #endregion

        ///////////////////////////////////////////////////////////////

        public IActionResult Privacy()
        {
            return RedirectToAction("Privacy", "Authorization");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}