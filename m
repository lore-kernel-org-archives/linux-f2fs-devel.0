Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77779CD8C9F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PR1B22nXcA+Ow4zAPV7ySLJtPUYVmlpBGrXu2h4kNyU=; b=UGnyXIOMpfulqsc4fPvuGlqYr2
	FWRNGtaLANRXe44x+zBpvmeb7URcV8tlnf2aPFLKP/rjYoXlFO9UO+4lEppHTp4VfBUkUxNCbJLVM
	18kIrAiC7FNxBSkeJuzRkR4GGt7VdJJlwfn07+3en3glkse+iT7iqNxzMAVWJgYt2IGA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wWWDv-0006uP-IN;
	Mon, 08 Jun 2026 09:24:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhaoyang.huang@unisoc.com>) id 1wWWDt-0006uJ-8g
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 09:24:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2GlIsTUOZnOeWK2UlaH1RDqGt/0CYCpbnQv09Gn8gg=; b=l/uzqH5WAlfPt9n1+evCHbiomO
 NbOLlrjGzPpuDjur9YVCvylYBLYxN+RPMLpuG+tFYrXX5HxqudqzblkJ9qPqdyVknoRJREvdZzpfO
 T4LvSNzI5qigQohZIaL5JVJhc6Zb0x5/C1D6G8UV+fVGPbLU9ZSre1wtmXErVcT949/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g2GlIsTUOZnOeWK2UlaH1RDqGt/0CYCpbnQv09Gn8gg=; b=E
 lcYLUz6qsjh9Jz9+ZClwDGsEecT79WV2GJVFBon7ctUdxSnNOgnX3e/At8OW2gWhAQAwEFTRuSXZ8
 lS4n4OxhJmlgVGoaoSl5iqqK3wlAkw46bmQsqWzmvrREaN8SNfZqlYO+V7J1DHu75rkuuD9Soq8Ez
 xo6tMrhFvSa1Ze6k=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWWDp-0000gJ-9D for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 09:24:45 +0000
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
 by SHSQR01.spreadtrum.com with ESMTP id 6589AeON052128
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 8 Jun 2026 17:10:40 +0800 (+08)
 (envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 65899qCr045319;
 Mon, 8 Jun 2026 17:09:52 +0800 (+08)
 (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4gYmNH6qBtz2NRRn4;
 Mon,  8 Jun 2026 17:05:35 +0800 (CST)
Received: from bj03382pcu03.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 8 Jun 2026 17:09:50 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Date: Mon, 8 Jun 2026 17:09:39 +0800
Message-ID: <20260608090939.2190185-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 65899qCr045319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
 s=default; t=1780909809;
 bh=g2GlIsTUOZnOeWK2UlaH1RDqGt/0CYCpbnQv09Gn8gg=;
 h=From:To:Subject:Date;
 b=DeBZqM8oGtoISgnqxIk/+1b+tq8rfz6RLGo/9x/CURRGkxd0ZRKFGaDab/NcyVUek
 wTIQsl7drL3bMvmuCcvJSz88Pf6pS6/4/rhPYME8fwDYK4+iZJd411AcSKTHB8nogV
 AYYTzcABBCt3/nopwr29qkSAd0fzmzYbSGQkxEIrPMZVjTcAD/rRGj/KGdSm4BZ2PI
 swYecyG/DOsQ0LCEaUM9ln0T09Ggu7JC9ToAR+MFUIbGOccC49cmCQ6/HfKCKS6Un7
 vCIa+W4idH5Uo5kZhS/+HPht2OMWouXIqpNQ5sYbCrzzB53OElZ7AgsmH16irT8/mD
 TxKIL6S4uMEeA==
X-Headers-End: 1wWWDp-0000gJ-9D
Subject: [f2fs-dev] [PATCH] Revert "f2fs: remove non-uptodate folio from the
 page cache in move_data_block"
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
From: "zhaoyang.huang via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This reverts commit 9609dd704725a40cd63d915f2ab6c44248a44598.

The kernel panics are keeping to be reported especially when the f2fs
partition get almost full. By investigation, we find that the reason is
one f2fs page got freed to buddy without being deleted from LRU and the
root cause is the race happened in [2] which is enrolled by this commit.

There are 3 race processes in this scenario, please find below for their
main activities.

The changed code in move_data_block() lets the GC path evict the tail-end
folio from the page cache through folio_end_dropbehind().  Once
folio_unmap_invalidate() removes the folio from mapping->i_pages, the
page-cache references for all pages in the folio are dropped.  The folio
is then kept alive only by temporary external references, which allows a
later split to operate on a folio whose subpages are no longer protected
by page-cache references.

After the page-cache references are gone, split_folio_to_order() can
split the big folio into individual pages and put the resulting subpages
back on the LRU.  For tail pages beyond EOF, split removes them from the
page cache and drops their page-cache references.  A tail page can then
remain on the LRU with PG_lru set while holding only the split caller's
temporary reference.  When free_folio_and_swap_cache() drops that final
reference, the page enters the final folio_put() release path.

In parallel, folio_isolate_lru() can observe the same tail page with a
non-zero refcount and PG_lru set.  It clears PG_lru before taking its own
reference.  If this races with the final folio_put() from the split path,
__folio_put() sees PG_lru already cleared and skips lruvec_del_folio().
The page is then freed back to the allocator while its lru links are
still present in the LRU list.  A later LRU operation on a neighboring
page detects the stale link and reports list corruption.

[1]
[   22.486082] list_del corruption. next->prev should be fffffffec10e0ac8, but was dead000000000122. (next=fffffffec10e0a88)
[   22.486130] ------------[ cut here ]------------
[   22.486134] kernel BUG at lib/list_debug.c:67!
[   22.486141] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[   22.488502] Tainted: [W]=WARN, [O]=OOT_MODULE
[   22.488506] Hardware name: Spreadtrum UMS9230 1H10 SoC (DT)
[   22.488511] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   22.488517] pc : __list_del_entry_valid_or_report+0x14c/0x154
[   22.488531] lr : __list_del_entry_valid_or_report+0x14c/0x154
[   22.488539] sp : ffffffc08006b830
[   22.488542] x29: ffffffc08006b868 x28: 0000000000003020 x27: 0000000000000000
[   22.488553] x26: 0000000000000000 x25: 0000000000000004 x24: fffffffec10e0ac0
[   22.488564] x23: 00000000000000e8 x22: 0000000000000024 x21: dead000000000122
[   22.488574] x20: fffffffec10e0a88 x19: fffffffec10e0ac8 x18: ffffffc080061060
[   22.488585] x17: 20747562202c3863 x16: 6130653031636566 x15: 0000000000000058
[   22.488595] x14: 0000000000000004 x13: ffffff80f91e0000 x12: 0000000000000003
[   22.488605] x11: 0000000000000003 x10: 0000000000000001 x9 : ffe85721f0e25f00
[   22.488615] x8 : ffe85721f0e25f00 x7 : 0000000000000000 x6 : 6c65645f7473696c
[   22.488625] x5 : ffffffed39b23026 x4 : 0000000000000000 x3 : 0000000000000010
[   22.488636] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000006d
[   22.488647] Call trace:
[   22.488651]  __list_del_entry_valid_or_report+0x14c/0x154 (P)
[   22.488661]  __folio_put+0x2bc/0x434
[   22.488670]  folio_put+0x28/0x58
[   22.488678]  do_garbage_collect+0x1a34/0x2584
[   22.488689]  f2fs_gc+0x230/0x9b4
[   22.488697]  f2fs_fallocate+0xb90/0xdf4
[   22.488706]  vfs_fallocate+0x1b4/0x2bc
[   22.488716]  __arm64_sys_fallocate+0x44/0x78
[   22.488725]  invoke_syscall+0x58/0xe4
[   22.488732]  do_el0_svc+0x48/0xdc
[   22.488739]  el0_svc+0x3c/0x98
[   22.488747]  el0t_64_sync_handler+0x20/0x130
[   22.488754]  el0t_64_sync+0x1c4/0x1c8

[2]
CPU0 (f2fs GC)              CPU1 (split_folio_to_order)          CPU2 (folio_isolate_lru)

F: pagecache refs = n
F: extra refs = GC + split
F: PG_lru set
move_data_block()
folio = f2fs_grab_cache_folio(F)
...
__folio_set_dropbehind(F)
folio_unlock(F)
folio_end_dropbehind(F)
  folio_unmap_invalidate(F)
    __filemap_remove_folio(F)
    folio_put_refs(F, n)
folio_put(F)
                            split_folio_to_order(F)
                              folio_ref_freeze(F, 1)
                              ...
                              lru_add_split_folio(T)
                                list_add_tail(&T->lru, &F->lru)
                                folio_set_lru(T)
                              __filemap_remove_folio(T)
                              folio_put_refs(T, 1)
                              /* T refcount == 1, PageLRU set */
                                                                  folio_isolate_lru(T)
                                                                    folio_test_clear_lru(T)
                            free_folio_and_swap_cache(T)
                              folio_put(T)
                                /* refcount: 1 -> 0 */
                                __folio_put(T)
                                  __page_cache_release(T)
                                    folio_test_lru(T) == false
                                    /* skip lruvec_del_folio(T) */
                                  free_frozen_pages(T)
                                                                  folio_get(T)
                                                                  lruvec_del_folio(T)
later:
  list_del(adjacent->lru)
    next == &T->lru
    next->prev == LIST_POISON / PCP freelist
    BUG

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/f2fs/gc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ba93010924c0..3084e05e22f2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1468,11 +1468,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 put_out:
 	f2fs_put_dnode(&dn);
 out:
-	if (!folio_test_uptodate(folio))
-		__folio_set_dropbehind(folio);
-	folio_unlock(folio);
-	folio_end_dropbehind(folio);
-	folio_put(folio);
+	f2fs_folio_put(folio, true);
 	return err;
 }
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
