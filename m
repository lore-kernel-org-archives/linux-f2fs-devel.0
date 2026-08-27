Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C48CC61DCD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RsYT4/RB48L4ECB5zt+Xo489lQ2nfiAYSki9+sTIZeU=; b=GyONSpzVUkAyQFjNs4x49CYlQS
	3W0L2w6XtuMl1vY0yqh0CGEyCmuAAqWMwtEiuZEWSKBdgsNPWtrMnSQNUL3OM/FSW5Y7wudkc2ppC
	n6v0MGB7my36KxPgzqVD4b8q4wEcDyTlTlX7NluyOa9BFzktsTrQjBJMCK0fZl/1BwOg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzZB8-0001gs-MW;
	Thu, 27 Aug 2026 12:25:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzZB7-0001gl-0c
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qtY75oKpnmSMhe+lnnh/YrgzUIGpvN/ZhEhEP7FjjzM=; b=I3Vf5GGYwDH+nQqk7GuUwZxHLf
 FEkK2JpukNU9zrM7PVKpD7afZ4+IHiCMvVc2iNtObthCir//ctwrGedUfqGdpWbDoaRU8Ex4d/NVG
 wZWZomJWGLu4+SKyHAQ6lDucueBf7JzbSfnI7Uqf3rg/CIiMEgbFmwHogLIzhiOlpq1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qtY75oKpnmSMhe+lnnh/YrgzUIGpvN/ZhEhEP7FjjzM=; b=DVIrBZH+9MC3WJ4nVWK11PKXIM
 VkGRBP5gf203pYdOn+PpFmHW43WBfy3TkUm+j2OrYrNvfM3SEgbuv7aOxzaJTU+N2K23PvLPh7uqy
 uPYVLiHtb/1eV3q6MEaZmLpBDTfKPL22hgQUbvYaDGWMbZ1q/lxixp/3RKPl9+91RG0Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzZB5-0006Bf-AS for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:25:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E114B41E4C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3B41F00A3A;
 Thu, 27 Aug 2026 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787833549;
 bh=qtY75oKpnmSMhe+lnnh/YrgzUIGpvN/ZhEhEP7FjjzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OgZP/OBPAJ0UyjK2Qhu1HgHxQR07aTje0OuVOuPK8QqACTExPuxy2NBUt+0AOkEyR
 k36gYwBxS1gFOQzEYAT8/BJzAVcjLXcfOVN/DLgbs3/y27ewxAHlgKp5rW8e3h8Vi2
 pFs9AmufnZ2PEk5fSdCrdqqSJJs9XEQIyplmx4bTpftInQmBarUxRRMcdUCpejMJKj
 bz6nh2+jpEbMTPCi/3BXTUzbrRHy0Ra5vxuDcVgZyvdVsCyW9ZuFd9ol6htK8pYx4i
 vM99eXdLW0Qog3DiKElEv75XlOnNA2j3SMuJoek5yidbEnafcJ1X3xxzc0HIlLK3QC
 PC+QM/y36oSeQ==
To: jaegeuk@kernel.org
Date: Thu, 27 Aug 2026 20:25:29 +0800
Message-ID: <20260827122541.19967-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827122541.19967-1-chao@kernel.org>
References: <20260827122541.19967-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wzZB5-0006Bf-AS
Subject: [f2fs-dev] [PATCH v4 01/12] f2fs: cache: implement metadata cache
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

This patch introduces the core metadata block caching infrastructure to
manage f2fs metadata independently of the page cache.

It implements:
- core cache APIs: get, create, put, drop, backed by a radix tree and
  a single global LRU list.
- support multiple status of cached block: LOCKED, UPTODATE, DIRTY,
  WRITEBACK, INLINE.
- internal bio based read/write helpers with adjacent block vector merging.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/Makefile |   2 +-
 fs/f2fs/cache.c  | 562 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h  | 182 +++++++++++++++
 fs/f2fs/data.c   | 282 +++++++++++++++++++++---
 fs/f2fs/f2fs.h   |  24 ++
 fs/f2fs/iostat.h |  11 +
 6 files changed, 1035 insertions(+), 28 deletions(-)
 create mode 100644 fs/f2fs/cache.c
 create mode 100644 fs/f2fs/cache.h

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 8a7322d229e4..fbf49c30b066 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
 
 f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
 f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
