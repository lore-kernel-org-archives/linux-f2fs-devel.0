Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F7CC5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whPqdySN9rPxa0VCkkTiJFpHmMVytFqXglFZiyxQpHY=; b=EX53QW9ktj4CQnuFtym+RwNqTH
	aziQ8VU8KZtzlmot0yBAQXlVqsjHPxNsXIIxWSMu/lT0ilpfe4fEs2Fu7g+91ha2R4QDBPhjFmbEW
	fK9sgRlJW+2gZ3mp0i7B+hlRpN58MBMqOcfsLYs8FEo5zX1qkbiC3USkd1y0eI48N26c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wySHT-0007yP-Og;
	Mon, 24 Aug 2026 10:51:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wySHS-0007yI-BY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:51:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=; b=h3Y6syCemizKs0UfQwSTih77Gi
 dmpaDOkaaIlzzhWjR8F10t6M1qvD4tHarLRy/1WXD4+rT2WJwSuTpRZYz+H+uBb1YlAp/Z1AGkKEZ
 FFkpaNJzne+fUJfHpbVxWbCy1zcBaZ0c51y1oZZfPZkslS9Ozc4WZnpfm651oHa+vPp4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=; b=Hmaehj8WBb0W6Rg3JoG/RfkY7I
 MfrQ7RxK8nEsNvtc6i4kd63xj8hoi3gpxy0x4/EnN/CjXOGJW+ulTEWq2Y5WUBw8lTa4LTSTDzrd+
 wJfGQfdx5CLhvy8GSuiF/tkOSZkEyJftjn3D/GkMM8jCr39WAcFaXMrkmekJM0inYFCo=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySHR-0005GV-Kj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:51:55 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3931756a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787568708; x=1788173508; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=;
 b=jf5fH3E4Gih9J4+AytPlvjyAF1LnG7GxL0ZuTW9cZxz3lPQ29AhFP4kf8vCFz9O0a6
 6zxKNMf0FgfjA547IUqpQebpOCcXA2Wr1G2+oanXIMLOXB2tApGMPHyr6XAXBaRR+eUy
 LrMXVaIxycdfbB9BHtaxybgrU6nu2E3hKwSJP47uPitrvOeEfNwA7m7/9lPzfqqCd/jj
 zYuyhSiBIrUqacwLZPCu90Yd/E8yL/FyPFTBLD6VOvNSVqQ9iQpIZMz0tHCBbTG5D8s9
 nOTQVd/YWYa0uwNinWDVzuIJeAaM1ifbB8gXPba0q8deZubBwZ6iXoxq7AuqBbHP2VVc
 b/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568708; x=1788173508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=;
 b=dOjO/Jb7t4AC9jKBUjejMW0cacQdYj2J2KBoGAurls78Zhf3GH/Ql4U4GDF+EdJQFp
 cqZ38BH1Li4cNe2EC28i3CIkAUKYyLmp5Auxy7wk6xfA79FfnbH16hI6YfZ7F2DmEpG+
 99NirNfYKr9DHgECTNCPUyGf+zyXQK+6gm+Fq2yWutAEuSmfi0sjOg1rU1FVJq2EXNnp
 oO2QhjyuHaWCDTfyzOCUH70Vn8x1elwWWDXkGXGtpGlqWWGzY74SzKeYJcNpS3SVgJzV
 Flzq6PErUMoHSUgwYVHk0/HnNv+g9Q8b+WpM4Bg5vSWuwjy4x0dCyZpIOf1ydzgUlX2Z
 CDSA==
X-Gm-Message-State: AFuF++lKzdUGo5i+/nF2EXYZtCxMVg1DrAPRBBNHtWRYtWBXEodLj4d7
 OycVMJOMurBrBo9nhkbDISQ3gsKy8OBE3cPT+e0wL5YHjkd38iLMqRk9
