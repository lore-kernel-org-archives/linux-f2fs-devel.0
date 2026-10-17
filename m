Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09046CCF2C1
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Oct 2026 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JItT8MbslQcmhsWInhzwX1QZpXsxs4qLBUzbiDg58ug=; b=ciWc6dbDLUHY8SWI7tSaE/iawG
	l6f0ZTSpJZIZs0mj9bnI2IUU5MRkdbn5/mM7etmbpH/0IHIdYF+ucW6zbZPRhq8hIgUXmpZCdJ9Ag
	IGneAK/l1TUTKJZwEsPNcOM80crkOrKmNseSJawCMETKrZl11w3hEHY2gXn+aaRHEzm0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHtmS-0000Xp-Vh;
	Sat, 17 Oct 2026 02:04:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xHtmS-0000Xi-Hl
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 02:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RKiZoTfO9HDHKNcvEigrJ8aHqQJWoppKggx0SJQ8qTQ=; b=ct0wzt2wc1uz8b/98LrUYs5a6h
 DxAszljI3sq11f5ngmEAG/22eFAe+WLvrXwY0ZGDceu25xLGdJiF8H240US3tKFLOG4Vt7HilvLqw
 A+2cXkppuMxMyKC6g+/bwFMEwB3wpDNM3JriJzDcEWRkLOu1EIJOMlrM+NFdpamP9RME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RKiZoTfO9HDHKNcvEigrJ8aHqQJWoppKggx0SJQ8qTQ=; b=R8mX77l/205/w0mgTMhbzNtK/a
 KWcoRs50K2RksDzNSxLDSvy5mAC7L5vs3COGzNzv7ivEjQmp/gRworvlV3JxIWeOkoioxBGMOtK1m
 qWpWLorkeRxeWHlxmg/2q6HaL14bz8vaB1bezlaByDC8hhrb7CcoVir0CabUdUmvsuQU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHtmR-0005fh-Ps for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 02:04:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 259D76022E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 02:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060A61F000C7;
 Sat, 17 Oct 2026 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792202649;
 bh=RKiZoTfO9HDHKNcvEigrJ8aHqQJWoppKggx0SJQ8qTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=llPq5MxbzaRmJckoK+czolYJGVZzmXYG7pStgFHS3fj23F9eUCeDYyqA/PjAn1Lkv
 9B7vYmtHGpFS/wR5J1mxpUuuvLaFJX+norVnNhRkAvnyccVxasop5DjJ/sSkrtGsgl
 Mid7sj+FvfYXsjxGMRNNWe8TyrJQynKZfC5iQ/8S7wuSMPtFdBlWp0igGmpURkzsvn
 UTrI0H3uA57wOyuUoqj+jaZ2wnC9kgZGxLdg/6oS2M7QFUywmUtPoz9iFYf+SzQN3c
 jJXr8PwmSLIJEMrgVt9OdEqxFWr6PP2VgsFoHfej1WA0lsz6J+5zufdL8/Qi1Ho+/R
 e2IGP/iL9uFZQ==
To: jaegeuk@kernel.org
Date: Sat, 17 Oct 2026 02:03:58 +0000
Message-ID: <20261017020358.305503-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261017020358.305503-1-chao@kernel.org>
References: <20261017020358.305503-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xHtmR-0005fh-Ps
Subject: [f2fs-dev] [PATCH 2/2] f2fs: remove max_atc_write_bio_size
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

Commit 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
introduced max_atc_write_bio_size to offload the completion of large
write bios to sbi->wq when f2fs_write_end_io() is called in atomic
context.

However, relying on bio->bi_iter.bi_size has two issues:
1. bi_size is not reliable at completion time: on a direct blk-mq path
   (e.g. SCSI or UFS), blk_update_request() consumes the bio iterator
   via bio_advance() before calling bio_endio(), so bi_size is already 0
   in f2fs_write_end_io(), whereas on a DM / zoned path (e.g. dm-linear)
   only the clone bio is advanced and orig_bio->bi_iter.bi_size stays
   intact.
2. With large folios enabled, folio size may be larger than 4KB, so
   bi_size cannot indicate how many folios are in a bio.

Since max_write_bio_{folio,entry}_cnt module parameters have been
introduced to limit the number of folios or cached blocks completed in
atomic context without depending on the bio iterator, let's remove
max_atc_write_bio_size logic and its sysfs entry.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 10 ----------
 fs/f2fs/data.c                          |  4 ++--
 fs/f2fs/f2fs.h                          |  2 --
 fs/f2fs/super.c                         |  1 -
 fs/f2fs/sysfs.c                         |  2 --
 5 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3d2e78a8bb7d..3520c29f3b9c 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1004,16 +1004,6 @@ Description:	It can be used to tune priority of f2fs critical task, e.g. f2fs_ck
 		- it requires user has CAP_SYS_NICE capability.
 		- the range is [100, 139], by default the value is 120.
 
-What:		/sys/fs/f2fs/<disk>/max_atc_write_bio_size
-Date:		June 2026
-Contact:	Bart Van Assche <bvanassche@acm.org>
-Description:	Every time a write operation completes f2fs_write_end_io() is
-		called. This function may be called from an atomic context,
-		e.g. from inside an interrupt handler. This attribute controls
-		the maximum size of a write bio that is completed in atomic
-		(atc) context. The default value for this attribute is UINT_MAX
-		which means that this functionality is disabled by default.
-
 What:		/sys/fs/f2fs/<disk>/pinned_area_max_secno
 Date:		August 2026
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3caadb30496a..867024c4c72d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -414,8 +414,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
-		F2FS_BIO(bio)->entry_cnt > f2fs_max_write_bio_cnt(bio))) {
+	if (in_atomic() &&
+		F2FS_BIO(bio)->entry_cnt > f2fs_max_write_bio_cnt(bio)) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4333d88cf076..e3ee28f0201f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1806,8 +1806,6 @@ struct f2fs_sb_info {
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 
 	/* for bio operations */
-	/* Largest write bio size completed in atomic context (atc). */
-	u32 max_atc_write_bio_size;
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1664928fedca..10be5888273c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5183,7 +5183,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = -EINVAL;
 		goto free_sb_buf;
 	}
-	sbi->max_atc_write_bio_size = UINT_MAX;
 
 	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
 	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 95f8dc0c4218..67202b7f8293 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1284,7 +1284,6 @@ F2FS_SBI_RW_ATTR(gc_idle_interval, interval_time[GC_TIME]);
 F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
 F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
-F2FS_SBI_RW_ATTR(max_atc_write_bio_size, max_atc_write_bio_size);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
@@ -1535,7 +1534,6 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
-	ATTR_LIST(max_atc_write_bio_size),
 	ATTR_LIST(max_fragment_chunk),
 	ATTR_LIST(max_fragment_hole),
 	ATTR_LIST(current_atomic_write),
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