-f2fs-y		+= shrinker.o extent_cache.o sysfs.o
+f2fs-y		+= shrinker.o extent_cache.o sysfs.o cache.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
new file mode 100644
index 000000000000..a1a73fa84320
--- /dev/null
+++ b/fs/f2fs/cache.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Google LLC
+ * Author: Chao Yu <chaseyu@google.com>
+ */
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+#include <linux/radix-tree.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/pagemap.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+#include <linux/delay.h>
+#include "f2fs.h"
+#include "cache.h"
+#include "node.h"
+#include "segment.h"
+
+void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
+					enum page_type type)
+{
+	/* in case the entry was truncated or on-going shrink */
+	if (!entry->cache)
+		return;
+
+	if (!f2fs_cache_test_writeback(entry))
+		return;
+
+	/* submit cached bio */
+	f2fs_submit_merged_write_cache(entry, type);
+
+	wait_on_bit_io(&entry->state, F2FS_BLOCK_WRITEBACK,
+					TASK_UNINTERRUPTIBLE);
+}
+
+void f2fs_cache_wait_writeback(struct f2fs_cached_block *entry)
+{
+	/* in case the entry was truncated or on-going shrink */
+	if (!entry->cache)
+		return;
+
+	f2fs_cache_wait_writeback_cond(entry,
+			IS_META_CACHE(entry->cache) ? META : NODE);
+}
+
+static void f2fs_cache_update_tag(struct f2fs_cached_block *entry,
+		unsigned int clear_from, unsigned int set_to)
+{
+	struct f2fs_cached_block_list *cache = entry->cache;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	if (clear_from != F2FS_CACHE_TAG_NONE)
+		radix_tree_tag_clear(&cache->root, entry->index, clear_from);
+	if (set_to != F2FS_CACHE_TAG_NONE)
+		radix_tree_tag_set(&cache->root, entry->index, set_to);
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+}
+
+bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
+{
+	struct f2fs_cached_block_list *cache = entry->cache;
+
+	f2fs_cache_set_uptodate(entry);
+
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (cache->type == F2FS_NODE_CACHE && IS_INODE(cache_folio(entry)))
+		f2fs_inode_chksum_set(cache->sbi, cache_folio(entry));
+#endif
+
+	if (f2fs_cache_test_dirty(entry))
+		return false;
+
+	if (!f2fs_cache_test_and_set_dirty(entry)) {
+		enum count_type type = IS_META_CACHE(cache) ?
+				F2FS_DIRTY_META : F2FS_DIRTY_NODES;
+
+		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_NONE,
+						F2FS_CACHE_TAG_DIRTY);
+		inc_page_count(cache->sbi, type);
+		return true;
+	}
+
+	return false;
+}
+
+bool f2fs_clear_cache_dirty(struct f2fs_cached_block *entry)
+{
+	if (!f2fs_cache_test_dirty(entry))
+		return false;
+
+	f2fs_cache_clear_dirty(entry);
+	return true;
+}
+
+static void __drop_cache_dirty(struct f2fs_cached_block *entry, bool force)
+{
+
+	struct f2fs_cached_block_list *cache = entry->cache;
+	enum count_type type = IS_META_CACHE(cache) ?
+				F2FS_DIRTY_META : F2FS_DIRTY_NODES;
+
+	f2fs_cache_clear_uptodate(entry);
+
+	if (!force && !f2fs_clear_cache_dirty(entry))
+		return;
+
+	f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
+					F2FS_CACHE_TAG_NONE);
+	dec_page_count(cache->sbi, type);
+}
+
+void f2fs_drop_cache_dirty(struct f2fs_cached_block *entry)
+{
+	__drop_cache_dirty(entry, false);
+}
+
+void f2fs_force_clear_cache_dirty(struct f2fs_cached_block *entry)
+{
+	__drop_cache_dirty(entry, true);
+}
+
+void f2fs_start_cache_writeback(struct f2fs_cached_block *entry)
+{
+	f2fs_cache_set_writeback(entry);
+	f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
+				F2FS_CACHE_TAG_WRITEBACK);
+}
+
+void f2fs_end_cache_writeback(struct f2fs_cached_block *entry)
+{
+	/*
+	 * should call f2fs_cache_update_tag() before clearing writeback bit,
+	 * in case f2fs_truncate_cache() set entry->cache to NULL.
+	 */
+	f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_WRITEBACK,
+						F2FS_CACHE_TAG_NONE);
+	clear_and_wake_up_bit(F2FS_BLOCK_WRITEBACK, &entry->state);
+}
+
+static int f2fs_cache_refcount(struct f2fs_cached_block *entry)
+{
+	return atomic_read(&entry->refcount);
+}
+
+static void __f2fs_free_cache(struct f2fs_cached_block *entry)
+{
+	kfree(entry->data);
+	kfree(entry);
+}
+
+static void f2fs_free_cache(struct f2fs_cached_block *entry)
+{
+	WARN_ON_ONCE(!list_empty(&entry->list));
+	WARN_ON_ONCE(f2fs_cache_refcount(entry));
+	__f2fs_free_cache(entry);
+}
+
+void f2fs_cache_get(struct f2fs_cached_block *entry)
+{
+	atomic_inc(&entry->refcount);
+}
+
+static bool f2fs_cache_put(struct f2fs_cached_block *entry)
+{
+	WARN_ON_ONCE(!f2fs_cache_refcount(entry));
+	if (atomic_dec_and_test(&entry->refcount)) {
+		f2fs_free_cache(entry);
+		return true;
+	}
+	return false;
+}
+
+static struct f2fs_cached_block *f2fs_create_cache(
+		struct f2fs_cached_block_list *cache,
+		unsigned long index, bool nofail)
+{
+	struct f2fs_cached_block *entry;
+	unsigned int flags = GFP_NOFS;
+
+	if (index == ULONG_MAX)
+		return ERR_PTR(-ERANGE);
+
+	if (nofail)
+		flags |= __GFP_NOFAIL;
+
+	entry = kzalloc_obj(*entry, flags);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->data = kmalloc(cache->sbi->blocksize, flags);
+	if (!entry->data) {
+		kfree(entry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	entry->index = index;
+
+	atomic_set(&entry->refcount, 0);
+	entry->next_entry = NULL;
+	INIT_LIST_HEAD(&entry->list);
+
+	entry->cache = cache;
+
+	return entry;
+}
+
+static struct f2fs_cached_block *f2fs_insert_cache(
+			struct f2fs_cached_block_list *cache,
+			unsigned long index,
+			struct f2fs_cached_block *new)
+{
+	struct f2fs_cached_block *e;
+	int ret;
+	unsigned long flags;
+
+	ret = radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
+	f2fs_bug_on(cache->sbi, ret);
+
+	spin_lock(&cache->list_lock);
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	e = radix_tree_lookup(&cache->root, index);
+	if (!e) {
+		e = new;
+		f2fs_bug_on(cache->sbi, f2fs_cache_refcount(e));
+
+		ret = radix_tree_insert(&cache->root, index, e);
+		f2fs_bug_on(cache->sbi, ret);
+
+		/* radix tree referenced cache entry */
+		f2fs_cache_get(e);
+		f2fs_bug_on(cache->sbi, !list_empty(&e->list));
+		list_add_tail(&e->list, &cache->lru_list);
+		cache->num_entries++;
+	}
+	f2fs_cache_get(e);
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	spin_unlock(&cache->list_lock);
+	radix_tree_preload_end();
+
+	if (new != e) {
+		f2fs_bug_on(cache->sbi, f2fs_cache_refcount(new));
+		__f2fs_free_cache(new);
+	}
+
+	return e;
+}
+
+struct f2fs_cached_block *f2fs_find_cache(
+			struct f2fs_cached_block_list *cache,
+			unsigned long index,
+			enum f2fs_cache_request_flag rflag)
+{
+	struct f2fs_cached_block *entry;
+	unsigned long flags;
+	bool update_lru = rflag & F2FS_CACHE_ACCESS;
+
+	if (update_lru)
+		spin_lock(&cache->list_lock);
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	entry = radix_tree_lookup(&cache->root, index);
+	if (entry) {
+		f2fs_bug_on(cache->sbi, !f2fs_cache_refcount(entry));
+		f2fs_cache_get(entry);
+		if (update_lru && !list_empty(&entry->list))
+			list_move_tail(&entry->list, &cache->lru_list);
+
+	} else {
+		entry = ERR_PTR(-ENOENT);
+	}
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	if (update_lru)
+		spin_unlock(&cache->list_lock);
+
+	return entry;
+}
+
+struct f2fs_cached_block *f2fs_grab_cache(
+			struct f2fs_cached_block_list *cache,
+			unsigned long index, int flags)
+
+{
+	struct f2fs_cached_block *entry, *new;
+	bool create = flags & F2FS_CACHE_CREATE;
+	bool nofail = flags & F2FS_CACHE_NOFAIL;
+	bool lock = flags & F2FS_CACHE_LOCK;
+
+repeat:
+	entry = f2fs_find_cache(cache, index, F2FS_CACHE_ACCESS);
+	if (!IS_ERR(entry))
+		goto found;
+
+	if (!create)
+		return ERR_PTR(-ENOENT);
+
+	new = f2fs_create_cache(cache, index, nofail);
+	if (IS_ERR(new))
+		return new;
+
+	entry = f2fs_insert_cache(cache, index, new);
+found:
+	if (lock) {
+		f2fs_lock_cache(entry);
+		/* has been truncated */
+		if (entry->cache != cache) {
+			f2fs_put_cache(entry, true);
+			goto repeat;
+		}
+	}
+	return entry;
+}
+
+bool f2fs_trylock_cache(struct f2fs_cached_block *entry)
+{
+	return !test_and_set_bit(F2FS_BLOCK_LOCKED, &entry->state);
+}
+
+void f2fs_lock_cache(struct f2fs_cached_block *entry)
+{
+	wait_on_bit_lock(&entry->state, F2FS_BLOCK_LOCKED,
+					TASK_UNINTERRUPTIBLE);
+}
+
+void f2fs_unlock_cache(struct f2fs_cached_block *entry)
+{
+	clear_and_wake_up_bit(F2FS_BLOCK_LOCKED, &entry->state);
+}
+
+bool f2fs_put_cache(struct f2fs_cached_block *entry, bool unlock)
+{
+	if (IS_ERR_OR_NULL(entry))
+		return false;
+	if (unlock)
+		f2fs_unlock_cache(entry);
+	return f2fs_cache_put(entry);
+}
+
+unsigned int f2fs_cache_gang_lookup(struct f2fs_cached_block_list *cache,
+				struct f2fs_cached_block **entries,
+				pgoff_t *index, unsigned long end)
+{
+	unsigned long flags;
+	unsigned int max_nr = min((unsigned long)F2FS_ONSTACK_CACHES, end - *index);
+	int nr, i;
+
+	if (*index >= end || *index == ULONG_MAX)
+		return 0;
+
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	nr = radix_tree_gang_lookup(&cache->root, (void **)entries,
+				*index, max_nr);
+	if (!nr)
+		goto out_unlock;
+
+	for (i = 0; i < nr; i++) {
+		struct f2fs_cached_block *entry = entries[i];
+
+		if (entry->index >= end) {
+			nr = i;
+			break;
+		}
+		f2fs_cache_get(entry);
+	}
+	if (nr)
+		*index = entries[nr - 1]->index + 1;
+out_unlock:
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	return nr;
+}
+
+unsigned int f2fs_cache_gang_lookup_tag(struct f2fs_cached_block_list *cache,
+				struct f2fs_cached_block **entries,
+				pgoff_t *index, unsigned int max_nr,
+				int tag)
+{
+	unsigned long flags;
+	int nr, i;
+
+	if (*index == ULONG_MAX)
+		return 0;
+
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	nr = radix_tree_gang_lookup_tag(&cache->root, (void **)entries,
+				*index, max_nr, tag);
+	if (!nr)
+		goto out;
+
+	for (i = 0; i < nr; i++)
+		f2fs_cache_get(entries[i]);
+	*index = entries[nr - 1]->index + 1;
+out:
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	return nr;
+}
+
+void f2fs_cache_gang_release(struct f2fs_cached_block **entries,
+				unsigned int nr_entries)
+{
+	int i;
+
+	for (i = 0; i < nr_entries; i++)
+		f2fs_put_cache(entries[i], false);
+}
+
+void f2fs_cache_wait_on_all_writeback(struct f2fs_cached_block_list *cache)
+{
+	unsigned long index = 0;
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
+	int nr, i;
+
+next:
+	nr = f2fs_cache_gang_lookup_tag(cache, entries, &index,
+			F2FS_ONSTACK_CACHES, F2FS_CACHE_TAG_WRITEBACK);
+	if (!nr)
+		return;
+
+	for (i = 0; i < nr; i++)
+		f2fs_cache_wait_writeback(entries[i]);
+	f2fs_cache_gang_release(entries, nr);
+
+	cond_resched();
+	goto next;
+}
+
+static void f2fs_do_truncate_cache(struct f2fs_cached_block *entry,
+						bool drop_dirty)
+{
+	struct f2fs_cached_block_list *cache = entry->cache;
+	unsigned long flags;
+
+	if (!drop_dirty &&
+		(f2fs_cache_test_dirty(entry) ||
+		f2fs_cache_test_writeback(entry)))
+		return;
+
+	f2fs_cache_wait_writeback(entry);
+	f2fs_drop_cache_dirty(entry);
+
+	spin_lock(&cache->list_lock);
+	spin_lock_irqsave(&cache->tree_lock, flags);
+
+	f2fs_bug_on(cache->sbi, !entry->cache);
+	if (!radix_tree_delete(&cache->root, entry->index))
+		f2fs_bug_on(cache->sbi, !entry->cache);
+
+	entry->cache = NULL;
+	cache->num_entries--;
+
+	atomic_dec(&entry->refcount);
+	f2fs_bug_on(cache->sbi, !f2fs_cache_refcount(entry));
+
+	f2fs_bug_on(cache->sbi, list_empty(&entry->list));
+	list_del_init(&entry->list);
+
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	spin_unlock(&cache->list_lock);
+}
+
+void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty)
+{
+	if (!entry->cache)
+		return;
+	f2fs_do_truncate_cache(entry, drop_dirty);
+}
+
+static void f2fs_truncate_cache_locked(struct f2fs_cached_block *entry, bool drop_dirty)
+{
+	f2fs_lock_cache(entry);
+	f2fs_truncate_cache(entry, drop_dirty);
+	f2fs_unlock_cache(entry);
+}
+
+static void f2fs_drop_cache(struct f2fs_cached_block_list *cache,
+			block_t blkaddr, bool drop_dirty)
+{
+	struct f2fs_cached_block *entry;
+
+	entry = f2fs_find_cache(cache, blkaddr, 0);
+	if (IS_ERR(entry))
+		return;
+
+	f2fs_truncate_cache_locked(entry, drop_dirty);
+	f2fs_put_cache(entry, false);
+}
+
+void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
+		unsigned long start, unsigned long len, bool drop_dirty)
+{
+	unsigned long index = start;
+	unsigned long end = (ULONG_MAX - start < len) ?
+				ULONG_MAX : (start + len);
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
+	int nr, i;
+
+	if (len == 1)
+		return f2fs_drop_cache(cache, index, drop_dirty);
+
+next:
+	nr = f2fs_cache_gang_lookup(cache, entries, &index, end);
+	if (!nr)
+		return;
+
+	for (i = 0; i < nr; i++)
+		f2fs_truncate_cache_locked(entries[i], drop_dirty);
+	f2fs_cache_gang_release(entries, nr);
+
+	if (index < end) {
+		cond_resched();
+		goto next;
+	}
+}
+
+int f2fs_init_cache(struct f2fs_sb_info *sbi,
+		struct f2fs_cached_block_list *cache,
+		enum f2fs_cache_type type)
+{
+	cache->sbi = sbi;
+	cache->type = type;
+	INIT_RADIX_TREE(&cache->root, GFP_ATOMIC);
+	spin_lock_init(&cache->tree_lock);
+	spin_lock_init(&cache->list_lock);
+	INIT_LIST_HEAD(&cache->lru_list);
+	cache->num_entries = 0;
+
+	return 0;
+}
+
+void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
+{
+	struct list_head *head = &cache->lru_list;
+	struct f2fs_cached_block *entry;
+	unsigned long flags;
+
+	f2fs_cache_wait_on_all_writeback(cache);
+next:
+	spin_lock(&cache->list_lock);
+	if (list_empty(head)) {
+		spin_unlock(&cache->list_lock);
+		return;
+	}
+	entry = list_first_entry(head, struct f2fs_cached_block, list);
+
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	radix_tree_delete(&cache->root, entry->index);
+	cache->num_entries--;
+	list_del_init(&entry->list);
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+
+	spin_unlock(&cache->list_lock);
+
+	/* wait on read cache IO */
+	f2fs_lock_cache(entry);
+	/* wait on write cache IO */
+	f2fs_cache_wait_writeback(entry);
+	f2fs_bug_on(cache->sbi, f2fs_cache_test_dirty(entry));
+	f2fs_bug_on(cache->sbi, f2fs_cache_test_writeback(entry));
+	f2fs_bug_on(cache->sbi, !list_empty(&entry->list));
+	f2fs_bug_on(cache->sbi, f2fs_cache_refcount(entry) != 1);
+	f2fs_put_cache(entry, true);
+	goto next;
+}
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
new file mode 100644
index 000000000000..0e201a36fcd5
--- /dev/null
+++ b/fs/f2fs/cache.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Google LLC
+ * Author: Chao Yu <chaseyu@google.com>
+ */
+#ifndef _LINUX_F2FS_CACHE_H
+#define _LINUX_F2FS_CACHE_H
+
+#include <linux/pagemap.h>
+#include <linux/mm.h>
+#include <linux/list.h>
+#include <linux/radix-tree.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/types.h>
+
+struct f2fs_rwsem;
+struct f2fs_io_info;
+enum page_type;
+
+/* Represents a single cached block (meta, node) */
+struct f2fs_cached_block {
+	struct list_head list;		/* LRU list head */
+	struct f2fs_cached_block_list *cache;	/* parent cache list */
+	struct f2fs_cached_block *next_entry;	/* chain for merged BIO */
+	unsigned long index;		/* key in radix tree, (meta: pba, node: nid) */
+	unsigned long state;		/* cache entry state (e.g., Dirty, UpToDate) */
+	void *data;			/* blocksize-aligned memory (4KB or 16KB) */
+	atomic_t refcount;		/* reference count */
+};
+
+struct f2fs_sb_info;
+
+enum f2fs_cache_type {
+	F2FS_META_CACHE,
+	F2FS_NODE_CACHE,
+};
+
+/* Main cache control structure (per sb_info) */
+struct f2fs_cached_block_list {
+	struct f2fs_sb_info *sbi;	/* Pointer to f2fs_sb_info */
+	struct radix_tree_root root;	/* Radix tree for cache lookup */
+	spinlock_t tree_lock;		/* Lock for radix tree */
+	struct list_head lru_list;	/* Single global LRU list */
+	spinlock_t list_lock;		/* Lock for LRU list */
+	enum f2fs_cache_type type;	/* Cache type (Node or Meta) */
+	unsigned long num_entries;	/* Current number of entries */
+};
+
+#define IS_META_CACHE(cache) (cache->type == F2FS_META_CACHE)
+
+/* Flags for f2fs_cached_block state */
+enum f2fs_cached_state {
+	F2FS_BLOCK_LOCKED,		/* cache entry is locked */
+	F2FS_BLOCK_UPTODATE,		/* cache data is valid */
+	F2FS_BLOCK_DIRTY,		/* cache data is dirty, need to writeback the data */
+	F2FS_BLOCK_WRITEBACK,		/* cache data is writeback state */
+	F2FS_BLOCK_INLINE_DATA,		/* indicate inline data */
+};
+
+enum {
+	__F2FS_CACHE_CREATE,		/* create the cache if there is no cache entry */
+	__F2FS_CACHE_LOCK,		/* get and lock the cache entry */
+	__F2FS_CACHE_NOFAIL,		/* do not allow failure */
+	__F2FS_CACHE_ACCESS,		/* relocate the entry in lru list */
+};
+
+enum f2fs_cache_request_flag {
+	F2FS_CACHE_CREATE	= 1 << __F2FS_CACHE_CREATE,
+	F2FS_CACHE_LOCK		= 1 << __F2FS_CACHE_LOCK,
+	F2FS_CACHE_NOFAIL	= 1 << __F2FS_CACHE_NOFAIL,
+	F2FS_CACHE_ACCESS	= 1 << __F2FS_CACHE_ACCESS,
+};
+
+#define F2FS_CACHE_LOCK_CREATE	(F2FS_CACHE_LOCK | F2FS_CACHE_CREATE)
+
+#define F2FS_ONSTACK_CACHES		(32)
+
+#define F2FS_CACHE_FLAG_TEST_FUNC(name, flagname)			\
+static inline bool f2fs_cache_test_##name(				\
+			const struct f2fs_cached_block *entry)		\
+{									\
+	return test_bit(F2FS_BLOCK_##flagname, &entry->state);		\
+}									\
+
+#define F2FS_CACHE_FLAG_SET_FUNC(name, flagname)			\
+static inline void f2fs_cache_set_##name(				\
+			struct f2fs_cached_block *entry)		\
+{									\
+	set_bit(F2FS_BLOCK_##flagname, &entry->state);			\
+}									\
+
+#define F2FS_CACHE_FLAG_CLEAR_FUNC(name, flagname)			\
+static inline void f2fs_cache_clear_##name(				\
+			struct f2fs_cached_block *entry)		\
+{									\
+	clear_bit(F2FS_BLOCK_##flagname, &entry->state);		\
+}									\
+
+#define F2FS_CACHE_FLAG_TEST_AND_SET_FUNC(name, flagname)		\
+static inline bool f2fs_cache_test_and_set_##name(			\
+			struct f2fs_cached_block *entry)		\
+{									\
+	return test_and_set_bit(F2FS_BLOCK_##flagname, &entry->state);	\
+}									\
+
+F2FS_CACHE_FLAG_TEST_FUNC(locked, LOCKED);
+F2FS_CACHE_FLAG_SET_FUNC(locked, LOCKED);
+F2FS_CACHE_FLAG_CLEAR_FUNC(locked, LOCKED);
+
+F2FS_CACHE_FLAG_TEST_FUNC(uptodate, UPTODATE);
+F2FS_CACHE_FLAG_SET_FUNC(uptodate, UPTODATE);
+F2FS_CACHE_FLAG_CLEAR_FUNC(uptodate, UPTODATE);
+
+F2FS_CACHE_FLAG_TEST_FUNC(dirty, DIRTY);
+F2FS_CACHE_FLAG_SET_FUNC(dirty, DIRTY);
+F2FS_CACHE_FLAG_CLEAR_FUNC(dirty, DIRTY);
+F2FS_CACHE_FLAG_TEST_AND_SET_FUNC(dirty, DIRTY);
+
+F2FS_CACHE_FLAG_TEST_FUNC(writeback, WRITEBACK);
+F2FS_CACHE_FLAG_SET_FUNC(writeback, WRITEBACK);
+F2FS_CACHE_FLAG_CLEAR_FUNC(writeback, WRITEBACK);
+
+F2FS_CACHE_FLAG_TEST_FUNC(inline, INLINE_DATA);
+F2FS_CACHE_FLAG_SET_FUNC(inline, INLINE_DATA);
+F2FS_CACHE_FLAG_CLEAR_FUNC(inline, INLINE_DATA);
+
+static inline void *cache_address(const struct f2fs_cached_block *entry)
+{
+	return entry->data;
+}
+
+#define CACHED_NODE(entry)	((struct f2fs_node *)(cache_address(entry)))
+
+static inline struct folio *cache_folio(const struct f2fs_cached_block *entry)
+{
+	return virt_to_folio(entry->data);
+}
+
+int f2fs_init_cache(struct f2fs_sb_info *sbi,
+				struct f2fs_cached_block_list *cache,
+				enum f2fs_cache_type type);
+void f2fs_destroy_cache(struct f2fs_cached_block_list *cache);
+void f2fs_cache_get(struct f2fs_cached_block *entry);
+struct f2fs_cached_block *f2fs_find_cache(
+			struct f2fs_cached_block_list *cache,
+			unsigned long index,
+			enum f2fs_cache_request_flag rflag);
+#define F2FS_CACHE_TAG_NONE		0
+#define F2FS_CACHE_TAG_DIRTY		1
+#define F2FS_CACHE_TAG_WRITEBACK	2
+
+bool f2fs_trylock_cache(struct f2fs_cached_block *entry);
+void f2fs_lock_cache(struct f2fs_cached_block *entry);
+void f2fs_unlock_cache(struct f2fs_cached_block *entry);
+bool f2fs_put_cache(struct f2fs_cached_block *entry, bool unlock);
+bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry);
+bool f2fs_clear_cache_dirty(struct f2fs_cached_block *entry);
+void f2fs_drop_cache_dirty(struct f2fs_cached_block *entry);
+void f2fs_force_clear_cache_dirty(struct f2fs_cached_block *entry);
+void f2fs_start_cache_writeback(struct f2fs_cached_block *entry);
+void f2fs_end_cache_writeback(struct f2fs_cached_block *entry);
+unsigned int f2fs_cache_gang_lookup(struct f2fs_cached_block_list *cache,
+				struct f2fs_cached_block **entries,
+				pgoff_t *index, unsigned long end);
+unsigned int f2fs_cache_gang_lookup_tag(struct f2fs_cached_block_list *cache,
+		struct f2fs_cached_block **results, pgoff_t *first_index,
+		unsigned int max_items, int tag);
+void f2fs_cache_gang_release(struct f2fs_cached_block **entries,
+				unsigned int nr_entries);
+int f2fs_writeback_cache(struct f2fs_cached_block_list *cache, bool sync);
+void f2fs_cache_wait_on_all_writeback(struct f2fs_cached_block_list *cache);
+void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
+					enum page_type type);
+void f2fs_cache_wait_writeback(struct f2fs_cached_block *entry);
+struct f2fs_cached_block *f2fs_grab_cache(struct f2fs_cached_block_list *cache,
+				unsigned long index, int flags);
+void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty);
+void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
+		unsigned long start, unsigned long len, bool drop_dirty);
+
+#endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6ae0eb37d20f..75ab768bb4f7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -41,11 +41,6 @@ struct f2fs_folio_state {
 	unsigned int		read_pages_pending;
 };
 
