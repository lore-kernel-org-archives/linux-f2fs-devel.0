Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559CCC55182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FuVDgQaVvLWEg+UjraRlFS7MQ3d1yDSmEnoo6YpPPEw=; b=cQiD8E6s4wSePx1Y+W/MaTmrZB
	lwhJ9lH0P4Gfb6SbeJeMdVFg2BZVdGGHRL3uHxHKHAJBunX7DAbGx7EuGo21gPMVqs6SSgBYRf2jl
	Turx63HP77B1JK2b6HKgXX9wpLkH5fzI8i4b66aCVg3WOywEevGMaWHo9OnlCGqFYO5w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqvu8-0002q7-LW;
	Mon, 03 Aug 2026 16:52:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wqvu7-0002q0-MR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 16:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kd+0ZsnKCdUOMRA/vYk//AkBb7YYehALy83z5G++w50=; b=nDzoRr0akFKy2j/DwyF3bJnRK9
 oUBLIWo0YeoaM6x3Jt3HfK4ZOvMFIenJv6ULVjctHbulC72SLZdeS4zSJ4Zv438Rk6cGnBv9WcMke
 28OWDKkobbdV4KpoBF7tVTngcczzgVgIrXuV56aI0m1z7SoWXvJiuB0zloPwOXvZNp3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kd+0ZsnKCdUOMRA/vYk//AkBb7YYehALy83z5G++w50=; b=N
 v4LhqLUj+e+KPUnw+Mcy2ygo22HtuLD/j/BaE0PQYiS1nYO59IT5SY6CYZlutkMKqSB4B/Br2Pyc0
 d38Z3jjlmcCk3e6JtmcaC3/jDs+suy//ssWovjI4yNWqRA6evO0VUQEzHbqiKVSZtf3YUgmeTxNCc
 +v4zDlroxQzb1m0A=;
Received: from 013.lax.mailroute.net ([199.89.1.16])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqvuB-0002PM-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 16:52:44 +0000
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4hDN5L536Zzlfvq4;
 Mon,  3 Aug 2026 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:mime-version:x-mailer:message-id:date
 :date:subject:subject:from:from:received:received; s=mr01; t=
 1785775955; x=1788367956; bh=kd+0ZsnKCdUOMRA/vYk//AkBb7YYehALy83
 z5G++w50=; b=V6hNPpSKoFgIsxgpODDFgdjNDeUKjQ9pwigCI2D1Oee87eHpGV7
 dHdXK8N9DEk7iOgwD7daJupMfVGlWVMsGymFBasncqi+l7P5qab53VJm97EDuSsO
 FuJqQ00NhJG1ZRL44azO/lcb52w8QaWZFz5+Z407DM9cDEuQT7jRKrFSXYWr03aw
 5pNqowWOSMCKDqBJzE1Y/y/GhWib9gg0DZGHdRRV2mRleRASJL5XG0oKjI7sn0pz
 PIdiKdNqPXuxHpOez2aO8ECb1O9pHmse9h2u5sXkcE2fxpfN8Knje2jX1BRKGViv
 tZzu/KQGms/RfeBoG0Y3UfDAc+wtK3zm+8g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0KvzjbAOpj0I; Mon,  3 Aug 2026 16:52:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hDN5G1nq5zlfvpM;
 Mon,  3 Aug 2026 16:52:33 +0000 (UTC)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon,  3 Aug 2026 09:52:22 -0700
Message-ID: <4493e1b9c502f9394cb6522ea433f43a64f218da.1785775861.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
MIME-Version: 1.0
X-Headers-End: 1wqvuB-0002PM-B3
Subject: [f2fs-dev] [PATCH v2] f2fs: Run f2fs_write_end_io() asynchronously
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The bio_for_each_segment_all() loop can take more than 10 ms for a large
bio on an ARM little core. This is too much for interrupt context. Hence
perform the write bio completion work asynchronously if a bio is large and
if f2fs_write_end_io() is called from atomic context. This patch reduces
the time spent in f2fs_write_end_io() from about 10 ms to about 150
microseconds on an Arm Cortex-A520 core if the max_atc_write_bio_size
parameter is changed to 16384.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: changed the default value of the new sysfs parameter
  from 16 K to UINT_MAX (disabled).

 Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
 fs/f2fs/data.c                          | 21 ++++++++++++++++++++-
 fs/f2fs/f2fs.h                          |  2 ++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         |  2 ++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 1b58c029abd0..f4e6a7415cde 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1002,3 +1002,13 @@ Description:	It can be used to tune priority of f2fs critical task, e.g. f2fs_ck
 		threads, limitation as below:
 		- it requires user has CAP_SYS_NICE capability.
 		- the range is [100, 139], by default the value is 120.
+
+What:		/sys/fs/f2fs/<disk>/max_atc_write_bio_size
+Date:		June 2026
+Contact:	Bart Van Assche <bvanassche@acm.org>
+Description:	Every time a write operation completes f2fs_write_end_io() is
+		called. This function may be called from an atomic context,
+		e.g. from inside an interrupt handler. This attribute controls
+		the maximum size of a write bio that is completed in atomic
+		(atc) context. The default value for this attribute is UINT_MAX
+		which means that this functionality is disabled by default.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0429766a2d5d..b986ba8fa532 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -411,11 +411,30 @@ static void f2fs_write_end_bio(struct bio *bio)
 	bio_put(bio);
 }
 
+static void f2fs_write_end_io_work(struct work_struct *work)
+{
+	struct bio *bio = &container_of(work, struct f2fs_bio, work)->bio;
+
+	f2fs_write_end_bio(bio);
+}
+
 static void f2fs_write_end_io(struct bio *bio)
 {
+	struct f2fs_sb_info *sbi;
+
 	iostat_update_and_unbind_ctx(bio);
 
-	f2fs_write_end_bio(bio);
+	sbi = bio->bi_private;
+
+	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
+		struct work_struct *w;
+
+		w = &container_of(bio, struct f2fs_bio, bio)->work;
+		INIT_WORK(w, f2fs_write_end_io_work);
+		queue_work(sbi->wq, w);
+	} else {
+		f2fs_write_end_bio(bio);
+	}
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 60affd57a19d..5d020b21eaaa 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1773,6 +1773,8 @@ struct f2fs_sb_info {
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 
 	/* for bio operations */
+	/* Largest write bio size completed in atomic context (atc). */
+	u32 max_atc_write_bio_size;
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9760e4efeffe..a87ec20d3363 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5068,6 +5068,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
+	sbi->max_atc_write_bio_size = UINT_MAX;
 
 	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
 	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 665687244c93..47b378ccf07a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1266,6 +1266,7 @@ F2FS_SBI_RW_ATTR(gc_idle_interval, interval_time[GC_TIME]);
 F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
 F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
+F2FS_SBI_RW_ATTR(max_atc_write_bio_size, max_atc_write_bio_size);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
@@ -1509,6 +1510,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
+	ATTR_LIST(max_atc_write_bio_size),
 	ATTR_LIST(max_fragment_chunk),
 	ATTR_LIST(max_fragment_hole),
 	ATTR_LIST(current_atomic_write),


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
