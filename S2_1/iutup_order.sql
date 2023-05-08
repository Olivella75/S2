USE youtube;

SELECT * FROM youtube.contentp;
SELECT * FROM youtube.agrada;
SELECT * FROM youtube.subscripcio;
SELECT * FROM youtube.canal;
SELECT * FROM youtube.comentaris;
SELECT * FROM youtube.etiquetes;
SELECT * FROM youtube.publication;
SELECT COUNT(likes.opinion) FROM youtube.likes;
SELECT * FROM youtube.usuari INNER JOIN youtube.video ON video.video_id = usuari.user_id;
SELECT * FROM youtube.usuari INNER JOIN youtube.playlist ON playlist.playlist_id = usuari.playlist;
SELECT * FROM youtube.comentaris INNER JOIN youtube.agrada ON agrada.enjoy_id = comentaris.comments_id;
