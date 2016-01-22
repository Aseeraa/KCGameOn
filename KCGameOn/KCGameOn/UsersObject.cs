using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KCGameOn
{
    public class UsersObject
    {
        private string username;
        private string firstname;
        private string lastname;
        private double price;

        public UsersObject(string username, string firstname, string lastname)
        {
            // TODO: Complete member initialization
            this.username = username;
            this.firstname = firstname;
            this.lastname = lastname;
        }

        public string Username
        {
            set { this.username = value; }
            get { return this.username; }
        }

        public string First
        {
            set { this.firstname = value; }
            get { return this.firstname; }
        }

        public string Last
        {
            set { this.lastname = value; }
            get { return this.lastname; }
        }

        public double Price
        {
            set { this.price = value; }
            get { return this.price; }
        }
    }
}