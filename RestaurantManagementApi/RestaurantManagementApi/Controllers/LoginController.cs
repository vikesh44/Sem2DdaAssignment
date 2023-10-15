using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Mail;
using System.Net;
using System.Security.Claims;
using System.Text;

namespace RestaurantManagementApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoginController : Controller
    {
        IConfiguration _configuration;

        public LoginController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost]
        [Route("ValidateUser")]
        public async Task<IActionResult> ValidateUser(string userName, string password)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@UserName", userName),
                new ProcedureParameter ("@Password", password)
            };

            List<PersonLoginDetail> result = await DbHelper.Instance.GetData<PersonLoginDetail>("SSP_ValidateUser", parameters);

            if (result == null || 
                result.Count < 1 || 
                result[0] == null ||
                string.IsNullOrEmpty(result[0].FirstName))
            {
                return Unauthorized();
            }
            else
            {
                //Try 1
                var claims = new[]
                            {
                    new Claim (JwtRegisteredClaimNames.Sub, _configuration["Jwt:Subject"]),
                    new Claim (JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim (JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
                    new Claim ("FirstName", result[0].FirstName),
                    new Claim ("UserName", userName),
                };

                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
                var signIn = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
                var token = new JwtSecurityToken(_configuration["Jwt:Issuer"],
                                                 _configuration["Jwt:Audience"],
                                                 claims,
                                                 expires: DateTime.UtcNow.AddMinutes(5),
                                                 signingCredentials: signIn);

                string jwtToken = new JwtSecurityTokenHandler().WriteToken(token);

                return Ok(new UserLogin(result[0].PersonId, result[0].FirstName, jwtToken, result[0].IsCustomer));
            }
        }

        [HttpPost]
        [Route("ForgotPassword")]
        public async Task<IActionResult> ForgotPassword(string emailId)
        {
            bool result = false;
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@EmailId", emailId)
            };
            string password = await DbHelper.Instance.GetFirstRecord<string>("SSP_RetrivePassword", parameters);

            if (string.IsNullOrEmpty(password))
            {
                return Ok(result);
            }

            MailMessage mailMessage = new()
            {
                From = new MailAddress("2022mt93643@wilp.bits-pilani.ac.in")
            };
            mailMessage.To.Add(emailId);
            mailMessage.Subject = "Forgot Password";
            mailMessage.Body = $"Hello,\nYou have requested for Password. The Password for your account is \"{password}\".\nRegards,\nMy Restaurant";

            SmtpClient smtpClient = new()
            {
                Host = "smtp.gmail.com",
                Port = 587,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("2022mt93643@wilp.bits-pilani.ac.in", "Niya@1407"),
                EnableSsl = true
            };

            try
            {
                smtpClient.Send(mailMessage);
                result = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }

            return Ok(result);
        }
    }

    public class UserLogin
    {
        public UserLogin(long personId, string personName, string accessToken, bool isCustomer)
        {
            PersonId = personId;
            PersonName = personName;
            AccessToken = accessToken;
            IsCustomer = isCustomer;
        }
        public long PersonId { get; set; }
        public string PersonName { get; set; }
        public string AccessToken { get; set; }
        public bool IsCustomer { get; set; }
    }
}
