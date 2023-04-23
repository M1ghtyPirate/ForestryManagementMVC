using ForestryWeb.Models;
using ForestryWeb.Models.Database;
using ForestryWeb.Models.Database.DataSets;
using ForestryWeb.Models.Database.MVCViews;
using ForestryWeb.Models.Database.Tables;
using ForestryWeb.Models.Database.Views;
using ForestryWeb.Utils;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Diagnostics;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Security.Claims;

namespace ForestryWeb.Controllers
{
    public class AuthorizationController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private ApplicationContext db;


        public AuthorizationController(ILogger<HomeController> logger, ApplicationContext context)
        {
            _logger = logger;
            db = context;
        }

        #region UtilityMethods

        static void SendEmail(EmailCreditentials emailCreditentials, string subject, string message, string address)
        {
            //Адрес SMTP-сервера
            String smtpHost = emailCreditentials.SMTPHost;
            //Порт SMTP-сервера
            int smtpPort = emailCreditentials.SMTPPort;
            //Логин
            String smtpUserName = emailCreditentials.Username;
            //Пароль
            String smtpUserPass = emailCreditentials.Password;

            //Создание подключения
            SmtpClient client = new SmtpClient(smtpHost, smtpPort);
            client.Credentials = new NetworkCredential(smtpUserName, smtpUserPass);
            client.EnableSsl = emailCreditentials.EnableSSL;
            //Адрес для поля "От"
            String msgFrom = emailCreditentials.Email;
            //Адрес для поля "Кому" (адрес получателя)
            String msgTo = address;
            //Тема письма
            String msgSubject = subject;
            //Текст письма
            String msgBody = message;
            //Вложение для письма
            //Если нужно больше вложений, для каждого вложения создаем свой объект Attachment с нужным путем к файлу


            //Создание сообщения
            MailMessage mailMessage = new MailMessage(msgFrom, msgTo, msgSubject, msgBody);
            //Крепим к сообщению подготовленное заранее вложение


            try
            {
                //Отсылаем сообщение
                client.Send(mailMessage);
                //Console.WriteLine("Success.");
            }
            catch (Exception ex)
            {
                //В случае ошибки при отсылке сообщения можем увидеть, в чем проблема
                //Console.WriteLine(ex.Message);
            }
            //Console.ReadKey();
        }

        #endregion

        /// <summary>
        /// Страница аутентификации.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> Login()
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        /// <summary>
        /// Аутентификация пользователя.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> Login(User user)
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            user.Login = user.Login?.Trim() ?? "";
            var userDB = await db.Users.FirstOrDefaultAsync(u => u.Login.ToLower() == user.Login.ToLower());
            if (userDB == null)
            {
                user.Login = null;
                user.Password = null;
                return View(user);
            }
            if (!Enumerable.SequenceEqual(userDB.PasswordHashed, UserInfo.EncodePassword(user.Password, userDB.UserID)))
            {
                user.Password = null;
                return View(user);
            }
            userDB.LoginDate = DateTime.Now;
            var resetPasswordDB = await db.ResetPasswords.FirstOrDefaultAsync(p => p.UserID == userDB.UserID);
            if (resetPasswordDB != null)
            {
                db.ResetPasswords.Remove(resetPasswordDB);
            }
            db.SaveChanges();

