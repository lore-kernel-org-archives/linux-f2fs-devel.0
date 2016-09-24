From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: support checkpoint error injection
Date: Sat, 24 Sep 2016 08:46:54 +0800
Message-ID: <3cf62ebc-3bfa-b64c-5e63-cb3170560ac0@huawei.com>
References: <20160923052458.83849-1-yuchao0@huawei.com>
	<20160923052458.83849-2-yuchao0@huawei.com>
	<20160923235345.GA23989@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bnb7i-0005RL-HD
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 00:47:22 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bnb7f-0005Xb-Al
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 00:47:22 +0000
In-Reply-To: <20160923235345.GA23989@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/9/24 7:53, Jaegeuk Kim wrote:
> Hi Chao,
> 
> The basic rule is to stop every operations once CP_ERROR_FLAG is set.
> But, this patch simply breaks the rule.
> For example, f2fs_write_data_page() currently exits with mapping_set_error().
> So this patch incurs missing dentry blocks in a valid checkpoint.

Yes, that's right.

How about triggering checkpoint error in f2fs_stop_checkpoint?

>From 7bedfe9a0e97c4deead1c7cdbfc24187f5080268 Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Fri, 23 Sep 2016 06:59:04 +0800
Subject: [PATCH] f2fs: support checkpoint error injection

This patch adds to support checkpoint error injection in f2fs for testing
fatal error tolerance.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 14 +++++++++++---
 fs/f2fs/data.c       |  7 ++++---
 fs/f2fs/f2fs.h       |  5 ++++-
 fs/f2fs/file.c       |  8 ++++----
 fs/f2fs/inode.c      |  7 +++++--
 fs/f2fs/super.c      |  1 +
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d1560bb..834c8ec 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -26,8 +26,17 @@
 static struct kmem_cache *ino_entry_slab;
 struct kmem_cache *inode_entry_slab;

-void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
+void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi,
+					bool end_io, bool need_stop)
 {
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_CHECKPOINT))
+		need_stop = true;
+#endif
+
+	if (!need_stop)
+		return;
+
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	sbi->sb->s_flags |= MS_RDONLY;
 	if (!end_io)
@@ -100,8 +109,7 @@ repeat:
 	 * readonly and make sure do not write checkpoint with non-uptodate
 	 * meta page.
 	 */
-	if (unlikely(!PageUptodate(page)))
-		f2fs_stop_checkpoint(sbi, false);
+	f2fs_stop_checkpoint(sbi, false, !PageUptodate(page));
 out:
 	return page;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a9f7436..1b00d3d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -74,10 +74,11 @@ static void f2fs_write_end_io(struct bio *bio)

 		fscrypt_pullback_bio_page(&page, true);

-		if (unlikely(bio->bi_error)) {
+		f2fs_stop_checkpoint(sbi, true, bio->bi_error);
+
+		if (unlikely(bio->bi_error))
 			set_bit(AS_EIO, &page->mapping->flags);
-			f2fs_stop_checkpoint(sbi, true);
-		}
+
 		end_page_writeback(page);
 	}
 	if (atomic_dec_and_test(&sbi->nr_wb_bios) &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e216bc0..7bc1802 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -47,6 +47,7 @@ enum {
 	FAULT_DIR_DEPTH,
 	FAULT_EVICT_INODE,
 	FAULT_IO,
+	FAULT_CHECKPOINT,
 	FAULT_MAX,
 };

@@ -80,6 +81,8 @@ static inline bool time_to_inject(int type)
 		return false;
 	else if (type == FAULT_IO && !IS_FAULT_SET(type))
 		return false;
+	else if (type == FAULT_CHECKPOINT && !IS_FAULT_SET(type))
+		return false;

 	atomic_inc(&f2fs_fault.inject_ops);
 	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
@@ -2115,7 +2118,7 @@ void destroy_segment_manager_caches(void);
 /*
  * checkpoint.c
  */
-void f2fs_stop_checkpoint(struct f2fs_sb_info *, bool);
+void f2fs_stop_checkpoint(struct f2fs_sb_info *, bool, bool);
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_tmp_page(struct f2fs_sb_info *, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d341a0e..57c7a64 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1720,21 +1720,21 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	case F2FS_GOING_DOWN_FULLSYNC:
 		sb = freeze_bdev(sb->s_bdev);
 		if (sb && !IS_ERR(sb)) {
-			f2fs_stop_checkpoint(sbi, false);
+			f2fs_stop_checkpoint(sbi, false, true);
 			thaw_bdev(sb->s_bdev, sb);
 		}
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
 		f2fs_sync_fs(sb, 1);
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, true);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, true);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
 		sync_meta_pages(sbi, META, LONG_MAX);
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, true);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ac4daa5..bf53cd2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -306,12 +306,15 @@ retry:
 	node_page = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(node_page)) {
 		int err = PTR_ERR(node_page);
+
+		f2fs_stop_checkpoint(sbi, false,
+				err != -ENOMEM && err != -ENOENT);
+
 		if (err == -ENOMEM) {
 			cond_resched();
 			goto retry;
-		} else if (err != -ENOENT) {
-			f2fs_stop_checkpoint(sbi, false);
 		}
+
 		f2fs_inode_synced(inode);
 		return 0;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6426855..3c49419 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -51,6 +51,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 	[FAULT_EVICT_INODE]	= "evict_inode fail",
 	[FAULT_IO]		= "IO error",
+	[FAULT_CHECKPOINT]	= "checkpoint error",
 };

 static void f2fs_build_fault_attr(unsigned int rate)
-- 
2.8.2.311.gee88674



------------------------------------------------------------------------------
