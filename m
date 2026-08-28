Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC59C61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bu3Eo+be1GtzQTGnU+2+e2pAuOM5zKizFDdgoMX4/Sk=; b=RPL+8uwdg4k/jr6TZYPUA/Rxv/
	i0tGfXQyxUUudLclmMu985VEkG72heTJ0CPJ82wgKqyJ4YxsRkKyQXLS1zQdwgwhYRzdXyqimfnMV
	iUwS0CvBzCEEDnP6BAFJoKlEGI7B+cawTxvA+wzq7p/x6v4S0WM/QpgvE/CZw1dghWS0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzxKF-00065L-1m;
	Fri, 28 Aug 2026 14:12:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzxKE-00065B-Ba
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:12:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jwGAw/3u92Bautox8ZBye7j/eciIao9tSSPeFwdR8xA=; b=O3Uw7HMaVsuMlMQ6Bw4AE6YzC7
 fNb2rUCwroVByk0sYUuzlWJLWT2SCpWXzGLXFTm3EjII7PA2d2+O1hVps2dDwVBxIuBoKoEizf94i
 2xmtfFlQhXGeRqU+hXv9n3WXxACZq/s+fNnfVKJveN50EQOuCxZFfbIbnRLwsM4jSj64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jwGAw/3u92Bautox8ZBye7j/eciIao9tSSPeFwdR8xA=; b=kVRhZU4NX8kCz565zdWEyMi5yo
 llRMT/3UwWLZgELNfp2ot/CoEhoM8QvvWMx5p3g1H/jB6qwzyKgo6IrOtEMrD0yUWDru2/uX3MFsE
 e6/jifoBrfUOjh6Ex5hI1ImiOkX9aG6g6WI+Q5DDDdQWMRYMuDGYGVrkQ5M5MAs2tMWY=;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzxKD-0005B7-Iy for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:12:59 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so975751a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787926372; x=1788531172; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jwGAw/3u92Bautox8ZBye7j/eciIao9tSSPeFwdR8xA=;
 b=HmN1YsjuBQtW9JblkPWkSYFnmO5BNNqmbSUxdU5hoR+g3dOgn0yWW9953KHgbCLBgs
 ss/C68+KIm/J5RzjvSgoAleIYYXfcWqjW0xGVIRO/njoyU+sc98vcPpWQbYG1R3tTIgM
 qsloCRptKKvk+N65zyKzg2YK6zcH9HXDtx1WQTuMeqK6CcKsKwyHuNyJg2HB5D/XklCO
 83ZStkfIAT/OsncpLA+45/cVJOmpYHEjegvtWBuNEFi+pRtjMH3/187n3tYkI2JeF8BP
 RM9H7WGIiqq/hvMPnW4VpQKSttO4doz2LeogihX8sU11MYI56SwTxaM14dOjGzMLaIsM
 jecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787926372; x=1788531172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jwGAw/3u92Bautox8ZBye7j/eciIao9tSSPeFwdR8xA=;
 b=TOFyDjWt43RC749tPN3GU5nMNARTKQ6P1QZR2yjAZAxNaq2DD7R6MDtEMxBs28cdMN
 kyTjogFCqPauxlI9ENnl47/y0+q7EtyyXqiC5lYS53IZ27WZyZpGGm7YYCoJSgDRnBDs
 voGDQ5hpQgHdyhwPvyFvrVouNaAcYtEbFwRu3mjQ8WCje3G1ZhpztBWtVzq0shk7nz+q
 jOn/Tqx1zF9YOvg2sayYYTZU6K7GJkYOkk3hNnRGL7E6pB82Av41iPeYpyhXsji6IwVN
 7MeqYJ5yN3L6orNbTj1ZFURD0pSAqSYC/fwzbaUIydPyiECeftSBSvNbOQV6UdJAPDpZ
 R2OA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9H4nKMU9Zt2D19DXR0kuHiNdQOR6LcwBrCjW3igVTX0wiYAjlBkRDl/UjLXyQRVNBVxtnteCkyKxTtktjfmY2@lists.sourceforge.net
X-Gm-Message-State: AFuF++lLX19lFF6vgELwKn0h7/E01A3Zh0tdZ3deow6A3h0812PwXz58
 XZYUPOihQf73aKWf9qAX2M38mzBSqf6dq8mfKshfTRAzYdbfbYHNWpYT
