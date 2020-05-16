﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ServerGameMD.Models;

namespace ServerGameMD.Controllers
{
    [Route("api/[controller]")]
    [Produces("application/json")]
    public class GameController : ControllerBase
    {
        private static List<Solider> list = new List<Solider>();
        //Отримуємо дані про постріл
        [HttpGet("{nick}")]
        public IActionResult Index(string nick)
        {
            var solider = list.SingleOrDefault(s => s.Nick == nick);
            if (solider != null)
                list.Remove(solider);
            return Ok(solider);
        }
        //Стріляємо по об’єкту
        [HttpPost]
        public IActionResult Post([FromBody]Solider solider)
        {
            if (solider != null)
                list.Add(solider);
            return Ok();
        }
    }
}