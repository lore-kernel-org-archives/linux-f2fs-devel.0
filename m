Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81588C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whPqdySN9rPxa0VCkkTiJFpHmMVytFqXglFZiyxQpHY=; b=LK+aEfmMjSDBjDdTkOcyG3DimR
	SCAUIgVSrJ32oRh5Aqbuh4XfB+nVPUz4mr8sFQSrr24DSVWceKhsRZ/DXMUtlsLq/gYpmNV8Bsbh/
	9Ha9pmSpEtYC0pZD1oQ6+eOBqUrUKKkjut1yIOti3aiVOPeaSEzt9mbobHvAHbECIRl4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyS0G-0004KZ-H6;
	Mon, 24 Aug 2026 10:34:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyS0F-0004KR-2Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=; b=aQAvK2uIVQ6pyk2YXUjWXxV0Q+
 44j371CyP0APhpzKu/bd+VR8DktYbMKLQiWL6Raunwc5ziHa99kpn1r3UaCmDxkLmyEmfU7826Mni
 TYXQZ9NQDAsx/jTCUl1YqWafp8bHU+rh14g6OTAu+hjEDsVUTN1/ZMBXhsJofpnW7sOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=; b=NeB3F5/x+aKypYRjRaGI4FVJLc
 hqJrVDx1q4KOxitLBYzL3+FGfTwOIZvcmBm02IJoo21a1yJ07epZaFacKoZ8sW7vz4N9mpnfdQGIY
 szztlyH6ZWC3iTY8Yh4C97X1SwFaIn/0p3YmN6q7RGbPxgDiwUItZLoK/wj4YIZJ1q1Y=;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyS0E-0001aD-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:34:07 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so3635633a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787567640; x=1788172440; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=;
 b=IxLksAGkv+zbCv0ElUEoAM4ckFdzTTAhhWPV2Dnaoq39c10kCt2luLt+iNW7nrompc
 lKyOJNForFRvXubSTvdyChlPpJNh3c3CkuwR0ZEq89kkfsfxMHmfDDaU/km+OPvw5FM/
 X89J8oLciko0H3rdxn36x6q+scb0jcTv12C+yZV9SjG05fB1VZE19AEKV/FbacBxgHTr
 EpkFKkR6HPcrnEdcQJHcXX8h+jLIxC9MUV1Y+3XXa4qWTYdV352qp8q367Ue+WdhYPSW
 euElbiZR9tFrSyNpVIeCmHwUsIOg+5JwhxsXRGXH/8SC0FOZJk+/rwftO7O4TetPZGVw
 5b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567640; x=1788172440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hJJbk4tPuMZ/n5IgnZpbMmRDFynIgVeuM9Ohf0uhx24=;
 b=hAp2OTfDkfd60jmpHj+Rn3ukvVnDRcZ/XtyomvxQZzski1dExIW8BvUGc+o1rWMLSO
 H9sS4zi/Yv1fic6krdsqxWe5sqFnqU53IPwgz/4/9Trl5PXgVgmPXSAYn7e2bhsLxFJF
 wmA65mCPcG432Elas13n7hl/XFO4Biu+A6D/zK7boTkllEJmsO1HPhnJOI1OGCj70uFB
 AxGEElZE2wsG13r4u/U1Oy2rOze0uGvfa+x4muWd04Em6sy2QGArnb8Ibj/9PGESxTh0
 UDG90oR3KBJmcyzCuYd8ZVWSUJRMkgPWrdJ078QHeVi1zSQBVVsLTusxlbpIryGhk4xI
 qDEw==
X-Gm-Message-State: AFuF++nVJ2z33jE96dionERnvtRtG4nBjOIbSj7FYMvHxAv+cVmh55kE
 MOo/xlSv2BRIegMreMWSLCoRLEICsslp2aXjP6rc91aaX0Mq0u+pBL/8
X-Gm-Gg: AR+sD11HY8xmhHHZITKlN5ZF+6fvDCAks+F/s5LfPmV3d6cC1FnypDT1Ykdv4wuAxdt
 FuKhz2QIoe+EREDHFby+NwXbX7YZMmQtFo43zV9zflTwCGeZtvuKP0pXA4CuEjHi22HaDBQAcDd
 dN9xkZQU6x4vUHVpR98YmLtQ3D13Fw4c/0V1TFvFFj2U1BZDqy0lsr97eL/pHD9HZwgUj70AQ4k
 j0IUnw8onYjN/vLQcZURk1CFtGjcFUdSsDGUpS/h9mDjbHmZHDRbBawBDBIJHR9++M0cA0MCYf0
 O3tzgminqqzwsauibCWinAC/iPrG01nshP97ENrFUTiZR6oYUw2jNNshio/KiTO8mOrc/Q/rsHG
 LLCYcLVt8lAIyEMKGAiWJWdQ5uV45SH+X83BS/tdCpJLaPzDJY9rH9r/uQ2y2zeufYdoQo13HX4
 YVr2SwbCf3xb1nGHIESSAlN732IGprjH2bWODuDGzsCYkqi/dXd8V1qgvG769LZS5GtwxbOGZ/h
 DSo7MMfYcZ7lEqkM06BTfBD
X-Received: by 2002:a17:90b:1d01:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-395df5e8426mr33513930a91.15.1787567640562; 
 Mon, 24 Aug 2026 03:34:00 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f14abb3sm1805081b3a.45.2026.08.24.03.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:33:59 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 24 Aug 2026 18:33:46 +0800
Message-ID: <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787564706.git.qiwenjie@xiaomi.com>
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <cover.1787564706.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wyS0E-0001aD-B3
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: complete dropbehind write bios in
 safe task context
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
