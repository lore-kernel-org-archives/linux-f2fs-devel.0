Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B0C61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:To:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MYqFVpCa5QTZ47xtVSWAasuwlmi/DVxn8lTtD0JNG8E=; b=BvndFIRzXuGX05J9NI2AaV00mC
	+ibWc8TbaAfeF5oOZzbsaIbiUJzzATyjDOKY89JuOsVI4sMgyiZzQ47v5PxhQxbk5JBEGf46q8Wr6
	OpunQFcnbN5vTSvoT1oqxdv5DKUGVc18m7CE2WX0IJi4LDy20h42GUuNC7IP9S5O963I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzxwz-00014o-QM;
	Fri, 28 Aug 2026 14:53:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wzxwj-00014Q-Ac
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ELhljBAu15ROpmEaT8Yh7qydfeZbcelWQRMHhRVBiPc=; b=mP6kAtapDcD0U+6cI6WGqai/Zh
 O/5swbvGqA08MKLMrCXrePdU8QPnusPtYxW0PcUh33asmfJVElORv9bSPtJZ8aCXYn9TwrPMyUvyo
 ntAN8x1Gw208Yv6Ze7cscWElMLWZV/QPJYNVrr0hPOv7FAZtX6/Nz9aZg1PcKMRdkPAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ELhljBAu15ROpmEaT8Yh7qydfeZbcelWQRMHhRVBiPc=; b=J
 B/aXwqEpvNQKDm4LYI/jooOU1oT+Fzws+GqhVu2fC4vJ3oY5U7V7upKAXrvVnkvedn/Je5QILyYMX
 PkopR7aQKuUl50uWmC7awRWBNSveF5sg/CGwg9hufs+dOSrNqwSJXG6TzwVr5bkUddf762C2tm7W4
 vw3qII7imnquoaS4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxwi-0005tB-7x for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:52:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAD6D40221;
 Fri, 28 Aug 2026 14:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6665B1F000E9;
 Fri, 28 Aug 2026 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787928758;
 bh=ELhljBAu15ROpmEaT8Yh7qydfeZbcelWQRMHhRVBiPc=;
 h=Date:From:To:Cc:Subject;
 b=ZJVzAIobQ8VTMLVwthiWeqOdq2KaEtJDkcBkAna8yjxaYGDfSL4JQql3gnxclxwvJ
 AthXPcQsxO7fIBIO5pfTN67WGR9hRfOicMpTB2k0+Js4V602FxQCkyS9l/ae3j/yk4
 +uh79hDG/SXDI9oissI84j1vYP+Bl00tYl6TxRaYhvnQB7FQZ8BZRmpxWT9wLUSH+q
 EU8sDxC3dEhNqKrEfpYAB3U4F1evzR5nyvrItWIa/VL6QRUcw0mPhROO/99zLs8hpW
 kGXs3O/u63mkaKuFHzOVUHpNPTGJ/6iZC8xlI7gKaUuvONBjlhF+WfUNJ5rMWzborH
 PfzbEP/3mLeIQ==
Date: Fri, 28 Aug 2026 14:52:36 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <apGgtMJ4mB-XRBlO@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1wzxwi-0005tB-7x
Subject: [f2fs-dev] [GIT PULL] f2fs for 7.3-rc1
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Linus,

Could you please consider this pull request?

Thanks,


The following changes since commit 62cc90241548d5570ee68e01aaba6506964e9811:

  Merge tag 'mm-hotfixes-stable-2026-07-27-14-18' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2026-07-27 14:36:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-7.3-rc1

for you to fetch changes up to c966d29e01bbf829f8bb4a39a49811c56cdb49c3:

  f2fs: support resizable tail section and unify pinned allocation (2026-08-27 04:47:36 +0000)

----------------------------------------------------------------
f2fs-for-7.3-rc1

In this round, key enhancements focus on reducing inode management memory
overhead, introducing resizable tail sections with unified pinned allocation,
and boosting I/O throughput via parallel multi-device flushes and asynchronous
f2fs_write_end_io() execution. We also add dynamic device alias reservations to
allow on-the-fly space donation from user partitions.

Alongside these features, critical bug fixes resolve folio race conditions,
lingering dirty flags, dentry and block counter leaks, and potential deadloops
in f2fs_fsync_node_pages(). Additional stability patches address error-path
handling across symlink, sync, and rename/unlink operations, prevent pinned file
fragmentation, and correct segment migration and free section accounting in
free_segment_range.

Enhancement:
 - reduce memory footprint of ino management
 - support dynamic reserve/release for device aliasing
 - issue multi-device flushes in parallel
 - add a way to run f2fs_write_end_io() asynchronously
 - support resizable tail section and unify pinned allocation

Bug fix:
 - fix to pass folio->index to f2fs_sanity_check_node_footer()
 - fix folio_nr_pages() race after put in large folio invalidate
 - fix to clear dirty flag on folio in error path
 - accurately adjust free_sections during free_segment_range
 - fix to avoid potential deadloop in f2fs_fsync_node_pages()
 - fix the error path in symlink, device alias in rename/unlink,
   f2fs_sync_fs,
 - fix to migrate all curseg types during free_segment_range
 - fix to avoid pinfile fragment on fragment:{block, segment} mode
 - fix valid block count leak on data block allocation failure
 - fix dentry folio leak in find_in_level
 - reject overlapping move range after len expansion
 - fix some bugs related to file pinning, GC functions, i_size.

