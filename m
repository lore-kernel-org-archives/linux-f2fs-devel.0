Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94530606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bhBlHEEq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OHbYJ1wD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cyon7sJb;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V4WpbkbD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=oS93W18eHhZoR+7p5G9Q4zvLddUTimrHTJ7a2sm4ixU=; b=bhBlHEEq/jVcfWiqpFXD0ZxVKt
	aNfIH35yAzYDnOika0BAIYI1muNT4qaa4HHG9M138LAmNe+3t4ugYP7i72BEclAr9ioqUe+KqSLOS
	5Nc3b32jqY+Ryhfkx1isog2hCKGcwkhSGuVoSq6UwIAQwvvu7S5BJWNkKhD0EkccIUhU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBTq-0000000040u-3Ggy;
	Mon, 26 Oct 2026 03:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBTn-0000000040h-2PLK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cy6PxPSPCs5rPCIB2XT0pE/iYjdEh8oPtZ9NuYgWXOQ=; b=OHbYJ1wDGPQjWm3/m5IIzmswUc
 VmOYXtEdLdqQGOScUkJc/iokiQXjN1Pj2bhqMxC1wbQ7qF/1Sbll17+pUl7wNbwwlcb/EIGbCYEN9
 Cjl8poHNsYC0jXQazWlq5OHElz/Wyty5oSFwGRZq7REqeAzPUeil8soUWdbtGaBwzbB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cy6PxPSPCs5rPCIB2XT0pE/iYjdEh8oPtZ9NuYgWXOQ=; b=Cyon7sJbRAPhqb2aBcVpVKCpOU
 WxZTDNx0zVzAdM5LQxexDs5R1XxNMkPNk1Z9bxbBwiU0u7WCQFIQkB1pc6ncGxvLChNt7OjxI0F/X
 GkU9A4ilYnwwQdpdTnHljgUinGCM35xEYGEGtVRnvm6PjkBRzWrbtY7xse1XIB2IbidU=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBTl-000000000bG-13XT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:34:35 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-398a0a87595so1376182a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985667; x=1793590467; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cy6PxPSPCs5rPCIB2XT0pE/iYjdEh8oPtZ9NuYgWXOQ=;
 b=V4WpbkbD2uUjUJDWIax8namw+3XZGMZaf2X/AHxBIyqMh1aIMUW8pFTpc+4q84Xe4n
 SeE5wE+JFiYmPh/fdcFTedzLLwKT5pCKrk38AiYlUrNrdPp6xz1/B+scKbOFvbQDQvil
 sE4R0N8pB3WI0faDTKaE2Ov4yhe25FD3kid2TjD9rE4n9FWcLOxF+nYZH5+YpwaXyPst
 b6aw/FQfS4l7WSv+Eikpd73COY/Giw2uCP+jQHhsi1FaGbQR48ZFRpxKtdXp14/QGRSH
 9OO1yT6foqYq63ZiCbwzQ/XHV75XQq4IFr6pmIaYyNiTsovpcFPfC5/c4oncOLh++9u1
 Zabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985667; x=1793590467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cy6PxPSPCs5rPCIB2XT0pE/iYjdEh8oPtZ9NuYgWXOQ=;
 b=TQjttKDZ9YGfOc51AQN2wj9ntPuOT2+9cZYB01Ny2HQ/WcYeyHugtnHb/S/xxzJjOr
 /NtPukrwutaPJIG8cNwd92fEY6XaEYRr8QmhSQpp9pHTSLpztqy1s9wwHw1mpRz2h/rI
 /q96/MUtAZWqXHMM93+LwHNTWXoIpQDbCPFvBkrKdvkEUcYDOnEMOh3dUKpYm16M/rIb
 3Rw/874JaMUSgB7uLUXLsNGZu7/FdpgzwZNyjwR0XpUFOngOaxuh8I4l7zzu3D0N5Jna
 EnUfWCjx+55feVFww4Nebc3ZGwWl2R9FEeAhqFHXoSewf+vzoZQA87euyXPtE+IiWw6N
 b1tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJQg4J3qjKRStSyJQzoBdHZV6vHIwjs07Bx6xnWrNqFMeKUZrBTJYIQyTB2iAPJaTUHfJI1m0V3Fpj2hvCDjlE@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIaPuUWVbSE6KHFk4RcIuelyfqhulkmjUzGg9FMwWvPKf6uubx5
 D03D2/M7SZMtlzKQe28WceN/3bPjI/mj0UFh+IRD0XYX0eSOTThqPMHV
