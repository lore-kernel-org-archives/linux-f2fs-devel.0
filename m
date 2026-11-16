Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C4606A339
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UvuwRSXe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=debnpDdw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Osd8BYZ1;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3M1CouK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=hK4NunOV+2ki7WY9CWTlxfpwjlWMqkK8Lmq7ZMA1pNY=; b=UvuwRSXegm4O0fAw6oh4xoknkg
	vfROBrLT7juutPneMrxzrAv2Qx/JY3AGeOBLhIJsqvEocqC898rsnpbJbM6374JNFaay2CT0By4vb
	2+GdvZFReLyt9EHRey838mlPB4nQPu5skTRvrCb+BqFrIoa52xqkNnBGRoN1B/R0Eeos=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo1q-000000001Fn-0Qf7;
	Mon, 16 Nov 2026 04:09:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo1i-000000001FZ-0Dt8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RSTviWjtfe6XxNDFOAlD9904SKRkGSAvfsq7xFNryA=; b=debnpDdwRm1JG049gmkbxNlXGO
 QiqrxTOcPDhjbTHrEYBjx9513LnXK4yi3E6/o1IY1CLwwOiDayJRw4jZtPvzbXwMJNLompWusiQI5
 X+Q5Nld7i1lW+eug/XMcqeOu6xp8DCupPkYf/UCSEJZmXmwZwHd5hx1V2CJqVgDN1wII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RSTviWjtfe6XxNDFOAlD9904SKRkGSAvfsq7xFNryA=; b=Osd8BYZ1iGMSwLPXP8orAl/44/
 qMV9GrYPSIUbv3UzgMx5CIJJUrkH4SCkmXcDcqofWzWwx5U5OAsg4q5Ini81YsBzAgYk373QQ2Wxh
 vuovrXmysQSFAK9edE0EW6fLJmNFke30lZqfFkOuFqyDwBirbyFtGsE8PJMsF34/ehvc=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1g-000000007bp-2hNJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:05 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b0ae87069dso1731895a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802139; x=1795406939; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7RSTviWjtfe6XxNDFOAlD9904SKRkGSAvfsq7xFNryA=;
 b=t3M1CouKo8HK+uJPgexhdJfK0AljAU3ymV6JzvsMgmBcIh3/M6ocWT66I49/YVDGes
 fGmoJx36CB6wBmgFvyJkh6JAlvqREkx88O1pzrWYZnDSDyKksPeKduf+ugbtUKw6U++A
 zSJMRt9ff4hNEwcWtBiXbGurx1jk1t0qWuhhgWB+toWC6g2PW85SdOKQq9MUltnNUZfK
 MpxaRGIHncpKVJNkrnJeGfifGLKqEyvP3kbMDigTp4dPAcYKvZ2ULLqRu798Ceba1JLW
 0TN3AH6CvV5t+7ZJFM6K2iqX/o+nxeRzAOm+lZN4WfueEHNpQ/S2ONfgNjKmIg51zhCj
 vncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802139; x=1795406939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7RSTviWjtfe6XxNDFOAlD9904SKRkGSAvfsq7xFNryA=;
 b=fHyA2yFi9jKwTgRd6+jVBp7es3aRK/m1M8/uv+nG702FHK22+I6WpdRurnJGmfQFPy
 nszeyQzFdZIWbxBRmF/fiwk4DAkTE7/M0upikI7BLxDrvFFB2utW0598PT37WbWJ0N6l
 DnkaUaLxYhm3QSFDdLeoAmHfpPjWjAKhbRTdFPpS6CYk/NQEjKtwYJCYFDDKHWjBUDUu
 fkx3wwicZH/Xt0ugKCieRgOqY15bIVpqqcN11DXianmgYfTd1pjqlIa3Qkcsk6v4aa4p
 TF0oRrVa9Ooo00FH1C0pJ9ozeWyjFAX7kTXxtcLIhwEmbN6IQSaoxItDs8N9yxdzachb
 48WQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFtH+iuadejNk8taLhEbfh4S9lsVCQ5PD1WVo5quwj4SnGFft21GCWL93VZqWU2Rb+GOyv1PuTebBTj/lA6g37S@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Gswo6XZVi7PIAUckjANKAzxJLGVDVQc/lG0Dq/pskAgfwIihg
 hOLsmieqa9yHeLqIFR8nnfHykfqenziUvhY02m9GtInk3ofW3EFu/j9t
