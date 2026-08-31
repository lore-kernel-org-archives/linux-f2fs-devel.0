Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E23FC624C6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XSgpNwMsUPKEf9ZNqB7Qfa2R0k0oszhgrYALj0iNyFI=; b=bsBUv/Q0gP9cUcPkFERnqS7IS5
	WL9kHWv5QHjCrpWGyS4FB+2OoN5rR63yYBDC5znJWH2U9VSuDKP2dbJn24WndpJhgSAEI/Pd3uDH+
	0K8iJXughUgqnY0speB070Ck435Nr7ebojyCNR3QCjI3LxUOs/t/s8EitVTnzOjjYxhI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0yEG-0006yF-Et;
	Mon, 31 Aug 2026 09:23:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0yE3-0006xH-7J
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nCvnrC11N1Lbiz0D/QpPRQ8mxbXQcTTZVHktCnp3uwA=; b=c50NB/fZ4mtTnS3qVsXZ6m2wQ6
 kKD//tIieq3PEXoePEEOi0dFgfU/uuUTe20rre4tODnS6dPN9SkVws2py3TTFiA1khiomE1PJwRzR
 4zxekzFzQySgcAPVF9UhKe8eUmpK2uTfum4mgFLh/R/bsjMgyfPDUpr7m5DwgdOxESOU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nCvnrC11N1Lbiz0D/QpPRQ8mxbXQcTTZVHktCnp3uwA=; b=f
 G71rbRjzzi7Y6C5hyJSeZSzGlIvhpg8QZAV0E0IULODurIjIf0gP82IPTL5DcYX9T93YUgZAlUCXQ
 q2r2Izp8jELhmjD29ujK3nlf6TkALa3TCz7iSg4dE5O7FAihoo0yR0/nasiClRAJ1N/GzuqK43AAg
 JeTrOOW05dToZ4iY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0yE2-0006yF-9E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7444D60120
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E67E1F00A3D;
 Mon, 31 Aug 2026 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168160;
 bh=nCvnrC11N1Lbiz0D/QpPRQ8mxbXQcTTZVHktCnp3uwA=;
 h=From:To:Cc:Subject:Date;
 b=SWmsC2XVX2mbOQ3VhG+Xvt9gq9zCrzit2v7OBnsWAkF2UyJrqG295HOF4xSbeyjWi
 0QLAqoOmB1zU0rEVWMQ4aelQaMqJMZg85m3qmQ24o5VHpqXaQH+uIwCOOloe347riZ
 Lb0s+fYYz3XQCqepm/K6UEuFnpbNRV0s15Qd6/fU66RJl56GR3FxwTx7IdlDNmWJ6V
 8wwBJaQ/UA94pVJsugWRlag2WO35h5jLjlzlwScUSvdBNwP6BXaUfx/XvZmHcIWmTC
 K8c6jriuBrJtw3HZVnqkK+UJExf96jqZYCLbKaLs80Fgmc96hCjRCVAIy+DmiEVlns
 3uQaJ+bjMtC8A==
To: jaegeuk@kernel.org
Date: Mon, 31 Aug 2026 17:22:15 +0800
Message-ID: <20260831092227.739737-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
MIME-Version: 1.0
X-Headers-End: 1x0yE2-0006yF-9E
Subject: [f2fs-dev] [PATCH v5 00/12] f2fs: introduce metadata cache
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

This patchset introduces a self-managed metadata block cache in f2fs,
decoupling meta blocks, node blocks, and compressed data blocks from
the Linux VFS page cache and fake internal inodes.

=== 1. Background & Motivation ===

Currently, F2FS uses fake VFS inodes (meta_inode, node_inode, and
compress_inode) to manage internal block caching through the VFS page
cache. Because of this implementation, the f2fs block size was
historically coupled to the kernel page size.

We now want to unbind block size from page size to support configurations
where block size <= PAGE_SIZE (e.g., mounting a 4KB-block F2FS image on a
16KB or 64KB page system).

One possible approach is to continue using the VFS page cache to store
metadata blocks. However, doing so introduces three major architectural
issues (illustrated by a 4KB block on a 16KB page system):

1. Memory Overhead:
   Metadata access patterns are typically random and sparse. Caching a
   single 4KB metadata block inside a page cache folio forces the
   allocation of an entire 16KB folio, resulting in 4x memory waste.

2. Folio and Sub-block Conversion Complexity:
   Using larger folios requires tracking individual sub-block dirty/uptodate
   states within each folio and performing index-to-offset conversions across
   function boundaries. Because core metadata structures (e.g., f2fs_checkpoint,
   f2fs_sit_block, f2fs_nat_block, f2fs_summary_block, f2fs_node) are accessed
   extensively throughout the filesystem, this sub-block management and offset
   calculation complexity would spread across the entire F2FS codebase.

3. Lock Contention:
   Multiple independent node blocks (e.g., dnode blocks belonging to
   different files) can reside within the same folio. Concurrent fsync()
   calls on unrelated files would contend on the same folio_lock(),
   serializing metadata updates and degrading multi-threaded performance.

Decoupling metadata caching from PAGE_SIZE by allocating exact
block-sized cache entries is the critical first step toward supporting
4KB-block F2FS images on 16KB/64KB page systems.

=== 2. Metadata Cache Architecture & Design ===

This patchset introduces a dedicated, block-size-aligned caching
infrastructure with the following key components:

- Block-Size Aligned Allocation:
  Allocates memory buffers matching exactly the filesystem block size
  (4KB or 16KB) via kzalloc(), fully independent of the host
  architecture's PAGE_SIZE.

