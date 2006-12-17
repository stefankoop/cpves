<?php
/******************************************************************************
* Copyright (C) 2006 Jonas Genannt <jonas.genannt@brachium-system.net>
* 
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License
* as published by the Free Software Foundation; either version 2
* of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
******************************************************************************/
session_start();
include("config.inc.php");
include("check_access.php");

if (isset($_SESSION['superadmin']) && 
    $_SESSION['superadmin']=='y'&& 
    is_numeric($_GET['id']) || is_numeric($_POST['id'])  && 
    isset($_POST['state']) &&
    $_POST['state']=='delete' )
{
if (! isset($_POST['del_ok']))
{

	$sql=sprintf("SELECT dnsname,id FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	$table_data = array();
	$sql=sprintf("SELECT email FROM users WHERE domainid='%s'",
		$db->escapeSimple($_GET['id']));
	$res =&$db->query($sql);
	$i=0;
	if ($res->numRows()==0)
	{
		$smarty->assign('if_no_data','y');
	}
	while($row=$res->fetchrow(DB_FETCHMODE_ASSOC))
	{
		array_push($table_data, array(
		'email'=>$row['email']
		));
		$i++;
	}
	$smarty->assign('if_del_ok', 'n');
}
else if (isset($_POST['del_ok']) && $_POST['del_ok']== 'y' ) 
{
	$sql=sprintf("SELECT id FROM users WHERE domainid='%d'",
		$db->escapeSimple($_POST['id']));
	$result=&$db->query($sql);
	while($row=$result->fetchrow(DB_FETCHMODE_ASSOC))
	{
		$sql=sprintf("DELETE FROM admin_access WHERE email='%d'",
			$db->escapeSimple($row['id']));
		$res=&$db->query($sql);
	}
	
	$sql=sprintf("SELECT dnsname,id FROM domains WHERE id='%s'",
		$db->escapeSimple($_POST['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	
	mail($config['postmaster'], "Delete Domain: ".$data['dnsname'], "Please move complete domain to save_dir!" );
	
	$sql=sprintf("DELETE FROM users WHERE domainid='%d'",
		$db->escapeSimple($_POST['id']));
	$db->query($sql);
	
	$sql=sprintf("DELETE FROM forwardings WHERE domainid='%d'",
		$db->escapeSimple($_POST['id']));
	$db->query($sql);
	
	$sql=sprintf("DELETE FROM domains WHERE id='%s'",
		$db->escapeSimple($_POST['id']));
	$db->query($sql);
	
	$sql=sprintf("DELETE FROM admin_access WHERE domain=%s",
		$db->escapeSimple($_POST['id']));
	$db->query($sql);

	
}



}// ende superadmin
$smarty->assign('id', $data['id']);
$smarty->assign('domain', $data['dnsname']);
$smarty->assign('table_data', $table_data);

$smarty->assign('template','domain_del.tpl');
$smarty->display('structure.tpl');
?>
