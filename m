Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E721C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t7G1ZPImMyXa6KJKPm6nuQyzqBwbNAxlWXYnMfo3NI8=; b=RJSumST8tvF6Odqd7h+1tl9h6c
	1+weBVBq0vCOPhhjQLv9p7Dgud2AJWVG0Hsvyou1uWXIjJQ0U3fUB6UtEmLQNElQgBbvSRpl4lpZg
	9L8p6nTfY4Gim/vOjx/BOadKgG5PkQLcqBxtV9VFAzHJNWOBL2As6CR8sAajJK7Jmd6g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2ta-0004gf-9r;
	Tue, 04 Aug 2026 00:20:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wr2tY-0004gX-4l
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZSAaMvg7YcjD6AAM/JK2EldJLvLWrEyPSS1OHljS2Y=; b=L4/IeHh+zh6zPmKlJayicmwmrt
 /3k+0pLnLyhtf71oeJDOdu5TXKeJy4+2Q3Vq9OeaTSjZhNAw2CfFnrDWU9ipIH0ZT+oJ+aFobv387
 I6WsAjQfv3bjAsvtrnFdXwb0Sz2HPkXmUQl+P5mHye+pNTsA3nrM2Vkfdq4btp3T4q3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lZSAaMvg7YcjD6AAM/JK2EldJLvLWrEyPSS1OHljS2Y=; b=Q
 DWh4e1geWDmXUNM4KRJTPHKaTvqGvFZvYArl49WMN61zZaQpYsj/77IXcT+QBukW8jy/p+SJrnXek
 xueWYRoYPKLXXeBZ745aMLVbDkubQj1NbRSjjVtk4nfpSDXUt3DVNgCF/34lirbWb7nRLYe73BmIO
 UsEFZeAWTj51QEZw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2tY-0002Lq-1w for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:20:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61C0460A59
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Aug 2026 00:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028E51F000E9;
 Tue,  4 Aug 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785802830;
 bh=lZSAaMvg7YcjD6AAM/JK2EldJLvLWrEyPSS1OHljS2Y=;
 h=From:To:Cc:Subject:Date;
 b=H5X32eQsITdutTr0VR78XRjVvTEKcG+cCdYxAHGbE84/JDsMqI1+J+Wp6KPOtBwic
 O9eW9A/cho9XS00P3ZknKJ7JgwstkNK47HKr6jZb6DSmBP9LdHhQutCeB7/iH4RzSt
 7+ilklGkJIS0B08ynOxP/5o25AQPt3JgKTOLr9sZjqx/mQWsquOsV97UULYk1fdqRQ
 DE5EcrTY43Wh0h5QcyFmaUGsgRtnw3fsoSDit5US5HKfJTWl/0pISKRWXwbiUT7M7c
 V0orK4XAsm9rv+YjntHAm9ZkM8NOL+NnlGd1+I2ENYJ1cXM+7F6mPSudn6f0qgOwkj
 4jIOCcjYxNxWg==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  4 Aug 2026 00:20:27 +0000
Message-ID: <20260804002027.2196300-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
MIME-Version: 1.0
X-Headers-End: 1wr2tY-0002Lq-1w
Subject: [f2fs-dev] [PATCH] f2fs: call __add_ino_entry out of the eviction
 path
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The f2fs_evict_inode() can be called during the direct reclaim path, but
__add_ino_entry requires allocating some memory. Since we don't need to
do that in that context, let's migrate it in other workqueue context.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 15 ++++++++
 fs/f2fs/data.c       | 13 ++++++-
 fs/f2fs/f2fs.h       |  4 ++
 fs/f2fs/inode.c      | 88 +++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/super.c      |  9 ++++-
 5 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 064f5b537423..2d00b718974f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -766,6 +766,15 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	spin_unlock(&im->ino_lock);
 }
 
+static void f2fs_wait_for_inode_record(struct f2fs_sb_info *sbi, int mode)
+{
+	if (mode != APPEND_INO && mode != UPDATE_INO)
+		return;
+
+	/* Let's wait for some pending updates for APPEND_INO and UPDATE_INO. */
+	flush_workqueue(sbi->evict_wq);
+}
+
 void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* add new dirty ino entry into list */
