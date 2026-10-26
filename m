Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67B606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C88uJwHV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BPq3EN75;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VnsgLOO3;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEuGzX7G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7IRjQ3PxEoYaY04u+xP7PIoxAqD/0cSUV4GJ0Jq2DxM=; b=C88uJwHVF+Qcml
	0Bjwu5Sj8G82dwcIaTA8bx9cziBj9ylRCHhSbiVH8bVMXVjuJAmHh9BXNTgamoLhJGiJXrPNBfWdZ
	toKdvBo/3F3QY100FGoO1irGbcWngPpvZOeg6eruh6XxaByj3Ti9aRsjn1TBtELeJAmGPA0cLouQI
	vmU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLJkK-000000002SM-1o9Q;
	Mon, 26 Oct 2026 12:24:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xLJkJ-000000002SG-3Xdo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 12:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUXKL3eYGQjkLRoiRXuLI7cTTqfZquLI8tZM3w47Qk8=; b=BPq3EN75qK0F9LdE8s+sIwP4Ee
 YPlVhoprE/apP8l8Q6WuOFvBtdO7a6gmYM8pgJX/GskylxujGfuJe5dOWSJDvBfwAKT2oUFlmsvI+
 41lJh4ZqHMxuiTZC4hf09vMExpk2nN0Q90CbHG+UTgCekZFOoVpYPnAnamZ1fADCStB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUXKL3eYGQjkLRoiRXuLI7cTTqfZquLI8tZM3w47Qk8=; b=VnsgLOO33QB8ld0Evw8sm8ccZu
 vIENEPKPcGHYOEFu/pqn5u62dU5FE1n/jjYwTAggyqcb7pwChyecG/3LlivFwEezVqeUJ4se2+Tno
 Pw0h7Md4az/AsEkrvn1DF9UA8EJg4o26YyYSWaWikHapimiswV+ZO75YKZaLZCOYZjdc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLJkI-000000000KT-1QIb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 12:24:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EFC0600CB;
 Mon, 26 Oct 2026 12:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7282C1F01825;
 Mon, 26 Oct 2026 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793017444;
 bh=jUXKL3eYGQjkLRoiRXuLI7cTTqfZquLI8tZM3w47Qk8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eEuGzX7GPbRmiThNaDFv0hX00IjWbhsH895UhWrtsLYphMpUpdXXLOV9nWpdGmvYX
 Kv0CbRa+0WY31EdhLjA8TID3O5HpBBC13/T1bS+n3cvyUUOQbMbr/BJvlCzyQaZN4x
 Ofa7CfQRMPtm+3UW8pPHj9AEqvhIymVFmIwUZa3wbUfHHaNB5p4oIqte/JJRU+uZ7I
 TVVgk2+V3WGMP8o/+8nh1+n7XiRnlJrgHMZ7hNcG4v6NjEYzgDcm9o/TrjUZvf44+K
 tCzoPaHozpY+oqvzj94DZ6n0KX8iHDweHWv2l9SJXS0S2NAoLR3li7PRjDn4i9AsSo
 0mQPf1jQOKR4w==
Message-ID: <3127cedd-cf38-4b56-8a09-81e98c98c5ac@kernel.org>
Date: Mon, 26 Oct 2026 20:24:01 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
References: <6667c6de-af4b-42b1-8bd6-65c4232bf86e@kernel.org>
 <20261026033422.780601-1-nzzhao.sigma@gmail.com>
 <786f87e0-2cf5-4ac1-aec6-0e79677fcb5e@kernel.org>
Content-Language: en-US
In-Reply-To: <786f87e0-2cf5-4ac1-aec6-0e79677fcb5e@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLJkI-000000000KT-1QIb
Subject: Re: [f2fs-dev] [PATCH v6 00/15] f2fs: support & optimize large
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Can you access this? based on v7

https://sashiko.corp.goog/#/patchset/fd106ada4dee4b8adefec791ee9b9681b7b77501..3654402f982852d17f617b488c21626402904c75@sashiko.local

