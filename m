Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D070C88E4A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkyQUAj8p0WKioX89m7ERVVeGyEhz4i84LisAo9G/e4=; b=D8C9qKVsoB+rcjaQIxnbnnborA
	xJ34UslNDEpIhYyZvuzZGDujbBRYgmxWyBDp5DMtkuEfPx4KSUrRlzHr7rl3h3PDIVmDu+uPVmuFo
	CJTWVeWbXhyPZEQFfn1/cnHDOYht4EXsST6yhGqNJN36PCgUtvEH+KDPFX7QSzHAW+7k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4owK-0004zV-AL;
	Fri, 11 Sep 2026 00:16:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4ow9-0004zJ-Qx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 00:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ApjyPaf1plzlokk+wZRCiU0tlnM76V6my9B1CMiV+pM=; b=mR0lHwDi5f9dGsyvy+AFU2M3iB
 d2yypSes5UI7Q8AIWn1mF/BK+5JKxA6yKkezfG5yYSbh47aHaFbLJEtW5q3cmOYAdlV5LtgXksaRi
 FXRHBnNOdbgUvn0xIvcL0sZdi3oA7oaMqLqxJk9FDjjzPZAhzBX1Ieq/k5BIDqFIXye0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ApjyPaf1plzlokk+wZRCiU0tlnM76V6my9B1CMiV+pM=; b=hemuoJwgZ/UbcIk2SCgadw3MDO
 8zsb7V9fQIYs1GxnkVdGxZM2rhtQrmnpJNHzZ6ocuvVKN1sp7PoWAGbv5C3qiUyynstEv4gibZ6nm
 7blNRL/uadcSV7HRVbfNRRhDr0bPW5Jz8VX9n3TJ37/vk0vLTDPO4Biz57sFztrzxPIc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4ow9-0002TE-36 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 00:16:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B19D0405D0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 00:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49CA1F000FF;
 Fri, 11 Sep 2026 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789085767;
 bh=ApjyPaf1plzlokk+wZRCiU0tlnM76V6my9B1CMiV+pM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=f551DYE2mQy2xGXqFi8BB3c93S/XPOEFG6EMudDtZGTLxLtcFvHkI31OW/3PNfL98
 MlmAZXPtO9ql52bPVshx9U50t5dZqS75STjCEPf6pjxIEEBFZUy+CbC1crlmtBIIL6
 RKBLPGcPivSTPT4ZrBjH2PSv4XcVN5fTCxTzgWgijSHp3ImpKX3cn7xRz/ylatqi1u
 NAYIVlMp4aDhJQpl5LZ2RsKe8jY/xGBCeKbrhyWHh1LcL+c48igWN6yFxDo5CDm7No
 pOaVlw7ZenaodBkDXNwW/+LW4HxGSJkDCaK64UJTtjvQTiuEZ0+Dh9Dt5f5c1kRfOr
 gLzpCXaq3AM7g==
Message-ID: <3c1f769e-48b5-4c42-b876-48d1762667a9@kernel.org>
Date: Fri, 11 Sep 2026 08:16:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
 <aqMfy0vzj5lzOyde@google.com>
Content-Language: en-US
In-Reply-To: <aqMfy0vzj5lzOyde@google.com>
X-Headers-End: 1x4ow9-0002TE-36
Subject: Re: [f2fs-dev] [PATCH v6 00/12] f2fs: introduce metadata cache
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/11/26 05:23, Jaegeuk Kim wrote:
> Chao, can you take a look at these patches?
> 
> https://github.com/Sys-AI-Foundation/f2fs/commit/e22a482931fb57d8e093e6cc5617f1f0a35539f5
> https://github.com/Sys-AI-Foundation/f2fs/commit/902febb3650c6b5d63bc2d1f1e4a0b28b0796757
> https://github.com/Sys-AI-Foundation/f2fs/commit/4a7dd5420623701c12c814f74a1211a5f86bd89b
> https://github.com/Sys-AI-Foundation/f2fs/commit/f609f4b93bd68e3caabdfaf7442bd196bfca4d21

Jaegeuk, thanks for the cleanup.

Let me take a look, and refactor based on all patches.

Thanks,

