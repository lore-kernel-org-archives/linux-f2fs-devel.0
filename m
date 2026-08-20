Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5695FC5DF85
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwJt9l1Hx/tII1+ECLPfFgr5VqpDlgvCAT7E2WPS2gU=; b=ZNxPWYRf/i0dEx39pDC7dh44+b
	vGTuYFdISo1IPGVQM9Gyz6vtqb2nZoT4g0lF1YSFK52ME/ijLByebRgypwyZ2iCqD8QrIakKBq0B/
	aGD5MDhsguRDCe79CJDd+0hRorx1HguvNno/C4qwxypiFtG8KYytTJKbq8QetDvQ17/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwwzL-0002x4-35;
	Thu, 20 Aug 2026 07:14:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wwwzJ-0002wm-0o
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rKVsXzEdcjeAkZAMt7kUuxma/a9jwFOX0PL7ezELQks=; b=c6gRP2Dt59mYGWH6tyRfY3ZMZK
 iMQxpAOSPO5zGDZ8K8D349GTSoTpijnIWcUPQrfyWGs2iWCW9m7fCACNnMhdp3TNAzdz5R9Bhj67t
 NedMS+ZrW3aNFm2c4M56UOSWw3rrKToquprcnssUUkyrgBhcQmHOwBHQhORjgtwIXzH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rKVsXzEdcjeAkZAMt7kUuxma/a9jwFOX0PL7ezELQks=; b=QG5Ae7RruANVV/Xv69lCRE5fOR
 O3wVVOmvQwcMewXrO3fyWQliPLJ9vgAcrMzIxfKxYrWLumkJEIQp5ddsltPs0ZrGD+TgRlgBGqt2i
 Isp5hQScrAAWTrrhM4FrmIZNJyec57r5TkDTrs1d3o7vlWxQsa3gcQ6lA06lH5aOtHtA=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwwzI-0001bR-6d for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:14:57 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1188254a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210090; x=1787814890; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rKVsXzEdcjeAkZAMt7kUuxma/a9jwFOX0PL7ezELQks=;
 b=n9NvKjVX1xedmUpIOmZ5jGnehxPKAP/WdBuExnI3/AVgFcS82D6Pkp0Wwrjzm3Dugl
 UpYCa3sA11WCE561AO5WBW9QXgLFg4U1gG4EtHcfLPEUDHWvZzlYAVNapmhklzwdfxpR
 O/lOIWz+JNuBafWhx3QuGajSzlUqSvqDq2gXY5Nf9vfrbiEnd0FzDX5Xq8iIXcis35lM
 LtL6uFbCJAvM6BsBLp0tXcuiojIT/BF8cnvqZ5MUNA3mUvqszugSpqE6AUJSIYRICPjF
 lkwm8iCSlmfkgNFn7oQgF+f7EeO2EL9Xt2lQtvHWOkyYwyLeQmyu0Yf69q2Exb1AJNfS
 KpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210090; x=1787814890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rKVsXzEdcjeAkZAMt7kUuxma/a9jwFOX0PL7ezELQks=;
 b=AguM69XEfRRZI+u5ZR9Pj8+YSgG0qIvxfHDnDIaJz1UHN3e+IPqzBlLkyr7HIyuAuF
 foI6ej1iStWn6H98GC7//7pwgpsKT1pB76vSNq+uV3RJeuJdfMalqdkyJYM6yvaCjF1k
 L9y8DCNl0VBbbEUTInu8wTd0BXOsF+QvwTI8vwFPQp8kmcXSkdACXlcXnxJmxKg/jpub
 ZT7KPbdiwql0qdSqTtUs84VBxFVW4uF2IZK/NzSgDSR+bX4H5FcrxXsYEe8KpDaYg/N7
 GYBlMmCmIf0QUGSvU0tN8ZL9EVgynxc6vrrfWMIXe3SaYj2Ht8ZsIgU0OeQAMjtQvZgZ
 19HA==
X-Gm-Message-State: AOJu0YxI/BWFIYvVKkQPacVugosPnndZ6cGBcbuEtWKS0eyTcai4bLGW
 gR8ULsRYWNtVMc3wfyTnpazPVW5jldECtmBypNS9k1eEZbiLuPea2GsM
X-Gm-Gg: AR+sD12Ay7P0l8VnTXvrOrP7Lkm1AUIUSTzD+r4gMiFEwNfw8U2W70BNnzgXD8Mliyt
 jEC7o/eEqW+6LgoxTx241Z8EqV2Pi8cfBTvq6P1tm/qCQhZ7H/tDHul0feFCYofRpWM6IHz3Wdz
 tppIvqQaXnHQ3OznBY4PIxm+fgIFHNIA0QuiSl1HGAXsi1YhLhED7rKKtscADJ6qf51Wfip2SeU
 HpySeIzCK82g9GU2vhFg6IKnusuSsQgb2Z+sJZJ9Mvu9uvIoU+/q4nzh7CqoW1OX7TyhIGkb6Lw
 TVAHZe7l3pBR+AEQLIsp/Ixp3qS6vuRloZ7lr65flDJKcBPlMfQKEJWqBbnvGWAP9XE0nKREZWV
 mr4MKfLdckapP3uLlOuC3ixNBrpetkefwVhxfJ3TRI14IKKz7jS9/Ox3o1K213zKkW7OpmrU+Rq
 Jg5pte+Xh+zVFt1Yga3EwQLtHBqLAjRfEy1L1iu6B/DH/SlaPrmBRtJikkFjXweDhnc3ZET4+z9
 i/QD8b4atH0FvpmSKCR9It8
X-Received: by 2002:a05:6a00:438e:b0:835:6388:655d with SMTP id
 d2e1a72fcca58-851d393d954mr18125399b3a.14.1787210090367; 
 Thu, 20 Aug 2026 00:14:50 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d36185d3sm1329116b3a.31.2026.08.20.00.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:14:49 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 20 Aug 2026 15:14:37 +0800
Message-ID: <20260820071438.695893-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820071438.695893-1-qiwenjie@xiaomi.com>
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wwwzI-0001bR-6d
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: complete dropbehind write bios in
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
defer a dropbehind bio to sbi->wq unless completion runs in
preemptible task context.

Use the same eligibility conditions as the proposed bio_in_atomic() helper.
Unlike !in_task(), this also covers disabled preemption and preemptible RCU
read-side critical sections.

Keep the existing large-ATC deferral unchanged.

Link: https://lore.kernel.org/linux-mm/20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu/
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
