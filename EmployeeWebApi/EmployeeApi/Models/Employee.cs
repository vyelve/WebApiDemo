using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeeApi.Models
{
    public class Employee
    {
        public int EmployeeId { get; set; }
        public int DepartmentID { get; set; }
        public string EmployeeName { get; set; }        
        public string EmailID { get; set; }
        public DateTime DOJ { get; set; }
    }
}