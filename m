Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20938F8D75C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dLm2pXsltIMiVjitznQ4U/gvdRf8U4kuPZ+gaaEuBOM=; b=MvGT00qGKa0+WFuGsM3PfjnZXY
	BzLumECtVxoI/1kxtz4ROdD7POE3PPMWXCxS0kxBF6ey2gx1DPtc/b841WWPPEwEQVPtR6hliNQu7
	kOdO3FRvqaOB/MMQwu6Xn7l4dzH0YhgT6OrLVsLp6uGdRo9ca5Tnu4ldzrNbH1g6TC+4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDp2z-00008F-Of;
	Fri, 17 Apr 2026 19:40:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <383LiaQcKALgafsjjccemmejc.amk@flex--chullee.bounces.google.com>)
 id 1wDp2y-000088-2F for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 19:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oF96Cc/IvEOxxBeBCh5Wbohcjk+dd56lPTP+sCCbGfs=; b=W6V8EamEIaljnrip+iUhGujdGL
 Erf9smmliPbFXCc4FMlRHQoz5C4KsHoPNssddGOTGG07dokGgrMZKL3ILVVZvB1t7PtQuA/e6k1w/
 m57g73gxUOG3fB3WIyE8bAvQxxJ5IBKbLsEJrmppnuazX9NbnmOvI4jOqN0X5WMhnaz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oF96Cc/IvEOxxBeBCh5Wbohcjk+dd56lPTP+sCCbGfs=; b=F
 4hCF5nCk6mjIzQa9RlGXtXBee1bcjJO+kvrDCeAvPeRptyK4maUkEHpG+BSf1Y8WmadtW5SuJTg0A
 9URl4757XNeiySPKAwjXZD4uTlUxX5ZqnkVw2jB26Fk/gqO2fJqIs37oHkdpWVma4jGmt9EFvRAUn
 Nv5QO2oXfqlL9uS8=;
