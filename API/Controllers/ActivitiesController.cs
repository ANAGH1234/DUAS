using Domain;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Persistence;

namespace API.Controllers
{

    public class ActivitiesController : BaseApiController
    {
        // Readonly fields can be initialized at declaration or in the constructor
        //kaafi developers ache jo hote hai _ ye use krte hai this ki jagah 
        private readonly Datacontext _context;
        public ActivitiesController(Datacontext context)
        {
            _context = context;
        }

        [HttpGet]// api/activities
        //action result<> jo hai specific type of data bhi bhejta hai and multiple type of data bhi and Iaction sif multiple type of dataype
        public async Task<ActionResult<List<Activity>>> GetActivities()
        {
            return await _context.Activities.ToListAsync();
        }
        //andar id humne isliye di hai because id ko mandatory field dene ke liye 
        [HttpGet("{id}")]// api/activities/fdjd

        public async Task<ActionResult<Activity>> GetActivity(Guid id)
        {
            return await _context.Activities.FindAsync(id);
        }

    }
}
