using ForestryWeb.Models;
using ForestryWeb.Models.Database;
using ForestryWeb.Models.Database.MVCViews;
using ForestryWeb.Models.Database.Tables;
using ForestryWeb.Models.Database.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
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