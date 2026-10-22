Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F23606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AF2Omyea;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jN+DwE/9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Dy/+4r4W;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1shWm6V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oCFZ9nU5088HX7Ar6j1xoQTzvc29juIP/BbFFtGXE0c=; b=AF2Omyeax1ADz0NWtDSJKqacWC
	pPXmzyxX3oZWl1M+u0Rxz47H6vr+mf4EHcNOxFeHP4QD7TbcKyUjRS8Hn8GIHcOXfadmCIZvz+81q
	aUBGtgkLXtxsqKqOaKr87dviBjZ/h1CAZ1NtqUZknkFuw5adaQhOBkiQAYKj2b5lvvho=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsNz-000000005vh-2KI3;
	Thu, 22 Oct 2026 12:59:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsNQ-000000005uu-40M5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pWzqtLm0ZZ5WjhUPz/kGpvJQe+XdRiWDlUmfhZy9YDk=; b=jN+DwE/9Z/0687hgHsFr0EiljY
 1WZSNAPDoDCrE4HO0DtELcc9Q7loCL1yyNSr49oTrgxt675Tslu17DBsXQt/Zses8yJu08ZNhdfXL
 gqUijYEY6BudKANwfh/D8UOw4rJssEpWJHgP7ZwVfK+RIQZ441yuT+ArGZ2IKzRhOeK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pWzqtLm0ZZ5WjhUPz/kGpvJQe+XdRiWDlUmfhZy9YDk=; b=Dy/+4r4WpAoBeUkOM0p9Xq1UJG
 iUgSnAL8eUR1FWyTZSeSM29EoIaZbGwyseCJn04JYMRXvF9VI7b49fRpkJAmkCzws4Jk5j/X4MNZa
 KpAAHBjpvbIwolO6jmf4eK+Kobm5XtOQjnhp9uczIvCY3bRGbgagpgQYhLTAuXr6awnM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsNQ-0000000072i-0jC2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:58:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9450B60DCA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D581F000C4;
 Thu, 22 Oct 2026 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673910;
 bh=pWzqtLm0ZZ5WjhUPz/kGpvJQe+XdRiWDlUmfhZy9YDk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W1shWm6VfUIlHC/evnjY5tYREQ8PU6kdaDwx0SyjRScPCzcLBPMjoxe4G7vyI3jT8
 /Ea2uuUi1r0/ZM2Qq7abb4BHyKaTNvIv/CdA2g5CIWHyv2g2QRAWBow+ZTcP7xvjer
 gkG47yJD1NQEsTDunexd+Wc8UNyxRuHjq/sQQJMlcxdR6NSOyasuLRla1Ce6PtOjQe
 I+ouS9rYQjEy1YjSQj5QItx349L1GVy1EV+4fh2iQZGTmCv36pkCgDPhCrxZ1CdXTd
 UWhoARkSRupiSj8omZ6HVls1I2UDsTyUphCTYVHSmAGB7q+fciRrr34nhGNQm7Szpz
 AeB7ZgueojH8Q==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:58:19 +0000
Message-ID: <20261022125820.2210579-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125820.2210579-1-chao@kernel.org>
References: <20261022125820.2210579-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsNQ-0000000072i-0jC2
Subject: [f2fs-dev] [PATCH 2/3] f2fs: introduce max_write_bio_{folio,
 entry}_cnt module parameters
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

Commit f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
added a per-superblock sysfs entry, max_atc_write_bio_entry_cnt, to
offload the completion of a write bio to sbi->wq if it contains too
many entries and f2fs_write_end_io() is called in atomic context.

However, it has two issues:

1. The limit is used to bound the CPU latency of f2fs_write_end_io() in
   atomic context, which is a property of the platform (CPU and storage
   completion path) rather than of each f2fs instance, so a global knob
   set once at boot fits better than a per-superblock sysfs entry.

2. Pagecache folios and cached metadata blocks are completed in
   different loops with different per-entry costs, i.e.
   f2fs_write_end_bio() and f2fs_cache_write_end_bio(), so it's better
   to tune them separately rather than sharing a single threshold.

To address these issues, let's replace max_atc_write_bio_entry_cnt
sysfs entry with two module parameters:

- max_write_bio_folio_cnt: for write bios of pagecache folios, which
  are completed in f2fs_write_end_bio().
- max_write_bio_entry_cnt: for write bios of cached metadata blocks,
  which are completed in f2fs_cache_write_end_bio().

