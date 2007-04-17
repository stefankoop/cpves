{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }
<form action="?module=email_view&#038;id={$id}&#038;did={$domainid}" method="post">
<table>
<tr>
 <td style="width:190px;">E-Mailadresse:</td>
 <td style="width:300px;">{$full_email}</td>
</tr>
<tr>
 <td>Voller Name:</td>
 <td><input type="text" name="full_name" value="{$full_name}"/></td>
</tr>
<tr>
 <td>Passwort:</td>
 <td><input type="password"  maxlength="{$max_passwd_len}" name="password" value=""/></td>
</tr>
{if $if_imap == '1' }
<tr>
 <td>IMAP-Verbindung:</td>
 <td><select name="imap">
     <option value="enable">Ja</option>
     {if $if_imap_value == 0}
     <option value="disable" selected="selected">Nein</option>
     {else}
     <option value="disable">Nein</option>
     {/if}
     </select></td>
</tr>
{/if}
{if $if_pop3 == '1' }
<tr>
 <td>POP3-Verbindung:</td>
 <td><select name="pop3">
     <option value="enable">Ja</option>
     {if $if_pop3_value == 0}
     <option value="disable" selected="selected" >Nein</option>
     {else}
     <option value="disable" >Nein</option>
     {/if}
     </select></td>
</tr>
{/if}
{if $if_webmail == 1 }
<tr>
 <td>Webmail m&ouml;glich:</td>
 <td><select name="webmail">
     <option value="enable">Ja</option>
     {if $if_webmail_value == 0 }
     <option value="disable" selected="selected" >Nein</option>
     {else}
     <option value="disable" >Nein</option>
     {/if}
     </select></td>
</tr>
{/if}
<tr>
	<td>Weiterleitung sichtbar:</td>
	<td><select name="forwarding">
	    <option value="enable">Ja</option>
	    {if $if_forwarding_value == 0 }
	    <option value="disable" selected="selected">Nein</option>
	    {else}
	    <option value="disable">Nein</option>
	    {/if}
	    </select></td>
	    
</tr>
{if $if_spamassassin == '1' }
<tr>
	<td>Spamassassin sichtbar:</td>
	<td><select name="spamassassin">
	<option value="enable">Ja</option>
	{if $if_spamassassin_value == 0 }
	<option value="disable" selected="selected">Nein</option>
	{else}
	<option value="disable">Nein</option>
	{/if}
	</select></td>
</tr>
{/if}
{if $if_bogofilter == '1' }
<tr>
	<td>Bogofilter sichtbar:</td>
	<td><select name="bogofilter">
	<option value="enable">Ja</option>
	{if $if_bogofilter_value == 0 }
	<option value="disable" selected="selected">Nein</option>
	{else}
	<option value="disable">Nein</option>
	{/if}
	</select></td>
</tr>
{/if}
{if $if_mailarchive == 1 }
<tr>
	<td>Mailarchiv sichtbar:</td>
	<td><select name="mailachrive">
	<option value="enable">Ja</option>
	{if $if_mailarchive_value == 0}
	<option value="disbale" selected="selected">Nein</option>
	{else}
	<option value="disbale">Nein</option>
	{/if}
	</select></td>
</tr>
{/if}


<tr>
<td></td>
<td><input type="submit" name="submit" value="Speichern"/></td>
</tr>
</form>

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
 <a href="?module=email_view&#038;id={$id}&#038;did={$did}&#038;del={$table_admins[row].del_id}"><img src="img/icons/delete.png" style="border:0px;" /></a></td>
</tr>
{/section}
<tr>
{/if}
<td colspan="2" class="domain_view"><h3>Neue Admin-Domain hinzuf&uuml;gen:</h3></td>
</tr>
<tr>
{if $if_nodomains_found != "y"}
 <td><form action="?module=email_view&#038;id={$id}&#038;did={$did}" method="post"> <select name="add_domain">
 {section name=row loop=$table_adddns}
 <option value="{$table_adddns[row].dnsid}">{$table_adddns[row].dnsname}</option>
 {/section}
 </select></td>
 <td style="text-align:right;"><input type="submit" name="adddns" value="Hinzuf&uuml;gen" /></form></td>
 {else}
 <td colspan="2">Keine weiteren Domains gefunden!</td>
 {/if}
