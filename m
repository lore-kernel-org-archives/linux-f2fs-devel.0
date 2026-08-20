Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96380C5DF82
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qxUOOi8WN/fTxLtscDSop9BC55GGkeAXhy1omrTEeTc=; b=XLj3YJmdAM8Rc4zQtgOVVNhSK5
	GSAd64UWpm84Yx1A0DE6hyU2Ssc4e3conrp030NAjIIYwLkFrb3IklLs9W8tOjl97dYSbba3dw1Cn
	Zl6YyRVWyrMCdE7Xpzs7Ug1LpF4vg55s2v3J+49bu5RzTSVgV/5Vr+fy2yLt89px8lwk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwtI8-0002Lw-2O;
	Thu, 20 Aug 2026 03:18:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwtHa-0002L1-7R
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DBhyx4V5iXIIxkrBe1Zk+wOfEnZ7kMO0AsYJ8bSWiHI=; b=nCG8JCnaJj6H/wdcKSLz1ScYZC
 JMfyfztQbMCxPPN0v9oaj2ZyClVqEOwWrHXixTbDIqxIs9w5QFDTGP5gDMMCbpIHhf/Ci8cW0NU5C
 HJ1m8OJpCIvSfyUYQUbX9+aS/HMcu/M7bR0fp1mi+kh+Rii+6eHo+h3s3+xJGdAbJOYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DBhyx4V5iXIIxkrBe1Zk+wOfEnZ7kMO0AsYJ8bSWiHI=; b=E
 Lspi35w4oaLX9sR9ZFGhQtw9DWRChh8QEMNZk2HPAzP8dXlprH+j3QcFVcYTdMPxDA8GAOqM4BeBi
 GWo7SxYP44SVNTCJZYvwGjeJw0rDvcGZk6j7ZUXg+8dOInd+GxYzjdkODQ7iT/OU0C7zaD4eGIY42
 F3ZbxE0oajTXARaM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwtHa-0000x4-3f for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D51061887
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D89F1F000E9;
 Thu, 20 Aug 2026 03:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787195847;
 bh=DBhyx4V5iXIIxkrBe1Zk+wOfEnZ7kMO0AsYJ8bSWiHI=;
 h=From:To:Cc:Subject:Date;
 b=mWIFHL8YHPdEIJ0L6zVOX4BV97Na4Jd68nTZRMdO4EsStiqEzXr2TnCHPUgb4iw+B
 UyMkc6Ek4VfumohdC5eGMud6rnc0YDzZY8aQ1T4zhP0WCyiCxGJcZQSp+CtP2zLL/4
 Aj2tDLy3e3u3PTzFWW18kijEIlAavnRy/WIHbqor78B7IIplCgPlPJbqrVUhDci1Qd
 lX5Qsg3lBs6yyjGewo/fXbXyLruv90erCYGDDUjyfE6MN6wOm2DXJhBhFSMa40Cr71
 TYpDQ7glbiFsjxfBynK4QGcKY+iQfuOavJhC+gIP0SOUmEpUwK3E4vSUPNMfmnWKFr
 TJQM+ihb1lG8g==
To: jaegeuk@kernel.org
Date: Thu, 20 Aug 2026 11:17:09 +0800
Message-ID: <20260820031721.12218-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
MIME-Version: 1.0
X-Headers-End: 1wwtHa-0000x4-3f
Subject: [f2fs-dev] [PATCH v1 00/12] f2fs: introduce metadata cache
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

3. Lock Contention:
   Multiple independent node blocks (e.g., dnode blocks belonging to
   different files) can reside within the same folio. Concurrent fsync()
   calls on unrelated files would contend on the same folio_lock(),
   serializing metadata updates and degrading multi-threaded performance.

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

 fs/f2fs/Makefile            |   2 +-
 fs/f2fs/acl.c               |  26 +-
 fs/f2fs/acl.h               |   8 +-
 fs/f2fs/cache.c             | 690 +++++++++++++++++++++++++
 fs/f2fs/cache.h             | 224 ++++++++
 fs/f2fs/checkpoint.c        | 404 +++++++--------
 fs/f2fs/compress.c          | 171 +++----
 fs/f2fs/data.c              | 527 +++++++++++++------
 fs/f2fs/debug.c             |  70 ++-
 fs/f2fs/dir.c               | 168 +++---
 fs/f2fs/extent_cache.c      |  14 +-
 fs/f2fs/f2fs.h              | 333 ++++++------
 fs/f2fs/file.c              |  78 ++-
 fs/f2fs/gc.c                | 178 ++++---
 fs/f2fs/inline.c            | 284 ++++++-----
 fs/f2fs/inode.c             | 205 +++-----
 fs/f2fs/iostat.h            |  11 +
 fs/f2fs/namei.c             | 118 ++---
 fs/f2fs/node.c              | 994 +++++++++++++++++-------------------
 fs/f2fs/node.h              | 109 ++--
 fs/f2fs/recovery.c          | 253 ++++-----
 fs/f2fs/segment.c           | 263 +++++-----
 fs/f2fs/segment.h           |  39 +-
 fs/f2fs/shrinker.c          |  13 +
 fs/f2fs/super.c             | 143 +++---
 fs/f2fs/xattr.c             | 123 +++--
 fs/f2fs/xattr.h             |  12 +-
 include/linux/f2fs_fs.h     |   3 -
 include/trace/events/f2fs.h |  71 +++
 29 files changed, 3331 insertions(+), 2203 deletions(-)
 create mode 100644 fs/f2fs/cache.c
 create mode 100644 fs/f2fs/cache.h

-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
