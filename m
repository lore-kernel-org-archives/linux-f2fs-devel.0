Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB00606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j83pj3W8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DFiIRJut;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R6Nxl4c6;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVkMwS0i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O5BsICQ8XuvcIa45BvTUifqJrZ7myI3uVRADKFkJFDM=; b=j83pj3W8pLepqkuQogvoLLgIcB
	U3ggH0/y3UChs9ZFMns4njM+uf5u4Mq/Y+JuUfZsjdX1j+lMKrBv4ZEb8TM3YLmKrynZq/mnxW6EE
	AAPYK8QOQ1sRNVuHQ8Z2O2lYH5tkvrqdpEoElLyfFOx3L02swZ8f26r1yRbpjCIpZOw8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM7Y5-000000005HB-2sXx;
	Wed, 28 Oct 2026 17:34:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xM7Y4-000000005H5-1h76
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 17:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z8flGgLCDZXbO2V4x4lmH9yUfLyn0i0Q2d4UVX084Co=; b=DFiIRJutF9cffze4VdWXO22Z+i
 O/EHBxmhMGqnzMu8fa18rN4QxczKuTeW/zf26f7BtUynrw4c7knEozjcRSswh+q9CalZqk9n/UPTS
 NOfC8ica6uHLjXlAwl7wpjb9Av3Gegg2c9CZKwn6nz/5LyZhQVTc0QO5CnpUJIXVmiHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z8flGgLCDZXbO2V4x4lmH9yUfLyn0i0Q2d4UVX084Co=; b=R6Nxl4c6SArQTgNBHkToFxkllw
 uyHCe06dLBG4LndUqOZMNL82xAmCn7kix4zHUU1er1FC6a1CEZOzM96K9rTQM/0MhEg091Oo9ltJe
 68Rb0EYuf8HAViIkhJdHwLE6htOayfzc4AS3ufVp2Ee7bhlbzq4XsKQmFpRoPHeEbGhw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xM7Y2-0000000074M-3q8K
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 17:34:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9710243BFC;
 Wed, 28 Oct 2026 17:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E288B1F01825;
 Wed, 28 Oct 2026 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793208885;
 bh=Z8flGgLCDZXbO2V4x4lmH9yUfLyn0i0Q2d4UVX084Co=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FVkMwS0i9gFLnjZmbALjT4X5TtDyAro1eVMx+qWzl/LukXvRXHHz37drdsan6B6WL
 kFDIDAt6LDChf8EXGQzoChXsJep1VYmeAkl7voyQm38178kRQAivV8zUbdhS2JBOyF
 mtF/x+1zYCWcgu3nN5QgjFfOJG3Fy9cbg3YNhkTZKJNsl72+iQrCRQayeZmNeZPweC
 JbUhtXKZsfxQmX5oA+bx6KFVM29fUrpIHLhs8MFnPki6y4dWav/ErWg1+vkgB/1QQt
 3sRUo4tPlnkTwZM+jt4ei6lAiaPSEHmSRFYrPiKls85hPFylUzDvJC9t8sEa95BtcZ
 OmWxx3ULD/jMQ==
Date: Wed, 28 Oct 2026 17:34:43 +0000
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Message-ID: <auIyM-RmQE3rx1XL@google.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM7Y2-0000000074M-3q8K
Subject: Re: [f2fs-dev] [PATCH v8 00/15] f2fs: support & optimize large
 folios for writable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nanzhe,

I applied this series on top of the latest mainline having page private patches
where I had to clean up some conflicts. Could you please check dev-test branch?

Thanks,