X-Gm-Gg: AYBFou1zKVD3UQJ7jG64A8hN5roe4afulaJq9UBL7ypueeV/uOpAFqkRd2NZzJOp5TZ
 eWQa3/v9NIkHmZuVai1xbrSZ9Oh3C4Fa7xS/8TJKcdJWc5Mx7RIULXSkwEe8KKgEH/h5d/qmOJO
 gceRu4yyiU96DFigCVdsyrwTs9Q1OUUwagMSXR1SydmFc0/5rMC3xkSAme0VPbQmdE+2g5Micsc
 cxLUkL64lX8U1IVJQku9C6IKyiDMzOoQomAcCJWDd/NAWSrNsb6GfsLIyOiNS5G95ABXxG1oeXB
 dqMQ+suvSuapcMGCl8Bi18iRL05mnkCfsuUH0OEFUjl/G42w4bAFEN0xsjLUB3kSEJfnyDXY3lL
 xbxbJF+ugfzS4Xpv4uQcM9g++iqSUwN9Z0O9V5zplLrwYZmhXOOy3T/pmpgnVyZgiFOrOEGLn5H
 RJyjWU8l1lJFFw2iQlgrRG5lD6WWnxjF4WV8NhqpAJoj2OvnTpXLanQLHXRRBXQZx3s8xAjq5Gj
 afYN5Toqw6pfq9gxtk/d6X9Ri19lEpXXKe5+ww5j16lKIShadE3ONqNjQcJTILLFt9OGcf8yQ7J
 Kv+1cjw6/0Vb6G2QSUxLXHnPdBylPxRN0qETJ9ulT37nXQymqisawoCbCx5sWuZt5hx73+aZIZX
 KBdySJEF+PqJEzcnydP62MrwnkaTJv6jTd1W5vvGBL2SHjGQ=
X-Received: by 2002:a17:90b:4ec5:b0:3ad:b86d:dbad with SMTP id
 98e67ed59e1d1-3b1b0a0dd02mr8036664a91.30.1794802138723; 
 Sun, 15 Nov 2026 20:08:58 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:08:57 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:31 -0800
Message-ID: <20261116040851.2849696-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1g-000000007bp-2hNJ
Subject: [f2fs-dev] [PATCH v2 00/20] f2fs: support block size smaller than
 PAGE_SIZE
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

F2FS has required the filesystem block size to equal PAGE_SIZE. On a
kernel with 16KB pages, this means an existing F2FS image with 4KB
blocks cannot be mounted, e.g. the userdata partition of an Android
device that moves from a 4KB page kernel to a 16KB page kernel.

This series lets F2FS mount and use a filesystem whose block size is
smaller than PAGE_SIZE, such as 4KB blocks on a 16KB page kernel. The
on-disk format does not change.

With subpage blocks, even an order-0 folio holds several blocks, so
the series builds on the large folio support from Nanzhe Zhao [1] and
tracks uptodate and dirty state per block in f2fs_folio_state for any
folio that holds more than one block. Most paths then work in blocks
instead of pages:

- Patches 1-2 convert more page based index and size calculations to
  block based ones, and add the superblock and mount infrastructure.
  Subpage block sizes are still rejected at this point.
- Patch 3 extends f2fs_folio_state with per-block state, identified by
  a magic number, and allocates it on demand with __GFP_NOFAIL.
