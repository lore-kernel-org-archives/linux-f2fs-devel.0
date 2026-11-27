Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DADD606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mYu0vzUh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vym/vQqC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R6TgyHAJ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKFriKmM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tIY0ca93gVIRCVAN5UajVbzBOq3km+Dhynm2a+Pmkhw=; b=mYu0vzUhC9WJMpQAGQGHuhRUcD
	vTzkDtslzzwVhqSgIauu4i1dkg6j1HDme4FOxjIXKgPb0vAf79nIJ+2ajkQBBeQ/SNxuAjvYAbnJJ
	WDLLKdAy+6nBW7mQMMuofedqYADKoMRZjaKgSAV1dO/UD1KXdQvRUJbX/zus9prlBKLk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWtdN-000000006ch-3ZHn;
	Fri, 27 Nov 2026 10:56:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xWtdL-000000006c2-2HLj
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CHN6KXnTS23nYEHkKbB8iinceo2+xcsNFrggmAImSbM=; b=Vym/vQqCmgxs/zLiQHkvq+TrdZ
 ttTrk/g/Pmin4nG8IeXEjxPfZKUoMZQ5HT09ZCQkxIoaBwpcnDE/MQDPvJSGYpm/prdM82115fbMU
 3WXZaf/3ZTLHwhziMWtS1CA4eh1HbGBtz2nIcsTb14cHFj/42V4vovEHDFgjfJqh3oDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CHN6KXnTS23nYEHkKbB8iinceo2+xcsNFrggmAImSbM=; b=R6TgyHAJttRanCBjf3yy9CuW9A
 IrNY9BJNaXzCA4XlShx9quqg8yeEKEnhD+jjtPwdiad81z/TgZmD5vOrqV37dBPHeyG1m2MUuLrn5
 ErkQRlAsdiL5svCuUUh27rJALVD1ebR4cHuSoQuTbFHe/bJiF5rN4LW+EOBNELQmracY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWtdK-000000001Co-1xe3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31B444514F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 10:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A0C1F00919;
 Fri, 27 Nov 2026 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795777004;
 bh=CHN6KXnTS23nYEHkKbB8iinceo2+xcsNFrggmAImSbM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZKFriKmM8BgGfH30pJsXD1m3ONDdXkKNs7+kX7bB9M90yEQSaBvUES1CXJLFVhg10
 fM7TgFF/56eH9lTWn3Q6iKt9NWm0QybRLfu71ZrQLZkSnvBdiSL/Wri8zh97Hg57dC
 E5hSb1d3z4IWWrV9gItlgx2pw6SY1fzq6yQFkobtwgUEWkjQaBcmXQFwipgM6e6Q50
 b75Fghs1EoKk8RYKeg+Sk8VI2iSdAu52fQP29s1d4aQx+mRVLS1jvxJeASWtSuCte4
 eI/qqs6BYL8iuUzTh9V6EqrgcySbjqnJz1tSBCiPFBaVw/e9OCKVsCaNufTJRGGuxy
 UTrxEVJzAnUug==
To: jaegeuk@kernel.org
Date: Fri, 27 Nov 2026 10:56:42 +0000
Message-ID: <20261127105640.537608-5-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105640.537608-4-chao@kernel.org>
References: <20261127105640.537608-4-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWtdK-000000001Co-1xe3
Subject: [f2fs-dev] [PATCH v2 2/3] f2fs: introduce max_write_bio_{folio,
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
v2:
- add document for max_write_bio_{folio,entry}_cnt module parameters in
  Documentation/filesystems/f2fs.rst.
- rebase to the latest dev-test branch.

 Documentation/ABI/testing/sysfs-fs-f2fs | 11 -----------
 Documentation/filesystems/f2fs.rst      | 18 ++++++++++++++++++
 fs/f2fs/data.c                          | 18 +++++++++++++++++-
 fs/f2fs/f2fs.h                          |  2 --
 fs/f2fs/super.c                         |  1 -
 fs/f2fs/sysfs.c                         |  2 --
 6 files changed, 35 insertions(+), 17 deletions(-)

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
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 4d827c8a98d8..22677bf54a01 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -453,6 +453,24 @@ The files in each per-device directory are shown in table below.
 Files in /sys/fs/f2fs/<devname>
 (see also Documentation/ABI/testing/sysfs-fs-f2fs)
 
+Module Parameters
+=================
+
+Module parameters apply to all f2fs instances. They can be set via
+"f2fs.<parameter>=<value>" in the kernel command line, or via modprobe
+if f2fs is built as a module, and are read-only at runtime.
+
+======================== ============================================================
+max_write_bio_folio_cnt	 Maximum number of pagecache folios in a write bio whose
+			 completion is done in atomic context, a write bio w/ more
+			 folios will be completed in a workqueue instead, to bound
+			 the latency of f2fs_write_end_io() in atomic context.
+			 Default: UINT_MAX, i.e. disabled.
+max_write_bio_entry_cnt	 Same as max_write_bio_folio_cnt, but for write bios of
+			 cached metadata blocks.
+			 Default: UINT_MAX, i.e. disabled.
+======================== ============================================================
+
 Usage
 =====
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6be0cadc511e..dbc21e4f147e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -35,6 +35,16 @@ static struct kmem_cache *bio_entry_slab;
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
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
 int __init f2fs_init_bioset(void)
@@ -472,6 +482,12 @@ static void f2fs_write_end_io_work(struct work_struct *work)
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
@@ -482,7 +498,7 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	if (bio_in_atomic() &&
 	    (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
-	     F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
+	     F2FS_BIO(bio)->entry_cnt > f2fs_max_write_bio_cnt(bio))) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d35149191625..7f6ca03baa8f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1835,8 +1835,6 @@ struct f2fs_sb_info {
 	/* for bio operations */
 	/* Largest write bio size completed in atomic context (atc). */
 	u32 max_atc_write_bio_size;
-	/* Largest write bio entry count completed in atomic context (atc). */
-	u32 max_atc_write_bio_entry_cnt;
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3fd8a18ac482..392d5a76d26e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5355,7 +5355,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto free_sb_buf;
 	}
 	sbi->max_atc_write_bio_size = UINT_MAX;
-	sbi->max_atc_write_bio_entry_cnt = UINT_MAX;
 
 	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
 	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 8ab9a5098f1c..81de27bebaaa 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1294,7 +1294,6 @@ F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
 F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
 F2FS_SBI_RW_ATTR(max_atc_write_bio_size, max_atc_write_bio_size);
-F2FS_SBI_RW_ATTR(max_atc_write_bio_entry_cnt, max_atc_write_bio_entry_cnt);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
@@ -1547,7 +1546,6 @@ static struct attribute *f2fs_attrs[] = {
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
