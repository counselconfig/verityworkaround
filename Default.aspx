<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VerityWebApp._Default" %> <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="jumbotron">
    <h3>1. Create an empty edit set on test <a href="http://test.editorial.tna.local/editorial/" target="_blank" rel="noopener">PROCAT</a><br /><br />2. Use this form to add pieces to the edit set</h3>
    <p class="lead"></p>
  </div>
  <div class="row">
    <div class="col-md-9">
      <h2>Add piece information</h2>
      <p></p>
      <table style="width: 100%;">

        <tr >
          <td class="text-left" style="height: 50px">Letter code: *</td>
          <td style="height: 50px">
            <asp:DropDownList ID="cboLetterCode" runat="server" ValidationGroup="AddPieceGroup" DataSourceID="SqlDataSourceILDB" DataTextField="letter_code" DataValueField="lettercode_id" AutoPostBack="True" OnSelectedIndexChanged="cboLetterCode_SelectedIndexChanged" AppendDataBoundItems="true">
              <asp:ListItem Selected="True" Text="--Select Letter Code--" disabled="disabled"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceILDB" runat="server" ConnectionString="<%$ ConnectionStrings:ILDBConnectionString %>" SelectCommand="SELECT DISTINCT [lettercode_id],[letter_code]  FROM [ILDB].[dbo].[tbl_lettercode]">
            </asp:SqlDataSource>
          </td>
        </tr>

        <tr>
          <td class="text-left" style="height: 50px">Class number: *</td>
          <td style="height: 50px">
            <asp:DropDownList ID="cboClass" runat="server" ValidationGroup="AddPieceGroup" DataTextField="class_no" DataValueField="class_no"></asp:DropDownList>
          </td>
        </tr>

        <tr>
          <td class="text-left" style="height: 50px">First piece: * 
          </td>
          <td style="height: 50px">
            <asp:TextBox ID="TxtFirstPiece" runat="server"></asp:TextBox>
              <asp:RegularExpressionValidator asp:RequiredFieldValidatorID="FirstPiece" runat="server" ControlToValidate="TxtFirstPiece" ErrorMessage="Only numbers, lower or upper case, hyphens, and forward slashes allowed" ForeColor="Red" ValidationExpression="^[0-9A-Za-z/-]+$"></asp:RegularExpressionValidator>
          </td>
        </tr>

        <tr>
          <td class="text-left" style="height: 50px">Last piece: 
          </td>
          <td style="height: 50px">
            <asp:TextBox ID="TxtLastPiece" runat="server"></asp:TextBox>&nbsp; 
              <asp:RegularExpressionValidator ID="LastPieceNumber" ControlToValidate="TxtFirstPiece" runat="server" ErrorMessage="Only numbers, lower or upper case, hyphens, and forward slashes allowed" ForeColor="Red" ValidationExpression="^[0-9A-Za-z/-]+$"></asp:RegularExpressionValidator>
          </td>
        </tr>

        <tr>
          <td class="text-left" style="height: 50px">Edit set name: * 
          </td>
          <td style="height: 50px">
             <asp:TextBox ID="TxtEditSet" placeholder="Enter name from PROCAT" runat="server" ></asp:TextBox>&nbsp;<asp:RegularExpressionValidator ID="EditSetValidator"  ControlToValidate="TxtEditSet" runat="server"  ErrorMessage="Editset name disallowed" ForeColor="Red" ValidationExpression="[\s\S]*"> </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator asp:RequiredFieldValidatorID="EditSet" runat="server" ControlToValidate="TxtEditSet" ErrorMessage="* Please enter edit set" ForeColor="Red" ID="RequiredFieldValidator2"></asp:RequiredFieldValidator>

          </td>
        </tr>

        <tr>
           <td style="height: 50px">
            <asp:Button ID="btnAddPiece" runat="server" Text="Populate Edit Set" OnClick="btnAddPiece_Click" CausesValidation="true" />
          </td>
        </tr>

      </table>
    </div>
  </div>
</asp:Content>