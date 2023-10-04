using System.Data;
using System.Data.SqlClient;
using System.Reflection;

namespace RestaurantManagementApi.Helper
{
    public class DbHelper
    {
        public string ConnectionString { get; set; }

        public async Task<int> UpdateData(string procedureName, List<ProcedureParameter> parameters)
        {
            int recordsUpdated = 0;
            try
            {
                using SqlConnection con = new(ConnectionString);
                SqlCommand cmd = new(procedureName, con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                foreach (ProcedureParameter parameter in parameters)
                {
                    cmd.Parameters.AddWithValue(parameter.Name, parameter.Value);
                }
                con.Open();
                recordsUpdated = await cmd.ExecuteNonQueryAsync();
                con.Close();
            }
            catch (Exception)
            {
                recordsUpdated = 0;
            }
            return recordsUpdated;
        }

        public Task<T>? GetFirstRecord<T>(string procedureName, List<ProcedureParameter> parameters)
        {
            try
            {
                using SqlConnection con = new(ConnectionString);
                SqlCommand cmd = new(procedureName, con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                foreach (ProcedureParameter parameter in parameters)
                {
                    cmd.Parameters.AddWithValue(parameter.Name, parameter.Value);
                }

                SqlDataAdapter da = new()
                {
                    SelectCommand = cmd
                };

                DataSet ds = new();

                da.Fill(ds);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                if (ds == null ||
                    ds.Tables == null ||
                    ds.Tables[0] == null ||
                    ds.Tables[0].Rows == null ||
                    ds.Tables[0].Rows.Count <= 0 ||
                    ds.Tables[0].Rows[0][0] == null)
                {
                    return null;
                }
                else
                {
                    return ds.Tables[0].Rows[0][0] is T
                        ? Task.FromResult((T)ds.Tables[0].Rows[0][0])
                        : Task.FromResult((T)Convert.ChangeType(ds.Tables[0].Rows[0][0], typeof(T)));
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        public Task<List<T>> GetData<T>(string procedureName)
        {
            try
            {
                using SqlConnection con = new(ConnectionString);
                SqlCommand cmd = new(procedureName, con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                return GetData<T>(con, cmd);
            }
            catch (Exception)
            {
                return Task.FromResult(new List<T>());
            }
        }

        public Task<List<T>> GetData<T>(string procedureName, List<ProcedureParameter> parameters)
        {
            try
            {
                using SqlConnection con = new(ConnectionString);
                SqlCommand cmd = new(procedureName, con)
                {
                    CommandType = CommandType.StoredProcedure
                };

                foreach (ProcedureParameter parameter in parameters)
                {
                    cmd.Parameters.AddWithValue(parameter.Name, parameter.Value);
                }

                return GetData<T>(con, cmd);
            }
            catch (Exception)
            {
                return Task.FromResult(new List<T>());
            }
        }

        private Task<List<T>> GetData<T>(SqlConnection con, SqlCommand cmd)
        {
            try
            {
                SqlDataAdapter da = new()
                {
                    SelectCommand = cmd
                };

                DataSet ds = new();

                da.Fill(ds);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                if (ds == null ||
                    ds.Tables == null ||
                    ds.Tables[0] == null)
                {
                    return Task.FromResult(new List<T>());
                }
                else
                {
                    return ConvertDataTable<T>(ds.Tables[0]);
                }
            }
            catch (Exception)
            {
                return Task.FromResult(new List<T>());
            }
        }

        private Task<List<T>> ConvertDataTable<T>(DataTable dt)
        {
            List<T> data = new();
            foreach (DataRow row in dt.Rows)
            {
                T item = GetItem<T>(row);
                data.Add(item);
            }
            return Task.FromResult(data);
        }

        private T GetItem<T>(DataRow dr)
        {
            Type temp = typeof(T);
            T obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
            {
                foreach (PropertyInfo pro in temp.GetProperties())
                {
                    if (pro.Name == column.ColumnName && dr[column.ColumnName] is not DBNull)
                    {
                        pro.SetValue(obj, dr[column.ColumnName], null);
                    }
                    else
                    {
                        continue;
                    }
                }
            }
            return obj;
        }

        #region Singleton Instance Implementation

        private DbHelper()
        {
            ConnectionString = string.Empty;
        }

        private static readonly object objLock = new();

        private static DbHelper? instance = null;
        public static DbHelper Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (objLock)
                    {
                        instance ??= new DbHelper();
                    }
                }
                return instance;
            }
        }

        #endregion
    }
}
