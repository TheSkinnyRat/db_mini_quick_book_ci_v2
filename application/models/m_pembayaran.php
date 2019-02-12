<?php

class m_pembayaran extends CI_Model{
	function tampil_data(){
		return $this->db->get('tbl_pembayaran');
	}

	function log_bayar(){
		return $this->db->get('tbl_log_bayar');
	}

  function terima($where){
	$this->db->where($where);
	$this->db->delete('tbl_pembayaran');
	}

  function terima_update($where){
  $this->db->set('ket', '1', FALSE);
	$this->db->where('kd_pembelian',$where);
	$this->db->update('tbl_log_bayar');
	}

  function tolak($where){
	$this->db->where($where);
	$this->db->delete('tbl_pembayaran');
	}

  function tolak_update($where){
  $this->db->set('ket', '2', FALSE);
	$this->db->where('kd_pembelian',$where);
	$this->db->update('tbl_log_bayar');
	}
}
