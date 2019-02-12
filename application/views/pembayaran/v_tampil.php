<?php
	include ('header_sa.php');
?>
<div id="main">
	<?php if( $error = $this->session->flashdata('response') ): ?>
        <div class="alert alert-success alert-dismissable">
<!--            <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>-->
            <?php echo $error; ?>
        </div>
    <?php endif; ?>
	<div class="container">
		<h1><center>Pembayaran</center></h1>
		<table class="table table-striped table-hover">
		  <thead>
		    <tr>
				<th>Kode Pembelian</th>
				<th>Pembeli</th>
				<th>Harga Total</th>
				<th>Bukti Pembayaran</th>
				<th colspan="2">Action</th>
			</tr>
		  </thead>
		  <tbody>
		    <?php
			$no = 1;
			foreach($tbl_pembayaran as $u){
			?>
				<tr>
					<td><?php echo $u->kd_pembelian;  ?></td>
					<td><?php echo $u->pembeli  ?></td>
					<td><?php echo $u->harga_total  ?></td>
					<td>
						<a href="<?php echo base_url() ?>assets/img_bayar/<?php echo $u->bukti_pembayaran ?>" target="_blank">
						<img src="<?php echo base_url() ?>assets/img_bayar/<?php echo $u->bukti_pembayaran ?>" width="auto" height="75" >
						</a>
					</td>
					<td><?php echo anchor("c_pembayaran/terima/{$u->kd_pembelian}", 'Terima', ['class'=>'btn btn-success']); ?></td>
					<td><?php echo anchor("c_pembayaran/tolak/{$u->kd_pembelian}", 'Tolak', ['class'=>'btn btn-danger']); ?></td>
				</tr>
				<?php

			$no++;
			}
			?>
		  </tbody>
		</table>
<br><br><br>
		<h1><center>History Pembayaran</center></h1>
		<table class="table table-striped table-hover">
			<thead>
			<tr>
				<th>Status</th>
				<th>Pembeli</th>
				<th>Kode Pembelian</th>
				<th>Kode Barang</th>
				<th>Deskripsi Barang</th>
				<th>Spesifikasi Barang</th>
				<th>Jumlah</th>
				<th>Harga Satuan</th>
				<th>Harga Total</th>
			</tr>
		</thead>
		<tbody>
			<?php
			foreach($tbl_log_bayar as $a){
			?>
				<tr>
					<td>
					<?php  if ($a->ket == 0) { ?>
						<div style="color: blue;">Dalam Proses...</div>
					<?php } else if ($a->ket == 1) { ?>
						<div style="color: green;">Pembayaran Berhasil</div>
					<?php } else if ($a->ket ==2 ){ ?>
						<div style="color: red;">Pembayaran Ditolak</div>
					<?php } else { ?>
						<b>ERROR,</b>
					<?php } ?>
					</td>
					<td><?php echo $a->pembeli  ?></td>
					<td><?php echo $a->kd_pembelian  ?></td>
					<td><?php echo $a->kd_barang  ?></td>
					<td><?php echo $a->deskripsi_barang  ?></td>
					<td><?php echo $a->spesifikasi_barang  ?></td>
					<td><?php echo $a->jumlah  ?></td>
					<td><?php echo $a->hrg_satuan ?></td>
					<td><?php echo $a->hrg_total ?></td>
				</tr>
				<?php
			}
			?>
		</tbody>
		</table>

	</div>
</div>
<?php
	include ('footer.php');
?>
