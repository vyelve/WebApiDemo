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
    [RoutePrefix("Api/Department")]
    public class DepartmentController : ApiController
    {
        readonly DepartmentRepository _repository = new DepartmentRepository();

        [Route("GetDepartmentDetails")]
        [HttpGet]
        public IEnumerable<Department> GetDepartmentDetails()
        {
            try
            {
                return _repository.GetDepartment();
            }
            catch (Exception)
            { throw; }
        }

        [HttpGet]
        [Route("GetDepartmentByID/{Id}")]
        public IHttpActionResult GetDepartmentByID(int Id)
        {
            Department objDept = new Department();
            try
            {
                objDept = _repository.GetDepartmentByID(Id);
                if (objDept == null)
                {
                    return NotFound();
                }
            }
            catch (Exception)
            { throw; }
            return Ok(objDept);
        }

        [HttpPost]
        [Route("InsertDepartmentDetails")]
        public IHttpActionResult PostDepartment(Department objDept)
        {
            try
            {
                var _id = _repository.InsertDepartment(objDept);
                objDept.DepartmentId = _id;               
            }
            catch (Exception)
            {
                throw;
            }
            return Ok(objDept);
        }

        [HttpPut]
        [Route("UpdateDepartmentDetails")]
        public IHttpActionResult PutDepartment(Department objDept)
        {           
            try
            {
                var Id = _repository.UpdateDepartment(objDept);
                objDept.DepartmentId = Id;
            }
            catch (Exception)
            {
                throw;
            }
            return Ok(objDept);
        }

        [HttpDelete]
        [Route("DeleteDepartmentDetails")]
        public IHttpActionResult DeleteDepartment(int Id)
        {
            try
            {
                _repository.DeleteDepartment(Id);
            }
            catch (Exception)
            {

                throw;
            }
            return Ok();
        }
    }
}