X-Gm-Gg: AYBFou2KDY9gUUbd2z7xrPIw883n0NSvq3e8XOrq0Jv8ScRQQyirdtVUL/lCmgLpG8L
 XhDXeFQ8OtAAN6/z8VeRe99A6unjw2yg84uubJCyO9vcni2LPs25CkwmeUoYkJZMdon76347/nD
 D2k3lN03vpIxMiwF4LsN3CJbM+K5EsU7n7sgwbuuEEL8AXmiPgBIwPAjMvAbof1sE/4uVuWvx7s
 edJtqrvMeXxdBlqw3PwJX1C5cODrYJizC3zMs3Y+qpd+BCFq+FaNO+5LPuID1bJV5sZSqXJIN1J
 rARtIZYo16Uow57sIZwTOUwuDfyXKE/hDEEZLg4NfKVPSx1tJi25jQT2bnkJtBAvuw95v6G0YGp
 Xf5iSnb043rTIee8eBxYfoS4saud0ElELo14x6mnlWLx9h08yErUhDLuFwmwZKM8oAMjH6m+94w
 CVJPTn2dh1VS4HMnw8siqB4FNe3jXaDJ7JHOXwAFAnNKagf0rMnTbwkOp+SfKHQmfyySeAM0VkX
 nYoIzJ94NIo7OD6pW1BWgdHvveDbYATOY89TPFzpN7s4V5EmIc/BkXhMiBmyNsIqUAF14NqOOny
 Y3d0h2QD8RYjvmTud945y8YypXtou14+D+p0If09hGgUmRo2YGNXx3eEoe0QYTof2hs=
X-Received: by 2002:a17:90b:4a81:b0:3ad:ce24:acfa with SMTP id
 98e67ed59e1d1-3adeaae632emr4563862a91.20.1792985667269; 
 Sun, 25 Oct 2026 20:34:27 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0667asm6519736a91.14.2026.10.25.20.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:34:26 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:34:22 +0800
Message-ID: <20261026033422.780601-1-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6667c6de-af4b-42b1-8bd6-65c4232bf86e@kernel.org>
References: <6667c6de-af4b-42b1-8bd6-65c4232bf86e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBTl-000000000bG-13XT
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chao,

Thanks for forwarding the local Sashiko review.  I went through every
comment.  Below I quote the review text and reply item by item.

== Patch 1: f2fs: extend folio state for large folio write path ==

> Should this check also exclude the PAGE_PRIVATE_NOT_POINTER bit?
> If a large folio has no ffs structure attached, but has an integer stored in
> folio->private with the PAGE_PRIVATE_NOT_POINTER bit set, this function will
> incorrectly return true.
>
> If f2fs_folio_has_ffs() returns true because an integer with the
> PAGE_PRIVATE_NOT_POINTER bit is stored in folio->private, does this code cast
> that raw integer into a struct f2fs_folio_state pointer?
> This would return an invalid out-of-bounds address for the private_flags
> field, leading to a crash when it gets dereferenced.
>
> Can this sequence trigger an invalid pointer dereference and a kernel panic?
> If PAGE_PRIVATE_SET_FUNC (e.g., folio_set_f2fs_gcing) is called on a large
> folio without an ffs structure:
> 1. folio->private is set to BIT(PAGE_PRIVATE_NOT_POINTER) (which is 1).
> 2. f2fs_folio_flags_addr() is called.
> 3. f2fs_folio_has_ffs() sees folio_test_large() and private != 0, returning
>    true.
> 4. f2fs_folio_flags_addr() casts the integer 1 to a struct f2fs_folio_state
>    pointer, returning a memory address based off this invalid pointer.
> 5. set_bit() attempts to write to this invalid unmapped memory address.

