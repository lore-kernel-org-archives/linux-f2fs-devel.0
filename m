Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE29FC44511
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:In-Reply-To:To:From:Mime-Version:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RohRuY9bmzpUgJDf70JZxDnkLraAENu8erxgHi+PMi0=; b=kswtA0zhS1TuogI7OQkYBtr7W2
	Lzwt65Icnlu7l10L6mZu+4mbq6CUB1RDEQjNDwjXMGObbXdoP1gbrmWC64vwQ6nJq+DSh5is6J8id
	14Em+nmg9VlwamMT3mIJalqnq8xR/WQMJwQXwMk+A/KKPjbvaHUx4PqrrKJ+jzU6r+O4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wkFuf-0001F1-Qw;
	Thu, 16 Jul 2026 06:49:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daejun7.park@samsung.com>) id 1wkFue-0001Et-Ek
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 06:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:In-Reply-To:CC:To:From:Sender:Reply-To:Subject:Mime-Version:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xfAHUck5Id3sifble+BPeZfArezjDU1Vs+VON1SkruI=; b=joRKWL/ii2L2OnNb75YINx7t2a
 qn+xBF70gBHg0K8Jfvyt07EgBw8xAGiAUo5xppONXDK/dKkiaZkOoKxRwmKv5SS0CZvVmGTxxTuwG
 K6BNgvSuGI1deeB0gJ9LDCJpj8GREgRwMLKnCKT/18N30FwFx5fMv8KwWYErk+f2w4bg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:
 In-Reply-To:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xfAHUck5Id3sifble+BPeZfArezjDU1Vs+VON1SkruI=; b=nRkfI/TZY+9FKaEzeLPyAfA5kX
 1PAIXgL/q4leWDUlz7Dn6ioBRUtGmyWNwK3SFhK3j908F5yO7NxA0ULMgf416Esu2n0F4/Yj/lleQ
 BZ+erfNBb0/wt2ycXMnHkDnJZ4Lt/U6M5K252wOqdk21DNJzhJwfSc8eNxA3lOFu+oqE=;
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkFud-0001md-7B for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 06:49:41 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260716064932epoutp04df927f3f5cd521f64bdc3204b12ac071~CsmpzgZ-z3223732237epoutp04D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 06:49:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260716064932epoutp04df927f3f5cd521f64bdc3204b12ac071~CsmpzgZ-z3223732237epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1784184572;
 bh=xfAHUck5Id3sifble+BPeZfArezjDU1Vs+VON1SkruI=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=FSG6CXLO+V5BkpN2LDssHOnkoFWpTZlroLSNwir6Xj3NGg4NZ8iz2gyMj2zr09vK+
 vKSyXrxjYese7BDa4PMtXb0HHWu7dh34JWY/O7+lle9leKauUNh2cVg6KvNovj7Esm
 OwloIyucom+q2nqHoONnEucar9JQwOFnzloBwKSQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20260716064932epcas2p10858d68a32916d8f1000c2c4a15bbdae~CsmpeI_9q1726717267epcas2p1O;
 Thu, 16 Jul 2026 06:49:32 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.212]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4h13Yl6mdnz2SSKY; Thu, 16 Jul
 2026 06:49:31 +0000 (GMT)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260716064837epcms2p163a4c4d7be63454c4746261155734d5f@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260716064931epcms2p206db7f955ec3b3fc55e6404dff48859b@epcms2p2>
Date: Thu, 16 Jul 2026 15:49:31 +0900
X-CMS-MailID: 20260716064931epcms2p206db7f955ec3b3fc55e6404dff48859b
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f
References: <20260716064837epcms2p163a4c4d7be63454c4746261155734d5f@epcms2p1>
 <20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f@epcms2p3>
 <CGME20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f@epcms2p2>
X-Headers-End: 1wkFud-0001md-7B
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs: pack same-inode blocks by inode
 during FG_GC
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
Reply-To: daejun7.park@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The legacy FG_GC path migrates a victim section's valid blocks in
source segment-offset order: blocks of several inodes that were
interleaved in each source segment are migrated to the destination
curseg in the same interleaved order, carrying source-side
fragmentation forward into the post-GC layout regardless of section
size.