On 10/28, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> This series supports large folios for most readable/writable files
> in buffered I/O paths, including normal files, block-layer encrypted
> files, and atomic files except for inline-data files, compressed files,
> and quota files.
> 
> It also extends f2fs_folio_state to coexist with f2fs page-private
> flags and to handle large folio write path and partial truncate of
> large folios correctly.  A valid large folio always carries a
> f2fs_folio_state at its folio->private in the current implementation.
> 
> Benchmark details can be found in the RFC v2 cover letter:
> https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
> 
> Changes in v8:
> - 01/15: add a sanity check in f2fs_folio_has_ffs(): if a large folio
>   carries non-pointer private data (PAGE_PRIVATE_NOT_POINTER), report
>   it with f2fs_bug_on() and return false instead of casting the value
>   to a struct f2fs_folio_state pointer.
> - 03/15: cache sbi before dropping read_pages_pending, so
>   f2fs_finish_read_bio() no longer uses F2FS_F_SB(folio) after a sync
>   reader has been woken up and may have released the folio.
> - 05/15: clear the dirty bits of the whole folio on success, otherwise
>   post-EOF subpages (e.g. fill_zero() with FALLOC_FL_KEEP_SIZE, or a
>   block migration beyond EOF) keep the folio redirtied forever;
>   - recheck cp_error after f2fs_balance_fs() or the trylock_op() backoff
>     dropped the folio lock, and drop the folio instead of writing on a
>     filesystem which can no longer checkpoint;
>   - reset the per-folio submitted counter for each dirty range.
> - 07/15: since the whole valid range below will be marked dirty, a large
>   folio whose subpage was invalidated by a racing collapse/insert/punch
>   hole is not usable; after folio_lock(), unlock it and return
>   VM_FAULT_NOPAGE (-EFAULT) so the faulting access is retried instead
>   of dirtying the stale subpages.
> - 08/15: keep PAGE_PRIVATE_GCING on a failed GC write which redirties
>   the folio, and clear it only when no dirty subpage is left; mark the
>   target subpage dirty in f2fs_defragment_range() and
>   f2fs_migrate_blocks(); and submit the cached bio before unlocking a
>   large folio in move_data_page() to avoid an AB-BA deadlock with
>   WB_SYNC_ALL.
> - 15/15: make redirty_blocks() large-folio aware: allocate the
>   f2fs_folio_state and mark the cluster range dirty.  This is mainly
>   for the chattr +c (FS_IOC_SETFLAGS) case, where the compression flag
>   is set on an inode that keeps using large folios until it is evicted;
>   since F2FS_IOC_COMPRESS_FILE is already rejected for large-folio
>   mappings, this hint state is only reachable through chattr +c.
>   Without this, F2FS_IOC_DECOMPRESS_FILE and
>   F2FS_IOC_RELEASE_COMPRESS_BLOCKS would find no dirty range and
>   silently skip the rewrite.
> 
> Many thanks to Chao for the detailed v7 review; several of the fixes
> above are folded in from his suggestions.
> 
> Changes in v7:
> - 01/15: realloc the f2fs_folio_state in f2fs_get_lock_data_folio() if
>   it was released while the folio was unlocked.
> - 04/15: on an atomic buffered write repeat if folio was unlocked, check the 
> COW block before reserving it again, so inc_atomic_write_cnt() is not called twice.
> - 08/15: clear PAGE_PRIVATE_GCING if large folio has no dirty sub pages
>  when f2fs_trylock_op() fails before any write is submitted in f2fs_do_write_data_page().
> 
> No other functional changes.
> 
> Changes in v6:
> - Rebased onto the f2fs dev branch (fd106ada4dee).
> - v5 12/16 ("f2fs: wait for folio writeback before ffs_detach_free")
>   is dropped, because the lkp warning reported by [1] was caused by a
>   write_pages_pending leak on the GC truncate path.
> 
> - Improve large-folio support in the f2fs_do_write_data_page() path used
>   by GC:
>   - 05/15: use __folio_start_writeback(folio, folio_test_dirty(folio))
>     in both the IPU and OPU paths, so a single-subpage GC write does not
>     clear PAGECACHE_TAG_TOWRITE while other subpages are still dirty [3].
>   - 05/15: add f2fs_ffs_put_write_pending() as the common writeback
>     completion helper; do_write_block() only ends writeback for order-0
>     folios.
>   - 08/15: move the write_pages_pending increment from move_data_page()
>     into f2fs_do_write_data_page(), take it only after
>     __folio_start_writeback(), and drop it on every error path.
>     move_data_page() no longer adjusts write_pages_pending or clears
>     gcing on error [1].
> 
> - 02/15: compute bio_offset/bio_len against the folio actually added to
>   the bio [5].
> 
> - 05/15, 06/15: fix the order-0 dirty accounting leak in the cp_error
>   path [2].
> 
> - 10/15: allocate ffs before f2fs_truncate_read_extent() [4].
> 
> - 11/15: move the existing truncated-page handling into
>   f2fs_clear_truncated_page_state() and reuse it for the subpage-aware
>   large-folio writeback path, including the -ENOENT/NULL_ADDR case [2].
> 
> Link to v5: [6]
> 
> Many thanks to Chao, Daeho and Jaegeuk for the reviews, and to the
> kernel test robot for the report.
> 
> [1] https://lore.kernel.org/oe-lkp/202610081027.b13dcf10-lkp@intel.com
> [2] https://lore.kernel.org/r/6be679d1-d8ab-41b3-9975-1f1bcd552579@kernel.org
> [3] https://lore.kernel.org/r/fc101bc7-6ece-4a30-9e19-9b32376489a8@kernel.org
> [4] https://lore.kernel.org/r/36220ef3-5b00-4aa1-ad11-60b10857a886@kernel.org
> [5] https://lore.kernel.org/r/atA8dsZ35E6wTMD6@google.com
> [6] https://lore.kernel.org/r/20261014064445.2835813-1-zhaonanzhe@xiaomi.com/
> 
> Nanzhe Zhao (15):
>   f2fs: extend folio state for large folio write path
>   f2fs: carry subpage offset and count in write IO
>   f2fs: support regular file buffered writes on large folios
>   f2fs: support atomic file large folios buffered write
>   f2fs: support large folio writeback
>   f2fs: account large folio dirty data at block granularity
>   f2fs: prepare mmap write faults for large folios
>   f2fs: make GC migration large-folio aware
>   f2fs: optimize small block size large folio read
>   f2fs: support partial uptodate large folio read
>   f2fs: handle partial truncate of large folio dirty subpages
>   f2fs: fix zeroing paths for large folios
>   f2fs: handle block cloning within the same large folio
>   f2fs: allow large folio support to writeable files
>   f2fs: make compressed files compatible with large folio
> 
>  Documentation/filesystems/f2fs.rst |   10 +
>  fs/f2fs/checkpoint.c               |   40 +-
>  fs/f2fs/compress.c                 |    7 +-
>  fs/f2fs/data.c                     | 1550 +++++++++++++++++++++++++---
>  fs/f2fs/dir.c                      |    2 +-
>  fs/f2fs/f2fs.h                     |  182 +++-
>  fs/f2fs/file.c                     |  269 +++--
>  fs/f2fs/gc.c                       |   51 +-
>  fs/f2fs/inline.c                   |    3 +-
>  fs/f2fs/inode.c                    |    4 +-
>  fs/f2fs/namei.c                    |    1 +
>  fs/f2fs/node.c                     |    2 +-
>  fs/f2fs/segment.c                  |   13 +-
>  13 files changed, 1869 insertions(+), 265 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
