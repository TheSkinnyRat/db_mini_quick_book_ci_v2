<?php
	include ('header_m.php');
?>
<div id="main">
	<div class="container">

		<h1><center>PEMBAYARAN</center></h1>
		<?php echo form_open_multipart("member/c_member/do_upload/{$tbl_beli->kd_pembelian}");?>
		<div class="row">
			<div class="col-lg-6">
				<div class="form-group">
			    	<label class="control-label col-lg-4" for="img_bayar">KODE PEMBELIAN :</label>
			    	<div class="col-lg-8">
			    		<?php echo form_input(['name'=>'kd_pembelian', 'type'=> 'text', 'readonly'=>'true', 'class'=>'form-control', 'placeholder'=>'Kode Pembelian', 'value'=>set_value('kd_pembelian', $tbl_beli->kd_pembelian) ]) ?>
						</div>
			    </div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="form-group">
						<label class="control-label col-lg-4" for="img_bayar">NAMA PEMBELI :</label>
						<div class="col-lg-8">
							<?php echo form_input(['name'=>'pembeli', 'type'=> 'text', 'readonly'=>'true', 'class'=>'form-control', 'placeholder'=>'Kode Pembelian', 'value'=>set_value('kd_pembelian', $tbl_beli->pembeli) ]) ?>
						</div>
					</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="form-group">
			    	<label class="control-label col-lg-4" for="img_bayar">TOTAL PEMBAYARAN :</label>
			    	<div class="col-lg-8">
			    		<?php echo form_input(['name'=>'harga_total', 'type'=> 'text', 'readonly'=>'true', 'class'=>'form-control', 'placeholder'=>'Total Pembayaran', 'value'=>set_value('kd_pembelian', $tbl_beli->harga_total) ]) ?>
						</div>
			    </div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="form-group">
			    	<label class="control-label col-lg-4" style="color: green;" for="img_bayar">KIRIM BUKTI PEMBAYARAN :</label>
			    	<div class="col-lg-8">
			    		<?php echo form_input(['name'=>'img_bayar', 'type'=>'file', 'readonly'=>'false', 'class'=>'form-control', 'placeholder'=>'Kirim Bukti Pembayaran']) ?>
			    	</div>
			    </div>
			</div>
		</div>

		<?php echo anchor("member/c_member/keranjang", 'Batal', array('class'=>'btn btn-primary btn-lg btn-info', 'style'=>'width: 170; float: left;')); ?>
		<button type="submit" style="width: 170; margin-left: 10; float: left;" class="btn btn-primary btn-lg btn-success">KIRIM</button>

	</form>
	</div>
</div>
<?php
	include ('footer.php');
?>