- Patches 4-7 handle directories, the per-inode dirty counters, the
  read path and GC, and the write path and writeback per block.
- Patches 8-19 adapt the remaining features: range operations and
  mmap, pinned files, collapse/insert range, move range,
  defragmentation, swapfile, fs-verity, atomic writes, inline data,
  online resize and compression, and remove the -EOPNOTSUPP checks
  that patch 2 added for the features that need them.
- Patch 20 stops rejecting subpage block sizes.

When the block size equals PAGE_SIZE, the behavior does not change,
except for the fixes noted in the individual patches. The following
are not limited to subpage blocks or large folios:

- Patch 1: __complete_revoke_list() and __clone_blkaddrs() compute
  offsets in 64 bits on 32-bit architectures.
- Patch 8: an extending direct write updates i_size in ->end_io(),
  before iomap invalidates the page cache of the written range.
- Patch 10: collapse and insert range hold i_gc_rwsem[WRITE] and
  invalidate_lock until the moved blocks are written back and the page
  cache is dropped.
- Patch 11: move range zeroes the cached data past the old EOF of the
  destination before extending it, and drops the source blocks from
  the page cache also after an exchange that failed part way.
- Patch 12: defragmentation reads compressed files through
  ->read_folio(). A block of a compressed cluster that was not in the
  page cache was read without decompression and written back as file
  data.
- Patch 15: aborting atomic writes holds i_gc_rwsem[WRITE] and
  invalidate_lock.

A few of the patches adjust code from the large folio series [1]:

- f2fs_folio_has_ffs() checks the folio state magic instead of
  requiring a large folio, since order-0 multi-block folios also carry
  a folio state, and the page private flags can legitimately be set
  before a state is attached.
- f2fs_ffs_find_or_alloc() cannot fail with __GFP_NOFAIL, so the
  allocation failure handling of its callers is removed.
- The inode dirty blocks are counted from the dirty bits of the folio
  state, and ->dirty_folio() marks the uptodate blocks of a folio
  dirty, since mm does not tell which blocks were modified.
- Defragmentation and swapfile activation mark only the target block
  dirty instead of the whole page.

Changes in v2:

Addressed the review comments from Chao Yu and Nanzhe Zhao, the
warning reported by the kernel test robot, and the findings of the
Sashiko review. v1 is at [2].