-struct f2fs_bio {
-	struct work_struct work;
-	struct bio bio;
-};
-
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
 int __init f2fs_init_bioset(void)
@@ -69,7 +64,6 @@ bool f2fs_is_cp_guaranteed(const struct folio *folio)
 		return folio_test_f2fs_gcing(fscrypt_pagecache_folio(folio));
 
 	inode = mapping->host;
-	sbi = F2FS_I_SB(inode);
 
 	if (inode->i_ino == F2FS_META_INO(sbi) ||
 			inode->i_ino == F2FS_NODE_INO(sbi) ||
@@ -437,6 +431,65 @@ static void f2fs_write_end_io(struct bio *bio)
 	}
 }
 
+static void f2fs_cache_read_end_io(struct bio *bio)
+{
+	struct f2fs_cached_block *entry = F2FS_BIO(bio)->entry;
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
+	enum count_type io_type = IS_META_CACHE(entry->cache) ?
+					F2FS_RD_META : F2FS_RD_NODE;
+	struct f2fs_cached_block *next;
+
+	iostat_update_and_unbind_ctx(bio);
+
+	if (time_to_inject(sbi, FAULT_READ_IO))
+		bio->bi_status = BLK_STS_IOERR;
+
+	while (entry) {
+		next = entry->next_entry;
+		entry->next_entry = NULL;
+
+		if (bio->bi_status == BLK_STS_OK)
+			f2fs_cache_set_uptodate(entry);
+
+		dec_page_count(sbi, io_type);
+
+		f2fs_unlock_cache(entry);
+		entry = next;
+	}
+	bio_put(bio);
+}
+
+static void f2fs_cache_write_end_io(struct bio *bio)
+{
+	struct f2fs_cached_block *entry = F2FS_BIO(bio)->entry;
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
+	struct f2fs_cached_block *next;
+
+	iostat_update_and_unbind_ctx(bio);
+
+	if (time_to_inject(sbi, FAULT_WRITE_IO))
+		bio->bi_status = BLK_STS_IOERR;
+
+	if (bio->bi_status != BLK_STS_OK)
+		f2fs_stop_checkpoint(sbi, true,
+			STOP_CP_REASON_WRITE_FAIL);
+
+	while (entry) {
+		next = entry->next_entry;
+		entry->next_entry = NULL;
+
+		dec_page_count(sbi, F2FS_WB_CP_DATA);
+
+		if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
+				wq_has_sleeper(&sbi->cp_wait))
+			wake_up(&sbi->cp_wait);
+
+		f2fs_end_cache_writeback(entry);
+		entry = next;
+	}
+	bio_put(bio);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static void f2fs_zone_write_end_io(struct bio *bio)
 {
@@ -444,7 +497,10 @@ static void f2fs_zone_write_end_io(struct bio *bio)
 
 	bio->bi_private = io->bi_private;
 	complete(&io->zone_wait);
-	f2fs_write_end_io(bio);
+	if (f2fs_is_cache_bio(bio))
+		f2fs_cache_write_end_io(bio);
+	else
+		f2fs_write_end_io(bio);
 }
 #endif
 
