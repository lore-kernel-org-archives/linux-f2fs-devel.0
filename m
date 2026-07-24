Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633ACC531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOUlU7bo/pnJMECLIqDoAWZs/SgQzjxZXxLjWMFZoL8=; b=Lby0/UlzIn8idDSqv77O8t6bom
	EqbmgmCg0IQqneI/OVh4iAAQn43Pi5P02saTWHV6P/tTxKxPZwptHzrClgssMrbCDQ+YTivEoarWe
	WCB9PrkC5KifNuiXzzHgc294QMppqYbsRTmC2HghItUEfZnHyELfmOu7+fd7qSKKIlVg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIAK-0006z7-Do;
	Fri, 24 Jul 2026 15:50:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wnIAJ-0006yz-9h
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glOWsmtsYU5zyv+/g+AgggDt8s7Rj1H5/Lf/7X9utA0=; b=KSqlErm30kPD7COlDITxGYCV4u
 z9WCKCFZ0ilvHqIV0Cd0SlwRZuDo2ZO0zSCUdS0jcRXRU5HHRES0MJb6pNYfnYLWgnqJuCZ1lc5LI
 O7N7M2rSndTwzTO5DR82emQAe5OqFbz3HN6CDBGjdlH5LRA9nnNubvyVa50JK+HXtlNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=glOWsmtsYU5zyv+/g+AgggDt8s7Rj1H5/Lf/7X9utA0=; b=ZbWgLiRltGktTGa+aATuI5RX11
 MZFqYrkmXBRu4JVaCAhXyU+zb1vYWzCXHPEZ/MpqYUI6cuzySKY2h2HN7IU0e0bTDrAzOhsKljauu
 x99qOjhpDErYW+NLiDP63BKJe1W+S+3fMjeZYpVuYAZhKyvSNiJibLyVlmjZLbU/k5xE=;
