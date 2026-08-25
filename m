Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53118C61DCA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYvUcMwBF34JIbSxrN+y7d13rU3ENIfUV2THdQkrGkY=; b=aVEp9YkB3UgSJiYgMAFJFXzxt2
	NkAGquk1Q2WkjzzsU8uMu3EhVgjoMgyf2Ds8mfe3FqchhwAR66nyxJ1JK3ql7p/0xmyuZDuieDWWV
	PwBjRouOvyLw0ekw6GZ5he74G1HV5evTebarXKcTCGCpBtGcBevn0qZyCvZDdD4OYPCs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyqn8-0002dj-1X;
	Tue, 25 Aug 2026 13:02:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyqn4-0002d8-Fs
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Eaq43fz5iKrCQFVYf00mn/GiUyrZL2+SlSu90UH7ZNw=; b=MaDgbl/vtDAvQwsXSuzdlMa5zl
 MiazDuHKY8jGZOgudyQVRPE5tIeD+FoErQtX/AfnF5gD7oxnE2fBcs/EzuI+sgSiVw2S0el6ZUzO7
 59qPQhUlD7zl62EIH3ryxkurSdVQQNaC5FAi4EDwarUb6yDNy2/lVTcYPkJNl9nIST7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Eaq43fz5iKrCQFVYf00mn/GiUyrZL2+SlSu90UH7ZNw=; b=kToVCh8m+89KXXlX+ZG92YbxvW
 MF4EgX3cYNThwGaAZnbNbfGtrmfeG3POqNw3Q4MRdEgZmXKoCTTC0fZI2ULIW/97BPpk4RAsqX8sd
 lJXtLS4L/jHCeKe2Hso8jIKHsb6OTp288H0uEudZjX8NADpCF/WogHYmADWH2PUHI87k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyqn1-0004ZG-0F for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B554143E7F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 13:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B771D1F00ACA;
 Tue, 25 Aug 2026 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787662921;
 bh=Eaq43fz5iKrCQFVYf00mn/GiUyrZL2+SlSu90UH7ZNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MoNgqvwsfMuDMC/2A1R9bfpQM53pXpMCReQ3LFEo61ENL3/HyHY7GLa5VNbV7G/q2
 yOVuGVu9z9Z7oG7Bj5ZuDMkDkMptJMlsJYebdwAgZ0hS2TjkankWDW2UWToXa/UUwR
 Kaj1DkNpbG74zkkYCFeCjZtWf/MF61dP0FOggYv6Isr02DVbIueAAZEqKN8gmaL9cP
 MbLKuolvRmTlwBKBGplDTLb47Or26B1r3sJImeCiNVA7VxU3BLPI6/DEE2IIKkJdZq
 jZIj4cRqZtrwNcONTJrMNgq/5OFYDA6xwqWvP/1pPKUkstKEuiNJMKseZHAuQzi+CJ
 +/04EsQSf1RPw==
To: jaegeuk@kernel.org
Date: Tue, 25 Aug 2026 21:01:25 +0800
Message-ID: <20260825130126.2078627-12-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260825130126.2078627-1-chao@kernel.org>
References: <20260825130126.2078627-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyqn1-0004ZG-0F
Subject: [f2fs-dev] [PATCH v3 11/12] f2fs: cache: introduce tracepoints
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

This patch introduces ftrace tracepoints to observe and profile metadata
cache operations:
- trace_f2fs_cache_set_dirty to trace marking a cached block dirty
- trace_f2fs_write_cache to trace single block writeback submission
- trace_f2fs_write_caches to tracesbatch writeback and sync sessions

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c             |  3 ++
 fs/f2fs/checkpoint.c        |  6 ++++
 fs/f2fs/segment.c           |  3 ++
 include/trace/events/f2fs.h | 71 +++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 013433ce96dc..2c53a57c187e 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -15,6 +15,7 @@
 #include "f2fs.h"
 #include "cache.h"
 #include "node.h"
+#include <trace/events/f2fs.h>
 #include "segment.h"
 
 void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
@@ -76,6 +77,8 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 		enum count_type type = IS_META_CACHE(cache) ?
 				F2FS_DIRTY_META : F2FS_DIRTY_NODES;
 
+		trace_f2fs_cache_set_dirty(entry,
+				IS_META_CACHE(cache) ? META : NODE);
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_NONE,
 						F2FS_CACHE_TAG_DIRTY);
 		inc_page_count(cache->sbi, type);
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fc7cbb60a95e..9191d2f834bb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -551,6 +551,8 @@ static bool __f2fs_write_meta_cache(struct f2fs_cached_block *entry,
 {
 	struct f2fs_sb_info *sbi = entry->cache->sbi;
 
+	trace_f2fs_write_cache(entry, META);
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
 			f2fs_force_clear_cache_dirty(entry);
@@ -609,6 +611,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 	struct blk_plug plug;
 	bool background = nr_to_write != LONG_MAX;
 
+	trace_f2fs_write_caches(sbi, nr_to_write, 0, META);
+
 	blk_start_plug(&plug);
 
 	while ((nr = f2fs_cache_gang_lookup_tag(META_CACHE(sbi), entries,
@@ -664,6 +668,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 
 	blk_finish_plug(&plug);
 
+	trace_f2fs_write_caches(sbi, nr_to_write, nwritten, META);
+
 	return nwritten;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 853e6777cab2..8946b2e71d09 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4171,6 +4171,9 @@ void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 {
 	struct f2fs_summary sum;
 
+	if (fio->is_cache)
+		trace_f2fs_write_cache(fio->cache_entry, NODE);
+
 	set_summary(&sum, nid, 0, 0);
 	do_write_page(&sum, fio);
 
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