            var claims = new List<Claim> {
                new Claim(ClaimTypes.NameIdentifier, ((Guid)userDB.UserID) + ""),
                new Claim(ClaimTypes.Name, userDB.Login),
                new Claim(ClaimTypes.Role, userDB.IsAdmin ? "Admin" : "User"),
                new Claim(ClaimTypes.Email, userDB.Email ?? "")
            };
            ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));
            //return Results.Redirect(returnUrl ?? "/");

            return RedirectToAction("Index", "Home");
        }

        /// <summary>
        /// Страница регистрации.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> Register()
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        /// <summary>
        /// Регистрация пользователя.
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> Register(User user)
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            user.Login = user.Login.Trim();
            var userDB = await db.Users.FirstOrDefaultAsync(u => u.Login.ToLower() == user.Login.ToLower());
            if (userDB != null)
            {
                user.Login = null;
                return View(user);
            }
            user.RegDate = DateTime.Now;

            user.PasswordHashed = new byte[32];
            var addedUserDB = db.Users.Add(user);
            addedUserDB.Entity.PasswordHashed = UserInfo.EncodePassword(user.Password, addedUserDB.Entity.UserID);

            db.SaveChanges();
            return RedirectToAction("Login");
        }

        /// <summary>
        /// Выход пользователя.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login");
        }

        /// <summary>
        /// Страница запроса восстановления пароля.
        /// </summary>
        /// <returns></returns>
        public IActionResult ForgotPassword()
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        /// <summary>
        /// Отправка письма для восстановления пароля.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> ForgotPassword(User user)
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            user.Login = user.Login?.Trim() ?? "";
            var userDB = await db.Users.FirstOrDefaultAsync(u => u.Login.ToLower() == user.Login.ToLower());
            if (userDB == null)
            {
                user.Login = null;
                return View(user);
            }
            if (string.IsNullOrEmpty(userDB.Email))
            {
                user.Email = null;
                return View(user);
            }

            var emailCreditentialsDB = await db.EmailCreditentials.FirstOrDefaultAsync(e => e.EmailType == 0);
            var resetPasswordDB = await db.ResetPasswords.FirstOrDefaultAsync(p => p.UserID == userDB.UserID);
            if (resetPasswordDB != null)
            {
                db.ResetPasswords.Remove(resetPasswordDB);
            }
            db.SaveChanges();
            var resetPassword = Guid.NewGuid() + "";
            var hashedResetPassword = UserInfo.EncodePassword(resetPassword, userDB.UserID);
            var passwordResetIDDB = db.ResetPasswords.Add(new ResetPassword() { UserID = (Guid)userDB.UserID, ResetPasswordHashed = hashedResetPassword });
            db.SaveChanges();

            var message = $"Код для восстановления пароля пользователя {userDB.Login}: {resetPassword}";
            var subject = $"Восстановления пароля пользователя ForestryMVC";

            SendEmail(emailCreditentialsDB, subject, message, userDB.Email);

            return View("ResetPassword", new ResetPasswordData { UserID = (Guid)userDB.UserID, ResetPassword = Guid.Empty + "", NewPassword = string.Empty });
        }

        /// <summary>
        /// Восстановление пароля.
        /// </summary>
        /// <param name="resetPaswordData"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> ResetPassword(ResetPasswordData resetPaswordData)
        {
            if (HttpContext.User.Identity?.IsAuthenticated == true)
            {
                return RedirectToAction("Index", "Home");
            }

            var resetPasswordDB = await db.ResetPasswords.FirstOrDefaultAsync(p => p.UserID == resetPaswordData.UserID);
            var userDB = await db.Users.FirstOrDefaultAsync(u => u.UserID == resetPaswordData.UserID);

            if (resetPasswordDB == null || userDB == null)
            {
                return RedirectToAction("AccessDenied", new { resourceName = "Восстановление пароля пользователя." });
            }

            if (!Enumerable.SequenceEqual(resetPasswordDB.ResetPasswordHashed, UserInfo.EncodePassword(resetPaswordData.ResetPassword, resetPaswordData.UserID)))
            {
                return View(resetPaswordData);
            }

            if (string.IsNullOrEmpty(resetPaswordData.NewPassword))
            {
                return View(resetPaswordData);
            }

            var newPasswordArr = UserInfo.EncodePassword(resetPaswordData.NewPassword, resetPaswordData.UserID);
            userDB.PasswordHashed = newPasswordArr;
            db.ResetPasswords.Remove(resetPasswordDB);
            
            db.SaveChanges();            

            return View("Login");
        }

        /// <summary>
        /// Не хватает прав доступа.
        /// </summary>
        /// <param name="resourceName"></param>
        /// <returns></returns>
        public async Task<IActionResult> AccessDenied(string resourceName)
        {
            return View((Object)resourceName);
        }

        ///////////////////////////////////////////////////////////////

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}