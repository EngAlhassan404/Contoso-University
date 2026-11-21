using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ContosoUniversity.Data;

namespace ContosoUniversity.Controllers
{
    /// <summary>
    /// Courses Controller - Listing university courses with warm visual identity
    /// Developed by: Eng.Alhassan Ali Bahbah
    /// </summary>
    public class CoursesController : Controller
    {
        private readonly SchoolContext _context;

        public CoursesController(SchoolContext context)
        {
            _context = context;
        }

        // GET: Courses
        public async Task<IActionResult> Index()
        {
            var courses = await _context.Courses.AsNoTracking().ToListAsync();
            return View(courses);
        }
    }
}