X-Gm-Gg: AR+sD11KqaOOXv0e5dybfqj8GHPAfD0aNr56hH4PHvqOE0f6QhpjwsIJs714PIgHI+V
 eQIo3DXxXGhIKGOHK0/AuaP9lhjPC4bdsV9sRcZZav7kXZIDhZ9y0x9nSaLw0dTmOzIhNQxzRos
 5uKQ/EpaSRuNjFYrLQ1hlOBK/SZL8oCctwW+TkQ+uVJ1Q6U6LVOJoTS11xCYOJKODnBDd2bjQPb
 JQuCGKZEMBabPLJPXwtRVtkBKJe9xFGwLtrjaXek8g87OkOOJTFkpIChYP0PX1TSvvQcJyCFNLA
 18XoQP33HSP9TvW0xzRiJaVOezAZ/hbRBPhIr3sN0YYhbId184t9iyHsfFLvnbEobEO5bmnbOa8
 4PV19oZpOZJCNqPPSVjJiRczvdoitE+jzuhr2m1F3ip8IXoSxqTNXQagPaSZ65zaCDQZKCMEsMn
 TOR9GVqlp1Z6MkWjCpFGDKEoV2IAuRr3zksA+8wn+ZnZ+w6aVzTankBl7QfC0LiGU9vdeHSx4Fj
 ViYE9vlcooehpW2EKmegAGOLT2w9netn3FO
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-396d0f1a83fmr15048057a91.13.1787926371638; 
 Fri, 28 Aug 2026 07:12:51 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396ddc0c703sm2737951a91.9.2026.08.28.07.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:12:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 28 Aug 2026 22:12:40 +0800
Message-ID: <20260828141240.2391915-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
References: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wzxKD-0005B7-Iy
Subject: [f2fs-dev] [PATCH 2/2] f2fs: refresh pinned allocation boundary
 after resize
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

pinned_area_max_secno is derived from MAIN_SECS(), the zoned device
boundary, and resizable_tail_secno. It is currently recalculated only
at mount and remount, so online resize leaves the pre-resize value
active after MAIN_SECS() changes.

A stale value can allow pinned allocations in sections outside the
new main-area boundary.

Move the calculation to segment.h and call it whenever
update_fs_metadata() changes MAIN_SECS(). This also restores the
previous boundary when a final checkpoint error rolls the resize
metadata back.

Mount option validation compares the tail count with the pre-resize
section count. Recalculating after a shrink below that tail would make
the unsigned subtraction wrap. Reject such a shrink with -EINVAL
before taking resize locks or changing filesystem geometry.

Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/gc.c      |  7 +++++++
 fs/f2fs/segment.h | 16 ++++++++++++++++
 fs/f2fs/super.c   | 15 ++-------------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a00180c21dc..978e85578c79 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2326,6 +2326,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
 	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
 	MAIN_SECS(sbi) += secs;
+	f2fs_adjust_pinned_area_boundary(sbi);
 	if (sbi->allocate_section_hint > MAIN_SECS(sbi))
 		sbi->allocate_section_hint = MAIN_SECS(sbi);
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
@@ -2398,6 +2399,12 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
+	if (secs >= MAIN_SECS(sbi) ||
+	    F2FS_OPTION(sbi).resizable_tail_secno >=
+	    MAIN_SECS(sbi) - secs) {
+		err = -EINVAL;
+		goto out_drop_write;
+	}
 
 	/* stop other GC */
 	if (!f2fs_down_write_trylock_trace(&sbi->gc_lock, &glc)) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5949aa5200ac..7c7ca0730d77 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -91,6 +91,22 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define GET_ZONE_FROM_SEG(sbi, segno)				\
 	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
+static inline void f2fs_adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
+{
+	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
+	if (f2fs_sb_has_blkzoned(sbi) &&
+	    sbi->first_seq_zone_segno != NULL_SEGNO)
+		sbi->pinned_area_max_secno =
+			min(sbi->pinned_area_max_secno,
+			    GET_SEC_FROM_SEG(sbi,
+					     sbi->first_seq_zone_segno));
+	if (F2FS_OPTION(sbi).resizable_tail_secno)
+		sbi->pinned_area_max_secno =
+			min(sbi->pinned_area_max_secno,
+			    MAIN_SECS(sbi) -
+			    F2FS_OPTION(sbi).resizable_tail_secno);
+}
+
 #define GET_SUM_BLOCK(sbi, segno)	\
 	(SM_I(sbi)->ssa_blkaddr + (segno / (sbi)->sums_per_block))
 #define GET_SUM_BLKOFF(sbi, segno) (segno % (sbi)->sums_per_block)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 253a579e9d5b..c8f8ecf49635 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -554,17 +554,6 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 			F2FS_OPTION(sbi).unusable_cap_perc);
 }
 
-static inline void adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
-{
-	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
-	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
-		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
-				GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
-	if (F2FS_OPTION(sbi).resizable_tail_secno)
-		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
-				MAIN_SECS(sbi) - F2FS_OPTION(sbi).resizable_tail_secno);
-}
-
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -3078,7 +3067,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
@@ -5321,7 +5310,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* get segno of first zoned block device */
 	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 
 	sbi->reserved_pin_section = f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