In the current implementation, every path that can carry a large folio also
allocates and keeps f2fs_folio_state; the private-flag layout is only used
for order-0 folios.  However, I did find one race window:

    f2fs_get_read_data_folio():
        if (f2fs_ffs_test_blk_uptodate(folio, index)) {
            folio_unlock(folio);
            return folio;
        }

    f2fs_get_lock_data_folio():
        folio = f2fs_get_read_data_folio(inode, index, 0, for_write, NULL);
        ...
        folio_lock(folio);
        if (unlikely(folio->mapping != mapping ||
                     !f2fs_ffs_test_blk_uptodate(folio, index))) {
            f2fs_folio_put(folio, true);
            return ERR_PTR(-EIO);
        }
        return folio;

A concurrent shrink can call ->release_folio() in the unlock window.  On a
clean large folio, f2fs_release_folio() detaches and frees the ffs:

    bool f2fs_release_folio(struct folio *folio, gfp_t wait)
    {
        if (folio_test_dirty(folio))
            return false;

        ffs_detach_free(folio);
        return true;
    }

__remove_mapping() then fails the folio_ref_freeze() check because the
caller still holds a reference, so the folio stays in the mapping but has
no ffs.  On relock, the fully uptodate folio hits the early check in
f2fs_ffs_test_blk_uptodate():

    if (folio_test_uptodate(folio))
        return true;

and is returned to GC.  GC later calls folio_set_f2fs_gcing() on a large
folio whose private is NULL.  This is the same root cause as the Patch 5
"large folio without ffs" comment; fixing this also fixes that one.

Expected diff:

    diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
    @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode,
        /* wait for read completion */
        folio_lock(folio);
    -   if (unlikely(folio->mapping != mapping ||
    -                !f2fs_ffs_test_blk_uptodate(folio, index))) {
    +   if (unlikely(folio->mapping != mapping)) {
            f2fs_folio_put(folio, true);
            return ERR_PTR(-EIO);
        }
    +   if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio)) {
    +       if (!f2fs_ffs_find_or_alloc(folio)) {
    +           f2fs_folio_put(folio, true);
    +           return ERR_PTR(-ENOMEM);
    +       }
    +   }
    +   if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
    +       f2fs_folio_put(folio, true);
    +       return ERR_PTR(-EIO);
    +   }
        return folio;

== Patch 3: f2fs: support regular file buffered writes on large folios ==

> Can this result in a spurious -EFSCORRUPTED error during a direct I/O
> fallback?
> In f2fs_preallocate_blocks(), FI_PREALLOCATED_ALL is set unconditionally
> when f2fs_map_blocks() returns 0.  However, for direct I/O, the allocation
> exits early on physically unmergeable extents, meaning map.m_len might be
> smaller than requested.
> ...
> Will reading the unallocated hole then yield a NULL_ADDR and trigger the
> -EFSCORRUPTED failure here?

False Positive. Our code path here is the buffered IO path, not the DIO case described.

> Does this miss updating the ffs dirty bitmap for large folios modified via
> external paths like get_user_pages?
> ...
> Should we be updating the ffs dirty bitmap here after a successful
> filemap_dirty_folio() for large folios?

A writable mapping goes through f2fs_vm_page_mkwrite(), which marks the
whole valid folio dirty before folio_mark_dirty():

    if (folio_test_large(folio))
        f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
    folio_mark_dirty(folio);

A GUP/DMA write needs a writable PTE, so it is covered by that
page_mkwrite.  I am not aware of a FOLL_WRITE path that bypasses
page_mkwrite.

== Patch 4: f2fs: support atomic file large folios buffered write ==

> Can returning -EAGAIN here cause atomic write counts to be double counted for
> prior subpages?
> ...
> Because cow_has_reserved_block defaults to false and the COW lookup was
> skipped, inc_atomic_write_cnt() will be incremented a second time for every
> subpage already processed before the abort.  Could this corrupt the atomic
> write statistics?

This is valid.  For a large folio, the assumption behind this check does
not hold:

    if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
        goto reserve_block;

