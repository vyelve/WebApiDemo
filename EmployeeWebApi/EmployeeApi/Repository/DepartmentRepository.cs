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
    public interface IDepartment
    {
        IEnumerable<Department> GetDepartment();
        Department GetDepartmentByID(int ID);
        int InsertDepartment(Department objDepartment);
        int UpdateDepartment(Department objDepartment);
        void DeleteDepartment(int ID);
    }

    public class DepartmentRepository : IDepartment
    {
        public IEnumerable<Department> GetDepartment()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                return con.Query<Department>("GetDepartments", null, null, true, 0, CommandType.StoredProcedure).ToList();
            }
        }

        public Department GetDepartmentByID(int Id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                var para = new DynamicParameters();
                para.Add("@DepartmentID", Id);
                return con.Query<Department>("GetDepartmentsByID", para, null, true, 0, commandType: CommandType.StoredProcedure).Single();
            }
        }

        public int InsertDepartment(Department objDepartment)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                var para = new DynamicParameters();
                para.Add("@DepartmentName", objDepartment.DepartmentName);                
                para.Add("@Id", dbType: DbType.Int32, direction: ParameterDirection.Output);
                con.Execute("AddDepartment", para, null, 0, CommandType.StoredProcedure);                
                int DeptID = para.Get<int>("Id");
                return DeptID;
            }
        }

        public int UpdateDepartment(Department objDepartment)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                var para = new DynamicParameters();
                para.Add("@DepartmentID", objDepartment.DepartmentId);
                para.Add("@DepartmentName", objDepartment.DepartmentName);                
                para.Add("@Id", dbType: DbType.Int32, direction: ParameterDirection.Output);
                con.Execute("UpdateDepartment", para, null, 0, CommandType.StoredProcedure);
                int DeptID = para.Get<int>("Id");
                return DeptID;
            }
        }

        public void DeleteDepartment(int Id)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["EmployeeApi"].ToString()))
            {
                string val = string.Empty;
                var para = new DynamicParameters();
                para.Add("@DepartmentID", Id);
                val = con.Query<string>("DeleteDepartment", para, null, true, 0, commandType: CommandType.StoredProcedure).SingleOrDefault();
            }
        }

    }
}