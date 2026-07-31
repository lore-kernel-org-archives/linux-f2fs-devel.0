Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6466C54F54
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aWbz266yo7YlXtpRpvW8Tf1sDspck7mEqTg1JpcSCrI=; b=XQFIQXs1Y/+4/4FjxGFPLJfAOF
	vZCHjG7sFYqwxXC1ynrPjYSIRfMXDLuHd+3FhIpGFtZACmiZjRIgC778sZlBT2XU9jzDMruNN/b1e
	Y5B51OwJr6RxVfWBLWRQ0KKbUKHTVoRYnfXgJ64wRGXlaPZ5CtVorN294o2svmWZtWuw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wplRS-0001Tb-EO;
	Fri, 31 Jul 2026 11:30:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1wplRQ-0001TL-Jw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 11:30:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bTKs8NCOgAKYfr6+60kQKyPlox9dFpdx3YCCQ8QMQ7I=; b=g2bSlXWpBPvjzhH22RWA9cxRym
 N1ai/+KRsaZQc3KMbXmhwz4Ur4lP3FKyIRisLpiF9F9syIqXNd3WrGKNAbSSm6FiPN1vJyNZRM8hg
 1Vl5PPZRonaTGhg8d7dMzRjyK4YyiIzKNt9SOhjNUdjHxc5T13S5hjSTmZtEXO5pZxbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bTKs8NCOgAKYfr6+60kQKyPlox9dFpdx3YCCQ8QMQ7I=; b=a
 Cda4n1kiryK+7KuovinNOu9ZJbTdQ51L+h/QZ8S8z8S68PaKnjcf0sCeA1yjmix11qeA3ez2zo8MQ
 hjDLTkRRVU7xh0L0SprKnDAvOqIuk8Wq/WmZSvZD+7NpOy09EZmaTJ2/nRI+mDk+KU72sPeknwPar
 SRW6GftnnI6x6NdA=;
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wplRQ-0006dS-U8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 11:30:17 +0000
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so656073a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 31 Jul 2026 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497411; x=1786102211; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bTKs8NCOgAKYfr6+60kQKyPlox9dFpdx3YCCQ8QMQ7I=;
 b=H+TNX/hPOgS95PfMpdpwSXZsRn2OBVZA+wkGbHE/6yFQigCCrrOzGY4kHUoCxWVRem
 zRAqUgCIIBN4xRg5OPyE/VSm8cZqro/yy8AuMGHMPtG2U1a/4ybBsCw7EWnT6D2UJ9Eb
 U4aCgSW8csEJiqM/DloJQa+0Vr8quVhuth0Wax6xh2SY60UyQUMgTZ+mwTuKATmOBS8o
 qzXVA0mWRqy/G7y9yTZ/5iOU3Ez3N8CccfdmAp2TDfWsatTUsy6htu+5yfzlze8KLeGs
 ZTU4kwMN3lBw0ncFKGq608IQhaH5FplNnM8r+QCpb3tKNmb0TVXe70Ep3OFZHYuuwkW/
 xhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497411; x=1786102211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bTKs8NCOgAKYfr6+60kQKyPlox9dFpdx3YCCQ8QMQ7I=;
 b=kI6cRKfVuu2Q45SUEgcGqy6Sbfn+EJ1cRgDWTcUr58tMx5u8P2fwt9Yku/1VuzL53c
 SMEEjeovgvavOpTpbeH6HFq21EmQHBij003h994ldCHiCdDsWMQCQTSsngQ125f3y5+5
 F/8Y75KQ36PP9ExLWW0wX8bPj64WD7Jy7rPQlZsLJyMZyuZcZPiIMZyB0gnTZSw1zpWX
 nxpnfot8J2U/bfyYaWs11DupbTyYiCO9dDan+ccYvKDfO2W/R1vjtx9aV/LIuBlY670Y
 aPkKsj9HgNHqhBBIhjVusWA8maibRaX0MpjfKGED+OimisfQ2BBccVM2CQRUZclMrxUY
 rM1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGdMTSh9MBJMatoaC3sL0wvMlxrkkO5WeTHmfshSCSnDJaRjewPpODTY6xCOrvbuiV26qL87HeTfIWfDYXgxki@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzPbsr3JGFJYLNy1eQLXc7WKDsMygzi5ALziVQj+WS6qgq43FvV
 L+9gZ4JITAMgpShJYMa71uoRa+JErxwV5zK78NyyUjT+AeGk5NgA09B4
X-Gm-Gg: AR+sD13KDDkTR3CdqP+S7KbHZmetTew39Cf19R4wqk2ecP6OzWDN8cQ1pQq4q68TFXP
 V50SkJI1fIR1QaREwmln+iUzXrZGaVgGUfkZOnaC87Mhr+bGVrGYDSXZNKbfTlsfCi3yQeQIaQY
 9x0+ghT5FUKOsJXnOEkxW+dZjqv0IM88kPhAuMCksEk7r8HUWTgdcSP9/Q9o+ArQsl83UNFbzeN
 HJJ24JSr5hgCa9NHcL2qdb0hEhuqHaP6Mn4QwrCfCaWx+ykCtz9Ik/W5c+3HRHy9KgB8LSgyXQ8
 jUW2uZrrahD5+uhH8gZPSdksjAav28fjfHtK3efoVCBmya/7Ji0BGIeJCaiwRLur+vllsEF+yZP
 0VgqNfwjSH3rnSnThb8vURmA/xI/62U/Mf/YRyoDGyr+eeSx2DPdV9U46WdaRTlyw5Ira+t26ex
 rsq1s1j01tBz79vzpxduPerDhZgG/UwcXtBe+oz22K37e8d/PVrN+lfs/b2w/HNLjkcog=