Received: from mail-qt1-f202.google.com ([209.85.160.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wDp2x-0007Vw-CT for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 19:40:12 +0000
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-50da529ff48so26399121cf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Apr 2026 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776454800; x=1777059600;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oF96Cc/IvEOxxBeBCh5Wbohcjk+dd56lPTP+sCCbGfs=;
 b=u23xysNtoKqXGgBYK/WlXnfZq/Ud7dTQx+y7wSuhlVVxLuk7wpgBX6yQkTjdotX2QT
 6gxEUo/VPFt0a9XwJAUt3Yub80DmhkB1iod2gNGxvSGzK8X2AQVMP/3xyyvuChkiV1KN
 9HHLPSP923WNSZ2VFjIwJVLqMttLjPcJ4i0bvIXxfJl+WfC3g/LYuz8Po/oxIsL9ylB3
 BEX23cP/ebpu/pGfTAJYFtNXaRovLem8uypyNXnrFz65h7AAcjmiVBdrOZ+Wmo1QV25B
 5udivNnCfBCNtjm2WQn8YY1gyMqsiN9E93qiSKrWukabhF8s1zgAkfQEzdtn/86slhJq
 KtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776454800; x=1777059600;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oF96Cc/IvEOxxBeBCh5Wbohcjk+dd56lPTP+sCCbGfs=;
 b=bzsp0KfCz9Ka5Jxc4OJi3YAL3lIRUvyglb547/4zHlRuZbqeiZ0qfqHaSka7oQRZOh
 oKYGCoDRqyGh/oo7s0hUC303/g+YcgVHc3ITKvdX3YLldnxvx3e+CBZQwtCRL5WFuWgw
 iEJs+r+N/1VMDEHKIwJKIbSOjFNTaCSHSxHaW2T3eKmdLUTcNDe5wtDyzhXjJhc/gTZr
 iFTMg24qWMicJFKile0lpre9SH8wHAtBgCgmb3UNtpD0Al2CcC0RLoFvY8C6XyXESGIH
 9XUZ4JbYiOVGWu410cBUXVxcv2stxf4PiB63HbVMUZk3xCMDc2P5KLe5calH4QqW38f3
 OB+Q==
X-Gm-Message-State: AOJu0YxFXhKTYvV+cMuXZn9rhTkVdm/Jn9pmFQ73bJjkFlOSM5mpJo8f
 eTI5ZD0KAc6s1BsGR9VGGIGFYPVsR/ROb1c6cP1UnEPKdg8MGxqi3ldJ6kM5hSEBJKpSCD6vbaU
 gSGSv9zJ4bw==
X-Received: from dyaw25-n1.prod.google.com
 ([2002:a05:693c:4159:10b0:2df:5e19:9e69])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:3723:b0:2de:9470:5e75
 with SMTP id 5a478bee46e88-2e478b289b8mr1846965eec.23.1776448243311; Fri, 17
 Apr 2026 10:50:43 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:50:40 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260417175040.3562355-1-chullee@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1wDp2x-0007Vw-CT
Subject: [f2fs-dev] [PATCH v2] f2fs: add page-order information for large
 folio reads in iostat
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
From: Daniel Lee via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Lee <chullee@google.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Track read folio counts by order in F2FS iostat sysfs and tracepoints.

Signed-off-by: Daniel Lee <chullee@google.com>
---
v2: use array size 11 instead of 16

 fs/f2fs/data.c              |  4 ++++
 fs/f2fs/f2fs.h              |  3 +++
 fs/f2fs/iostat.c            | 38 ++++++++++++++++++++++++++++++++++++-
 fs/f2fs/iostat.h            |  4 ++++
 include/trace/events/f2fs.h | 21 ++++++++++++++++----
 5 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a210a7a627c6..965d4e6443c6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2508,6 +2508,8 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	if (!folio)
 		goto out;
 
+	f2fs_update_read_folio_count(F2FS_I_SB(inode), folio);
+
 	folio_in_bio = false;
 	index = folio->index;
 	offset = 0;
@@ -2682,6 +2684,8 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 			prefetchw(&folio->flags);
 		}
 
+		f2fs_update_read_folio_count(F2FS_I_SB(inode), folio);
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		index = folio->index;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 56c4af4b1737..e40b6b2784ee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -10,6 +10,7 @@
 
 #include <linux/uio.h>
 #include <linux/types.h>
+#include <linux/mmzone.h>
 #include <linux/page-flags.h>
 #include <linux/slab.h>
 #include <linux/crc32.h>
@@ -2034,6 +2035,8 @@ struct f2fs_sb_info {
 	unsigned long long iostat_count[NR_IO_TYPE];
 	unsigned long long iostat_bytes[NR_IO_TYPE];
 	unsigned long long prev_iostat_bytes[NR_IO_TYPE];
+	unsigned long long iostat_read_folio_count[NR_PAGE_ORDERS];
+	unsigned long long prev_iostat_read_folio_count[NR_PAGE_ORDERS];
 	bool iostat_enable;
 	unsigned long iostat_next_period;
 	unsigned int iostat_period_ms;
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index f8703038e1d8..ae265e3e9b2c 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -34,6 +34,7 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i;
 
 	if (!sbi->iostat_enable)
 		return 0;
@@ -76,6 +77,12 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 	IOSTAT_INFO_SHOW("fs node", FS_NODE_READ_IO);
 	IOSTAT_INFO_SHOW("fs meta", FS_META_READ_IO);
 
+	/* print read folio order stats */
+	seq_printf(seq, "%-23s", "fs read folio order:");
+	for (i = 0; i < NR_PAGE_ORDERS; i++)
+		seq_printf(seq, " %llu", sbi->iostat_read_folio_count[i]);
+	seq_putc(seq, '\n');
+
 	/* print other IOs */
 	seq_puts(seq, "[OTHER]\n");
 	IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
@@ -113,6 +120,7 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
 {
 	unsigned long long iostat_diff[NR_IO_TYPE];
+	unsigned long long read_folio_count_diff[NR_PAGE_ORDERS];
 	int i;
 	unsigned long flags;
 
@@ -133,9 +141,15 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
 				sbi->prev_iostat_bytes[i];
 		sbi->prev_iostat_bytes[i] = sbi->iostat_bytes[i];
 	}
+
+	for (i = 0; i < NR_PAGE_ORDERS; i++) {
+		read_folio_count_diff[i] = sbi->iostat_read_folio_count[i] -
+					sbi->prev_iostat_read_folio_count[i];
+		sbi->prev_iostat_read_folio_count[i] = sbi->iostat_read_folio_count[i];
+	}
 	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 
-	trace_f2fs_iostat(sbi, iostat_diff);
+	trace_f2fs_iostat(sbi, iostat_diff, read_folio_count_diff);
 
 	__record_iostat_latency(sbi);
 }
@@ -151,6 +165,10 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 		sbi->iostat_bytes[i] = 0;
 		sbi->prev_iostat_bytes[i] = 0;
 	}
+	for (i = 0; i < NR_PAGE_ORDERS; i++) {
+		sbi->iostat_read_folio_count[i] = 0;
+		sbi->prev_iostat_read_folio_count[i] = 0;
+	}
 	spin_unlock_irq(&sbi->iostat_lock);
 
 	spin_lock_irq(&sbi->iostat_lat_lock);
@@ -165,6 +183,24 @@ static inline void __f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	sbi->iostat_count[type]++;
 }
 