- Patch 1 (block based calculations): rename the subject ("in more
  paths"). Use F2FS_BLK_ALIGN() in dir_blocks(). Compute the new
  i_size in __clone_blkaddrs() in 64 bits.
- Patch 2 (superblock and mount): probe the 2nd superblock from the
  smallest block size and stop at the first one found, so that a stale
  superblock of a larger block size is not picked, and return its
  error instead of the error of the last probe. Bound log_sectorsize
  by log_blocksize and remove F2FS_MAX_LOG_SECTOR_SIZE. Check the
  requested inline_xattr_size in f2fs_check_opt_consistency(). Do not
  set *recovery when no valid superblock is found. Report a failed
  read of a superblock again.
- Patch 3 (folio state): remove the unused variable in
  prepare_large_folio_write_begin(). Count the submitted blocks in
  nwritten also on error. Do not clear the uptodate flag of the folio
  of an inline inode in f2fs_invalidate_folio(). Explain the use of
  __GFP_NOFAIL in the commit message.
- Patch 4 (directories): read the name length in f2fs_delete_entry()
  under the folio lock. Clear the gcing flag of the folio when its
  last dirty block is freed. Simplify f2fs_dentry_to_lblk() and use
  f2fs_folio_lblk_address().
- Patch 5 (dirty counters): commit message only.
- Patch 6 (read path and GC): keep the folio state of a folio that is
  not fully uptodate in ->release_folio while the folio has other
  users. Read the block again in f2fs_get_read_data_folio() and
  f2fs_find_data_folio() when the folio state was released while the
  folio was unlocked, instead of failing. Do not map the blocks past
  EOF in f2fs_read_data_large_folio(). Read under memalloc_nofs in
  ra_data_block(), where GC locks are held. Rename
  f2fs_submit_page_read_sync() to f2fs_submit_block_read_sync().
- Patch 7 (write path and writeback): count the inode dirty blocks
  from the dirty bits of the folio state instead of per folio. Make
  ->dirty_folio() mark the uptodate blocks within EOF dirty, and add
  f2fs_folio_mark_dirty() for the updates made by f2fs, which mark
  only the blocks they modify. Keep f2fs_balance_fs_folio_locked() in
  write_begin instead of balancing after the folio is unlocked. Drop
  the pending write that a failed submission leaves behind in
  f2fs_convert_inline_folio(). Keep the folio dirty and accounted when
  flush_inline_data() fails.
- Patch 8 (range operations and mmap): update i_size of an extending
  direct write in ->end_io(). In page_mkwrite, reserve blocks only
  where it may allocate, i.e. not for a pinned file or a compressed
  cluster, do not balance with the folio locked, and read the blocks
  that are not uptodate after a partial invalidation. Check the dirty
  state of a reserved block only for SEEK_DATA.
- Patch 9 (pinned files): keep failing page_mkwrite on a device
  aliasing file with -EIO.
- Patch 10 (collapse and insert range): hold i_gc_rwsem[WRITE] and
  invalidate_lock from before the first writeback until the moved
  blocks are written back and the page cache is dropped.
- Patch 11 (move range): zero the cached data past the old EOF of the
  destination with f2fs_zero_post_eof_page() before the move. Drop the
  source blocks from the page cache also after an exchange that failed
  part way. Call pagecache_isize_extended() for the gap between the
  old EOF and the moved data.
- Patch 12 (defragmentation): read compressed files through
  ->read_folio() as well, and lock and redirty the folio that was read
  instead of looking it up again (f2fs_get_defrag_folio()).
- Patch 13 (swapfile): use f2fs_folio_mark_dirty().
- Patch 14 (fs-verity): stop the data reads of a verity file at i_size
  in f2fs_read_data_large_folio(). Do not zero the blocks past i_size
  on read while verity is being enabled.
- Patch 15 (atomic writes): hold i_gc_rwsem[WRITE] and invalidate_lock
  while aborting atomic writes, except at eviction.
- Patch 16 (inline data): redirty the folio and stop on any error of
  the inline writeback in f2fs_write_cache_folios(). Note the effect
  on inline inodes with large folios in the commit message.
- Patch 18 (compression): raise the minimum cluster size only when a
  page has more than four blocks, reject a smaller compress_log_size
  in the mount option and in F2FS_IOC_SET_COMPRESS_OPTION, fail the
  open of a file that already has a smaller cluster with -EOPNOTSUPP
  instead of failing its inode sanity check, and document it. Dirty
  every block of a partially dirty compressed cluster before it is
  rewritten. Attach a folio state to the multi-block folios of a
  rewritten cluster before they are dirtied. Count a read folio of a
  compressed file once in the iostat. Do not cut the range that
  redirty_blocks() dirties at EOF. Remove inode_inc_dirty_block() and
  inode_dec_dirty_block().
- Patches 17, 19 and 20: no change.
- The patches also use the F2FS_BLK_* helpers in more places, as
  suggested in the review.

Testing:

Built every patch for x86_64, arm64 (16KB pages), arm and i386.

Ran the xfstests auto group (excluding the clone, dedupe and thin
groups) on arm64 QEMU with mount options "discard,fsync_mode=strict"
in these combinations of page size / block size:

- 16KB/4KB:  default, compression (lz4, zstd, lz4hc, lzo-rle with
             64KB clusters and checksum), compression+encryption,
             encryption+verity, mode=lfs, atgc
- 4KB/4KB:   default, compression, encryption+verity,
             compression+encryption, mode=lfs
- 16KB/16KB: default, compression, encryption+verity,
             compression+encryption, mode=lfs

plus generic/019, 521, 522 and 780 for each combination, and a 24 hour
power-off recovery test with fsstress for each of the three
combinations.

There were no crashes or hangs, and the power-off recovery tests found
no corruption. Two failures are worth a note, and neither depends on
this series:

- generic/455 failed once on 16KB/4KB with encryption+verity, because
  fsync() returned before its node block was written. [3] fixes it.
- generic/551 was killed by the OOM killer in three of the compression
  runs. It is killed the same way without this series.

Also ran:

- The xfstests quick group with lockdep (PROVE_LOCKING and
  DEBUG_ATOMIC_SLEEP) on 16KB/4KB, default and compression. The only
  reports were in generic/574 with compression, where
  f2fs_decompress_cluster() may sleep in the read completion. This
  happens without this series as well, and [4] fixes it.
- 16 processes writing through mmap at the same time until the
  filesystem is full, on a 1GB image with 16KB pages and 4KB blocks,
  with and without large folios and with and without mode=lfs, as
  asked in the review of v1. They got SIGBUS only after the free
  space ran out, the data read back was correct, and fsck found no
  error.
- A 32-bit ARM kernel (4KB pages) with files beyond 4GB.

[1] https://lore.kernel.org/linux-f2fs-devel/20261028154407.1601430-1-nzzhao.sigma@gmail.com/
[2] https://lore.kernel.org/linux-f2fs-devel/20261102193952.3002018-1-daeho43@gmail.com/
[3] https://lore.kernel.org/linux-f2fs-devel/20261103101208.4550-1-seungbum.ju@gmail.com/
[4] https://lore.kernel.org/linux-f2fs-devel/20261112143355.2923939-2-jprusakowski@google.com/

Daeho Jeong (20):
  f2fs: use block-based index and size calculations in more paths
  f2fs: support subpage block size superblock and mount
  f2fs: extend f2fs_folio_state for subpage blocks
  f2fs: support subpage blocks in directory operations
  f2fs: convert inode dirty page counters to dirty block counters
  f2fs: support subpage blocks in data read path and GC
  f2fs: support subpage blocks in data write path and writeback
  f2fs: adapt range operations and mmap for subpage blocks
  f2fs: support subpage blocks in pinned files
  f2fs: support subpage blocks in collapse and insert range
  f2fs: support subpage blocks in move range
  f2fs: support subpage blocks in defragmentation
  f2fs: support subpage blocks in swapfile activation
  f2fs: support subpage blocks in fs-verity enablement
  f2fs: support subpage blocks in atomic writes
  f2fs: preserve inline data in subpage block mode
  f2fs: support subpage blocks in online resize
  f2fs: support subpage blocks in compression
  f2fs: count compress cache entries in pages for its memory limit
  f2fs: enable subpage block size support

 Documentation/filesystems/f2fs.rst |    7 +-
 fs/f2fs/checkpoint.c               |   67 +-
 fs/f2fs/compress.c                 |  569 ++++++---
 fs/f2fs/data.c                     | 1725 ++++++++++++++++++----------
 fs/f2fs/dir.c                      |  126 +-
 fs/f2fs/f2fs.h                     |  237 ++--
 fs/f2fs/file.c                     |  716 ++++++++----
 fs/f2fs/gc.c                       |  103 +-
 fs/f2fs/inline.c                   |   23 +-
 fs/f2fs/inode.c                    |    3 +-
 fs/f2fs/node.c                     |   26 +-
 fs/f2fs/segment.c                  |   14 +-
 fs/f2fs/super.c                    |  180 ++-
 fs/f2fs/verity.c                   |    5 -
 include/linux/f2fs_fs.h            |    2 +-
 15 files changed, 2494 insertions(+), 1309 deletions(-)


base-commit: b9d7379d10d43386b59082da8c9a0b111e054781
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
