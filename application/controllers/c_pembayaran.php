<?php
class c_pembayaran extends CI_Controller{

	public function __construct(){
		parent::__construct();
		$this->load->model('m_pembayaran');

		if($this->session->userdata('ux_akses') != "super_admin" && $this->session->userdata('ux_akses') != "admin" ){ ?>
			<script>alert("Anda Bukan ADMIN/SUPER ADMIN.!");
			document.location= "<?php echo base_url('c_login') ?>"</script>
		<?php
		}
	}

	public function index(){
		$data['tbl_pembayaran'] = $this->m_pembayaran->tampil_data()->result();
		$data['tbl_log_bayar'] = $this->m_pembayaran->log_bayar()->result();
		$this->load->view('pembayaran/v_tampil',$data);
	}

  public function terima($kd_pembelian){
    $where = array('kd_pembelian' => $kd_pembelian);
    $this->m_pembayaran->terima($where);
		$this->m_pembayaran->terima_update($kd_pembelian);
		return redirect('c_pembayaran');
	}

  public function tolak($kd_pembelian){
    $where = array('kd_pembelian' => $kd_pembelian);
    $this->m_pembayaran->tolak($where);
		$this->m_pembayaran->tolak_update($kd_pembelian);
		return redirect('c_pembayaran');
	}
}

?>
