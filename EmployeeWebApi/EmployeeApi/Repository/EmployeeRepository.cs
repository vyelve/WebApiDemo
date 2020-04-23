using Dapper;
using EmployeeApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace EmployeeApi.Repository
{
    public interface IEmployee
    {
        IEnumerable<Employee> GetEmployees();
        Employee GetEmployeeByID(int ID);
        int InsertEmployee(Employee objEmployee);
        int UpdateEmployee(Employee objEmployee);
        void DeleteEmployee(int ID);
    }
    public class EmployeeRepository : IEmployee
    {
        public IEnumerable<Employee> GetEmployees()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                return con.Query<Employee>("GetEmployees", null, null, true, 0, CommandType.StoredProcedure).ToList();
            }
        }

        public Employee GetEmployeeByID(int ID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                var para = new DynamicParameters();
                para.Add("@EmployeeID", ID);
                return con.Query<Employee>("GetEmployeesByID", para, null, true, 0, commandType: CommandType.StoredProcedure).Single();
            }
        }

        public int InsertEmployee(Employee objEmployee)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                var para = new DynamicParameters();
                para.Add("@EmployeeName", objEmployee.EmployeeName);
                para.Add("@DepartmentID", objEmployee.DepartmentID);
                para.Add("@EmailId", objEmployee.EmailID);
                para.Add("@DOJ", objEmployee.DOJ);

                para.Add("@Id", dbType: DbType.Int32, direction: ParameterDirection.Output);
                con.Execute("AddEmployee", para, null, 0, CommandType.StoredProcedure);
                int EmpID = para.Get<int>("Id");
                return EmpID;
            }
        }

        public int UpdateEmployee(Employee objEmployee)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                var para = new DynamicParameters();
                para.Add("@EmployeeID", objEmployee.EmployeeId);
                para.Add("@EmployeeName", objEmployee.EmployeeName);
                para.Add("@DepartmentID", objEmployee.DepartmentID);
                para.Add("@EmailId", objEmployee.EmailID);
                para.Add("@DOJ", objEmployee.DOJ);

                para.Add("@Id", dbType: DbType.Int32, direction: ParameterDirection.Output);
                con.Execute("UpdateEmployee", para, null, 0, CommandType.StoredProcedure);
                int EmpID = para.Get<int>("Id");
                return EmpID;
            }
        }

        public void DeleteEmployee(int ID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                string val = string.Empty;
                var para = new DynamicParameters();
                para.Add("@EmployeeID", ID);
                val = con.Query<string>("DeleteEmployee", para, null, true, 0, commandType: CommandType.StoredProcedure).SingleOrDefault();
            }
        }
    }
}