And, the series includes a number of minor bug fixes.

----------------------------------------------------------------
Bart Van Assche (1):
      f2fs: Run f2fs_write_end_io() asynchronously

Chao Yu (22):
      f2fs: drop FGP_NOFS in f2fs_write_begin()
      f2fs: quota: do not use GFP_NOFS in f2fs_quota_read()
      f2fs: embed f2fs_gc_kthread in f2fs_sb_info
      f2fs: fix to avoid potential section-unaligned pinfile
      f2fs: fix to avoid move_range and defragment on device_alias file
      f2fs: fix to return -EFSCORRUPTED in f2fs_get_node_info() correctly
      f2fs: avoid unnecessary shrink in f2fs_shrink_scan()
      f2fs: fix to clear dirty flag on folio in error path
      f2fs: print error information in f2fs_put_super()
      f2fs: fix to pass folio->index to f2fs_sanity_check_node_footer()
      f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
      f2fs: fix to zero post-EOF data when extending file size
      f2fs: unify add/remove ino entry API for all ino types
      f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
      f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
      f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
      f2fs: fix to avoid pinfile fragment on fragment:{block, segment} mode
      f2fs: reduce memory footprint of ino management
      f2fs: use f2fs_{down, up}_(read, write}_trace() for nat_tree_lock
      f2fs: fix to reset all pinned status during fggc
      f2fs: fix to propagate error from f2fs_sync_fs()
      f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()

Chen Changcheng (1):
      f2fs: fix valid block count leak on data block allocation failure

Daeho Jeong (6):
      f2fs: support dynamic reserve/release for device aliasing
      f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
      f2fs: fix to migrate all curseg types during free_segment_range
      f2fs: fix error handling on device alias check in rename and unlink
      f2fs: accurately adjust free_sections during free_segment_range
      f2fs: support resizable tail section and unify pinned allocation

Guanghui Yang (1):
      f2fs: fix dentry folio leak in find_in_level

Hao-Qun Huang (1):
      f2fs: reject overlapping move range after len expansion

Jaegeuk Kim (3):
      f2fs: refactor f2fs_evict_inode having three major parts
      f2fs: call __add_ino_entry out of the eviction path
      f2fs: don't leave the hashed inode while it's unlinked

Joanne Chang (1):
      f2fs: dirty directory inodes on mtime/ctime update

Seongjae Jeong (1):
      f2fs: use adjusted write range after f2fs_write_checks()

Wenjie Qi (8):
      f2fs: validate MOVE_RANGE destination size
      f2fs: limit recovery filename logging to stored length
      f2fs: only redirty pinned folios in redirty_blocks
      f2fs: return writeback error from collapse range
      f2fs: reject invalid recovered filename lengths
      f2fs: avoid NULL checkpoint thread access in sysfs
      f2fs: protect critical_task_priority updates with s_umount
      f2fs: return symlink writeback errors

Yonggil Song (1):
      f2fs: issue multi-device flushes in parallel

Zhan Xusheng (4):
      f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
      f2fs: don't drop the top folio order in the f2fs_iostat tracepoint
      f2fs: Remove unused curseg_segno() and curseg_alloc_type()
      f2fs: fix i_size when pinned fallocate partially fails

Zhaoyang Huang (1):
      f2fs: fix folio_nr_pages() race after put in large folio invalidate

 Documentation/ABI/testing/sysfs-fs-f2fs |  18 ++
 Documentation/filesystems/f2fs.rst      |  43 ++-
 fs/f2fs/checkpoint.c                    | 123 ++++++++-
 fs/f2fs/data.c                          |  48 +++-
 fs/f2fs/debug.c                         |   4 -
 fs/f2fs/dir.c                           |   7 +-
 fs/f2fs/extent_cache.c                  |   9 +
 fs/f2fs/f2fs.h                          |  90 ++++++-
 fs/f2fs/file.c                          | 460 ++++++++++++++++++++++++++++----
 fs/f2fs/gc.c                            | 129 +++++----
 fs/f2fs/gc.h                            |  27 +-
 fs/f2fs/inline.c                        |   2 +-
 fs/f2fs/inode.c                         | 234 +++++++++++-----
 fs/f2fs/iostat.c                        |   6 +
 fs/f2fs/namei.c                         | 168 +++++++-----
 fs/f2fs/node.c                          |  81 +++---
 fs/f2fs/recovery.c                      |  55 ++--
 fs/f2fs/segment.c                       | 279 +++++++++++++------
 fs/f2fs/segment.h                       |  37 ++-
 fs/f2fs/shrinker.c                      |   3 +-
 fs/f2fs/super.c                         |  99 ++++++-
 fs/f2fs/sysfs.c                         |  34 ++-
 fs/f2fs/xattr.c                         |   2 +-
 include/trace/events/f2fs.h             |  23 +-
 include/uapi/linux/f2fs.h               |   7 +
 25 files changed, 1532 insertions(+), 456 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
