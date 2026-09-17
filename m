Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBFBC982D9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvLteNH099GvyR0eb1PfzutzziH9S1QwBkI/bw7v4/c=; b=FSOYTuNQfFqdPxQ5bqBEOPQrTr
	0JMat/A+EtHq/mZvL2QWvJYH1wtnfb5tpwu0Exj6AerwNkCracNvj/5OtJIMTF5a79Nm26vaLv93J
	Eb0u7gyBre7p8TUG69rRe3VIma8CjnZZi5mmurAqsVYtKvpI7LH3eAQA90hEnO6UFLC0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x76dM-00062q-51;
	Thu, 17 Sep 2026 07:34:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x76dG-00061s-IS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tYamscoLThd9uu6l7yA0TW70/o0I3Ve8SZuTWlu3b3s=; b=BbXzvivbM2teMJ0c1Y8VdQV7aq
 kkT+6KwEEuctmbrLDrHxF4BjcTVhTTTYs6vwyxjLzL7PYKEzedKCnQq+eF7HbuVAunQxAcKpWYNcE
 Pq4QgtmYPs8qF2M0L7rVizjgJqhNOIkwM9E39tCTeQg115m6heyAEnYAoSGPakDrhbOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tYamscoLThd9uu6l7yA0TW70/o0I3Ve8SZuTWlu3b3s=; b=JEPhwQcdVSCqDtVpJV4ReOSVmt
 pJvUpGzfLq4fOzmW8e3na4c5kS4YZqexrdj5d5QBBU8H60erak93+SAGfGUuXCHb0vvXG42uhjuKx
 mfh29W8WYca4RrcUn/fcXSegpOxCDlC91wpIWfmCPiFOdR80v3AK934hf9CsBKJQ/lws=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x76dD-0004Ru-Ss for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:34:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8538F447F2;
 Thu, 17 Sep 2026 07:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818511F000FF;
 Thu, 17 Sep 2026 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630442;
 bh=tYamscoLThd9uu6l7yA0TW70/o0I3Ve8SZuTWlu3b3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dr0QWMJ4KWervRJ95DFlHBVIvNDC4w17WhniZL4a4V+flSX/iXSpvRNqmUX2LNI6J
 xqJzj0xiHmwXF62+DPKPgiVp7O8Dl3B55aTIPegoMly2B1PVUwwdLRs4hSDYbR84Sl
 q4QnITYBmyjdX4sRMedNIvagm5ROz08fppFlBU+IeJ2Cv/I+AevOMwNImbBBXYxujX
 5fWWSjGqPOuNJwnq9spvuvigAdk+m19n8IkAXLZKIcmS6neqU5mw5F4J63LuyYwrqy
 79axGQ4ViFUo2SLval7Dti4IJAw/P28tJQfSu6khbtJ5aIfeJwFR9pVz7nG5jYrfD7
 0j0oXNP9dGSgA==
To: jaegeuk@kernel.org
Date: Thu, 17 Sep 2026 15:33:42 +0800
Message-ID: <20260917073343.2823157-12-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260917073343.2823157-1-chao@kernel.org>
References: <20260917073343.2823157-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x76dD-0004Ru-Ss
Subject: [f2fs-dev] [PATCH v9 11/12] f2fs: cache: introduce tracepoints
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This patch introduces ftrace tracepoints to observe and profile metadata
cache operations:
- trace_f2fs_cache_set_dirty to trace marking a cached block dirty
- trace_f2fs_write_cache to trace single block writeback submission
- trace_f2fs_write_caches to tracesbatch writeback and sync sessions

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c             |  3 ++
 fs/f2fs/checkpoint.c        |  6 ++++
 fs/f2fs/node.c              |  4 +++
 fs/f2fs/segment.c           |  3 ++
 include/trace/events/f2fs.h | 71 +++++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 0814c38b24bc..be0a48cfec6b 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -15,6 +15,7 @@
 #include "f2fs.h"
 #include "cache.h"
 #include "node.h"
+#include <trace/events/f2fs.h>
 #include "segment.h"
 
 void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
@@ -73,6 +74,8 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 		enum count_type type = IS_META_CACHE(cache) ?
 				F2FS_DIRTY_META : F2FS_DIRTY_NODES;
 