@@ -531,12 +587,21 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
 	bio->bi_iter.bi_sector = sector;
+	F2FS_BIO(bio)->entry = NULL;
+	bio->bi_private = NULL;
 	if (is_read_io(fio->op)) {
-		bio->bi_end_io = f2fs_read_end_io;
-		bio->bi_private = NULL;
+		if (fio->is_cache)
+			bio->bi_end_io = f2fs_cache_read_end_io;
+		else
+			bio->bi_end_io = f2fs_read_end_io;
 	} else {
-		bio->bi_end_io = f2fs_write_end_io;
-		bio->bi_private = sbi;
+		if (fio->is_cache) {
+			bio->bi_end_io = f2fs_cache_write_end_io;
+		} else {
+			bio->bi_end_io = f2fs_write_end_io;
+			bio->bi_private = sbi;
+		}
+
 		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
 						fio->type, fio->temp);
 		bio->bi_write_stream = f2fs_io_type_to_write_stream(bdev, fio->type,
@@ -559,7 +624,7 @@ static void f2fs_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 	 * The f2fs garbage collector sets ->encrypted_page when it wants to
 	 * read/write raw data without encryption.
 	 */
-	if (!fio || !fio->encrypted_page)
+	if (!fio || (!fio->encrypted_page && !fio->is_cache))
 		fscrypt_set_bio_crypt_ctx(bio, inode,
 				(loff_t)first_idx << inode->i_blkbits,
 				gfp_mask);
@@ -769,6 +834,53 @@ void f2fs_submit_merged_write_folio(struct f2fs_sb_info *sbi,
 	__submit_merged_write_cond(sbi, NULL, folio, 0, type, true);
 }
 
+static bool __has_merged_cache(struct bio *bio,
+		struct f2fs_cached_block *target)
+{
+	struct f2fs_cached_block *entry;
+
+	if (!bio)
+		return false;
+
+	entry = F2FS_BIO(bio)->entry;
+
+	while (entry) {
+		if (target && entry == target)
+			return true;
+		entry = entry->next_entry;
+	}
+	return false;
+}
+
+bool f2fs_submit_merged_write_cache(struct f2fs_cached_block *entry,
+				enum page_type type)
+{
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
+	enum temp_type temp;
+	bool ret = false;
+
+	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
+		enum page_type btype = PAGE_TYPE_OF_BIO(type);
+		struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
+		struct f2fs_lock_context lc;
+		bool merged;
+
+		f2fs_down_read_trace(&io->io_rwsem, &lc);
+		merged = __has_merged_cache(io->bio, entry);
+		f2fs_up_read_trace(&io->io_rwsem, &lc);
+
+		if (merged) {
+			__f2fs_submit_merged_write(sbi, type, temp);
+			ret = true;
+		}
+
+		/* TODO: use HOT temp only for meta pages now. */
+		if (type >= META)
+			break;
+	}
+	return ret;
+}
+
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
 {
 	f2fs_submit_merged_write(sbi, DATA);
@@ -832,6 +944,8 @@ static bool io_type_is_mergeable(struct f2fs_bio_info *io,
 
 	if (io->fio.op != fio->op)
 		return false;
+	if (io->fio.is_cache != fio->is_cache)
+		return false;
 	return (io->fio.op_flags & mask) == (fio->op_flags & mask);
 }
 
@@ -1063,6 +1177,33 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
 		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
 		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
 }
