Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22967C61DC6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JixOJblZlPK9NowNIJ5uKHZ8rwAAdB+ga12xIKd0QQE=; b=NGPjZ9JM7SMHJGa4PcXB6hdHun
	r00/zPNCBxgBjV/IWa5ifqjAL4CwplJghcQeuyGzzLqxHBDg5vj++ZyIlOUP2nDHsrZ8tTltxFUCt
	RaEXEV3T8dUXpnjF95KNFpw8js3kQ+NBInpEbgn7amp7VVw7uXymhBVF2GStvMQBdJbc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzZBA-0002Mq-K8;
	Thu, 27 Aug 2026 12:25:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzZB9-0002Mj-Qf
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1whlCASNGAm3B0YuCliHXR5uVhRAnNBvZHd43fmII9o=; b=CEG6GTvPfkdnkFq0VcMhwbeHYe
 DikAEfs5jpszwnfHndkT5lil26drdtuoyrqDbCEZCQFOcW0lPmPIKVTis20aTgArO1uGw6l8048BB
 ZqOfx7X/u26Kk6R7qdniZ+W3TuOduGZM8u9uvLcJlFofH1G5A6fhDHc8dP9mRXehkaTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1whlCASNGAm3B0YuCliHXR5uVhRAnNBvZHd43fmII9o=; b=JqiRuSbAdxlmyIlpsOwYo+Pdut
 WhpxRJOPd+EOF4T0M6B82M8bZCULLZ9F+qmJrgCIULhMHkWdjjvLEkgi3Hcb2X16R2BepjVO2xUi7
 WA9BTBpNO0paP9GmuX+h2RycbhVqRw7DSfIXEVqP5rqXegYhl3BYCw568yy94bOnLZS8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzZB6-0006Bt-GQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:25:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FCFA40421
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 12:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329191F000E9;
 Thu, 27 Aug 2026 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787833551;
 bh=1whlCASNGAm3B0YuCliHXR5uVhRAnNBvZHd43fmII9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UAvJbe4fbOAF3NeJ5xXB7IAyT8wG0e5VbPTSIvSKFsD668wqkA+lzSCQ1mtmsUhPb
 kekjMbeBSBNgJ/siNiuYM6l0mwhazkbgmkliioraNZ3BWp8DF6qRoyHOZMXdOyAMFC
 GRUCC7mEFmpVGpdQ6gsy0WAEL4Idz1aHw4n/4EX5Y3LUPvY2I1w9XH22oFhIsb9zaP
 rbCLC4mWICDeDwPm+ELkj/N7SBwC8BiBPhYEfBThgtai4eWRWWNCYucqh8n9EKb1nQ
 f4tZBF24wQmFalPhfhXrpoO0NYgO2Vp0jT7Grp9PtL2c5Lyv61iSMB8Ci9NXQBu25H
 mifSR8Y4NM3Nw==
To: jaegeuk@kernel.org
Date: Thu, 27 Aug 2026 20:25:30 +0800
Message-ID: <20260827122541.19967-3-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827122541.19967-1-chao@kernel.org>
References: <20260827122541.19967-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wzZB6-0006Bt-GQ
Subject: [f2fs-dev] [PATCH v4 02/12] f2fs: cache: initialize meta cache
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

This patch introduces meta_blocks in f2fs_sb_info structure, initializes
and destroys the meta cache during filesystem mount and unmount.

It also introduces helper wrappers for meta cache operation.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.h | 12 ++++++++++++
 fs/f2fs/data.c  |  3 +++
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 10 +++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 0e201a36fcd5..cb5a466526fc 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -179,4 +179,16 @@ void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty);
 void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 		unsigned long start, unsigned long len, bool drop_dirty);
 
+int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
+void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
+
+#define META_CACHE(sbi)		(&(sbi)->meta_blocks)
+
+#define f2fs_find_meta_cache(sbi, blkaddr)		\
+	f2fs_find_cache(META_CACHE(sbi), blkaddr)
+#define f2fs_invalidate_meta_caches(sbi, start, len)	\
+	f2fs_drop_cache_range(META_CACHE(sbi), start, len, false)
+#define f2fs_truncate_meta_caches(sbi, start, len)	\
+	f2fs_drop_cache_range(META_CACHE(sbi), start, len, true)
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 75ab768bb4f7..2c91382ffc3c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -695,6 +695,9 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
 	if (!inode && !folio && !ino)
 		return true;
 
+	if (f2fs_is_cache_bio(bio))
+		return false;
+
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *target = fi.folio;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 84ee4601126d..0f855ac7d1e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2108,6 +2108,9 @@ struct f2fs_sb_info {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key cp_global_sem_key;
 #endif
+
+	/* f2fs internal cache */
+	struct f2fs_cached_block_list meta_blocks;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c1e315282ec6..32e80c70e141 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2075,6 +2075,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	f2fs_destroy_cache(META_CACHE(sbi));
+
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
 		if (!get_pages(sbi, i))
@@ -5225,12 +5227,16 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_percpu;
 
+	err = f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
+	if (err)
+		goto free_page_array_cache;
+
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_err(sbi, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
-		goto free_page_array_cache;
+		goto free_meta_cache;
 	}
 
 	err = f2fs_get_valid_checkpoint(sbi);
@@ -5564,6 +5570,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
+free_meta_cache:
+	f2fs_destroy_cache(META_CACHE(sbi));
 free_page_array_cache:
 	f2fs_destroy_page_array_cache(sbi);
 free_percpu:
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
