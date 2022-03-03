;=== Adinda Luthfiah S ===
;=== 20/463587/TK/51579 ===
;===== MELAKUKAN DIAGNOSIS SEMENTARA TUBERKULOSIS =====

; Melakukan identifikasi gejala TBC
(defrule exposedppl
	=>
	(printout t crlf "Identifikasi gejala tuberkulosis sementara.")
	(printout t crlf "Apabila jawaban pertanyaan salah ketik 0 dan 1 untuk benar." crlf)
	(printout t crlf "Apakah ada riwayat pengobatan tuberkulosis atau kontak erat dengan pasien tuberkulosis?" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then (assert (checkFever)))
	(if (= ?x 1)
		then(assert (exposedppl yes))
			(printout t crlf "Langsung melakukan Tes Cepat Molekuler pada fasilitas kesehatan terdekat yang menyediakan." crlf crlf))
)

;identifikasi gejala pasien
(defrule symptom1
	(checkFever)
	=>
	(printout t crlf "Apakah mengalami demam dan batuk selama 2 minggu atau lebih?" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then (assert (NonTBC)))
	(if (= ?x 1)
		then (assert (checkCough)))
)

(defrule symptom2
	(checkCough)
	=>
	(printout t crlf "Apakah batuk disertai dahak atau darah?" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then(printout t crlf "Apakah hanya batuk kering?" crlf)
		(bind ?x (read))
		(if (= ?x 0)
			then (assert (NonTBC)))
		(if (= ?x 1)
			then (assert(check_hardToBreathe)))
	)
	(if (= ?x 1)
		then (assert (check_hardToBreathe)))
)

(defrule symptom3
	(check_hardToBreathe)
	=>
	(printout t crlf "Apakah mengalami nyeri di dada atau sesak napas?" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then (assert (TCMtest)))
	(if (= ?x 1)
		then (assert (checkSweats)))
)

(defrule symptom4
	(checkSweats)
	=>
	(printout t crlf "Apakah mengalami keringat berlebih di malam hari" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then (assert (checkTiredness)))
	(if (= ?x 1)
		then (assert (checkTiredness)))
)

(defrule symptom5
	(checkTiredness)
	=>
	(printout t crlf "Apakah mengalami nyeri otot dan sendi? ataukah merasa lemas?" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then (assert (check_weight_loss)))
	(if (= ?x 1)
		then (assert (check_weight_loss)))
)

(defrule symptom6
	(check_weight_loss)
	=>
	(printout t crlf "Apakah mengalami penurunan napsu makan atau penurunan berat badan selama 2 bulan sebelumnya?" crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then (assert (medical_check)))
	(if (= ?x 1)
		then (assert (medical_check)))
)


;======= HASIL DIAGNOSIS =========

(defrule medical_nonTBC
	(NonTBC)
	=>
	(printout t crlf "Bukan tuberkulosis, tetapi SANGAT disarankan untuk melakukan pemeriksaan lebih lanjut secara medis." crlf crlf)
)

(defrule medical_TCM
	(TCMtest)
	=>
	(printout t crlf "Bukan tuberkulosis tetapi SANGAT disarankan melakukan pemeriksaan secara medis seperti tes mantoux atau tes darah." crlf crlf)
)

(defrule medical_TBC
	(medical_check)
	=>
	(printout t crlf "=== Silahkan melakukan Tes Cepat Molekuler, Rontgen, dan Uji Tuberkulin ===")
	(printout t crlf "Jika dari pemeriksaan tersebut ada indikasi yang mengarah ke tuberkulosis")
	(printout t crlf "Segera lakukan terapi OAT dan melakukan pengobatan sesuai anjuran dokter spesialis."crlf crlf)
)