+
+static void f2fs_wait_zone_io_completion(struct f2fs_sb_info *sbi,
+			struct f2fs_bio_info *io, enum page_type btype)
+{
+	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
+		wait_for_completion_io(&io->zone_wait);
+		bio_put(io->zone_pending_bio);
+		io->zone_pending_bio = NULL;
+		io->bi_private = NULL;
+	}
+}
+
+static void f2fs_submit_zone_io(struct f2fs_sb_info *sbi,
+			struct f2fs_io_info *fio, struct f2fs_bio_info *io,
+			enum page_type btype)
+{
+	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
+			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
+		bio_get(io->bio);
+		reinit_completion(&io->zone_wait);
+		io->bi_private = io->bio->bi_private;
+		io->bio->bi_private = io;
+		io->bio->bi_end_io = f2fs_zone_write_end_io;
+		io->zone_pending_bio = io->bio;
+		__submit_merged_bio(io);
+	}
+}
 #endif
 
 void f2fs_submit_page_write(struct f2fs_io_info *fio)
@@ -1079,14 +1220,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_down_write_trace(&io->io_rwsem, &lc);
 next:
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
-		wait_for_completion_io(&io->zone_wait);
-		bio_put(io->zone_pending_bio);
-		io->zone_pending_bio = NULL;
-		io->bi_private = NULL;
-	}
+	f2fs_wait_zone_io_completion(sbi, io, btype);
 #endif
