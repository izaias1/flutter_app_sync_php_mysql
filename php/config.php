<?php
	$db = mysqli_connect(
		"localhost",
		"root",
		"root",
		"syncsqftomysqldatabase",
	);

	if (!$db) {
		echo "Database Connect Error " . mysqli_connect_error($db);
	}