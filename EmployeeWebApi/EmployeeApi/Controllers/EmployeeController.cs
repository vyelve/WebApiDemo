using EmployeeApi.Models;
using EmployeeApi.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EmployeeApi.Controllers
{
    [RoutePrefix("Api/Employee")]
    public class EmployeeController : ApiController
    {
        readonly EmployeeRepository _repository = new EmployeeRepository();

        [Route("GetEmployeeDetails")]
        [HttpGet]
        public IEnumerable<Employee> GetEmployeeDetails()
        {
            try
            {
                return _repository.GetEmployees();
            }
            catch (Exception)
            { throw; }
        }

        [HttpGet]
        [Route("GetEmployeeByID/{Id}")]
        public IHttpActionResult GetEmployeeByID(int Id)
        {
            Employee objEmp = new Employee();
            try
            {
                objEmp = _repository.GetEmployeeByID(Id);
                if (objEmp == null)
                {
                    return NotFound();
                }
            }
            catch (Exception)
            { throw; }
            return Ok(objEmp);
        }

        [HttpPost]
        [Route("InsertEmployeeDetails")]
        public IHttpActionResult PostEmployee(Employee objEmp)
        {
            try
            {
                var _id = _repository.InsertEmployee(objEmp);
                objEmp.EmployeeId = _id;
            }
            catch (Exception)
            {
                throw;
            }
            return Ok(objEmp);
        }

        [HttpPut]
        [Route("UpdateEmployeeDetails")]
        public IHttpActionResult PutEmployee(Employee objEmp)
        {
            try
            {
                var _id = _repository.UpdateEmployee(objEmp);
                objEmp.EmployeeId = _id;
            }
            catch (Exception)
            {
                throw;
            }
            return Ok(objEmp);
        }

        [HttpDelete]
        [Route("DeleteEmployeeDetails")]
        public IHttpActionResult DeleteEmployee(int Id)
        {
            try
            {
                _repository.DeleteEmployee(Id);
            }
            catch (Exception)
            {

                throw;
            }
            return Ok();
        }
    }
}