-
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
@@ -1141,16 +1276,109 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	trace_f2fs_submit_folio_write(fio->folio, fio);
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
-			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
-		bio_get(io->bio);
-		reinit_completion(&io->zone_wait);
-		io->bi_private = io->bio->bi_private;
-		io->bio->bi_private = io;
-		io->bio->bi_end_io = f2fs_zone_write_end_io;
-		io->zone_pending_bio = io->bio;
+	f2fs_submit_zone_io(sbi, fio, io, btype);
+#endif
+
+	if (fio->in_list)
+		goto next;
+out:
+	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
+				!f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
+	f2fs_up_write_trace(&io->io_rwsem, &lc);
+}
+
+static void f2fs_bio_add_cache(struct f2fs_io_info *fio, struct bio *bio)
+{
+	struct f2fs_bio *fbio = F2FS_BIO(bio);
+	struct f2fs_cached_block *head = fbio->entry;
+	struct f2fs_cached_block *new = fio->cache_entry;
+
+	new->next_entry = head;
+	fbio->entry = new;
+}
+
+int f2fs_submit_cache_read(struct f2fs_io_info *fio)
+{
+	struct f2fs_sb_info *sbi = fio->sbi;
+	struct f2fs_cached_block *entry = fio->cache_entry;
+	struct bio *bio;
+	enum count_type io_type = IS_META_CACHE(entry->cache) ?
+				F2FS_RD_META : F2FS_RD_NODE;
+
+	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
+			fio->is_por ? META_POR : (__is_meta_io(fio) ?
+			META_GENERIC : DATA_GENERIC_ENHANCE)))
+		return -EFSCORRUPTED;
+
+	bio = __bio_alloc(fio, 1);
+
+	bio_add_virt_nofail(bio, cache_address(entry), sbi->blocksize);
+	f2fs_bio_add_cache(fio, bio);
+	inc_page_count(sbi, io_type);
+
+	f2fs_submit_read_bio(sbi, bio, fio->type);
+	return 0;
+}
+
+void f2fs_submit_cache_write(struct f2fs_io_info *fio)
+{
+	struct f2fs_sb_info *sbi = fio->sbi;
+	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
+	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
+	struct f2fs_lock_context lc;
+	struct folio *folio;
+
+	f2fs_bug_on(sbi, is_read_io(fio->op));
+
+	f2fs_down_write_trace(&io->io_rwsem, &lc);
+next:
+#ifdef CONFIG_BLK_DEV_ZONED
+	f2fs_wait_zone_io_completion(sbi, io, btype);
+#endif
+	if (fio->in_list) {
+		spin_lock(&io->io_lock);
+		if (list_empty(&io->io_list)) {
+			spin_unlock(&io->io_lock);
+			goto out;
+		}
+		fio = list_first_entry(&io->io_list,
+						struct f2fs_io_info, list);
+		list_del(&fio->list);
+		spin_unlock(&io->io_lock);
 	}
+
+	verify_fio_blkaddr(fio);
+
+	fio->submitted = 1;
+	inc_page_count(sbi, F2FS_WB_CP_DATA);
+
+	if (io->bio &&
+	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
+			      fio->new_blkaddr)))
+		__submit_merged_bio(io);
+alloc_new:
+	if (io->bio == NULL) {
+		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
+		io->fio = *fio;
+	}
+
+	folio = cache_folio(fio->cache_entry);
+
+	if (!bio_add_folio(io->bio, folio, sbi->blocksize,
+			offset_in_folio(folio, cache_address(fio->cache_entry)))) {
+		f2fs_bug_on(sbi, !F2FS_BIO(io->bio)->entry);
+
+		__submit_merged_bio(io);
+		goto alloc_new;
+	}
+
+	f2fs_bio_add_cache(fio, io->bio);
+
+	io->last_block_in_bio = fio->new_blkaddr;
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	f2fs_submit_zone_io(sbi, fio, io, btype);
 #endif
 	if (fio->in_list)
 		goto next;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16720f1f0a9c..84ee4601126d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -222,6 +222,8 @@ struct f2fs_rwsem {
 #endif
 };
 