</tr>
{/if}

<!-- Autoresponder feature begin -->
<form name="autoresp" action="?module=email_view&#038;id={$id}&#038;did={$did}" method="post">
<tr>
<td colspan="2" class="domain_view"><h3>Autoresponder</h3></td>
</tr>
<tr>
 <td>Autoresponder aktiv:</td>
 <td><select name="autores_active">
  <option value="y" onclick="cpves_autores_field('');">Ja</option>
  {if $autores_active eq 'n' }
  	<option value="n" onclick="cpves_autores_field('true');" selected="selected">Nein</option>
  {else}
  	<option value="n" onclick="cpves_autores_field('true');">Nein</option>
  {/if}
  </select></td>
</tr>
<tr>
 <td>Autoresponder Betreff:</td>
 <td><input type="text" name="autores_subject" id="autores_subject" maxlength="50" value="{$autores_subject}" /></td>
</tr>
<tr>
 <td valign="top">Nachricht:</td>
 <td><textarea name="autores_msg" id="autores_msg" cols="50" rows="15">{$autores_msg}</textarea></td>
</tr>
<tr>
 <td></td>
 <td><input type="submit" value="Speichern" name="autores_submit" /></td>
</tr>
	<form action="?module=user_autores" method="post">
	<tr>
		<td valign="top">Dekativiere Autoresponder:</td>
		<td><select name="autores_datedisable_active" id="autores_datedisable_active">
		<option value="1" onclick="cpves_autores_datedisable('')">Ja</option>
		{if $autores_disable.active == 0 }
		<option value="0" onclick="cpves_autores_datedisable('true')" selected="selected">Nein</option>
		{else}
		<option value="0" onclick="cpves_autores_datedisable('true')">Nein</option>
		{/if}
		</select></td>
	</tr>
	<tr>
		<td>Ab Datum:</td>
		<td><input type="text" name="autores_datedisable_date" value="{$autores_disable.a_date}" id="autores_datedisable_date"/></td>
	</tr>
	<tr>
		<td>Ab Uhrzeit:</td>
		<td><input type="text" name="autores_datedisable_time" value="{$autores_disable.a_time}" id="autores_datedisable_time"/></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" id="autores_datedisable_submit" name="autores_datedisable_submit" value="Speichern" /></td>
	</tr>
	</form>
	{if $autores_active eq 'n' }
	<script type="text/javascript">cpves_autores_field('true');
	</script>
	{/if}
	{if $autores_disable.active == 0 }
	<script type="text/javascript">
	cpves_autores_datedisable('true');
	</script>
	{/if}

	<tr>
		<td colspan="2">&#160;</td>
	</tr>
	<tr>
		<td colspan="2">&#160;</td>
	</tr>
	
	
	
	<tr>
		<td>Aktiviere validierte Empf&auml;ngeradressen:</td>
		<td>{if $val_tos_active == 1 }
		<input type="radio" onclick="submit();" checked="checked" name="val_tos_active" value="1"> Ja <input type="radio" onclick="submit();" name="val_tos_active"  value="0"> Nein
		{else}<input type="radio" onclick="submit();"  name="val_tos_active" value="1"> Ja <input type="radio" checked="checked" onclick="submit();" name="val_tos_active"  value="0"> Nein{/if}</td>
	</tr>
	
	<tr>
		<td valign="top">Validierte Empf&auml;ngeradressen:</td>
		<td>
		<select name="val_tos[]" size="8" multiple="true">
		{foreach from=$table_val_tos item=row }
		<option value="{$row.id}">{$row.recip}</option>
		{/foreach}
		</select><br/>
		<input type="submit" name="val_tos_del" value="Markierte L&ouml;schen" />
		</td>
		
	</tr>
	<tr>
		<td>Hinzuf&uuml;gen:</td>
		<td><input type="text" name="val_tos_da" /><input type="submit" name="val_tos_add" value="Hinzuf&uuml;gen" /></td>
	</tr>


</form>
<!-- Autoresponder feature end -->


