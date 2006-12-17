{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_valid eq 'n'}
<div style="text-align:center;color:red;">eMailadresse ist nicht konform. Bitte korigieren!<br/><br/></div>
{/if}
{if $if_exists eq 'y' }
<div style="text-align:center;color:red;">eMailadresse ist bereits vorhanden! Bitte korigieren!<br/><br/></div>
{/if}
{if $if_missing eq 'y' }
<div style="text-align:center;color:red;">Fehlerhafte eingabe! Bitte korigieren!<br/><br/></div>
{/if}
{if $if_passwd_len eq 'y' }
<div style="text-align:center;color:red;">Passwort muss zwischen 3 und {$max_passwd_len} Zeichen sein!<br/><br/></div>
{/if}
{if $if_email_saved eq "y" }
<div style="text-align:center;color:blue;">eMailadresse geaendert!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$domainid}">
{/if}

<form action="email_view.php?id={$id}&#038;did={$domainid}" method="post">
<table>
<tr>
 <td style="width:190px;">eMailadresse:</td>
 <td style="width:300px;">{$full_email}</td>
</tr>
<tr>
 <td>Voller Name:</td>
 <td><input type="text" class="in_1" name="full_name" value="{$full_name}"/></td>
</tr>
<tr>
 <td>Passwort:</td>
 <td><input type="password"  maxlength="{$max_passwd_len}" class="in_1" name="password" value=""/></td>
</tr>
{if $if_imap != '1' }
<tr>
 <td>IMAP-Verbindung:</td>
 <td><select name="imap">
     <option value="enable">Ja</option>
     {if $if_imapdisable eq 1}
     <option value="disable" selected="selected">Nein</option>
     {else}
     <option value="disable">Nein</option>
     {/if}
     </select></td>
</tr>
{/if}
{if $if_pop3 != '1' }
<tr>
 <td>POP3-Verbindung:</td>
 <td><select name="pop3">
     <option value="enable">Ja</option>
     {if $if_pop3disable eq 1}
     <option value="disable" selected="selected" >Nein</option>
     {else}
     <option value="disable" >Nein</option>
     {/if}
     </select></td>
</tr>
{/if}
{if $if_webmail != '1' }
<tr>
 <td>Webmail m&ouml;glich:</td>
 <td><select name="webmail">
     <option value="enable">Ja</option>
     {if $if_webmaildisable eq "1"}
     <option value="disable" selected="selected" >Nein</option>
     {else}
     <option value="disable" >Nein</option>
     {/if}
     </select></td>
</tr>
{/if}
<tr>
<td></td>
<td><input type="submit" name="submit" value="Speichern"/></td>
</tr>
{if $if_superadmin eq 'y' }
<tr><td colspan="2" style="height:10px;"></td></tr>
{if $ava_ad_domains ge 1 }
<tr>
 <td colspan="2" class="domain_view"><h3>User ist Admin der Domain(s):</h3></td>
</tr>
{section name=row loop=$table_admins}
<tr>
 <td>{$table_admins[row].dnsname}</td>
 <td style="text-align:right;vertical-align:middle;">
 <a href="email_view.php?id={$id}&#038;did={$domainid}&#038;del={$table_admins[row].del_id}"><img src="img/icons/delete.png" style="border:0px;" /></a></td>
</tr>
{/section}
<tr>
{/if}
<td colspan="2" class="domain_view"><h3>Neue Admin-Domain hinzuf&uuml;gen:</h3></td>
</tr>
<tr>
{if $if_nodomains_found != "y"}
 <td><form action="email_view.php?id={$id}&#038;did={$domainid}" method="post"> <select name="add_domain">
 {section name=row loop=$table_adddns}
 <option value="{$table_adddns[row].dnsid}">{$table_adddns[row].dnsname}</option>
 {/section}
 </select></td>
 <td style="text-align:right;"><input type="submit" name="adddns" value="Hinzuf&uuml;gen" class="in_1"/></form></td>
 {else}
 <td colspan="2">Keine weiteren Domains gefunden!</td>
 {/if}
</tr>
{/if}

</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}