+#include "cache.h"
+
 struct f2fs_mount_info {
 	unsigned long long opt;
 	block_t root_reserved_blocks;	/* root reserved blocks */
@@ -1372,8 +1374,10 @@ struct f2fs_io_info {
 	unsigned int is_por:1;		/* indicate IO is from recovery or not */
 	unsigned int encrypted:1;	/* indicate file is encrypted */
 	unsigned int meta_gc:1;		/* require meta inode GC */
+	unsigned int is_cache:1;	/* indicate IO is from internal cache */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
+	struct f2fs_cached_block *cache_entry;
 	struct bio **bio;		/* bio for ipu */
 	sector_t *last_block;		/* last block number in bio */
 };
@@ -1783,6 +1787,12 @@ struct f2fs_gc_kthread {
 	unsigned int boost_gc_greedy;
 };
 
+struct f2fs_bio {
+	struct work_struct work;
+	struct f2fs_cached_block *entry;
+	struct bio bio;
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -2326,6 +2336,16 @@ static inline bool is_node_folio(struct folio *folio)
 	return folio->mapping == NODE_MAPPING(F2FS_F_SB(folio));
 }
 
+static inline struct f2fs_bio *F2FS_BIO(struct bio *bio)
+{
+	return container_of(bio, struct f2fs_bio, bio);
+}
+
+static inline bool f2fs_is_cache_bio(struct bio *bio)
+{
+	return F2FS_BIO(bio)->entry != NULL;
+}
+
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	return test_bit(type, &sbi->s_flag);
@@ -4241,6 +4261,8 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				nid_t ino, enum page_type type);
 void f2fs_submit_merged_write_folio(struct f2fs_sb_info *sbi,
 				struct folio *folio, enum page_type type);
