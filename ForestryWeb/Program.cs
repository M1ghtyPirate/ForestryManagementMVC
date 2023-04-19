using ForestryWeb.Models.Database;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.EntityFrameworkCore;

//var builder = WebApplication.CreateBuilder(args);
var builder = WebApplication.CreateBuilder(args);

string connection = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ApplicationContext>(options => options.UseSqlServer(connection));

// Add services to the container.
builder.Services.AddControllersWithViews();

//Max post size
//builder.Services.Configure<FormOptions>(options => options.MultipartBodyLengthLimit = 134217728 );
//builder.WebHost.ConfigureKestrel(options => { 
//    options.Limits.MaxRequestBodySize = 134217728;
//    options.Limits.Http2.MaxFrameSize = 16777215;
//});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