Pack the migration order by inode for every victim section:

  * gc_data_segment()'s phase 3 records each valid block on a
    per-inode gc_blocks list hanging off the inode_entry that
    add_gc_inode() already creates in gc_list.  Each gc_block
    carries the source segno, nofs, ofs_in_node and per-segment off
    so the deferred migration can rebuild start_bidx and pass the
    correct segno to check_valid_map() inside the existing
    do_migrate_one_data_block() helper.

  * Phase 4 of gc_data_segment() is gated by nr_phases: in packing
    mode nr_phases caps the loop at 4 (phases 0..3), so the summary
    block is not re-scanned just to hit a per-slot 'continue'.  The
    phase 4 migration body is reached only via the new 'goto
    do_migrate' fallback path described below, in which case the
    inode_entry just returned by add_gc_inode() is reused instead of
    repeating find_gc_inode().

  * do_garbage_collect() invokes pack_gc_section() once, after every
    source segment of the victim section has been parsed.  Walking
    gc_list->ilist in inode order emits all of one inode's blocks
    contiguously to the destination curseg.  On large sections this
    lets an inode's blocks span the full SEGS_PER_SEC *
    usable_blks_in_seg destination range.  pack_gc_section()
    re-checks each queued block with check_valid_map() and skips any
    invalidated since phase 3, matching the legacy phase-4 skip so a
    block that went stale is neither migrated nor stat-counted.

  * Because migration is deferred past gc_data_segment()'s
    per-segment loop, the in-loop 'freed:' check can no longer
    observe the emptied source segments: at that point the source is
    still fully valid.  do_garbage_collect() therefore skips the
    in-loop seg_freed count when packing and recomputes seg_freed
    across the scanned range after the pack pass -- counting
    already-empty segments exactly as the legacy 'goto freed' does, so a
    fully reclaimed section reaches seg_freed == f2fs_usable_segs_in_sec().
    Without this, FG_GC reports seg_freed == 0 for a fully packed
    section, so f2fs_gc() never counts the section as reclaimed,
    has_enough_free_secs() keeps looping, and a sync F2FS_IOC_GC returns
    -EAGAIN despite having freed the space.  The recompute runs on the
    freezing path too, so a section emptied by an earlier
    gc_pack_max_blocks drain before the freeze is still counted; any
    already-empty segments counted there feed only the total_freed
    tracepoint, not the sec_freed/-EAGAIN decision (gated on the
    equality).

  * i_gc_rwsem is taken and released per block inside the packing
    pass (via do_migrate_one_data_block), matching the legacy
    phase 4 lock-holding window so concurrent user IO sees no
    additional latency.

Activation conditions:
  * sbi->gc_inode_local_packing == true (sysfs writable, accepts
    only 0 or 1; defaults to 0 -- the feature is opt-in, since a new
    GC behaviour should not be enabled by default)
  * gc_type == FG_GC; BG_GC's move_data_page() path defers
    destination allocation to the writeback flusher, so any
    reordering applied during GC is lost.

Race against the sysfs knob: gc_inode_local_packing is unsynchronised.
Re-reading it from phase 3 (enqueue), phase 4 (skip) and the pack
pass independently would let a concurrent toggle queue blocks via
gc_blocks and then bypass pack_gc_section().  do_garbage_collect()
snapshots the value into a local 'pack_by_inode' bool and threads it
through gc_data_segment() and the packing call so all three sites
remain consistent for the entire section.

On the freezing 'goto stop' path the pack pass is skipped.  f2fs_gc()
reuses one gc_list across the sections it collects in a single call, so
the queued records are dropped by drop_gc_blocks() at the stop: label,
otherwise they could leak into the next section's pack pass.
next_victim_seg is cleared (NULL_SEGNO) so the next FG_GC re-selects a
victim by search rather than resuming past the still-valid source
segments whose blocks were just dropped.

