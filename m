Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02303CAC5BB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Sep 2025 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y0HtaC9/QsuSJH/VMFNHwpnnPVDBgBgK52hodmAp3Jg=; b=cD1wLvep5Rk4WQKAv56eOQ0GZj
	SsqHLOvDh6jRNcoCs336LlYPpjv6wCBJ6pgAccvdYBZ1zeeYkhrP+uLHA8x6IzE7Do274UY4NzZ/x
	z9L9eLH04WwVaBlKVdH9iuk2mC6IksQIvkMwFKEs+aykI41q19dnDnNdVavZqFmV/cMw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v2oyF-0003jv-3P;
	Sun, 28 Sep 2025 10:49:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1v2oyD-0003jc-I5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 28 Sep 2025 10:49:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=blQdSWC1XawFVwE+HN6BevfF6cRExgF1/1cBq0PSpkw=; b=Pw14pzj0wUMYSi/OjrWKqy5FYG
 gaiLge6XnG1hY5ugL1kZah8x5JiNZK/KLinyR2KOMkr1wwWtsmOXDaEVubWofNIUfsHRJ62Ml4GhN
 vRvgbcasdH/V5p7wWFCVZgEO0d65qSd1Bs5WGIaqqkEOP9ZT4+6pWvhe3Yo+8yW2mKvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=blQdSWC1XawFVwE+HN6BevfF6cRExgF1/1cBq0PSpkw=; b=U
 D+2Cf7Fm5QkIWZY0d735LfOSBm8L/6QyDrn4qFKfTyApcMZupCuoT/WRHIt62fhoIc/sOGi6EWwoT
 zGspJsgCq9FzQPQ0JhWpnpjM0RklbXBJ6YsBRZv5RMBGucTRe6r+a8xxq0fX8GmaZ1Del9ICahtP2
 +ZF1j06B6FQAT+h8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v2oaC-00014R-In for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 28 Sep 2025 10:24:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D169262153;
 Sun, 28 Sep 2025 10:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55264C4CEF0;
 Sun, 28 Sep 2025 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759055073;
 bh=0SFpAeRsj+73ToPc1OCYE3veDt4HP4vYJm03fBRLVFE=;
 h=From:To:Cc:Subject:Date:From;
 b=M0w1x+sSdZtVvYm0WP1ebGpHK0/h2vx/PYXiyih7hcXRENwvq/tHs3H5tCQG47n2G
 ZMkt8QrzTerKDYx9+Zec+DvaZg4+p1ermiQRK9jxMKWHqAcA4BnkU0IMNhqu+bIPZx
 CgSHwnbldWWwwBE7jyr6LoF2ZIUJdEFexve3BtSj9cle9wFRahYJEHJQyTYH40M/0L
 YSYq1QIwrbb89KiyzhybVzqiOsCVUDTsKixmhgyD1h4TA1iUG/V0qU3ufJN2pFZJ+3
 buvVnSu7k/cstow3Up5U8yIKpMdePiZKX5JM43fz52mWl4c/gtDi1Oo5yIb+liBy6I
 uGGhxtX6u4B2A==
To: jaegeuk@kernel.org
Date: Sun, 28 Sep 2025 18:24:22 +0800
Message-ID: <20250928102422.300429-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
MIME-Version: 1.0
X-Headers-End: 1v2oaC-00014R-In
Subject: [f2fs-dev] [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
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
Cc: linux-kernel@vger.kernel.org, JY <JY.Ho@mediatek.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As JY reported in bugzilla [1],

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
pc : [0xffffffe51d249484] f2fs_is_cp_guaranteed+0x70/0x98
lr : [0xffffffe51d24adbc] f2fs_merge_page_bio+0x520/0x6d4
CPU: 3 UID: 0 PID: 6790 Comm: kworker/u16:3 Tainted: P    B   W  OE      6.12.30-android16-5-maybe-dirty-4k #1 5f7701c9cbf727d1eebe77c89bbbeb3371e895e5
Tainted: [P]=PROPRIETARY_MODULE, [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Workqueue: writeback wb_workfn (flush-254:49)
Call trace:
 f2fs_is_cp_guaranteed+0x70/0x98
 f2fs_inplace_write_data+0x174/0x2f4
 f2fs_do_write_data_page+0x214/0x81c
 f2fs_write_single_data_page+0x28c/0x764
 f2fs_write_data_pages+0x78c/0xce4
 do_writepages+0xe8/0x2fc
 __writeback_single_inode+0x4c/0x4b4
 writeback_sb_inodes+0x314/0x540
 __writeback_inodes_wb+0xa4/0xf4
 wb_writeback+0x160/0x448
 wb_workfn+0x2f0/0x5dc
 process_scheduled_works+0x1c8/0x458
 worker_thread+0x334/0x3f0
 kthread+0x118/0x1ac
 ret_from_fork+0x10/0x20

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220575

The panic was caused by UAF issue w/ below race condition:

kworker
- writepages
 - f2fs_write_cache_pages
  - f2fs_write_single_data_page
   - f2fs_do_write_data_page
    - f2fs_inplace_write_data
     - f2fs_merge_page_bio
      - add_inu_page
      : cache page #1 into bio & cache bio in
        io->bio_list
  - f2fs_write_single_data_page
   - f2fs_do_write_data_page
    - f2fs_inplace_write_data
     - f2fs_merge_page_bio
      - add_inu_page
      : cache page #2 into bio which is linked
        in io->bio_list
						write
						- f2fs_write_begin
						: write page #1
						 - f2fs_folio_wait_writeback
						  - f2fs_submit_merged_ipu_write
						   - f2fs_submit_write_bio
						   : submit bio which inclues page #1 and #2

						software IRQ
						- f2fs_write_end_io
						 - fscrypt_free_bounce_page
						 : freed bounced page which belongs to page #2
      - inc_page_count( , WB_DATA_TYPE(data_folio), false)
      : data_folio points to fio->encrypted_page
        the bounced page can be freed before
        accessing it in f2fs_is_cp_guarantee()

It can reproduce w/ below testcase:
Run below script in shell #1:
for ((i=1;i>0;i++)) do xfs_io -f /mnt/f2fs/enc/file \
-c "pwrite 0 32k" -c "fdatasync"

Run below script in shell #2:
for ((i=1;i>0;i++)) do xfs_io -f /mnt/f2fs/enc/file \
-c "pwrite 0 32k" -c "fdatasync"

So, in f2fs_merge_page_bio(), let's avoid using fio->encrypted_page after
commit page into internal ipu cache.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Reported-by: JY <JY.Ho@mediatek.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 82ae31b8ecc4..9d1d439e2650 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -919,7 +919,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(data_folio, false));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(folio, false));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
