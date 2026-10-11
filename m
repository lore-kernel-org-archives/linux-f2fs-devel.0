Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D10CA9EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 04:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0LHLcIBv7as32XNq3NUMMXTYpVfwDPYo8ilbhDBK7Ko=; b=NxIS1HpgiUYt7pV0dRHSdi2NTC
	DyrIkSfWw3FEq8ZJ+0nZ0AwErLQMgeC1+gMXZu3zeLvInLYiSL5MY8jjJMZK1SQgQ8u34EzDAXX2v
	5vuKOcA4xg+oTKXyKqYmkIih28XFYh0lmsNi6H9prFSZjqQ38sj5cDC/gdHRGWlinJhg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFkm4-00017u-AM;
	Sun, 11 Oct 2026 04:03:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFkm2-00017d-DC
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 04:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ByIMgzHlHKSnpusTEI/Blb9NGNki/9e4oGULv6zhbck=; b=CT/ORSt3hXMbJrWzvX9arVqs57
 g0yXH7t3B3Nk41gCCzdbWpTtFIAMb8lZCzQidrS82l3ZcFeStXE6GLctbFGXR5Zi/892Qc0N65Cpa
 ygqZGdo1gWQ6lfDtKAimQ5c1ineaP7M+1OaruGBHozdTl/+3vmR5uTSGPCpTBcLn4F2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ByIMgzHlHKSnpusTEI/Blb9NGNki/9e4oGULv6zhbck=; b=D
 gpiNVGsbe/dImmlUMOmlnE9n/Z0b6ZCYLCzqQ3BMHLmT7k6/7S0FMv0WKEe+c83eetJXRIeMYPCM7
 lFxFyM5QxOU2NuUoBuDeOjow0ybw3Qp88t1CcngfsEYRit3R/OnaZ8DIGmE/2uezmb9l7fwO/VBV/
 QmLk/Th2j+0yI1Mg=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFkm1-0007hW-FB for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 04:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=By
 IMgzHlHKSnpusTEI/Blb9NGNki/9e4oGULv6zhbck=; b=TlLiVAye1NuuDobsxZ
 E9LRM3BYUSiOZ63E9cmNbPaXJPzlxS1QYuTx1cPt0C8ENqQRPBlAimN9IgG6nB11
 hc9nsLUgQVgrHNMQLcnfTJPXJVWV9NfSIfOEt+Yzg8Ch63L6xn2Wq6PnYNue7NbY
 2ROhRTWejUK/I3sWQC6ZhR9h8=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgAXzutYCstqTqVQBQ--.42864S2;
 Sun, 11 Oct 2026 12:02:33 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sun, 11 Oct 2026 12:02:32 +0800
Message-ID: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: PikvCgAXzutYCstqTqVQBQ--.42864S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4kCFyxXF47JryDAw4fKrg_yoW5Jr1kpF
 9xuF1xG395Ww1UWrsrG3Z8ur1rt3sxuw4xWFs7uw1fXa17ZrnYkF1fta4rZF1UKr93JFWI
 qr4jkryrXa1rJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_9N-UUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohkm9WrLClnnPAAA3B
X-Headers-End: 1xFkm1-0007hW-FB
Subject: [f2fs-dev] [PATCH v2] f2fs: remove mappedtodisk flag usage in mmap
 write path
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
f2fs has no buffer heads and the flag is no longer meaningful.  The only
user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
which makes mmap write faults skip marking the folio dirty.  Chao Yu
pointed out that this is not only a cleanup: it causes the following
race condition with filesystem freezing:

 CPU0 (write fault)     CPU1 (freeze_super)
 ----                   ----
 f2fs_vm_page_mkwrite()
 sb_start_pagefault()
 /* shortcut: no dirty */
 sb_end_pagefault()

                        sb_wait_write(SB_FREEZE_PAGEFAULT)
                        /* no waiter, passes */
                        sync_filesystem()
                        /* folio not dirty, skipped */

 finish_fault()
 /* PTE writable */
 fault_dirty_shared_page()
 folio_mark_dirty()
 /* dirty folio on a frozen fs */

It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
folio zeroing.

Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
f2fs_read_single_page().

Reported-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22c..35d9ddaf78f4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2260,7 +2260,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..2d763e156d06 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -217,12 +217,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (folio_test_mappedtodisk(folio))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