> 
> On 09/09, Chao Yu wrote:
>> This patchset introduces a self-managed metadata block cache in f2fs,
>> decoupling meta blocks, node blocks, and compressed data blocks from
>> the Linux VFS page cache and fake internal inodes.
>>
>> === 1. Background & Motivation ===
>>
>> Currently, F2FS uses fake VFS inodes (meta_inode, node_inode, and
>> compress_inode) to manage internal block caching through the VFS page
>> cache. Because of this implementation, the f2fs block size was
>> historically coupled to the kernel page size.
>>
>> We now want to unbind block size from page size to support configurations
>> where block size <= PAGE_SIZE (e.g., mounting a 4KB-block F2FS image on a
>> 16KB or 64KB page system).
>>
>> One possible approach is to continue using the VFS page cache to store
>> metadata blocks. However, doing so introduces three major architectural
>> issues (illustrated by a 4KB block on a 16KB page system):
>>
>> 1. Memory Overhead:
>>     Metadata access patterns are typically random and sparse. Caching a
>>     single 4KB metadata block inside a page cache folio forces the
>>     allocation of an entire 16KB folio, resulting in 4x memory waste.
>>
>> 2. Folio and Sub-block Conversion Complexity:
>>     Using larger folios requires tracking individual sub-block dirty/uptodate
>>     states within each folio and performing index-to-offset conversions across
>>     function boundaries. Because core metadata structures (e.g., f2fs_checkpoint,
>>     f2fs_sit_block, f2fs_nat_block, f2fs_summary_block, f2fs_node) are accessed
>>     extensively throughout the filesystem, this sub-block management and offset
>>     calculation complexity would spread across the entire F2FS codebase.
>>
>> 3. Lock Contention:
>>     Multiple independent node blocks (e.g., dnode blocks belonging to
>>     different files) can reside within the same folio. Concurrent fsync()
>>     calls on unrelated files would contend on the same folio_lock(),
>>     serializing metadata updates and degrading multi-threaded performance.
>>
>> Decoupling metadata caching from PAGE_SIZE by allocating exact
>> block-sized cache entries is the critical first step toward supporting
>> 4KB-block F2FS images on 16KB/64KB page systems.
>>
>> === 2. Metadata Cache Architecture & Design ===
>>
>> This patchset introduces a dedicated, block-size-aligned caching
>> infrastructure with the following key components:
>>
>> - Block-Size Aligned Allocation:
>>    Allocates memory buffers matching exactly the filesystem block size
>>    (4KB or 16KB) via kzalloc(), fully independent of the host
>>    architecture's PAGE_SIZE.
>>
>> - Radix Tree Indexing with Fast Tag Scanning:
>>    Each cache instance (META_CACHE, NODE_CACHE, COMPRESS_CACHE) indexes
>>    cached blocks via a radix tree (keyed by Physical Block Address for meta/
>>    compress cache, and Node ID for node cache). Radix tree tags
>>    (F2FS_CACHE_TAG_DIRTY, F2FS_CACHE_TAG_WRITEBACK) provide O(1) batch gang
>>    lookups for flushing and writeback without dual-list shuffling.
>>
>> - Lightweight Bit-Locking:
>>    Individual entries use atomic bit locks (F2FS_BLOCK_LOCKED via
>>    wait_on_bit_lock() / clear_and_wake_up_bit()) rather than heavyweight
>>    embedded mutexes/semaphores, minimizing memory footprint per entry.
>>
>> - Direct BIO Read/Write & BIO Merging:
>>    Decouples metadata/node I/O from VFS address spaces by submitting direct
>>    BIOs (f2fs_submit_cache_read / f2fs_submit_cache_write) with chained
>>    adjacent vector merging (entry->next_entry) and dedicated completion
>>    handlers.
>>
>> - Memory Reclamation Shrinker:
>>    Integrates with the kernel shrinker subsystem via a 3-phase isolation
>>    algorithm (isolate unreferenced clean entries -> truncate from radix tree
>>    under lock -> splice un-reclaimed entries back to LRU) to safely reclaim
>>    clean cached blocks under system memory pressure.
>>
>> - Background Writeback Kthread & Checkpoint Integration:
>>    Provides a dedicated background kthread (f2fs_writeback-X:Y) for periodic
>>    dirty cache flushing, combined with synchronous flushing during checkpoint
>>    commit.
>>
>> - Fault Injection, Tracepoints & Debugfs Observability:
>>    Integrates FAULT_KALLOC fault injection, tracepoints for cache state
>>    transitions and batch writeback, and per-cache memory breakdowns in debugfs.
>>
>> === 3. Patchset Organization ===
>>
>> - Patch 01: Implement the core metadata cache infrastructure & direct BIO I/O.
>> - Patch 02: Initialize and teardown META_CACHE in sb_info.
>> - Patch 03: Integrate metadata cache into the memory shrinker subsystem.
>> - Patch 04: Introduce the background writeback kernel thread.
>> - Patch 05: Migrate metadata block caching (SIT, NAT, SSA, CP, recovery, GC)
>>              from meta_inode to META_CACHE.
>> - Patch 06: Initialize and teardown NODE_CACHE in sb_info.
>> - Patch 07: Migrate node and inode block caching from node_inode to NODE_CACHE.
>> - Patch 08: Initialize and teardown COMPRESS_CACHE in sb_info.
>> - Patch 09: Migrate compressed cluster caching from compress_inode to COMPRESS_CACHE.
>> - Patch 10: Add fault injection support for cache allocation paths.
>> - Patch 11: Introduce ftrace tracepoints for cache dirty and writeback events.
>> - Patch 12: Expose per-cache memory usage in debugfs.
>>
>> Changelog:
>>
>> v5->v6:
>> - rebase on last dev-test
>> - rely on ("f2fs: parameterize node helpers and macros")
>> - remove unneeded f2fs_cache_test_dirty() check in f2fs_mark_cache_dirty()
>> - drop f2fs_force_clear_cache_dirty()
>> - avoid unnecessary type cast before cache_address() in checkpoint.c
>> - fix to init cache_wb_interval in prior create f2fs_writeback kthread
>> - fix to goto restore_wb label if f2fs_sync_fs() failed in f2fs_remount()
>> - fix to avoid race condition when access entry->ino in between
>>    f2fs_cache_compressed_page() and f2fs_invalidate_compress_pages()
>> - rebase on decoupling patchset from Kelvin
>> - fix to access IS_INODE() and ino_of_inode() under cache lock
>>
>> Chao Yu (12):
>>    f2fs: cache: implement metadata cache
>>    f2fs: cache: initialize meta cache
>>    f2fs: cache: introduce shrinker
>>    f2fs: cache: introduce writeback thread
>>    f2fs: cache: use meta cache
>>    f2fs: cache: initialize node cache
>>    f2fs: cache: use node cache
>>    f2fs: cache: initialize compress cache
>>    f2fs: cache: use compress cache
>>    f2fs: cache: support fault injection
>>    f2fs: cache: introduce tracepoints
>>    f2fs: cache: show per-cache usage in debugfs
>>
>>   Documentation/ABI/testing/sysfs-fs-f2fs |    6 +
>>   fs/f2fs/Makefile                        |    2 +-
>>   fs/f2fs/acl.c                           |   26 +-
>>   fs/f2fs/acl.h                           |    8 +-
>>   fs/f2fs/cache.c                         |  704 ++++++++++++++++
>>   fs/f2fs/cache.h                         |  242 ++++++
>>   fs/f2fs/checkpoint.c                    |  397 ++++-----
>>   fs/f2fs/compress.c                      |  163 ++--
>>   fs/f2fs/data.c                          |  520 ++++++++----
>>   fs/f2fs/debug.c                         |   70 +-
>>   fs/f2fs/dir.c                           |  170 ++--
>>   fs/f2fs/extent_cache.c                  |   14 +-
>>   fs/f2fs/f2fs.h                          |  361 ++++----
>>   fs/f2fs/file.c                          |   78 +-
>>   fs/f2fs/gc.c                            |  185 ++--
>>   fs/f2fs/inline.c                        |  284 +++----
>>   fs/f2fs/inode.c                         |  205 ++---
>>   fs/f2fs/iostat.h                        |   11 +
>>   fs/f2fs/namei.c                         |  114 +--
>>   fs/f2fs/node.c                          | 1023 +++++++++++------------
>>   fs/f2fs/node.h                          |  104 +--
>>   fs/f2fs/recovery.c                      |  251 +++---
>>   fs/f2fs/segment.c                       |  261 +++---
>>   fs/f2fs/segment.h                       |   37 +-
>>   fs/f2fs/shrinker.c                      |   14 +
>>   fs/f2fs/super.c                         |  145 ++--
>>   fs/f2fs/sysfs.c                         |   13 +-
>>   fs/f2fs/xattr.c                         |  123 ++-
>>   fs/f2fs/xattr.h                         |   12 +-
>>   include/linux/f2fs_fs.h                 |    3 -
>>   include/trace/events/f2fs.h             |   71 ++
>>   31 files changed, 3401 insertions(+), 2216 deletions(-)
>>   create mode 100644 fs/f2fs/cache.c
>>   create mode 100644 fs/f2fs/cache.h
>>
>> -- 
>> 2.49.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