+void f2fs_update_read_folio_count(struct f2fs_sb_info *sbi, struct folio *folio)
+{
+	unsigned int order = folio_order(folio);
+	unsigned long flags;
+
+	if (!sbi->iostat_enable)
+		return;
+
+	if (order >= NR_PAGE_ORDERS)
+		order = NR_PAGE_ORDERS - 1;
+
+	spin_lock_irqsave(&sbi->iostat_lock, flags);
+	sbi->iostat_read_folio_count[order]++;
+	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
+
+	f2fs_record_iostat(sbi);
+}
+
 void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 			enum iostat_type type, unsigned long long io_bytes)
 {
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index eb99d05cf272..2025225b5bed 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -34,6 +34,8 @@ extern int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 extern void f2fs_reset_iostat(struct f2fs_sb_info *sbi);
 extern void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 			enum iostat_type type, unsigned long long io_bytes);
+extern void f2fs_update_read_folio_count(struct f2fs_sb_info *sbi,
+			struct folio *folio);
 
 struct bio_iostat_ctx {
 	struct f2fs_sb_info *sbi;
@@ -68,6 +70,8 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
+static inline void f2fs_update_read_folio_count(struct f2fs_sb_info *sbi,
+		struct folio *folio) {}
 static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx) {}
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9364e6775562..ff4a58c2cbbb 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2116,9 +2116,10 @@ DEFINE_EVENT(f2fs_zip_end, f2fs_decompress_pages_end,
 #ifdef CONFIG_F2FS_IOSTAT
 TRACE_EVENT(f2fs_iostat,
 
-	TP_PROTO(struct f2fs_sb_info *sbi, unsigned long long *iostat),
+	TP_PROTO(struct f2fs_sb_info *sbi, unsigned long long *iostat,
+			unsigned long long *read_folio_count),
 
-	TP_ARGS(sbi, iostat),
+	TP_ARGS(sbi, iostat, read_folio_count),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -2150,6 +2151,7 @@ TRACE_EVENT(f2fs_iostat,
 		__field(unsigned long long,	fs_mrio)
 		__field(unsigned long long,	fs_discard)
 		__field(unsigned long long,	fs_reset_zone)
+		__array(unsigned long long,	read_folio_count, 11)
 	),
 
 	TP_fast_assign(
@@ -2182,6 +2184,9 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->fs_mrio	= iostat[FS_META_READ_IO];
 		__entry->fs_discard	= iostat[FS_DISCARD_IO];
 		__entry->fs_reset_zone	= iostat[FS_ZONE_RESET_IO];
+		memset(__entry->read_folio_count, 0, sizeof(__entry->read_folio_count));
+		memcpy(__entry->read_folio_count, read_folio_count,
+				sizeof(unsigned long long) * min_t(int, NR_PAGE_ORDERS, 11));
 	),
 
 	TP_printk("dev = (%d,%d), "
@@ -2194,7 +2199,9 @@ TRACE_EVENT(f2fs_iostat,
 		"app [read=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
 		"compr(buffered=%llu, mapped=%llu)], "
 		"fs [data=%llu, (gc_data=%llu, cdata=%llu), "
-		"node=%llu, meta=%llu]",
+		"node=%llu, meta=%llu], "
+		"read_folio_count [0=%llu, 1=%llu, 2=%llu, 3=%llu, 4=%llu, "
+		"5=%llu, 6=%llu, 7=%llu, 8=%llu, 9=%llu, 10=%llu]",
 		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
 		__entry->app_bio, __entry->app_mio, __entry->app_bcdio,
 		__entry->app_mcdio, __entry->fs_dio, __entry->fs_cdio,
@@ -2205,7 +2212,13 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->app_rio, __entry->app_drio, __entry->app_brio,
 		__entry->app_mrio, __entry->app_bcrio, __entry->app_mcrio,
 		__entry->fs_drio, __entry->fs_gdrio,
-		__entry->fs_cdrio, __entry->fs_nrio, __entry->fs_mrio)
+		__entry->fs_cdrio, __entry->fs_nrio, __entry->fs_mrio,
+		__entry->read_folio_count[0], __entry->read_folio_count[1],
+		__entry->read_folio_count[2], __entry->read_folio_count[3],
+		__entry->read_folio_count[4], __entry->read_folio_count[5],
+		__entry->read_folio_count[6], __entry->read_folio_count[7],
+		__entry->read_folio_count[8], __entry->read_folio_count[9],
+		__entry->read_folio_count[10])
 );
 
 #ifndef __F2FS_IOSTAT_LATENCY_TYPE
-- 
2.54.0.rc1.513.gad8abe7a5a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