The retry can be caused by f2fs_balance_fs_folio_locked() dropping the
folio lock and a concurrent reclaim calling ->release_folio(), which frees
the ffs.  The retry is not necessarily caused by a truncate, so the block
at that index can still be NEW_ADDR.

The append branch itself is not new: the original 4K code skipped the COW
lookup in the same way, so a retry there can also double count.  The
large-folio path makes it much easier to hit because balance can retry on
ffs release or folio order change and restarts the whole folio.

The fix is to check the COW block only on retry.  The first attempt keeps
the original fast path (no COW lookup); once f2fs_write_begin() retries,
it passes check_reserved=true so an already reserved NEW_ADDR block is not
reserved and accounted again.  This does not depend on whether a truncate
path clears the block address.

Expected diff:

    diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
    @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
    -           struct inode *inode, pgoff_t index,
    -           block_t *blk_addr, bool *node_changed)
    +           struct inode *inode, pgoff_t index,
    +           block_t *blk_addr, bool *node_changed,
    +           bool check_reserved)
     {
         struct inode *cow_inode = F2FS_I(inode)->cow_inode;
         int err = 0;
         block_t ori_blk_addr = NULL_ADDR;
         bool cow_has_reserved_block = false;
    +    bool append = ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode);

    -    if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
    +    if (append && !check_reserved)
             goto reserve_block;

         /* Look for the block in COW inode first */
         err = __find_data_block(cow_inode, index, blk_addr);
         ...
         if (*blk_addr == NEW_ADDR)
             cow_has_reserved_block = true;

    -    if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
    +    if (append || is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
             goto reserve_block;

    @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
    -           unsigned int len)
    +           unsigned int len, bool retried)
     {
         ...
         err = prepare_atomic_write_begin(sbi, inode, index,
    -                                    &blkaddr, &node_changed);
    +                                    &blkaddr, &node_changed, retried);

    @@ static int f2fs_write_begin(const struct kiocb *iocb,
         bool need_balance = false;
    +    bool retried = false;
         block_t blkaddr = NULL_ADDR;

         ...
         if (err) {
             if (err == -EAGAIN) {
    +            retried = true;
                 f2fs_folio_put(folio, true);
                 goto repeat;
             }
             goto put_folio;
         }

         if (f2fs_balance_fs_folio_locked(folio, mapping, need_balance)) {
    +        retried = true;
             f2fs_folio_put(folio, true);
             goto repeat;
         }

== Patch 5: f2fs: support large folio writeback ==

> Does this prematurely end writeback for the entire large folio when it
> lacks FFS state?
> If a large folio is dirtied without an attached f2fs_folio_state (FFS), it
> bypasses the write_pages_pending reference counter during background
> writeback.
> When the first I/O block completes, f2fs_ffs_put_write_pending() will
> immediately call folio_end_writeback().
> ...
> A Time-Of-Check to Time-Of-Use (TOCTOU) race exists when retrieving a folio
> using f2fs_get_lock_data_folio().  It calls f2fs_get_read_data_folio(), which
> allocates FFS but then unlocks the folio if it is already up-to-date.  Before
> f2fs_get_lock_data_folio() re-acquires the lock, a concurrent memory reclaim
> can call f2fs_release_folio() on the clean folio, freeing its FFS state.

This is the same race as the one described for Patch 1.  Once
f2fs_get_lock_data_folio() rebuilds the ffs after relock, a large folio
cannot enter writeback without ffs, so this one is fixed by the Patch 1
change rather than by a separate put() workaround.

> Can this crash the kernel via f2fs_bug_on() due to a missing NULL_ADDR check?
> ...
> Without that check here, f2fs_outplace_write_data() will hit this assertion
> and panic the kernel:
>      f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);

False Positive. This is covered by 11/15, which adds the subpage-aware truncated state:

    if (err == -ENOENT || fio.old_blkaddr == NULL_ADDR) {
        f2fs_clear_truncated_page_state(folio, i);
        err = 0;
        goto block_done;
    }

> Does this logic trap the worker in an infinite writeback loop on truncated or
> hole-punched large folios?
> ...

Same, covered by 11/15.

== Patch 8: f2fs: make GC migration large-folio aware ==