Both parameters are read-only at runtime, they can be set via
f2fs.max_write_bio_{folio,entry}_cnt=<n> in the kernel command line, or
via modprobe, and apply to all f2fs instances. The default value is
UINT_MAX, which means this functionality is disabled by default.

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 11 -----------
 fs/f2fs/data.c                          | 18 +++++++++++++++++-
 fs/f2fs/f2fs.h                          |  2 --
 fs/f2fs/super.c                         |  1 -
 fs/f2fs/sysfs.c                         |  2 --
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index e7e968c6df92..65d45d8edc68 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1014,17 +1014,6 @@ Description:	Every time a write operation completes f2fs_write_end_io() is
 		(atc) context. The default value for this attribute is UINT_MAX
 		which means that this functionality is disabled by default.
 
-What:		/sys/fs/f2fs/<disk>/max_atc_write_bio_entry_cnt
-Date:		October 2026
-Contact:	Chao Yu <chao@kernel.org>
-Description:	Every time a write operation completes f2fs_write_end_io() is
-		called. This function may be called from an atomic context,
-		e.g. from inside an interrupt handler. This attribute controls
-		the maximum number of entries (folios or cached blocks) in a
-		write bio that is completed in atomic (atc) context. The default
-		value for this attribute is UINT_MAX which means that this
-		functionality is disabled by default.
-
 What:		/sys/fs/f2fs/<disk>/pinned_area_max_secno
 Date:		August 2026
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 16ab2c693aa9..e2f5b95b5c6d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -36,6 +36,16 @@ static struct kmem_cache *ffs_entry_slab;
 static mempool_t *bio_post_read_ctx_pool;
 static struct bio_set f2fs_bioset;
 
+static unsigned int max_write_bio_folio_cnt = UINT_MAX;
+module_param(max_write_bio_folio_cnt, uint, 0444);
+MODULE_PARM_DESC(max_write_bio_folio_cnt,
+		"Maximum number of folios in a write bio completed in atomic context");
+
+static unsigned int max_write_bio_entry_cnt = UINT_MAX;
+module_param(max_write_bio_entry_cnt, uint, 0444);
+MODULE_PARM_DESC(max_write_bio_entry_cnt,
+		"Maximum number of cache entries in a write bio completed in atomic context");
+
 struct f2fs_folio_state {
 	spinlock_t		state_lock;
 	unsigned int		read_pages_pending;
@@ -390,6 +400,12 @@ static void f2fs_write_end_io_work(struct work_struct *work)
 	f2fs_write_end_bio(bio);
 }
 
+static unsigned int f2fs_max_write_bio_cnt(struct bio *bio)
+{
+	return f2fs_is_cache_bio(bio) ? max_write_bio_entry_cnt :
+					max_write_bio_folio_cnt;
+}
+
 static void f2fs_write_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi;
@@ -400,7 +416,7 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	if (bio_in_atomic() &&
 	    (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
-	     F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
+	     F2FS_BIO(bio)->entry_cnt > f2fs_max_write_bio_cnt(bio))) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6b3955f9a6f..05a7e96febdf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1808,8 +1808,6 @@ struct f2fs_sb_info {
 	/* for bio operations */
 	/* Largest write bio size completed in atomic context (atc). */
 	u32 max_atc_write_bio_size;
-	/* Largest write bio entry count completed in atomic context (atc). */
-	u32 max_atc_write_bio_entry_cnt;
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 12a051ba51ac..bd79cbbeba20 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5262,7 +5262,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto free_sb_buf;
 	}
 	sbi->max_atc_write_bio_size = UINT_MAX;
-	sbi->max_atc_write_bio_entry_cnt = UINT_MAX;
 
 	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
 	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 430356e500af..3f50c291b355 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1285,7 +1285,6 @@ F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
 F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
 F2FS_SBI_RW_ATTR(max_atc_write_bio_size, max_atc_write_bio_size);
-F2FS_SBI_RW_ATTR(max_atc_write_bio_entry_cnt, max_atc_write_bio_entry_cnt);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
@@ -1538,7 +1537,6 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
 	ATTR_LIST(max_atc_write_bio_size),
-	ATTR_LIST(max_atc_write_bio_entry_cnt),
 	ATTR_LIST(max_fragment_chunk),
 	ATTR_LIST(max_fragment_hole),
 	ATTR_LIST(current_atomic_write),
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