+bool f2fs_submit_merged_write_cache(struct f2fs_cached_block *entry,
+				enum page_type type);
 void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 					struct bio **bio, struct folio *folio);
 void f2fs_submit_all_merged_ipu_writes(struct f2fs_sb_info *sbi);
@@ -4248,6 +4270,8 @@ void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 int f2fs_merge_page_bio(struct f2fs_io_info *fio);
 void f2fs_submit_page_write(struct f2fs_io_info *fio);
+int f2fs_submit_cache_read(struct f2fs_io_info *fio);
+void f2fs_submit_cache_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 		block_t blk_addr, sector_t *sector);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 2025225b5bed..61c6bc8e3119 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -60,6 +60,13 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
+static inline void iostat_set_post_read_ctx(struct bio *bio, void *ctx)
+{
+	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+
+	iostat_ctx->post_read_ctx = ctx;
+}
+
 extern void iostat_update_and_unbind_ctx(struct bio *bio);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
@@ -81,6 +88,10 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 {
 	return bio->bi_private;
 }
+static inline void iostat_set_post_read_ctx(struct bio *bio, void *ctx)
+{
+	bio->bi_private = ctx;
+}
 static inline int f2fs_init_iostat_processing(void) { return 0; }
 static inline void f2fs_destroy_iostat_processing(void) {}
 static inline int f2fs_init_iostat(struct f2fs_sb_info *sbi) { return 0; }
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