On 10/26/26 20:19, Chao Yu wrote:
> Hi Nanzhe,
> 
> Thanks for the updates.
> 
> On 10/26/26 11:34, Nanzhe Zhao wrote:
>> Hi Chao,
>>
>> Thanks for forwarding the local Sashiko review.  I went through every
>> comment.  Below I quote the review text and reply item by item.
>>
>> == Patch 1: f2fs: extend folio state for large folio write path ==
>>
>>> Should this check also exclude the PAGE_PRIVATE_NOT_POINTER bit?
>>> If a large folio has no ffs structure attached, but has an integer stored in
>>> folio->private with the PAGE_PRIVATE_NOT_POINTER bit set, this function will
>>> incorrectly return true.
>>>
>>> If f2fs_folio_has_ffs() returns true because an integer with the
>>> PAGE_PRIVATE_NOT_POINTER bit is stored in folio->private, does this code cast
>>> that raw integer into a struct f2fs_folio_state pointer?
>>> This would return an invalid out-of-bounds address for the private_flags
>>> field, leading to a crash when it gets dereferenced.
>>>
>>> Can this sequence trigger an invalid pointer dereference and a kernel panic?
>>> If PAGE_PRIVATE_SET_FUNC (e.g., folio_set_f2fs_gcing) is called on a large
>>> folio without an ffs structure:
>>> 1. folio->private is set to BIT(PAGE_PRIVATE_NOT_POINTER) (which is 1).
>>> 2. f2fs_folio_flags_addr() is called.
>>> 3. f2fs_folio_has_ffs() sees folio_test_large() and private != 0, returning
>>>    true.
>>> 4. f2fs_folio_flags_addr() casts the integer 1 to a struct f2fs_folio_state
>>>    pointer, returning a memory address based off this invalid pointer.
>>> 5. set_bit() attempts to write to this invalid unmapped memory address.
>>
>> In the current implementation, every path that can carry a large folio also
>> allocates and keeps f2fs_folio_state; the private-flag layout is only used
>> for order-0 folios.  However, I did find one race window:
>>
>>     f2fs_get_read_data_folio():
>>         if (f2fs_ffs_test_blk_uptodate(folio, index)) {
>>             folio_unlock(folio);
>>             return folio;
>>         }
>>
>>     f2fs_get_lock_data_folio():
>>         folio = f2fs_get_read_data_folio(inode, index, 0, for_write, NULL);
>>         ...
>>         folio_lock(folio);
>>         if (unlikely(folio->mapping != mapping ||
>>                      !f2fs_ffs_test_blk_uptodate(folio, index))) {
>>             f2fs_folio_put(folio, true);
>>             return ERR_PTR(-EIO);
>>         }
>>         return folio;
>>
>> A concurrent shrink can call ->release_folio() in the unlock window.  On a
>> clean large folio, f2fs_release_folio() detaches and frees the ffs:
>>
>>     bool f2fs_release_folio(struct folio *folio, gfp_t wait)
>>     {
>>         if (folio_test_dirty(folio))
>>             return false;
>>
>>         ffs_detach_free(folio);
>>         return true;
>>     }
>>
>> __remove_mapping() then fails the folio_ref_freeze() check because the
>> caller still holds a reference, so the folio stays in the mapping but has
>> no ffs.  On relock, the fully uptodate folio hits the early check in
>> f2fs_ffs_test_blk_uptodate():
>>
>>     if (folio_test_uptodate(folio))
>>         return true;
>>
>> and is returned to GC.  GC later calls folio_set_f2fs_gcing() on a large
>> folio whose private is NULL.  This is the same root cause as the Patch 5
>> "large folio without ffs" comment; fixing this also fixes that one.
>>
>> Expected diff:
>>
>>     diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>     @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode,
>>         /* wait for read completion */
>>         folio_lock(folio);
>>     -   if (unlikely(folio->mapping != mapping ||
>>     -                !f2fs_ffs_test_blk_uptodate(folio, index))) {
>>     +   if (unlikely(folio->mapping != mapping)) {
>>             f2fs_folio_put(folio, true);
>>             return ERR_PTR(-EIO);
>>         }
>>     +   if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio)) {
>>     +       if (!f2fs_ffs_find_or_alloc(folio)) {
>>     +           f2fs_folio_put(folio, true);
>>     +           return ERR_PTR(-ENOMEM);
>>     +       }
>>     +   }
>>     +   if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
>>     +       f2fs_folio_put(folio, true);
>>     +       return ERR_PTR(-EIO);
>>     +   }
>>         return folio;
>>
>> == Patch 3: f2fs: support regular file buffered writes on large folios ==
>>
>>> Can this result in a spurious -EFSCORRUPTED error during a direct I/O
>>> fallback?
>>> In f2fs_preallocate_blocks(), FI_PREALLOCATED_ALL is set unconditionally
>>> when f2fs_map_blocks() returns 0.  However, for direct I/O, the allocation
>>> exits early on physically unmergeable extents, meaning map.m_len might be
>>> smaller than requested.
>>> ...
>>> Will reading the unallocated hole then yield a NULL_ADDR and trigger the
>>> -EFSCORRUPTED failure here?
>>
>> False Positive. Our code path here is the buffered IO path, not the DIO case described.
> 
> Agreed,
> 
> Looks like a bug, maybe we can add f2fs_bug_on for such case?
> 
>>
>>> Does this miss updating the ffs dirty bitmap for large folios modified via
>>> external paths like get_user_pages?
>>> ...
>>> Should we be updating the ffs dirty bitmap here after a successful
>>> filemap_dirty_folio() for large folios?
>>
>> A writable mapping goes through f2fs_vm_page_mkwrite(), which marks the
>> whole valid folio dirty before folio_mark_dirty():
>>
>>     if (folio_test_large(folio))
>>         f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
>>     folio_mark_dirty(folio);
>>
>> A GUP/DMA write needs a writable PTE, so it is covered by that
>> page_mkwrite.  I am not aware of a FOLL_WRITE path that bypasses
>> page_mkwrite.
>>
>> == Patch 4: f2fs: support atomic file large folios buffered write ==
>>
>>> Can returning -EAGAIN here cause atomic write counts to be double counted for
>>> prior subpages?
>>> ...
>>> Because cow_has_reserved_block defaults to false and the COW lookup was
>>> skipped, inc_atomic_write_cnt() will be incremented a second time for every
>>> subpage already processed before the abort.  Could this corrupt the atomic
>>> write statistics?
> 
> I'm a bit confuse about what detailed number inc_atomic_write_cnt() tries to
> record, previously we need to call inc_atomic_write_cnt() only if node_changed
> is true, if it tries to record the first time write on cow inode, IIUC, please
> correct me if I understand incorrectly.
> 
> To Daeho, could you please take a look and help to review the comments and
> below change?
> 
>>
>> This is valid.  For a large folio, the assumption behind this check does
>> not hold:
>>
>>     if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
>>         goto reserve_block;
>>
>> The retry can be caused by f2fs_balance_fs_folio_locked() dropping the
>> folio lock and a concurrent reclaim calling ->release_folio(), which frees
>> the ffs.  The retry is not necessarily caused by a truncate, so the block
>> at that index can still be NEW_ADDR.
>>
>> The append branch itself is not new: the original 4K code skipped the COW
>> lookup in the same way, so a retry there can also double count.  The
>> large-folio path makes it much easier to hit because balance can retry on
>> ffs release or folio order change and restarts the whole folio.
>>
>> The fix is to check the COW block only on retry.  The first attempt keeps
>> the original fast path (no COW lookup); once f2fs_write_begin() retries,
>> it passes check_reserved=true so an already reserved NEW_ADDR block is not
>> reserved and accounted again.  This does not depend on whether a truncate
>> path clears the block address.
>>
>> Expected diff:
>>
>>     diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>     @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>>     -           struct inode *inode, pgoff_t index,
>>     -           block_t *blk_addr, bool *node_changed)
>>     +           struct inode *inode, pgoff_t index,
>>     +           block_t *blk_addr, bool *node_changed,
>>     +           bool check_reserved)
>>      {
>>          struct inode *cow_inode = F2FS_I(inode)->cow_inode;
>>          int err = 0;
>>          block_t ori_blk_addr = NULL_ADDR;
>>          bool cow_has_reserved_block = false;
>>     +    bool append = ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode);
>>
>>     -    if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
>>     +    if (append && !check_reserved)
>>              goto reserve_block;
>>
>>          /* Look for the block in COW inode first */
>>          err = __find_data_block(cow_inode, index, blk_addr);
>>          ...
>>          if (*blk_addr == NEW_ADDR)
>>              cow_has_reserved_block = true;
>>
>>     -    if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
>>     +    if (append || is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
>>              goto reserve_block;
>>
>>     @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
>>     -           unsigned int len)
>>     +           unsigned int len, bool retried)
>>      {
>>          ...
>>          err = prepare_atomic_write_begin(sbi, inode, index,
>>     -                                    &blkaddr, &node_changed);
>>     +                                    &blkaddr, &node_changed, retried);
>>
>>     @@ static int f2fs_write_begin(const struct kiocb *iocb,
>>          bool need_balance = false;
>>     +    bool retried = false;
>>          block_t blkaddr = NULL_ADDR;
>>
>>          ...
>>          if (err) {
>>              if (err == -EAGAIN) {
>>     +            retried = true;
>>                  f2fs_folio_put(folio, true);
>>                  goto repeat;
>>              }
>>              goto put_folio;
>>          }
>>
>>          if (f2fs_balance_fs_folio_locked(folio, mapping, need_balance)) {
>>     +        retried = true;
>>              f2fs_folio_put(folio, true);
>>              goto repeat;
>>          }
>>
>> == Patch 5: f2fs: support large folio writeback ==
>>
>>> Does this prematurely end writeback for the entire large folio when it
>>> lacks FFS state?
>>> If a large folio is dirtied without an attached f2fs_folio_state (FFS), it
>>> bypasses the write_pages_pending reference counter during background
>>> writeback.
>>> When the first I/O block completes, f2fs_ffs_put_write_pending() will
>>> immediately call folio_end_writeback().
>>> ...
>>> A Time-Of-Check to Time-Of-Use (TOCTOU) race exists when retrieving a folio
>>> using f2fs_get_lock_data_folio().  It calls f2fs_get_read_data_folio(), which
>>> allocates FFS but then unlocks the folio if it is already up-to-date.  Before
>>> f2fs_get_lock_data_folio() re-acquires the lock, a concurrent memory reclaim
>>> can call f2fs_release_folio() on the clean folio, freeing its FFS state.
>>
>> This is the same race as the one described for Patch 1.  Once
>> f2fs_get_lock_data_folio() rebuilds the ffs after relock, a large folio
>> cannot enter writeback without ffs, so this one is fixed by the Patch 1
>> change rather than by a separate put() workaround.
>>
>>> Can this crash the kernel via f2fs_bug_on() due to a missing NULL_ADDR check?
>>> ...
>>> Without that check here, f2fs_outplace_write_data() will hit this assertion
>>> and panic the kernel:
>>>      f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);
>>
>> False Positive. This is covered by 11/15, which adds the subpage-aware truncated state:
>>
>>     if (err == -ENOENT || fio.old_blkaddr == NULL_ADDR) {
>>         f2fs_clear_truncated_page_state(folio, i);
>>         err = 0;
>>         goto block_done;
>>     }
>>
>>> Does this logic trap the worker in an infinite writeback loop on truncated or
>>> hole-punched large folios?
>>> ...
>>
>> Same, covered by 11/15.
>>
>> == Patch 8: f2fs: make GC migration large-folio aware ==
>>
>>> Is there a regression here where f2fs_do_write_data_page() bypasses the
>>> newly added cleanup code on early errors, leaking the PG_f2fs_gcing flag on
>>> the folio?
>>> The removed cleanup relies on f2fs_do_write_data_page() performing it at the
>>> out label added above, but f2fs_do_write_data_page() can return directly
>>> without reaching that label.  For example, it might fail on lock acquisition:
>>>   /* Deadlock due to between page->lock and f2fs_lock_op */
>>>   if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc))
>>>       return -EAGAIN;
>>> Could the folio permanently retain the PG_f2fs_gcing flag since the
>>> caller-side cleanup was removed?
>>
>> This one is also valid.  The early trylock failure returns directly and
>> bypasses the common out path.  Expected diff:
>>
>>     diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>     @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>         /* Deadlock due to between page->lock and f2fs_lock_op */
>>     -   if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc))
>>     -       return -EAGAIN;
>>     +   if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc)) {
>>     +       if (!f2fs_ffs_has_dirty_subpage(folio))
>>     +           folio_clear_f2fs_gcing(folio);
>>     +       return -EAGAIN;
>>     +   }
>>
>> The Patch 1 race and this early-return path are the two issues I can fix
>> immediately; the Patch 4 atomic accounting and the Patch 14 mkwrite part
>> are also valid, but need more design work.
>>
>> == Patch 12: f2fs: fix zeroing paths for large folios ==
>>
>>> Does this code skip zeroing valid subpages of partially up-to-date large
>>> folios?
>>> ...
>>> Should this check be converted to f2fs_ffs_test_blk_uptodate(folio, index)
>>> to match the changes made in f2fs_get_new_data_folio()?
>>
>> False Positive. cache_only is only passed for inline data: truncate_page is set only in
>> the f2fs_has_inline_data() branch of f2fs_do_truncate_blocks().  Inline
>> data is order-0, and f2fs_read_inline_data() marks the whole folio
>> uptodate, so the large-folio partially-uptodate case cannot reach the
>> cache_only branch.
>>
>> == Patch 13: f2fs: handle block cloning within the same large folio ==
>>
>>> Does returning -ENOMEM here leave the page cache corrupted?
>>> Before this check, memcpy_folio() has already copied the data into the
>>> destination folio.  If f2fs_ffs_find_or_alloc() fails and we return -ENOMEM,
>>> the page cache modification is not reverted.
>>> If the cloning operation is aborted, would userspace read the incorrectly
>>> modified page cache?  Could this corrupted data also be persisted to disk if
>>> the folio is later dirtied?
>>> Additionally, when same_folio is true, the block reserved earlier with
>>> f2fs_reserve_block() does not appear to be reverted on this error path.
>>
>> f2fs_get_new_data_folio() already calls f2fs_ffs_find_or_alloc() before
>> returning the locked folio:
>>
>>     if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
>>         f2fs_folio_put(folio, true);
>>         f2fs_put_cache(ientry, true);
>>         return ERR_PTR(-ENOMEM);
>>     }
>>
>> False Positive. For same_folio, fdst is fsrc from f2fs_get_lock_data_folio(), which also
>> has the ffs.  The later f2fs_ffs_find_or_alloc(fdst) is redundant, and the
>> post-memcpy ENOMEM path is unreachable in the normal flow.
>>
>> == Patch 14: f2fs: allow large folio support to writeable files ==
>>
>>> Can this check be bypassed using FS_IOC_SETFLAGS?
>>> If a user creates a file, sets it immutable (chattr +i), and drops caches to
>>> force an inode reload, the mapping is configured with MAX_PAGECACHE_ORDER.
>>> The user can then clear the immutable flag (chattr -i).
>>> Since f2fs_setflags_common() clears S_IMMUTABLE but does not downgrade the VFS
>>> mapping limits, this now-mutable file can be opened for writing and populate
>>> the page cache with large folios.
>>
>> Not important.  Our final
>> direction is to enable large folios for writable files as well.
>>
>>> Does this cause O(N^2) complexity and massive stat inflation for large folios?
>>> ...
>>> For a 2MB large folio, sequentially writing to all 512 subpages will trigger
>>> this page fault handler 512 times.  Each invocation processes all 512 blocks
>>> and increments the IO stats by 2MB, resulting in 262,144 block iterations and
>>> a 1GB inflation to APP_MAPPED_IO.
>>
>>
>> As explained before, do_shared_fault()'s finish_fault() installs writable PTEs for 
>> the whole folio. So we should dirty the whole folio to avoid data loss.
>>
>> I will send a v7 series with these fixes.
> 
> Thanks, will take a look soon.
> 
> Thanks,
> 
>>
>> Thanks,
>> Nanzhe
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