Received: from mail-qv1-f43.google.com ([209.85.219.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIAM-00059K-5o for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:50:23 +0000
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8ef7b7651ecso23351906d6.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784908217; x=1785513017; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=glOWsmtsYU5zyv+/g+AgggDt8s7Rj1H5/Lf/7X9utA0=;
 b=Ao4nIaVpSJWx/mDcdJkhYRz/ITglo/wPDbcfX6KYiVepmEHkbS2HocT5LFc2A7DwKN
 ZpxJmg9FAjbRVjKOS3USe/iilNCMBJY+/k/xuj3q8d7sgvjuTuXoxYSm5FsN1Q68+FYX
 Ubmsga3/b6jBSxSGxez2PmVAraZ92ife0Q8YWvGm6WHuv7vfrtz717fEaI1MLW88RD0b
 2jSoE+fbHlmQYvawSswtsgMnWz+2VmCf8iIkLfHWXstOwiISwvrC75X88m1ZcJKHF3OE
 1PqzvOGiPSZ1w4dyjLxqNd/CVnPYcj9Y9Qx8Y4bIkTbp/qIYIeZyNXj8IPBnDs535LwV
 3I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908217; x=1785513017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=glOWsmtsYU5zyv+/g+AgggDt8s7Rj1H5/Lf/7X9utA0=;
 b=bF5k9dUIaVjZU6KhGHxwLe6L9/ooZwJmZGkhEFvIChfzeLHD5jc8QOI2O8tm8nYYt2
 +EoGUoSPdXvpFOdiOc7+havaPKvMbSTEqDsm+90/S+Sxy4s3inmgO64gfm6Y9ETtLlAg
 5JCwfdAMFZQKFxET4iPiOLrhHSMTk2/JP6E7M3JTZJObqzx8bWqN3pwpxz8sZH3oyhVq
 jgYnYZYzXPOaM5f55IX9tswRTp1oh8sR7Ziu9NFy72c5HEUZ4d1YVBgiJbuW+kJIZW/I
 f2HALwnroLt12cV9ND9LI483FIsVMynJ1zh2Ola0jCOjwBUdayOcYpS1Q0QoZIw6lyVz
 5VXA==
X-Gm-Message-State: AOJu0YxKuX7b7Z+igdaVudykjKZRMO5pAHA67saOHRpz2dDCioylxuW4
 wFWALK87AJPNQ8/EfnWFUspkTbsxqhQPulqzbNwSGmDaiMkKZq3QIwnNcPnH8g==
X-Gm-Gg: AR+sD10OCLDy62e9lGZRu3GXC0pr1ZW0HsnNwgfrpWp9t6HReNCBcozmysR8ETJBzOC
 s74KsPDZDf8JRLSx5ZiLEQs+DWSuVK19HVj4cw/+V6jhLVV1rkgjt36bpFfZAP+OzskC3O0Pamt
 Vsem9ZiMPsIiQ8Hduyi5/giKybkcWZicdNmXPLr5uemHqrteR4zycLogvoZzjQc6yfyJdnnmCSk
 ymyuFRjDxaIwMGs12jbgUDFcAolTKXZXoW5npGwq0HW3/WBzBNIhg0poD+OwQFNmmg+mxFHW/fg
 nyadNPFUqE/0LNUEOgmi4F/RQx8ULr+fJwm461k1scoa2RaIDPzT7ojvuRl4pJsnRuJmxzy9Hn5
 7+JjoqrHMTCgffgI2sHfTIc7V/0mV/PgHoUxPG5CmrIGSDaJ0w26WNMbOCO2g1qbgLWhN2LYDST
 hiMs2lKXEQzanbFfGwu5p23Pn7eVD7nnF+KfIlUlTR2Aqccijj4vw1yx83Ka4=
X-Received: by 2002:a4a:e907:0:b0:6aa:edca:e139 with SMTP id
 006d021491bc7-6aaf45fb29bmr328541eaf.31.1784897964463; 
 Fri, 24 Jul 2026 05:59:24 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45767486cf6sm7359957fac.15.2026.07.24.05.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:59:24 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 24 Jul 2026 20:58:23 +0800
Message-ID: <20260724125847.3928772-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
References: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wnIAM-00059K-5o
Subject: [f2fs-dev] [RFC PATCH v3 3/3] f2fs: introduce tracepoints for
 inline extent lookup and update
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Add tracepoints to aid performance analysis and debugging of the
inline extent mechanism:

- trace_f2fs_iext_lookup_blkaddr_start: fired at the beginning of an
  inline extent lookup, recording the inode and logical block offset.

- trace_f2fs_iext_lookup_blkaddr_end: fired on successful lookup,
  recording the inode, logical offset, resolved physical block address,
  and extent length.

- trace_f2fs_iext_update_data_blkaddr: fired when updating a block
  mapping in the inline extent area, recording the inode, logical
  offset, and new physical block address.

These tracepoints can be used with ftrace/perf to measure inline
extent cache hit rates and identify hot files benefiting from the
feature.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/iextent.c           | 11 +++++-
 include/trace/events/f2fs.h | 79 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/iextent.c b/fs/f2fs/iextent.c
index dd1d1782598f..35eb3be54963 100644
--- a/fs/f2fs/iextent.c
+++ b/fs/f2fs/iextent.c
@@ -10,6 +10,7 @@
 
 #include "f2fs.h"
 #include "iextent.h"
+#include <trace/events/f2fs.h>
 
 /*
  * ASSERT - debug assertion for inline extent code.
@@ -482,12 +483,18 @@ int f2fs_iext_lookup_blkaddr(struct inode *inode, struct folio *ifolio,
 	struct f2fs_iext_header *eh = iext_get_header(ifolio);
 	struct f2fs_extent *last_ext = EXT_LAST_INDEX(eh);
 
+	trace_f2fs_iext_lookup_blkaddr_start(inode, fofs);
+
 	if (EXT_ENTRY_COUNT(eh) == 0 || F2FS_EXT_LOGICAL_END(last_ext) < fofs)
 		error = -ENOENT;
 	else
 		error = __iext_lookup_data_blkaddr(inode, ifolio, fofs,
 						blkaddr, len);
 
+	if (!error)
+		trace_f2fs_iext_lookup_blkaddr_end(inode, fofs,
+						*blkaddr, len ? *len : 1);
+
 	return error;
 }
 
@@ -522,6 +529,8 @@ int f2fs_iext_update_data_blkaddr(struct inode *inode, struct folio *ifolio,
 	struct f2fs_iext_info *iext_info = sbi->iext_info;
 #endif
 
+	trace_f2fs_iext_update_data_blkaddr(inode, fofs, blkaddr);
+
 retry:
 	ASSERT(sbi, retry_cnt >= 0);
 	ASSERT(sbi, EXT_ENTRY_COUNT(eh) <= max_inline_extents);
@@ -747,4 +756,4 @@ void f2fs_iext_show_stat(struct f2fs_sb_info *sbi, struct seq_file *s)
 		atomic64_read(&iext_info->truncate_last_ext_cnt),
 		atomic64_read(&iext_info->drop_insert_new_ext_cnt));
 }
-#endif
\ No newline at end of file
+#endif
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 270c1a2c24c4..dc468a0c2980 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2623,6 +2623,85 @@ TRACE_EVENT(f2fs_fault_report,
 		__entry->data)
 );
 
+TRACE_EVENT(f2fs_iext_lookup_blkaddr_start,
+
+	TP_PROTO(struct inode *inode, unsigned int pgofs),
+
+	TP_ARGS(inode, pgofs),
+
+	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(dev_t,	dev)
+		__field(unsigned int, pgofs)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgofs = pgofs;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u",
+		show_dev_ino(__entry),
+		__entry->pgofs)
+);
+
+TRACE_EVENT(f2fs_iext_lookup_blkaddr_end,
+
+	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr,
+						unsigned int len),
+
+	TP_ARGS(inode, pgofs, blkaddr, len),
+
+	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(dev_t,	dev)
+		__field(unsigned int, pgofs)
+		__field(u32, blk)
+		__field(unsigned int, len)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgofs = pgofs;
+		__entry->blk = blkaddr;
+		__entry->len = len;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, blkaddr = %u, len = %u",
+		show_dev_ino(__entry),
+		__entry->pgofs,
+		__entry->blk,
+		__entry->len)
+);
+
+TRACE_EVENT(f2fs_iext_update_data_blkaddr,
+
+	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr),
+
+	TP_ARGS(inode, pgofs, blkaddr),
+
+	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(dev_t,	dev)
+		__field(unsigned int, pgofs)
+		__field(u32, blk)
+	),
+
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pgofs = pgofs;
+		__entry->blk = blkaddr;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, blkaddr = %u",
+		show_dev_ino(__entry),
+		__entry->pgofs,
+		__entry->blk)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
