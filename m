Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DCECD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McaUF9xuMmU98UFfl3S+YCjqkT4JuN1i2sL3LWTvniM=; b=QzDGbgmz3ECmRiMJRjDUCMVfiq
	xwvp6N+Poioh0eDpwPWvFD6nyyGYp0WX6F8iw07465oYN/JpG5ajZiJvjrq25OGlQU1zTld8AXhRk
	ueVIgxeU1DHKd0wnGYHCO5VxGD3ZDVo5fw7HMeXfpoycdgH8vXVkRT155RGloQQzJMiE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ97y-000215-JV;
	Mon, 15 Jun 2026 15:21:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wZ97w-00020y-Vq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HNuZclxP7Sgr+xIYhJyVFroRWhcV93jROB10xGPxqcI=; b=VQX6n4B+LQCuiVuEcdJMMy3XVS
 BCBh/Q649+hRRu/No4wveQLzPPnEANyQYsxvqAJ745quo8c/h5GRkSsgqUElYqYdD+ed1vHaD5MaV
 hljWHC3dq74p2vijRgSBtkUlOL8QbFHyrBOjck5ke8Y0m2j1HhBSSfmVD8/ZtnjUrMK0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HNuZclxP7Sgr+xIYhJyVFroRWhcV93jROB10xGPxqcI=; b=nV6l2TosW1FiDuhjAeKiz1Jf8d
 yPmijdun64UY0eEj9ytWrARW1HVq5UhIuz/QDR7weTDRTYrdsfwLJjWo81VtEUV1I2ImfDkann17B
 a69TNNtI42p7z7htwdCTZW1mQc4OLcP5coSBtE4OOoOczdJrujfNzcAsD4vYLIte7Ews=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ97s-0000w1-7x for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:21:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BDF54334B;
 Mon, 15 Jun 2026 15:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5341F00A3A;
 Mon, 15 Jun 2026 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781536874;
 bh=HNuZclxP7Sgr+xIYhJyVFroRWhcV93jROB10xGPxqcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ITt8ClhU14YGXf/mzfptqQ6I5mj8WN+nxoPghUc4QcprEDSwoKnJmbUZ3WqSBTOiC
 /E8+50Fj6vMZIkVsC0tqBQoRJV5rltIIT191xGDc6uZQkkHpP0Wt53COfQ3boROgOA
 aNu/nFvskS4rhw+85nLXjldhn8jp7mnUt0XUjjq5fEVENFdOBwBGIRhIZ/nabRs1ON
 m3NrVdxRpu2+Ov2RC/9QGdM1t3g4n3y58riSlalZoRUrVRdSgE1SjKgX6kzwaNM8CJ
 RsTY3h0WcrwUkem3k1L89nkJxhqq+vTh8TZKra6J2uY2Apx7tmntHxB5mCq6psYOds
 S/UHk90kNizkA==
Date: Mon, 15 Jun 2026 15:21:12 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ajAYaEWFnZwDF1Ty@google.com>
References: <20260608090939.2190185-1-zhaoyang.huang@unisoc.com>
 <f3948889-4ac3-422b-8dcf-fd3a7c27b304@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3948889-4ac3-422b-8dcf-fd3a7c27b304@kernel.org>
