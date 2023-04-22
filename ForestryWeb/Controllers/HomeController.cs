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

        public HomeController(ILogger<HomeController> logger, ApplicationContext context)
        {
            _logger = logger;
            db = context;
        }

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
            forestry.AuthorID = new Guid("d2c08496-de7e-4277-b068-b642b832b14d");
            if (forestry.ForestryID == null)
                db.Forestries.Add(forestry);
            else
            {
                var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == forestry.ForestryID);
                forestryDB.Name = forestry.Name;
                forestryDB.IsShared = forestry.IsShared;
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
            //Реализовать каскадное удаление?
            var forestryDB = db.Forestries.FirstOrDefault(f => f.ForestryID == ID);
            if (forestryDB != null)
            {
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
            var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
            var user = await db.Users.FirstOrDefaultAsync(u => u.UserID == forestry.AuthorID);
            var areTreeGroupsSet = await db.view_TreeGroups.FirstOrDefaultAsync(g => g.ForestryID == ID) != null;
            var areSectionsSet = await db.view_SectionsTotal.FirstOrDefaultAsync(g => g.ForestryID == ID) != null;
            return View(new Tuple<Forestry, User, bool, bool>(forestry, user, areTreeGroupsSet, areSectionsSet));
        }

        /// <summary>
        /// Отображение территорий, перенаправление на добавление.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryAreas(Guid ID)
        {
            var forestryAreas = await db.view_ForestryAreas.FirstOrDefaultAsync(f => f.ForestryID == ID);
            if (forestryAreas == null)
            {
                //var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
                //return View("AddForestryAreas", new Tuple<Forestry, ForestryAreas>(forestry, null));
                return RedirectToAction("EditForestryAreas", new { ID = ID });
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
        /// Отображение групп деревьев по возрасту, перенаправление на добавление.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryTreeGroups(Guid ID)
        {
            var treeGroups = await db.view_TreeGroups.Where(g => g.ForestryID == ID).ToListAsync();

            if (treeGroups.Count() == 0)
            {
                //var forestry = await db.Forestries.FirstOrDefaultAsync(f => f.ForestryID == ID);
                //return View("AddForestryTreeGroups", new Tuple<Forestry, List<TreeGroup>>(forestry, null));
                return RedirectToAction("EditForestryTreeGroups", new { ID = ID });
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
            Func<TreeAgeGroup, List<TreeQualityGroup>, List<QualityClass>, int?> getQualityClass = (a, l, n) => n.FirstOrDefault(v => l.FirstOrDefault(q => q.TreeQualityGroupID == a.TreeQualityGroupID)?.QualityClassID == v.QualityClassID)?.Number;
            Func<TreeAgeGroup, List<AgeClass>, int?> getAgeClass = (a, n) => n.FirstOrDefault(v => v.AgeClassID == a.AgeClassID)?.Number;
            Func<TreeAgeGroup, List<TreeQualityGroup>, Guid?> getTreeSpeciesID = (a, l) => l.FirstOrDefault(q => q.TreeQualityGroupID == a.TreeQualityGroupID)?.TreeSpeciesID;

            var forestryID = treeGroups.FirstOrDefault().ForestryID;
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
        /// Отображение распределения групп бонитета по секциям.
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryTreeGroupsAllocation(Guid ID)
        {
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
            var qualityClasses = await db.QualityClasses.ToDictionaryAsync(q => q.Number, q => q.QualityClassID);
            var forestryID = sectionAllocations.FirstOrDefault().ForestryID;
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
                treeQulaityGroupDB.SectionID = treeQualityGroup.SectionID;
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
        /// Основные показатели по лесному фонду
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryTreeSpecies(Guid ID)
        {
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
            var sectionsTotal = await db.view_SectionsTotal.Where(g => g.ForestryID == ID && (bool)g.IsHigh).ToListAsync();
            var avgSectionGrowthCalc = await db.view_AvgSectionGrowthCalc.ToListAsync();
            return View(new Tuple<List<SectionTotal>, List<AvgSectionGrowthCalc>>(sectionsTotal, avgSectionGrowthCalc));
        }

        /// <summary>
        /// Распределение площадей и запасов по классам возраста
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public async Task<IActionResult> ForestryFellingSections(Guid ID)
        {
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