Per-block records are allocated from a dedicated f2fs_gc_block slab
(via f2fs_kmem_cache_create) rather than kmalloc(GFP_NOFS).  To bound
the transient footprint, the queue is drained early once it reaches
gc_pack_max_blocks (sysfs-tunable, default 4096 = ~128 KiB at 32 B per
gc_block, minimum 64; checked at segment boundaries, so the queue can
transiently overshoot the value by up to one segment's blocks) instead
of holding an entire section's worth of records before the first
write: ordinary sections stay under the cap and pack in a single pass,
while a pathologically large section drains in batches.  A per-cache
slabinfo line and FAULT_SLAB_ALLOC coverage of the fallback path are
useful for diagnostics.

Allocation failure falls through to 'goto do_migrate', the same
phase 4 body the !pack_by_inode path uses, so the block is migrated
immediately rather than dropped.  This costs the packing benefit
for the one block but preserves FG_GC progress under memory
pressure, which matters more when FG_GC is called precisely
because the system is short on free sections.

Measurements (QEMU virtio guest, 4-cycle fragmentation, gc_urgent
40s, filefrag total extents before/after GC; structural counters
only since QEMU virtio BW/lat is unreliable):

  Large section (mkfs.f2fs -s 32 = 64 MiB section,
                 64 files x 4 MiB):
    legacy   65536 -> 65536    0 %  reduction
    packed   65536 -> 49170   24 %  reduction (-16366 extents)

  Default section (mkfs.f2fs -s 1 = 2 MiB section,
                   128 files x 256 KiB):
    legacy    8192 ->  8192    0 %  reduction
    packed    8192 ->  7690    6 %  reduction
    GC work (move_blks, cp_blks, gc_calls) identical between modes;
    the packing only reorders dest curseg writes.

  Natural FG_GC under tight cold migration
  (mkfs.f2fs -s 32, 2 GiB disk 90 % fill,
   6 hot x 200 MiB + 6 cold x 100 MiB interleaved fill,
   background_gc=sync, 300 s hot rewrite):
    legacy   cold extents 350 -> 357 (delta +7,  no improvement)
    packed   cold extents 350 -> 132 (delta -218, -63 %  reduction)
    per user iter:
      move_blks         legacy 42344  packed 34822  (-18 %)
      cp_blocks         legacy 23.90  packed 22.95  (-4  %)
      skipped_gc_rwsem  legacy 108    packed   44   (-59 %)

  The move_blks/skipped_gc_rwsem deltas are a second-order effect of
  the defragmentation: packing consolidates each inode's blocks into
  denser cold sections, so those sections drop out of the FG_GC victim
  pool and their cold blocks are re-collected fewer times, and the
  colder victims contend less with the inodes being rewritten.  Lock
  granularity is unchanged (still per block).

seg_freed accounting regression test (QEMU guest, mkfs.f2fs -s 4,
400 x 1 MiB files written sequentially so each 2 MiB segment holds
exactly two files, every even-indexed file deleted so each data
segment is ~50 % valid with no trivially-empty segment -- forcing
GC to free sections by migration, the path this commit defers).
Forced sync F2FS_IOC_GC x24 plus gc_urgent, packing OFF vs ON:

    metric (sum over FG_GC)      packing OFF   packing ON
    f2fs_gc_end seg_freed             152          152
    f2fs_gc_end sec_freed              38           38
    F2FS_IOC_GC(sync) successes        24           24
    data integrity (sha256)            OK           OK

  Without the deferred-migration seg_freed recompute the ON column
  collapses to seg_freed/sec_freed = 0 and all 24 ioctls return
  -EAGAIN, which is the regression this test guards against.

Sanity verified in QEMU guest (mkfs.f2fs -s 8, 16 x 4 MiB files,
gc_urgent + remount): data sha256 matches before and after GC; no
WARN/BUG in dmesg; the gc_inode_local_packing and gc_pack_max_blocks
knobs are exposed under /sys/fs/f2fs/<disk>/.  An additional stress
run on mkfs.f2fs -s 32 with FAULT_SLAB_ALLOC at inject_rate=4
triggered 7689 slab alloc failures during FG_GC, exercising the 'goto
do_migrate' fallback; sha256 was preserved and dmesg stayed clean.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
v3 (addressing Chao Yu's review):
 - default gc_inode_local_packing to 0 (opt-in; was on for large sections).
 - drop the section's queued gc_blocks on the freezing 'goto stop' path
   via a new drop_gc_blocks() helper, so they cannot leak into the next
   section's pack pass through the gc_list f2fs_gc() reuses across sections.
 - replace the MAX_GC_PACK_BLOCKS constant with a gc_pack_max_blocks
   sysfs knob (default 4096, range [64, UINT_MAX]); the ABI doc describes
   it as a drain threshold checked at segment boundaries.
 - pack_gc_section() skips a queued block invalidated since phase 3
   (check_valid_map), matching the legacy phase-4 skip.
 - free queued records in one place: pack_gc_section() and put_gc_inode()
   release them via drop_gc_blocks(); guard the normal-completion
   pack_gc_section() call with nr_gc_blocks to avoid a useless walk when
   an early drain already emptied the queue.
 - gc_inode_local_packing's sysfs store assigns the bool directly (!!t),
   like iostat_enable/readdir_ra, instead of falling through to the
   generic unsigned-int write over a bool field.
 - drop the '+45 %' hot-rewrite iteration figure from the measurements
   (wall-clock number; QEMU virtio bandwidth/latency is not reliable).
 - seg_freed accounting is unchanged: the recompute still runs after the
   pack pass on all exit paths and counts already-empty segments, matching
   the legacy 'goto freed' path (required for the usable-segs equality).
 - rebased onto current f2fs/dev (now includes "embed f2fs_gc_kthread in
   f2fs_sb_info"); no code change, diff identical to the c0b65f612 base.
v2:
 - recompute seg_freed after the deferred pack pass (the in-loop 'freed:'
   check saw the source still valid, so seg_freed stayed 0 and a sync
   F2FS_IOC_GC returned -EAGAIN despite freeing space).
 - clear next_victim_seg on the freezing 'goto stop' path.
 - bound the packing queue and drain in batches.
 - rebased onto current f2fs/dev.

 Documentation/ABI/testing/sysfs-fs-f2fs |  20 +++
 fs/f2fs/f2fs.h                          |   9 +-
 fs/f2fs/gc.c                            | 193 ++++++++++++++++++++++--
 fs/f2fs/gc.h                            |   5 +
 fs/f2fs/super.c                         |   2 +
 fs/f2fs/sysfs.c                         |  16 ++
 6 files changed, 233 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 1b58c029abd..88d184ea807 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1002,3 +1002,23 @@ Description:	It can be used to tune priority of f2fs critical task, e.g. f2fs_ck
 		threads, limitation as below:
 		- it requires user has CAP_SYS_NICE capability.
 		- the range is [100, 139], by default the value is 120.
+
+What:		/sys/fs/f2fs/<disk>/gc_inode_local_packing
+Date:		May 2026
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	When set to 1, foreground GC packs valid blocks of the same
+		inode contiguously into the destination curseg, in addition to
+		(rather than within) source segment-offset order.  Effective
+		only under FG_GC; BG_GC's writeback-deferred destination
+		allocation is unaffected.  Default is 0 (disabled); set to 1 to
+		enable.
+
+What:		/sys/fs/f2fs/<disk>/gc_pack_max_blocks
+Date:		June 2026
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	Drain threshold for the foreground-GC inode-packing queue (only
+		meaningful when gc_inode_local_packing is enabled).  The
+		threshold is checked at segment boundaries, so the queue can
+		transiently exceed the value by up to one segment's blocks.
+		Bounds the transient memory used by packing on very large
+		victim sections.  Default 4096, minimum 64.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8011bbdf2c6..72a6cdf80f7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -404,8 +404,9 @@ struct ino_entry {
 
 /* for the list of inodes to be GCed */
 struct inode_entry {
-	struct list_head list;	/* list head */
-	struct inode *inode;	/* vfs inode pointer */
+	struct list_head list;		/* list head */
+	struct inode *inode;		/* vfs inode pointer */
+	struct list_head gc_blocks;	/* per-inode block list for GC packing */
 };
 
 struct fsync_node_entry {
@@ -1935,6 +1936,10 @@ struct f2fs_sb_info {
 	unsigned int migration_granularity;
 	/* migration window granularity of garbage collection, unit: segment */
 	unsigned int migration_window_granularity;
+	/* pack same-inode blocks together during FG_GC migration */
+	bool gc_inode_local_packing;
+	/* drain threshold for the FG_GC inode-packing queue, unit: blocks */
+	unsigned int gc_pack_max_blocks;
 
 	/*
 	 * for stat information.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 936d4cfa0a9..2584c87d2bd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -24,6 +24,16 @@
 #include <trace/events/f2fs.h>
 
 static struct kmem_cache *victim_entry_slab;
+static struct kmem_cache *gc_block_slab;
+
+/* Per-block migration record for inode-local packing under FG_GC. */
+struct gc_block {
+	struct list_head list;
+	unsigned int segno;		/* source segment for check_valid_map() */
+	unsigned int nofs;
+	unsigned int ofs_in_node;
+	int off;
+};
 
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
@@ -998,16 +1008,40 @@ static struct inode_entry *add_gc_inode(struct gc_inode_list *gc_list,
 	new_ie = f2fs_kmem_cache_alloc(f2fs_inode_entry_slab,
 					GFP_NOFS, true, NULL);
 	new_ie->inode = inode;
+	INIT_LIST_HEAD(&new_ie->gc_blocks);
 
 	f2fs_radix_tree_insert(&gc_list->iroot, inode->i_ino, new_ie);
 	list_add_tail(&new_ie->list, &gc_list->ilist);
 	return new_ie;
 }
 
+/*
+ * drop_gc_blocks - free every queued gc_block without migrating it and reset
+ * the queue counter.  pack_gc_section() calls it to release the queue after
+ * its migration pass; do_garbage_collect()'s freezing 'goto stop' path and
+ * put_gc_inode() call it directly so records queued for one section cannot
+ * leak into the next section's pack pass through the gc_list that f2fs_gc()
+ * reuses across sections.
+ */
+static void drop_gc_blocks(struct gc_inode_list *gc_list)
+{
+	struct inode_entry *ie;
+	struct gc_block *e, *tmp;
+
+	list_for_each_entry(ie, &gc_list->ilist, list) {
+		list_for_each_entry_safe(e, tmp, &ie->gc_blocks, list) {
+			list_del(&e->list);
+			kmem_cache_free(gc_block_slab, e);
+		}
+	}
+	gc_list->nr_gc_blocks = 0;
+}
+
 static void put_gc_inode(struct gc_inode_list *gc_list)
 {
 	struct inode_entry *ie, *next_ie;
 
+	drop_gc_blocks(gc_list);
 	list_for_each_entry_safe(ie, next_ie, &gc_list->ilist, list) {
 		radix_tree_delete(&gc_list->iroot, ie->inode->i_ino);
 		iput(ie->inode);
@@ -1636,7 +1670,7 @@ static int do_migrate_one_data_block(struct f2fs_sb_info *sbi,
  */
 static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		struct gc_inode_list *gc_list, unsigned int segno, int gc_type,
-		bool force_migrate, struct blk_plug *plug)
+		bool force_migrate, bool pack_by_inode, struct blk_plug *plug)
 {
 	struct super_block *sb = sbi->sb;
 	struct f2fs_summary *entry;
@@ -1645,6 +1679,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	int phase = 0;
 	int submitted = 0;
 	unsigned int usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
+	/* packing path skips phase 4; pack_gc_section() handles migration */
+	int nr_phases = pack_by_inode ? 4 : 5;
 
 	start_addr = START_BLOCK(sbi, segno);
 
@@ -1653,6 +1689,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 	for (off = 0; off < usable_blks_in_seg; off++, entry++) {
 		struct inode *inode;
+		struct inode_entry *ie = NULL;
 		struct node_info dni; /* dnode info for the data */
 		unsigned int ofs_in_node, nofs;
 		block_t start_bidx;
@@ -1695,6 +1732,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (phase == 3) {
 			struct folio *data_folio;
+			struct gc_block *e;
 			int err;
 
 			inode = f2fs_iget(sb, dni.ino);
@@ -1741,8 +1779,10 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 					iput(inode);
 					continue;
 				}
-				add_gc_inode(gc_list, inode);
-				continue;
+				ie = add_gc_inode(gc_list, inode);
+				if (!pack_by_inode)
+					continue;
+				goto queue;
 			}
 
 			data_folio = f2fs_get_read_data_folio(inode, start_bidx,
@@ -1754,18 +1794,38 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			}
 
 			f2fs_folio_put(data_folio, false);
-			add_gc_inode(gc_list, inode);
+			ie = add_gc_inode(gc_list, inode);
+			if (!pack_by_inode)
+				continue;
+queue:
+			e = f2fs_kmem_cache_alloc(gc_block_slab, GFP_NOFS,
+						  false, sbi);
+			if (!e)
+				goto do_migrate;	/* alloc fail: migrate now */
+			e->segno = segno;
+			e->nofs = nofs;
+			e->ofs_in_node = ofs_in_node;
+			e->off = off;
+			list_add_tail(&e->list, &ie->gc_blocks);
+			gc_list->nr_gc_blocks++;
 			continue;
 		}
 
-		/* phase 4 */
-		inode = find_gc_inode(gc_list, dni.ino);
+		/*
+		 * phase 4: legacy per-segment migration.  Capped out by
+		 * nr_phases when packing is on; reached only via the
+		 * 'goto do_migrate' fallback above, in which case @ie is
+		 * the entry add_gc_inode() just returned and we reuse it
+		 * instead of repeating the radix-tree lookup.
+		 */
+do_migrate:
+		inode = ie ? ie->inode : find_gc_inode(gc_list, dni.ino);
 		if (inode)
 			submitted += do_migrate_one_data_block(sbi, inode,
 					segno, off, nofs, ofs_in_node, gc_type);
 	}
 
-	if (++phase < 5) {
+	if (++phase < nr_phases) {
 		blk_finish_plug(plug);
 		blk_start_plug(plug);
 		goto next_step;
@@ -1774,6 +1834,38 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return submitted;
 }
 
+/*
+ * pack_gc_section - migrate all gc_blocks queued for this victim section,
+ * grouped by inode.  gc_list->ilist is walked in insertion order so
+ * destination curseg writes form inode-contiguous runs that span every
+ * source segment of the section.
+ */
+static int pack_gc_section(struct f2fs_sb_info *sbi,
+			   struct gc_inode_list *gc_list, int gc_type)
+{
+	struct inode_entry *ie;
+	struct gc_block *e;
+	int submitted = 0;
+
+	list_for_each_entry(ie, &gc_list->ilist, list) {
+		list_for_each_entry(e, &ie->gc_blocks, list) {
+			/*
+			 * Skip blocks invalidated between the phase-3 enqueue
+			 * and now, mirroring the legacy phase-4 check_valid_map()
+			 * skip: avoids a futile migration attempt and the
+			 * stat_inc_data_blk_count() do_migrate_one_data_block()
+			 * would still charge for a stale block.
+			 */
+			if (check_valid_map(sbi, e->segno, e->off))
+				submitted += do_migrate_one_data_block(sbi,
+						ie->inode, e->segno, e->off,
+						e->nofs, e->ofs_in_node, gc_type);
+		}
+	}
+	drop_gc_blocks(gc_list);
+	return submitted;
+}
+
 static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 			int gc_type, bool one_time)
 {
@@ -1800,6 +1892,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	unsigned char type;
 	unsigned char data_type;
 	int submitted = 0, sum_blk_cnt;
+	/*
+	 * Snapshot the packing knob once for this section.  Re-reading the
+	 * sysfs-writable bool from phase 3, phase 4 and the pack pass would
+	 * let a concurrent toggle queue blocks at phase 3's queue: label and
+	 * then bypass pack_gc_section(), losing this cycle of migration.
+	 */
+	bool pack_by_inode = sbi->gc_inode_local_packing && gc_type == FG_GC;
 
 	if (__is_large_section(sbi)) {
 		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
@@ -1928,14 +2027,20 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			else
 				submitted += gc_data_segment(sbi, sum->entries,
 						gc_list, cur_segno,
-						gc_type, force_migrate, &plug);
+						gc_type, force_migrate,
+						pack_by_inode, &plug);
 
 			stat_inc_gc_seg_count(sbi, data_type, gc_type);
 			sbi->gc_reclaimed_segs[sbi->gc_mode]++;
 			migrated++;
 
 freed:
-			if (gc_type == FG_GC &&
+			/*
+			 * Packing defers migration to pack_gc_section() after
+			 * this loop, so the source segment is still fully valid
+			 * here; seg_freed is recomputed below the stop: label.
+			 */
+			if (!pack_by_inode && gc_type == FG_GC &&
 					get_valid_blocks(sbi, cur_segno, false) == 0)
 				seg_freed++;
 
@@ -1946,20 +2051,79 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 			if (unlikely(freezing(current))) {
 				folio_put_refs(sum_folio, 2);
+				/*
+				 * Packing deferred this section's migration to
+				 * pack_gc_section(), which the goto stop below
+				 * skips; the queued blocks are dropped un-migrated
+				 * by drop_gc_blocks() at stop:.  Clear the
+				 * in-section victim hint so the next FG_GC
+				 * re-selects via a clean search instead of
+				 * skipping the still-valid source segments.
+				 */
+				if (pack_by_inode && __is_large_section(sbi))
+					sbi->next_victim_seg[gc_type] = NULL_SEGNO;
 				goto stop;
 			}
+
+			/*
+			 * Bound the transient gc_block footprint on very large
+			 * sections: drain once the packing queue grows past
+			 * gc_pack_max_blocks rather than holding the whole
+			 * section before migrating anything.
+			 */
+			if (pack_by_inode &&
+				gc_list->nr_gc_blocks >= sbi->gc_pack_max_blocks)
+				submitted += pack_gc_section(sbi, gc_list,
+								gc_type);
 		}
 next_block:
 		folio_put_refs(sum_folio, 2);
 		segno = block_end_segno;
 	}
 
+	/*
+	 * Normal completion: drain whatever is still queued for this section
+	 * (an earlier gc_pack_max_blocks drain may have already emptied it).
+	 * Skipped on the freezing 'goto stop' path, where the queued records are
+	 * instead dropped un-migrated below.
+	 */
+	if (pack_by_inode && gc_list->nr_gc_blocks)
+		submitted += pack_gc_section(sbi, gc_list, gc_type);
+
 stop:
+	/*
+	 * Drop any records still queued for this section so they cannot leak into
+	 * the next section's pack pass via the gc_list f2fs_gc() reuses across
+	 * sections.  No-op on the normal path (pack_gc_section() already drained
+	 * and cleared nr_gc_blocks); only the freezing path leaves records here.
+	 */
+	if (pack_by_inode && gc_list->nr_gc_blocks)
+		drop_gc_blocks(gc_list);
+
 	if (submitted)
 		f2fs_submit_merged_write(sbi, data_type);
 
 	blk_finish_plug(&plug);
 
+	/*
+	 * Migration was deferred past the per-segment loop, so the in-loop
+	 * 'freed:' check could not observe the emptied source segments.  Recompute
+	 * seg_freed over the scanned range here -- counting already-empty segments
+	 * exactly as the legacy 'goto freed' does, so a fully reclaimed section
+	 * reaches seg_freed == f2fs_usable_segs_in_sec().  This runs on the
+	 * freezing path too, so a section emptied by an earlier gc_pack_max_blocks
+	 * drain before the freeze is still counted; any already-empty segments
+	 * counted here feed only the total_freed tracepoint, not the
+	 * sec_freed/-EAGAIN decision (gated on the equality above).
+	 */
+	if (pack_by_inode) {
+		unsigned int seg;
+
+		for (seg = start_segno; seg < end_segno; seg++)
+			if (get_valid_blocks(sbi, seg, false) == 0)
+				seg_freed++;
+	}
+
 	if (migrated)
 		stat_inc_gc_sec_count(sbi, data_type, gc_type);
 
@@ -2129,11 +2293,20 @@ int __init f2fs_create_garbage_collection_cache(void)
 {
 	victim_entry_slab = f2fs_kmem_cache_create("f2fs_victim_entry",
 					sizeof(struct victim_entry));
-	return victim_entry_slab ? 0 : -ENOMEM;
+	if (!victim_entry_slab)
+		return -ENOMEM;
+	gc_block_slab = f2fs_kmem_cache_create("f2fs_gc_block",
+					sizeof(struct gc_block));
+	if (!gc_block_slab) {
+		kmem_cache_destroy(victim_entry_slab);
+		return -ENOMEM;
+	}
+	return 0;
 }
 
 void f2fs_destroy_garbage_collection_cache(void)
 {
+	kmem_cache_destroy(gc_block_slab);
 	kmem_cache_destroy(victim_entry_slab);
 }
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index b015742fb45..445093c022a 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -37,6 +37,10 @@
 #define BOOST_GC_MULTIPLE	5
 #define ZONED_PIN_SEC_REQUIRED_COUNT	1
 
+/* drain threshold for the FG_GC inode-packing queue (gc_pack_max_blocks) */
+#define DEF_GC_PACK_MAX_BLOCKS	4096	/* ~128 KiB of gc_block records */
+#define MIN_GC_PACK_BLOCKS	64
+
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
 
@@ -50,6 +54,7 @@
 struct gc_inode_list {
 	struct list_head ilist;
 	struct radix_tree_root iroot;
+	unsigned int nr_gc_blocks;	/* blocks queued for inode-local packing */
 };
 
 struct victim_entry {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index afca2dad4da..81a9cdc051c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4363,6 +4363,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->migration_granularity = SEGS_PER_SEC(sbi);
 	sbi->migration_window_granularity = f2fs_sb_has_blkzoned(sbi) ?
 		DEF_MIGRATION_WINDOW_GRANULARITY_ZONED : SEGS_PER_SEC(sbi);
+	sbi->gc_inode_local_packing = false;
+	sbi->gc_pack_max_blocks = DEF_GC_PACK_MAX_BLOCKS;
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index be92c05a542..ad57cc0c76b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -659,6 +659,18 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 	}
 
+	if (!strcmp(a->attr.name, "gc_inode_local_packing")) {
+		if (t > 1)
+			return -EINVAL;
+		sbi->gc_inode_local_packing = !!t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_pack_max_blocks")) {
+		if (t < MIN_GC_PACK_BLOCKS || t > UINT_MAX)
+			return -EINVAL;
+	}
+
 	if (!strcmp(a->attr.name, "gc_urgent")) {
 		if (t == 0) {
 			sbi->gc_mode = GC_NORMAL;
@@ -1269,6 +1281,8 @@ F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
+F2FS_SBI_GENERAL_RW_ATTR(gc_inode_local_packing);
+F2FS_SBI_GENERAL_RW_ATTR(gc_pack_max_blocks);
 F2FS_SBI_GENERAL_RW_ATTR(dir_level);
 F2FS_SBI_GENERAL_RW_ATTR(allocate_section_hint);
 F2FS_SBI_GENERAL_RW_ATTR(allocate_section_policy);
@@ -1438,6 +1452,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(migration_granularity),
 	ATTR_LIST(migration_window_granularity),
+	ATTR_LIST(gc_inode_local_packing),
+	ATTR_LIST(gc_pack_max_blocks),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