- Radix Tree Indexing with Fast Tag Scanning:
  Each cache instance (META_CACHE, NODE_CACHE, COMPRESS_CACHE) indexes
  cached blocks via a radix tree (keyed by Physical Block Address for meta/
  compress cache, and Node ID for node cache). Radix tree tags
  (F2FS_CACHE_TAG_DIRTY, F2FS_CACHE_TAG_WRITEBACK) provide O(1) batch gang
  lookups for flushing and writeback without dual-list shuffling.

- Lightweight Bit-Locking:
  Individual entries use atomic bit locks (F2FS_BLOCK_LOCKED via
  wait_on_bit_lock() / clear_and_wake_up_bit()) rather than heavyweight
  embedded mutexes/semaphores, minimizing memory footprint per entry.

- Direct BIO Read/Write & BIO Merging:
  Decouples metadata/node I/O from VFS address spaces by submitting direct
  BIOs (f2fs_submit_cache_read / f2fs_submit_cache_write) with chained
  adjacent vector merging (entry->next_entry) and dedicated completion
  handlers.

- Memory Reclamation Shrinker:
  Integrates with the kernel shrinker subsystem via a 3-phase isolation
  algorithm (isolate unreferenced clean entries -> truncate from radix tree
  under lock -> splice un-reclaimed entries back to LRU) to safely reclaim
  clean cached blocks under system memory pressure.

- Background Writeback Kthread & Checkpoint Integration:
  Provides a dedicated background kthread (f2fs_writeback-X:Y) for periodic
  dirty cache flushing, combined with synchronous flushing during checkpoint
  commit.

- Fault Injection, Tracepoints & Debugfs Observability:
  Integrates FAULT_KALLOC fault injection, tracepoints for cache state
  transitions and batch writeback, and per-cache memory breakdowns in debugfs.

=== 3. Patchset Organization ===

- Patch 01: Implement the core metadata cache infrastructure & direct BIO I/O.
- Patch 02: Initialize and teardown META_CACHE in sb_info.
- Patch 03: Integrate metadata cache into the memory shrinker subsystem.
- Patch 04: Introduce the background writeback kernel thread.
- Patch 05: Migrate metadata block caching (SIT, NAT, SSA, CP, recovery, GC)
            from meta_inode to META_CACHE.
- Patch 06: Initialize and teardown NODE_CACHE in sb_info.
- Patch 07: Migrate node and inode block caching from node_inode to NODE_CACHE.
- Patch 08: Initialize and teardown COMPRESS_CACHE in sb_info.
- Patch 09: Migrate compressed cluster caching from compress_inode to COMPRESS_CACHE.
- Patch 10: Add fault injection support for cache allocation paths.
- Patch 11: Introduce ftrace tracepoints for cache dirty and writeback events.
- Patch 12: Expose per-cache memory usage in debugfs.

Changelog:

v4->v5:
- rebase the code to 7.3-rc1
- introduce F2FS_CACHE_ACCESS and F2FS_CACHE_REFERENCED to give another
  chance to rotate to list tail
- remove f2fs_bug_on(sbi, !f2fs_is_compress_cache(entry)) in
  f2fs_invalidate_compress_pages()
- use f2fs_cache_test_and_clear_dirty instead of f2fs_clear_cache_dirty
- check scanned w/ cache->num_entries in f2fs_do_shrink_cache()

Chao Yu (12):
  f2fs: cache: implement metadata cache
  f2fs: cache: initialize meta cache
  f2fs: cache: introduce shrinker
  f2fs: cache: introduce writeback thread
  f2fs: cache: use meta cache
  f2fs: cache: initialize node cache
  f2fs: cache: use node cache
  f2fs: cache: initialize compress cache
  f2fs: cache: use compress cache
  f2fs: cache: support fault injection
  f2fs: cache: introduce tracepoints
  f2fs: cache: show per-cache usage in debugfs

 Documentation/ABI/testing/sysfs-fs-f2fs |    6 +
 fs/f2fs/Makefile                        |    2 +-
 fs/f2fs/acl.c                           |   26 +-
 fs/f2fs/acl.h                           |    8 +-
 fs/f2fs/cache.c                         |  713 ++++++++++++++++
 fs/f2fs/cache.h                         |  240 ++++++
 fs/f2fs/checkpoint.c                    |  398 ++++-----
 fs/f2fs/compress.c                      |  158 ++--
 fs/f2fs/data.c                          |  518 ++++++++----
 fs/f2fs/debug.c                         |   70 +-
 fs/f2fs/dir.c                           |  170 ++--
 fs/f2fs/extent_cache.c                  |   14 +-
 fs/f2fs/f2fs.h                          |  335 ++++----
 fs/f2fs/file.c                          |   78 +-
 fs/f2fs/gc.c                            |  185 +++--
 fs/f2fs/inline.c                        |  284 +++----
 fs/f2fs/inode.c                         |  205 ++---
 fs/f2fs/iostat.h                        |   11 +
 fs/f2fs/namei.c                         |  114 +--
 fs/f2fs/node.c                          | 1010 +++++++++++------------
 fs/f2fs/node.h                          |  109 ++-
 fs/f2fs/recovery.c                      |  251 +++---
 fs/f2fs/segment.c                       |  259 +++---
 fs/f2fs/segment.h                       |   39 +-
 fs/f2fs/shrinker.c                      |   14 +
 fs/f2fs/super.c                         |  143 ++--
 fs/f2fs/sysfs.c                         |   13 +-
 fs/f2fs/xattr.c                         |  123 ++-
 fs/f2fs/xattr.h                         |   12 +-
 include/linux/f2fs_fs.h                 |    3 -
 include/trace/events/f2fs.h             |   71 ++
 31 files changed, 3376 insertions(+), 2206 deletions(-)
 create mode 100644 fs/f2fs/cache.c
 create mode 100644 fs/f2fs/cache.h

-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