X-Headers-End: 1wZ97s-0000w1-7x
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove non-uptodate folio from
 the page cache in move_data_block"
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
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/12, Chao Yu wrote:
> On 6/8/26 17:09, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > This reverts commit 9609dd704725a40cd63d915f2ab6c44248a44598.
> > 
> > The kernel panics are keeping to be reported especially when the f2fs
> > partition get almost full. By investigation, we find that the reason is
> > one f2fs page got freed to buddy without being deleted from LRU and the
> > root cause is the race happened in [2] which is enrolled by this commit.
> > 
> > There are 3 race processes in this scenario, please find below for their
> > main activities.
> > 
> > The changed code in move_data_block() lets the GC path evict the tail-end
> > folio from the page cache through folio_end_dropbehind().  Once
> > folio_unmap_invalidate() removes the folio from mapping->i_pages, the
> > page-cache references for all pages in the folio are dropped.  The folio
> > is then kept alive only by temporary external references, which allows a
> > later split to operate on a folio whose subpages are no longer protected
> > by page-cache references.
> > 
> > After the page-cache references are gone, split_folio_to_order() can
> > split the big folio into individual pages and put the resulting subpages
> > back on the LRU.  For tail pages beyond EOF, split removes them from the
> > page cache and drops their page-cache references.  A tail page can then
> > remain on the LRU with PG_lru set while holding only the split caller's
> > temporary reference.  When free_folio_and_swap_cache() drops that final
> > reference, the page enters the final folio_put() release path.
> > 
> > In parallel, folio_isolate_lru() can observe the same tail page with a
> > non-zero refcount and PG_lru set.  It clears PG_lru before taking its own
> > reference.  If this races with the final folio_put() from the split path,
> > __folio_put() sees PG_lru already cleared and skips lruvec_del_folio().
> > The page is then freed back to the allocator while its lru links are
> > still present in the LRU list.  A later LRU operation on a neighboring
> > page detects the stale link and reports list corruption.
> > 
> > [1]
> > [   22.486082] list_del corruption. next->prev should be fffffffec10e0ac8, but was dead000000000122. (next=fffffffec10e0a88)
> > [   22.486130] ------------[ cut here ]------------
> > [   22.486134] kernel BUG at lib/list_debug.c:67!
> > [   22.486141] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> > [   22.488502] Tainted: [W]=WARN, [O]=OOT_MODULE
> > [   22.488506] Hardware name: Spreadtrum UMS9230 1H10 SoC (DT)
> > [   22.488511] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   22.488517] pc : __list_del_entry_valid_or_report+0x14c/0x154
> > [   22.488531] lr : __list_del_entry_valid_or_report+0x14c/0x154
> > [   22.488539] sp : ffffffc08006b830
> > [   22.488542] x29: ffffffc08006b868 x28: 0000000000003020 x27: 0000000000000000
> > [   22.488553] x26: 0000000000000000 x25: 0000000000000004 x24: fffffffec10e0ac0
> > [   22.488564] x23: 00000000000000e8 x22: 0000000000000024 x21: dead000000000122
> > [   22.488574] x20: fffffffec10e0a88 x19: fffffffec10e0ac8 x18: ffffffc080061060
> > [   22.488585] x17: 20747562202c3863 x16: 6130653031636566 x15: 0000000000000058
> > [   22.488595] x14: 0000000000000004 x13: ffffff80f91e0000 x12: 0000000000000003
> > [   22.488605] x11: 0000000000000003 x10: 0000000000000001 x9 : ffe85721f0e25f00
> > [   22.488615] x8 : ffe85721f0e25f00 x7 : 0000000000000000 x6 : 6c65645f7473696c
> > [   22.488625] x5 : ffffffed39b23026 x4 : 0000000000000000 x3 : 0000000000000010
> > [   22.488636] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000006d
> > [   22.488647] Call trace:
> > [   22.488651]  __list_del_entry_valid_or_report+0x14c/0x154 (P)
> > [   22.488661]  __folio_put+0x2bc/0x434
> > [   22.488670]  folio_put+0x28/0x58
> > [   22.488678]  do_garbage_collect+0x1a34/0x2584
> > [   22.488689]  f2fs_gc+0x230/0x9b4
> > [   22.488697]  f2fs_fallocate+0xb90/0xdf4
> > [   22.488706]  vfs_fallocate+0x1b4/0x2bc
> > [   22.488716]  __arm64_sys_fallocate+0x44/0x78
> > [   22.488725]  invoke_syscall+0x58/0xe4
> > [   22.488732]  do_el0_svc+0x48/0xdc
> > [   22.488739]  el0_svc+0x3c/0x98
> > [   22.488747]  el0t_64_sync_handler+0x20/0x130
> > [   22.488754]  el0t_64_sync+0x1c4/0x1c8
> > 
> > [2]
> > CPU0 (f2fs GC)              CPU1 (split_folio_to_order)          CPU2 (folio_isolate_lru)
> > 
> > F: pagecache refs = n
> > F: extra refs = GC + split
> > F: PG_lru set
> > move_data_block()
> > folio = f2fs_grab_cache_folio(F)
> > ...
> > __folio_set_dropbehind(F)
> > folio_unlock(F)
> > folio_end_dropbehind(F)
> >    folio_unmap_invalidate(F)
> >      __filemap_remove_folio(F)
> >      folio_put_refs(F, n)
> > folio_put(F)
> >                              split_folio_to_order(F)
> >                                folio_ref_freeze(F, 1)
> >                                ...
> >                                lru_add_split_folio(T)
> >                                  list_add_tail(&T->lru, &F->lru)
> >                                  folio_set_lru(T)
> >                                __filemap_remove_folio(T)
> >                                folio_put_refs(T, 1)
> >                                /* T refcount == 1, PageLRU set */
> >                                                                    folio_isolate_lru(T)
> >                                                                      folio_test_clear_lru(T)
> >                              free_folio_and_swap_cache(T)
> >                                folio_put(T)
> >                                  /* refcount: 1 -> 0 */
> >                                  __folio_put(T)
> >                                    __page_cache_release(T)
> >                                      folio_test_lru(T) == false
> >                                      /* skip lruvec_del_folio(T) */
> >                                    free_frozen_pages(T)
> >                                                                    folio_get(T)
> >                                                                    lruvec_del_folio(T)
> > later:
> >    list_del(adjacent->lru)
> >      next == &T->lru
> >      next->prev == LIST_POISON / PCP freelist
> >      BUG
> > 
> 
> Missing Fixes and Cc: stable lines.

Applied with them.

> 
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> I suspect this is a bug of MM, we can revert this first, and reapply after we
> fix this iusse in MM.
> 
> Thanks,
> 
> > ---
> >   fs/f2fs/gc.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index ba93010924c0..3084e05e22f2 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1468,11 +1468,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
> >   put_out:
> >   	f2fs_put_dnode(&dn);
> >   out:
> > -	if (!folio_test_uptodate(folio))
> > -		__folio_set_dropbehind(folio);
> > -	folio_unlock(folio);
> > -	folio_end_dropbehind(folio);
> > -	folio_put(folio);
> > +	f2fs_folio_put(folio, true);
> >   	return err;
> >   }
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
