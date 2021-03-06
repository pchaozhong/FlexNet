﻿<%@  Language="C#" AutoEventWireup="true" Inherits="SenseNet.Portal.UI.SingleContentView" EnableViewState="false" %>
<%@ Import Namespace="SenseNet.ContentRepository" %>
<%@ Import Namespace="SenseNet.Portal.UI" %>
<%@ Import Namespace="SenseNet.Portal.Helpers" %>

<sn:ErrorView ID="ErrorView1" runat="server" />

<% var doc = this.Content.ContentHandler.GetReference<GenericContent>("ContentToApprove");
    if (doc != null) { %>

<div class="sn-inputunit ui-helper-clearfix" id="InputUnitPanel1">
    <div class="sn-iu-label">
        <asp:Label CssClass="sn-iu-title" ID="LabelForTitle" runat="server"><%=this.Content.Fields["ContentToApprove"].DisplayName %></asp:Label>
    </div>
    <div class="sn-iu-control">
        <%= IconHelper.RenderIconTag(doc.Icon)%>
        <a href='<%= Actions.BrowseUrl(SenseNet.ContentRepository.Content.Create(doc)) %>' title='<%=doc.DisplayName %>'><%=doc.DisplayName %></a> (in 
        <a href='<%= Actions.BrowseUrl(SenseNet.ContentRepository.Content.Create(doc.Parent)) %>' title='<%=doc.ParentPath %>' target="_blank"><%=doc.Parent.DisplayName%></a>)
     
    </div>
</div>
   <% } %>
<sn:GenericFieldControl ID="GenericFields2" runat="server" FieldsOrder="DueDate Description AssignedTo" />
<div class="sn-panel sn-buttons">
<% var status = this.Content.ContentHandler.GetProperty<string>("Result");
   if (status == null)
   { %>
    <asp:Button CssClass="sn-submit" Text="Approve" ID="Approve" runat="server" OnClick="Click" CommandName="Approve" />
    <asp:Button CssClass="sn-submit" Text="Reject" ID="Reject" runat="server" OnClick="Click" CommandName="Reject" />
    <% }
   else
   { %>
   Task already completed with answer:<strong> <sn:DropDown runat="server" ID="ResultField" FieldName="Result" RenderMode="Browse" /></strong>
    <% } %>
    <sn:BackButton CssClass="sn-submit" Text="Cancel" ID="BackButton1" runat="server" />
</div>

<script runat="server">

    protected virtual void Click(object sender, EventArgs e)
    {
        string actionName = "";
        IButtonControl button = sender as IButtonControl;
        if (button != null)
            actionName = button.CommandName;

        if (!string.IsNullOrEmpty(actionName))
        {
            switch (actionName)
            {
                case "Approve": this.Content["Result"] = "yes"; this.Content.Save(); this.CallDone(); return;
                case "Reject": this.Content["Result"] = "no"; this.Content.Save(); this.CallDone(); return;
            }
        }

        base.Click(sender, e);
    }

</script>