+		trace_f2fs_cache_set_dirty(entry,
+				IS_META_CACHE(cache) ? META : NODE);
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_NONE,
 						F2FS_CACHE_TAG_DIRTY);
 		inc_page_count(cache->sbi, type);
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fe7e8bab644b..406bd3b1c77f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -550,6 +550,8 @@ static bool __f2fs_write_meta_cache(struct f2fs_cached_block *entry,
 {
 	struct f2fs_sb_info *sbi = entry->cache->sbi;
 
+	trace_f2fs_write_cache(entry, META);
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
 			f2fs_cache_clear_uptodate(entry);
@@ -611,6 +613,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 	struct blk_plug plug;
 	bool background = nr_to_write != LONG_MAX;
 
+	trace_f2fs_write_caches(sbi, nr_to_write, 0, META);
+
 	blk_start_plug(&plug);
 
 	while ((nr = f2fs_cache_gang_lookup_tag(META_CACHE(sbi), entries,
@@ -666,6 +670,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 
 	blk_finish_plug(&plug);
 
+	trace_f2fs_write_caches(sbi, nr_to_write, nwritten, META);
+
 	return nwritten;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2e57fac39227..0dba5b2d5b51 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2110,6 +2110,8 @@ int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 	int ret = 0;
 	int nr, done = 0;
 
+	trace_f2fs_write_caches(sbi, nr_to_write, 0, NODE);
+
 next_step:
 	index = 0;
 
@@ -2217,6 +2219,8 @@ int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 	if (nwritten)
 		f2fs_submit_merged_write(sbi, NODE);
 
+	trace_f2fs_write_caches(sbi, nr_to_write, nwritten, NODE);
+
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 	return ret;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 87e24d0306e8..15cffbb5b407 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4226,6 +4226,9 @@ void f2fs_do_write_node_cache(unsigned int nid, struct f2fs_io_info *fio)
 {
 	struct f2fs_summary sum;
 
+	if (fio->is_cache)
+		trace_f2fs_write_cache(fio->cache_entry, NODE);
+
 	set_summary(&sum, nid, 0, 0);
 	do_write_block(&sum, fio);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index d53be932df01..df4cd346ae72 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1430,6 +1430,50 @@ DEFINE_EVENT(f2fs__folio, f2fs_set_page_dirty,
 	TP_ARGS(folio, type)
 );
 
+DECLARE_EVENT_CLASS(f2fs__cached_block,
+
+	TP_PROTO(struct f2fs_cached_block *block, int type),
+
+	TP_ARGS(block, type),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(pgoff_t, index)
+		__field(int,	type)
+		__field(int,	dirty)
+		__field(int,	uptodate)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= block->cache->sbi->sb->s_dev;
+		__entry->index	= block->index;
+		__entry->type	= type;
+		__entry->dirty	= f2fs_cache_test_dirty(block);
+		__entry->uptodate = f2fs_cache_test_uptodate(block);
+	),
+
+	TP_printk("dev = (%d,%d), %s, index = %lu, dirty = %d, uptodate = %d",
+		show_dev(__entry->dev),
+		show_block_type(__entry->type),
+		(unsigned long)__entry->index,
+		__entry->dirty,
+		__entry->uptodate)
+);
+
+DEFINE_EVENT(f2fs__cached_block, f2fs_write_cache,
+
+	TP_PROTO(struct f2fs_cached_block *block, int type),
+
+	TP_ARGS(block, type)
+);
+
+DEFINE_EVENT(f2fs__cached_block, f2fs_cache_set_dirty,
+
+	TP_PROTO(struct f2fs_cached_block *block, int type),
+
+	TP_ARGS(block, type)
+);
+
 TRACE_EVENT(f2fs_replace_atomic_write_block,
 
 	TP_PROTO(struct inode *inode, struct inode *cow_inode, pgoff_t index,
@@ -1574,6 +1618,33 @@ TRACE_EVENT(f2fs_writepages,
 		__entry->for_sync)
 );
 
+TRACE_EVENT(f2fs_write_caches,
+
+	TP_PROTO(struct f2fs_sb_info *sbi, long nr_to_write, long nwritten, int type),
+
+	TP_ARGS(sbi, nr_to_write, nwritten, type),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(long,	nr_to_write)
+		__field(long,	nwritten)
+		__field(int,	type)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sbi->sb->s_dev;
+		__entry->nr_to_write	= nr_to_write;
+		__entry->nwritten	= nwritten;
+		__entry->type		= type;
+	),
+
+	TP_printk("dev = (%d,%d), %s, nr_to_write = %ld, nwritten = %ld",
+		show_dev(__entry->dev),
+		show_block_type(__entry->type),
+		__entry->nr_to_write,
+		__entry->nwritten)
+);
+
 TRACE_EVENT(f2fs_readpages,
 
 	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage),
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
