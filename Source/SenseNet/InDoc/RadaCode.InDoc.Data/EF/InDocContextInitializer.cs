﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using RadaCode.InDoc.Data.DocumentNaming;

namespace RadaCode.InDoc.Data.EF
{
    class InDocContextInitializer : DropCreateDatabaseIfModelChanges<InDocContext>
    {
        protected override void Seed(InDocContext context)
        {
            //new List<WebUserRole>
            //{
            //    new WebUserRole() { RoleName = "Thinker"
            //             },
            //    new WebUserRole() { RoleName = "ThoughtRouter"}
            //}.ForEach(r => context.WebUserRoles.Add(r));

            var orderFormat = new NamingApproach()
                            {
                                Format = "{intInc_G}/{intInc_D}/02/-{yy}",
                                TypeName = "Orders"
                            };

            var initParams = new List<KeyValuePair<int, string>>
                                 {new KeyValuePair<int, string>(0, "2296"), new KeyValuePair<int, string>(1, "1")};

            orderFormat.SaveCurrentParams(initParams);

            context.NamingApproaches.Add(orderFormat);

            base.Seed(context);
        }
    }
}