@@ -774,6 +783,8 @@ void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 
 void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
+	f2fs_wait_for_inode_record(sbi, type);
+
 	/* remove dirty ino entry from list */
 	__remove_ino_entry(sbi, ino, type);
 }
@@ -784,6 +795,8 @@ bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 	struct inode_management *im = &sbi->im[mode];
 	struct ino_entry *e;
 
+	f2fs_wait_for_inode_record(sbi, mode);
+
 	spin_lock(&im->ino_lock);
 	e = radix_tree_lookup(&im->ino_root, ino);
 	spin_unlock(&im->ino_lock);
@@ -798,6 +811,8 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	for (i = all ? ORPHAN_INO : APPEND_INO; i < MAX_INO_ENTRY; i++) {
 		struct inode_management *im = &sbi->im[i];
 
+		f2fs_wait_for_inode_record(sbi, i);
+
 		spin_lock(&im->ino_lock);
 		list_for_each_entry_safe(e, tmp, &im->ino_list, list) {
 			list_del(&e->list);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c219ea76a3a7..6ae0eb37d20f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4558,13 +4558,24 @@ int f2fs_init_wq(struct f2fs_sb_info *sbi)
 {
 	sbi->wq = alloc_workqueue("f2fs_wq", WQ_UNBOUND | WQ_HIGHPRI,
 				  num_online_cpus());
-	return sbi->wq ? 0 : -ENOMEM;
+	if (!sbi->wq)
+		return -ENOMEM;
+
+	sbi->evict_wq = alloc_workqueue("f2fs_evict_wq",
+			WQ_UNBOUND | WQ_HIGHPRI, num_online_cpus());
+	if (!sbi->evict_wq) {
+		destroy_workqueue(sbi->wq);
+		return -ENOMEM;
+	}
+	return 0;
 }
 
 void f2fs_destroy_wq(struct f2fs_sb_info *sbi)
 {
 	if (sbi->wq)
 		destroy_workqueue(sbi->wq);
+	if (sbi->evict_wq)
+		destroy_workqueue(sbi->evict_wq);
 }
 
 int __init f2fs_init_bio_entry_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c44908258dc1..54f9d3856b5c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2016,6 +2016,8 @@ struct f2fs_sb_info {
 
 	struct workqueue_struct *wq;		/* bio completion workqueue */
 
+	struct workqueue_struct *evict_wq;	/* inode eviction workqueue */
+
 	/*
 	 * If we are in irq context, let's update error information into
 	 * on-disk superblock in the work.
@@ -3875,6 +3877,8 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
 void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
 void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc);
+int f2fs_init_evict_inode_work(void);
+void f2fs_destroy_evict_inode_work(void);
 
 /*
  * namei.c
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c95e0b126da4..ed67eed3675e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -24,6 +24,18 @@
 extern const struct address_space_operations f2fs_compress_aops;
 #endif
 
+#define NUM_PREALLOC_EVICT_INODE_WORK 8
+
+static struct kmem_cache *evict_inode_work_cache;
+static mempool_t *evict_inode_work_pool;
+
+struct evict_inode_work {
+	struct work_struct work;
+	struct f2fs_sb_info *sbi;
+	nid_t ino;
+	unsigned int add_ino_entry_bits;
+};
+
 void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 {
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
@@ -854,6 +866,25 @@ void f2fs_remove_donate_inode(struct inode *inode)
 	spin_unlock(&sbi->inode_lock[DONATE_INODE]);
 }
 
+static void f2fs_record_inode_state(struct f2fs_sb_info *sbi, nid_t ino,
+				    unsigned int bits)
+{
+	if (bits & BIT(APPEND_INO))
+		f2fs_add_ino_entry(sbi, ino, APPEND_INO);
+	if (bits & BIT(UPDATE_INO))
+		f2fs_add_ino_entry(sbi, ino, UPDATE_INO);
+}
+
+static void f2fs_evict_inode_work(struct work_struct *work)
+{
+	struct evict_inode_work *ew =
+		container_of(work, struct evict_inode_work, work);
+
+	f2fs_record_inode_state(ew->sbi, ew->ino, ew->add_ino_entry_bits);
+
+	mempool_free(ew, evict_inode_work_pool);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero
  */
@@ -864,6 +895,7 @@ void f2fs_evict_inode(struct inode *inode)
 	nid_t xnid = fi->i_xattr_nid;
 	int err = 0;
 	bool freeze_protected = false;
+	unsigned int record_bits = 0;
 
 	f2fs_abort_atomic_write(inode, true);
 
@@ -1003,12 +1035,32 @@ void f2fs_evict_inode(struct inode *inode)
 							inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
-	if (inode->i_nlink) {
-		if (is_inode_flag_set(inode, FI_APPEND_WRITE))
-			f2fs_add_ino_entry(sbi, inode->i_ino, APPEND_INO);
-		if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
-			f2fs_add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+
+	if (!inode->i_nlink)
+		goto skip_record;
+
+	if (is_inode_flag_set(inode, FI_APPEND_WRITE))
+		record_bits = BIT(APPEND_INO);
+	if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
+		record_bits = BIT(UPDATE_INO);
+
+	if (!record_bits)
+		goto skip_record;
+
+	/* Let's do this in workqueue out of the direct reclaim path. */
+	if (current_is_kswapd()) {
+		f2fs_record_inode_state(sbi, inode->i_ino, record_bits);
+	} else {
+		struct evict_inode_work *ew =
+			mempool_alloc(evict_inode_work_pool, GFP_NOFS);
+
+		ew->sbi = sbi;
+		ew->ino = inode->i_ino;
+		ew->add_ino_entry_bits = record_bits;
+		INIT_WORK(&ew->work, f2fs_evict_inode_work);
+		queue_work(sbi->evict_wq, &ew->work);
 	}
+skip_record:
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
 		f2fs_alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
@@ -1079,3 +1131,29 @@ void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc)
 	/* iput will drop the inode object */
 	iput(inode);
 }
+
+int __init f2fs_init_evict_inode_work(void)
+{
+	evict_inode_work_cache =
+		kmem_cache_create("f2fs_evict_inode_work",
+				  sizeof(struct evict_inode_work), 0, 0, NULL);
+	if (!evict_inode_work_cache)
+		goto fail;
+	evict_inode_work_pool =
+		mempool_create_slab_pool(NUM_PREALLOC_EVICT_INODE_WORK,
+					 evict_inode_work_cache);
+	if (!evict_inode_work_pool)
+		goto fail_free_cache;
+	return 0;
+
+fail_free_cache:
+	kmem_cache_destroy(evict_inode_work_cache);
+fail:
+	return -ENOMEM;
+}
+
+void f2fs_destroy_evict_inode_work(void)
+{
+	mempool_destroy(evict_inode_work_pool);
+	kmem_cache_destroy(evict_inode_work_cache);
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 67abbf7ab477..6b55c30f0daa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5763,10 +5763,16 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_xattr_cache();
 	if (err)
 		goto free_casefold_cache;
-	err = register_filesystem(&f2fs_fs_type);
+	err = f2fs_init_evict_inode_work();
 	if (err)
 		goto free_xattr_cache;
+	err = register_filesystem(&f2fs_fs_type);
+	if (err)
+		goto free_evict_inode_cache;
 	return 0;
+
+free_evict_inode_cache:
+	f2fs_destroy_evict_inode_work();
 free_xattr_cache:
 	f2fs_destroy_xattr_cache();
 free_casefold_cache:
@@ -5809,6 +5815,7 @@ static int __init init_f2fs_fs(void)
 static void __exit exit_f2fs_fs(void)
 {
 	unregister_filesystem(&f2fs_fs_type);
+	f2fs_destroy_evict_inode_work();
 	f2fs_destroy_xattr_cache();
 	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
-- 
2.55.0.571.g244d577d93-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