> Is there a regression here where f2fs_do_write_data_page() bypasses the
> newly added cleanup code on early errors, leaking the PG_f2fs_gcing flag on
> the folio?
> The removed cleanup relies on f2fs_do_write_data_page() performing it at the
> out label added above, but f2fs_do_write_data_page() can return directly
> without reaching that label.  For example, it might fail on lock acquisition:
>   /* Deadlock due to between page->lock and f2fs_lock_op */
>   if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc))
>       return -EAGAIN;
> Could the folio permanently retain the PG_f2fs_gcing flag since the
> caller-side cleanup was removed?

This one is also valid.  The early trylock failure returns directly and
bypasses the common out path.  Expected diff:

    diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
    @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
        /* Deadlock due to between page->lock and f2fs_lock_op */
    -   if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc))
    -       return -EAGAIN;
    +   if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc)) {
    +       if (!f2fs_ffs_has_dirty_subpage(folio))
    +           folio_clear_f2fs_gcing(folio);
    +       return -EAGAIN;
    +   }

The Patch 1 race and this early-return path are the two issues I can fix
immediately; the Patch 4 atomic accounting and the Patch 14 mkwrite part
are also valid, but need more design work.

== Patch 12: f2fs: fix zeroing paths for large folios ==

> Does this code skip zeroing valid subpages of partially up-to-date large
> folios?
> ...
> Should this check be converted to f2fs_ffs_test_blk_uptodate(folio, index)
> to match the changes made in f2fs_get_new_data_folio()?

False Positive. cache_only is only passed for inline data: truncate_page is set only in
the f2fs_has_inline_data() branch of f2fs_do_truncate_blocks().  Inline
data is order-0, and f2fs_read_inline_data() marks the whole folio
uptodate, so the large-folio partially-uptodate case cannot reach the
cache_only branch.

== Patch 13: f2fs: handle block cloning within the same large folio ==

> Does returning -ENOMEM here leave the page cache corrupted?
> Before this check, memcpy_folio() has already copied the data into the
> destination folio.  If f2fs_ffs_find_or_alloc() fails and we return -ENOMEM,
> the page cache modification is not reverted.
> If the cloning operation is aborted, would userspace read the incorrectly
> modified page cache?  Could this corrupted data also be persisted to disk if
> the folio is later dirtied?
> Additionally, when same_folio is true, the block reserved earlier with
> f2fs_reserve_block() does not appear to be reverted on this error path.

f2fs_get_new_data_folio() already calls f2fs_ffs_find_or_alloc() before
returning the locked folio:

    if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
        f2fs_folio_put(folio, true);
        f2fs_put_cache(ientry, true);
        return ERR_PTR(-ENOMEM);
    }

False Positive. For same_folio, fdst is fsrc from f2fs_get_lock_data_folio(), which also
has the ffs.  The later f2fs_ffs_find_or_alloc(fdst) is redundant, and the
post-memcpy ENOMEM path is unreachable in the normal flow.

== Patch 14: f2fs: allow large folio support to writeable files ==

> Can this check be bypassed using FS_IOC_SETFLAGS?
> If a user creates a file, sets it immutable (chattr +i), and drops caches to
> force an inode reload, the mapping is configured with MAX_PAGECACHE_ORDER.
> The user can then clear the immutable flag (chattr -i).
> Since f2fs_setflags_common() clears S_IMMUTABLE but does not downgrade the VFS
> mapping limits, this now-mutable file can be opened for writing and populate
> the page cache with large folios.

Not important.  Our final
direction is to enable large folios for writable files as well.

> Does this cause O(N^2) complexity and massive stat inflation for large folios?
> ...
> For a 2MB large folio, sequentially writing to all 512 subpages will trigger
> this page fault handler 512 times.  Each invocation processes all 512 blocks
> and increments the IO stats by 2MB, resulting in 262,144 block iterations and
> a 1GB inflation to APP_MAPPED_IO.


As explained before, do_shared_fault()'s finish_fault() installs writable PTEs for 
the whole folio. So we should dirty the whole folio to avoid data loss.

I will send a v7 series with these fixes.

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