<!-- Options feature begin -->
<form action="?module=email_view&#038;id={$id}&#038;did={$did}" method="post">
<tr>
 <td colspan="2" class="domain_view"><h3>Optionen</h3></td>
</tr>
<tr>
<td>L&ouml;sche Virenbenachrichtigungen:</td>
  <td><select name="del_virus_notifi">
		{if $del_virus_notifi eq 1}
			<option value="1" selected="selected">Ja</option>
			<option value="0">Nein</option>
		{else}
			<option value="1">Ja</option>
			<option value="0" selected="selected">Nein</option>
		{/if}
  </select></td>  
</tr>
<tr>
	<td></td>
	<td><input type="submit" name="virus_submit" value="Speichern" /></td>
</tr>
</form>
<!-- Options feature end -->

<!-- Forward feature begin -->
<form action="?module=email_view&#038;id={$id}&#038;did={$did}" method="post">
<tr>
 <td colspan="2" class="domain_view"><h3>Weiterleitung</h3></td>
</tr>
<tr>
	<td>Alle E-Mails weiterleiten:</td>
	<td><input name="forwardaddress" value="{$forwardaddress}" type="text"/></td>
</tr>

<tr>
	<td>Kopie im Postfach belassen:</td>
	<td><select name="save_local">
	{if $if_forward_cc == 1 }
		<option value="1">Ja</option>
		<option value="0">Nein</option>
	{else}
		<option value="0">Nein</option>
		<option value="1">Ja</option>
	{/if}
	</select></td>
</tr>

<tr>
	<td>Weiterleitung l&ouml;schen:</td>
	<td><input type="checkbox" name="delete_forward"/></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" name="fwdmail_submit" value="Speichern" /></td>
</tr>
</form>
<!-- Forward feature end -->

<!-- Spamassasssin feature begin -->
{if $if_spamassassin == 1 }
<form action="?module=email_view&#038;id={$id}&#038;did={$did}" name="sa_form" id="sa_form" method="post">
<tr>
 <td colspan="2" class="domain_view"><h3>Spamfilter</h3></td>
</tr>
<tr>
	<td>Spamfilter aktiv:</td>
	<td><select id="spamassasin_active" name="spamassasin_active">
	<option value="1" onclick="cpves_sa_active('1');">Ja</option>
	{if $spamassassin_active eq '0' }
	<option value="0" onclick="cpves_sa_active('0');" selected="selected">Nein</option>
	{else}
	<option value="0" onclick="cpves_sa_active('0');">Nein</option>
	{/if}
	</select></td>
</tr>

{if $if_bogofilter == 1}
<tr>
	<td>Bogofilter aktiv:</td>
	<td><select id="bogofilter_active" name="bogofilter_active">
	<option value="1">Ja</option>
	{if $bogofilter_active == 0}
	<option value="0" selected="selected">Nein</option>
	{else}
	<option value="0">Nein</option>
	{/if}
	</select></td>
</tr>
{/if}
	
<tr>
	<td valign="top">Schreibe Betreffszeile um:</td>
	<td>{if $rewrite_subject == '1' } 
	<input type="radio" name="rewrite_subject"  value="0" /> Nein 
	<input type="radio" name="rewrite_subject" checked="checked" value="1" /> Ja<br />
	{else} 
	<input type="radio" checked="checked" name="rewrite_subject"  value="0" /> Nein 
	<input type="radio" name="rewrite_subject" value="1" /> Ja<br />
	{/if}
	<input id="spamassassin_subject_header"  maxlength="15" name="rewrite_subject_header" value="{$rewrite_subject_header}" type="text" />
	</td>
</tr>
	
<tr>
	<td>Markiere Nachricht als Spam ab:</td>
	<td><input type="text" id="spamassassin_threshold" name="threshold" value="{$threshold}" />	
	
	{if $spamassassin_active eq '0' }
	<script type="text/javascript">
	cpves_sa_active('0');
	</script>
	{/if}
	<input name="save_option" type="submit" value="Speichern" /> 
	</td>
</tr>

</form>
{/if}
<!-- Spamassasssin feature end -->

</table>

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}