X-Gm-Gg: AR+sD13XW8k1+c7E7PSA5KSv42m1bq5ti+lYFSWA9ESUXPIdrIZqpK1n4cuAi+eUN83
 +qE9Vj9m3LyOdN3OfrmCTT+RQO8UXDyLGLfg5GqUElEpnrR2v71bfR/XFltMFeDb5EbRUcM/aZW
 jo/OJe4+3QpbLt6NiQx0mOz+YuqZA59W3FGViPWjX3vCCWrRmKPTxDStCfbnBNTkqJomm7wnk12
 +++OUs5xVidlaL1ra6NxckmHTy7TbRoRMHKWEh1mYOY2RSMxYhrYoek4HcfSLw+uJS+HdvMXXye
 qKiCKmlVAKAJylsZvMPq+WMGfdOIstuIFiKGICpdPlav1FNix11/2ObfYB0dCBfpXSLGOQY1tMJ
 NPhYXUXUnKSAav/CH7yvZ5l0fXGpuWIPdS1pnl9xgZfj6OmZWmEVsuiJNYz3i9l9IiurPCdQ7/O
 BHNR+lN6L7BHTKcRpJyjY29JvPfJtrKjlgVbXgSrZ9vXH6vX0mzOgnH92gngE990ghTMJEuxx4h
 wEU0vxS32GgG1i34kbBI5it
X-Received: by 2002:a17:90b:5112:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-395dee8a5c5mr34369423a91.4.1787568707684; 
 Mon, 24 Aug 2026 03:51:47 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af6e88sm9708996a91.9.2026.08.24.03.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:51:47 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 24 Aug 2026 18:51:36 +0800
Message-ID: <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787568046.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787568046.git.qiwenjie@xiaomi.com>
References: <cover.1787568046.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wySHR-0005GV-Kj
Subject: [f2fs-dev] [PATCH v3 RESEND 1/2] f2fs: complete dropbehind write
 bios in safe task context
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Buffered RWF_DONTCACHE writes invalidate dropbehind folios from writeback
completion. Keep normal and dropbehind folios in separate write bios, and
defer dropbehind bios to sbi->wq unless completion runs in preemptible task
context.

Use an F2FS-local context check for this decision. Task context alone is
not sufficient: preemption may still be disabled, or completion may run in
a preemptible RCU read-side critical section.

Keep the existing large-ATC deferral unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6ae0eb37d20..774a3e2d8e3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -21,6 +21,7 @@
 #include <linux/fiemap.h>
 #include <linux/iomap.h>
 #include <linux/fserror.h>
+#include <linux/rcupdate.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -43,9 +44,29 @@ struct f2fs_folio_state {
 
 struct f2fs_bio {
 	struct work_struct work;
+	bool dropbehind;
 	struct bio bio;
 };
 
+static struct f2fs_bio *to_f2fs_bio(struct bio *bio)
+{
+	return container_of(bio, struct f2fs_bio, bio);
+}
+
+/* Keep in sync with the proposed block-layer bio_in_atomic(). */
+static bool f2fs_bio_in_atomic(void)
+{
+#ifdef CONFIG_PREEMPTION
+	if (rcu_preempt_depth())
+		return true;
+#endif
+#ifndef CONFIG_PREEMPT_COUNT
+	return true;
+#else
+	return !preemptible();
+#endif
+}
+
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
 int __init f2fs_init_bioset(void)
@@ -426,12 +447,13 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
-		struct work_struct *w;
+	if ((to_f2fs_bio(bio)->dropbehind && f2fs_bio_in_atomic()) ||
+	    (in_atomic() &&
+	     bio->bi_iter.bi_size > sbi->max_atc_write_bio_size)) {
+		struct work_struct *work = &to_f2fs_bio(bio)->work;
 
-		w = &container_of(bio, struct f2fs_bio, bio)->work;
-		INIT_WORK(w, f2fs_write_end_io_work);
-		queue_work(sbi->wq, w);
+		INIT_WORK(work, f2fs_write_end_io_work);
+		queue_work(sbi->wq, work);
 	} else {
 		f2fs_write_end_bio(bio);
 	}
@@ -530,6 +552,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	to_f2fs_bio(bio)->dropbehind =
+			!is_read_io(fio->op) && folio_test_dropbehind(fio->folio);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -825,6 +849,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
 }
 
+static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
+					  struct f2fs_io_info *fio)
+{
+	return to_f2fs_bio(bio)->dropbehind ==
+		folio_test_dropbehind(fio->folio);
+}
+
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
 						struct f2fs_io_info *fio)
 {
@@ -1017,8 +1048,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 	trace_f2fs_submit_folio_bio(data_folio, fio);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio &&
+	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				fio->new_blkaddr) ||
+	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
@@ -1118,7 +1151,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
-				bio_folio->index, fio)))
+				bio_folio->index, fio) ||
+	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