X-Received: by 2002:a05:6a21:e081:b0:3c3:9835:e75e with SMTP id
 adf61e73a8af0-3c91b4e87admr1571486637.70.1785497410965; 
 Fri, 31 Jul 2026 04:30:10 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:d147:9c7c:d120:bcea])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe396ea5casm472093a12.15.2026.07.31.04.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:30:10 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Fri, 31 Jul 2026 19:29:54 +0800
Message-ID: <20260731112954.1023817-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wplRQ-0006dS-U8
Subject: [f2fs-dev] [PATCH] f2fs: adjust iostat tracepoints
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
Cc: jinbaoliu365@gmail.com, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

Move trace_f2fs_submit_read_bio() and trace_f2fs_submit_write_bio()
after iostat context initialization, and add trace_f2fs_iostat_update()
so f2fs iostat can be adjusted through tracepoints.

Use ktime_get_ns() for more accurate iostat accounting.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/data.c              |  4 ++--
 fs/f2fs/iostat.c            |  5 ++++-
 fs/f2fs/iostat.h            |  2 +-
 include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..0b6aab302f02 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -568,9 +568,9 @@ void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 		return;
 
 	WARN_ON_ONCE(!is_read_io(bio_op(bio)));
-	trace_f2fs_submit_read_bio(sbi->sb, type, bio);
 
 	iostat_update_submit_ctx(bio, type);
+	trace_f2fs_submit_read_bio(sbi->sb, type, bio);
 	blk_crypto_submit_bio(bio);
 }
 
@@ -578,8 +578,8 @@ static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 				  enum page_type type)
 {
 	WARN_ON_ONCE(is_read_io(bio_op(bio)));
-	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
 	iostat_update_submit_ctx(bio, type);
+	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
 	blk_crypto_submit_bio(bio);
 }
 
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index ae265e3e9b2c..73d810b3b7ff 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -257,7 +257,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	if (!sbi->iostat_enable)
 		return;
 
-	ts_diff = jiffies - iostat_ctx->submit_ts;
+	ts_diff = ktime_get_ns() - iostat_ctx->submit_ts;
 	if (page_type == META_FLUSH) {
 		page_type = META;
 	} else if (page_type >= NR_PAGE_TYPE) {
@@ -278,6 +278,9 @@ void iostat_update_and_unbind_ctx(struct bio *bio)
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
 	enum iostat_lat_type lat_type;
 
+	trace_f2fs_iostat_update(iostat_ctx->sbi->sb, bio,
+				 iostat_ctx->submit_ts);
+
 	if (op_is_write(bio_op(bio))) {
 		lat_type = bio->bi_opf & REQ_SYNC ?
 				WRITE_SYNC_IO : WRITE_ASYNC_IO;
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 2025225b5bed..2e3e1e4ce8b3 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -49,7 +49,7 @@ static inline void iostat_update_submit_ctx(struct bio *bio,
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
 
-	iostat_ctx->submit_ts = jiffies;
+	iostat_ctx->submit_ts = ktime_get_ns();
 	iostat_ctx->type = type;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 270c1a2c24c4..b97e0740d7ed 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2315,6 +2315,38 @@ TRACE_EVENT(f2fs_iostat_latency,
 		__entry->n_wr_as_peak, __entry->n_wr_as_avg, __entry->n_wr_as_cnt,
 		__entry->m_wr_as_peak, __entry->m_wr_as_avg, __entry->m_wr_as_cnt)
 );
+
+TRACE_EVENT(f2fs_iostat_update,
+
+	TP_PROTO(struct super_block *sb, struct bio *bio,
+		unsigned long submit_ts),
+
+	TP_ARGS(sb, bio, submit_ts),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(enum req_op, op)
+		__field(blk_opf_t, op_flags)
+		__field(sector_t, sector)
+		__field(unsigned int, size)
+		__field(unsigned long, submit_ts)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->op = bio_op(bio);
+		__entry->op_flags = bio->bi_opf;
+		__entry->sector = bio->bi_iter.bi_sector;
+		__entry->size = bio->bi_iter.bi_size;
+		__entry->submit_ts = submit_ts;
+	),
+
+	TP_printk("dev=(%d,%d), rw = %s(%s), sector = %llu, size = %u",
+		show_dev(__entry->dev),
+		show_bio_type(__entry->op, __entry->op_flags),
+		(unsigned long long)__entry->sector,
+		__entry->size)
+);
 #endif
 
 TRACE_EVENT(f2fs_bmap,
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
