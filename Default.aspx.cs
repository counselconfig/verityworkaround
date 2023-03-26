using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace VerityWebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           
        }

        

        protected void btnAddPiece_Click(object sender, EventArgs e)
        {

            //if (TxtFirstPiece.Text != "" && TxtEditSet.Text != "" && cboClass.Text != "")
            //{

            //string connString = @"server=na-t-sqlc02v02\sql2; database=ILDB;uid=sa;pwd=jW76S0@qjmz*2";
            //string connString = @"Data Source=na-t-sqlc02v02\sql2;Initial Catalog=ILDB; User id=sa; Password=jW76S0@qjmz*2; Integrated Security=False";

            //sql connection object
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["ILDBConnectionString"].ConnectionString);
            {

                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "usp_Edit_InsertPiecesToEditSet";
                    cmd.Parameters.Add("@lettercode", SqlDbType.NVarChar).Value = cboLetterCode.SelectedItem.Text;
                    cmd.Parameters.Add("@class_no", SqlDbType.Int).Value = cboClass.SelectedItem.Text;
                    cmd.Parameters.Add("@minPRef", SqlDbType.NVarChar).Value = TxtFirstPiece.Text.Trim();
                    if (!string.IsNullOrWhiteSpace(TxtLastPiece.Text))
                    {
                        cmd.Parameters.Add("@maxPRef", SqlDbType.NVarChar).Value = TxtLastPiece.Text.Trim();
                    }
                    else
                    {
                        cmd.Parameters.Add("@maxPRef", SqlDbType.NVarChar).Value = DBNull.Value;
                    }

                    cmd.Parameters.Add("@editSetName", SqlDbType.NVarChar).Value = TxtEditSet.Text.Trim();
                    cmd.Connection = cnx;

                    try
                    {
                        cnx.Open();
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>window.alert('Successfully updated. Please verify!');</script>");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>window.alert('Import error, please contact IT Service Desk. ');</script>");
                        //throw ex;

                    }
                    finally
                    {
                        cnx.Close();
                        ClearControls();
                    }

                }
            //}
            //else
            //{
            //    Response.Write("<script>window.alert('* marked fields are mandatory');</script>");
            //}

        }
        
        protected void ClearControls()
        {
            cboLetterCode.DataBind();
            cboClass.Items.Clear();
            TxtEditSet.Text = "";
            TxtFirstPiece.Text = "";
            TxtLastPiece.Text = "";
            
        }

        protected void cboLetterCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            TxtFirstPiece.Text = "";
            TxtLastPiece.Text = "";
            cboClass.Items.Clear();
            SqlDataReader dReader;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ILDBConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT class_no, class_id FROM tbl_class WHERE lettercode_id IN (" + cboLetterCode.SelectedValue + ")", con);
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                con.Open();

                dReader = cmd.ExecuteReader();
                if (dReader.HasRows == true)
                {
                    cboClass.DataSource = dReader;
                    cboClass.DataTextField = "class_no";
                    cboClass.DataValueField = "class_id";
                    cboClass.DataBind();
                    con.Close();

                }
                else
                {
                    cboClass.Text = "--No Class found--";
                }
                //dReader.Close();
                cboClass.Items.Insert(0, new ListItem("--Select Class--", "0"));
               
            }


        }

      
    }
}