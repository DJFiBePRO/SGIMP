<form action="tablaArticulos.php" method="post"align="center">
			    
			    <input name="nombre" size="30"  placeholder="Busqueda por nombre..." >
			    
			    <input type="submit" name="Buscar" value="Buscar" ><p>
</form>	
<?php 
	$dato = $_POST['nombre'];
	require_once "../../clases/Conexion.php";
	$c= new conectar();
	$conexion=$c->conexion();
	$sql="SELECT id_servicio,
						 descripcion_servicio,
						 disponibilidad_servicio,
						 tipo_servicio 
				from servicio
				where tipo_servicio like '%$dato%'";
	$result=mysqli_query($conexion,$sql);

 ?>



<table class="table table-hover table-condensed table-bordered" style="text-align: center;">
	<caption><label>Articulos</label></caption>
	<tr>
		<td>#</td>
		<td>Descripcion</td>
		<td>Disponibilidad</td>
		<td>Tipo de servicio</td>
		<td>Editar</td>
		<td>Eliminar</td>
	</tr>

	<?php while($ver=mysqli_fetch_row($result)): ?>

	<tr>
		<td><?php echo $ver[0]; ?></td>
		<td><?php echo $ver[1]; ?></td>
		<td><?php echo $ver[2]; ?></td>
		<td><?php echo $ver[3]; ?></td>

		<td>
			<span  data-toggle="modal" data-target="#abremodalUpdateArticulo" class="btn btn-warning btn-xs" onclick="agregaDatosArticulo('<?php echo $ver[0] ?>')">
				<span class="glyphicon glyphicon-pencil"></span>
			</span>
		</td>
		<td>
			<span class="btn btn-danger btn-xs" onclick="eliminaArticulo('<?php echo $ver[0] ?>')">
				<span class="glyphicon glyphicon-remove"></span>
			</span>
		</td>
	</tr>
<?php endwhile; ?>
</table>