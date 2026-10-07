Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819F7CA5FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqmP+cyoQGXwJitPflEjAAtqsoBx2vczXSKG7WYz2CM=; b=ZTB7AznsTSEpgKvvMWOnnyoqQS
	Rc26csYRRguiMzUsGuUqqMJGNz3DaYjFmeSiD8xOOuMA7lt2A0CbZHqG+MkS9TELYMrbbASOHPS2/
	j5CFOGBUQxCv6OpVHdqZko3l7rIFz6lyKG4Rx8gdoRIFLC1F0cG+LUy15SjoNuzTa+GM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEQ9v-0006lq-8U;
	Wed, 07 Oct 2026 11:50:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xEQ9s-0006lY-ID
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7AKynYn/YaLPC6ZGec+I8tbwyuxRUcwNNuNurUAQMw=; b=jWQLK/+hiy7ChI7zJbACxBg6mS
 /XdEnIFJUPzV3nGrxQuY5ZrlWVjE6jA5FJiYuf5FAZ7muQxDPRRtfnk0+ktZRLJCLsPEu9bXt0klQ
 e7Z7bi/C+/Hxn3hKD/SqQZoM5RBB+DnFGijnbRzox7N4lUB7nweTxvl6N5r4LgotCudY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o7AKynYn/YaLPC6ZGec+I8tbwyuxRUcwNNuNurUAQMw=; b=XCVO20p92ssPeFjTKMjG8ftvZs
 FqufkUZpc2+me0JG4oX2OayL7v09GiPE3ztoUcHlFmw5DTGl+qTXzO2rP0sBA81ze24dlqKuuspNK
 ua/BKyTQQ+TbxZOiEO3Fvr5Nc8NYisi0TwHv/zgi6LFYfHIZmhSdkWfjIODaTNCu0gr8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEQ9r-0001IA-Rj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:50:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C68D601FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  7 Oct 2026 11:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310581F0089E;
 Wed,  7 Oct 2026 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791373798;
 bh=o7AKynYn/YaLPC6ZGec+I8tbwyuxRUcwNNuNurUAQMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jy4RYaM3O+vNN7qlGbn1NJVtQIbJBoakpyKp2pApgqVBDf8/Vgc/4rlnkpzePvQNc
 NmxuPQs84nv3tYkLcmuJcF1VaVbZLQlOqtfrQzYByMVrWYW+JJTIWB3r60Xb1EZfV0
 w9RzC99s6zLefqLKZ+Q+f22h7ZNLvZKDPUSqZ19Q/yGukDIm14g8CkAlXjCGIYNKtH
 4O9r3ant1+Kv8xfiVlt8jatHF6/hHH5pB/W9kxIGj1gqwxclOPC7qroZzGgNhMFxWX
 0yF3SudhQ6ZEn92bBZ4a8nhJ8xzvK+C6ZjkM5s/Hx/3kYAtRUxZ11gLVLIDFGTmwLT
 9oN8rmp/0W67A==
To: jaegeuk@kernel.org
Date: Wed,  7 Oct 2026 11:49:46 +0000
Message-ID: <20261007114949.2428048-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261007114949.2428048-1-chao@kernel.org>
References: <20261007114949.2428048-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xEQ9r-0001IA-Rj
Subject: [f2fs-dev] [PATCH 2/5] f2fs: cache: shrink meta and node caches in
 f2fs_balance_fs_bg
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

This patch introduces META_BLOCK and NODE_BLOCK memory types to monitor
meta and node cache usage against available free memory, and integrates
them into f2fs_balance_fs_bg().

In f2fs_balance_fs_bg(), shrink 128 clean cached blocks of each types when
memory is insufficient (cache memory usage is larger than 50% of low memory).

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c   | 12 ++++++++++++
 fs/f2fs/cache.h   |  6 ++++++
 fs/f2fs/node.c    | 10 ++++++++++
 fs/f2fs/node.h    |  2 ++
 fs/f2fs/segment.c |  8 ++++++++
 5 files changed, 38 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 04b5408cbc58..f385fe928b5b 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -669,6 +669,18 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 	return freed;
 }
 
+unsigned long f2fs_shrink_meta_cache(struct f2fs_sb_info *sbi,
+					unsigned long nr_to_scan)
+{
+	return f2fs_do_shrink_cache(META_CACHE(sbi), nr_to_scan);
+}
+
+unsigned long f2fs_shrink_node_cache(struct f2fs_sb_info *sbi,
+					unsigned long nr_to_scan)
+{
+	return f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan);
+}
+
 static int f2fs_cache_writeback_kthread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 6c4db910d767..3df3a562c46f 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -84,6 +84,8 @@ enum f2fs_cache_request_flag {
 
 #define F2FS_ONSTACK_CACHES		(32)
 
+#define METADATA_CACHE_SHRINK_NUMBER	(128)
+
 #define F2FS_CACHE_FLAG_TEST_FUNC(name, flagname)			\
 static inline bool f2fs_cache_test_##name(				\
 			const struct f2fs_cached_block *entry)		\
@@ -223,6 +225,10 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 				unsigned long nr_to_scan);
+unsigned long f2fs_shrink_meta_cache(struct f2fs_sb_info *sbi,
+				unsigned long nr_to_scan);
+unsigned long f2fs_shrink_node_cache(struct f2fs_sb_info *sbi,
+				unsigned long nr_to_scan);
 
 #define DEF_DIRTY_CACHE_TIMEOUT 5000
 #define MIN_DIRTY_CACHE_TIMEOUT 100
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index be14dfa31e53..7b2ff2c3dd03 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -123,6 +123,16 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 #else
 		res = false;
 #endif
+	} else if (type == META_BLOCK) {
+		mem_size = (META_CACHE(sbi)->num_entries *
+				(sizeof(struct f2fs_cached_block) +
+				F2FS_BLKSIZE(sbi))) >> PAGE_SHIFT;
+		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
+	} else if (type == NODE_BLOCK) {
+		mem_size = (NODE_CACHE(sbi)->num_entries *
+				(sizeof(struct f2fs_cached_block) +
+				F2FS_BLKSIZE(sbi))) >> PAGE_SHIFT;
+		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else {
 		if (!bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return true;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 2704a5c6a54d..ff1f04864391 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -158,6 +158,8 @@ enum mem_type {
 	AGE_EXTENT_CACHE,	/* indicates age extent cache */
 	DISCARD_CACHE,	/* indicates memory of cached discard cmds */
 	COMPRESS_BLOCK,	/* indicates memory of cached compressed blocks */
+	META_BLOCK,	/* indicates memory of cached meta blocks */
+	NODE_BLOCK,	/* indicates memory of cached node blocks */
 	BASE_CHECK,	/* check kernel status */
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 794e0d99fc7c..dab66ab3311d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -510,6 +510,14 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 		f2fs_shrink_age_extent_tree(sbi,
 				AGE_EXTENT_CACHE_SHRINK_NUMBER);
 
+	/* try to shrink meta cache when there is no enough memory */
+	if (!f2fs_available_free_memory(sbi, META_BLOCK))
+		f2fs_shrink_meta_cache(sbi, METADATA_CACHE_SHRINK_NUMBER);
+
+	/* try to shrink node cache when there is no enough memory */
+	if (!f2fs_available_free_memory(sbi, NODE_BLOCK))
+		f2fs_shrink_node_cache(sbi, METADATA_CACHE_SHRINK_NUMBER);
+
 	/* check the # of cached NAT entries */
 	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES))
 		f2fs_try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK(sbi));
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
