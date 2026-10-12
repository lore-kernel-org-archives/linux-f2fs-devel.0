Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB63CA9EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 03:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/XVZO/8p/cTNTvSzt12WXdtVaGOxhxONPvxT3tcx/Jo=; b=EF8Sk8R4wYoIA038pYkflYlI5O
	HhkKil8gWpVG1ca4ypfYPU6HreteHN8IBVtxJyO/gH9YxzgM/5Wy4QDe48l/exgTAQ8t28QPHuUU3
	mwPkARirTZFoLPZbi8pYuTUdVO1W93TtZguyfFI/yJiSe/dyfv1T7lqpuC+zpSDZ0Iow=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xG6KU-0005ZQ-PJ;
	Mon, 12 Oct 2026 03:03:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xG6KS-0005ZH-NB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x3DPsizR66wJCaQJx0+u3kmJi3wdWuq2hudqePkWk8w=; b=V8xUBpD6LX1b/6C5j2uz1+0TVR
 JQVV3zJ6sHe4SW1TGy2dG7JcRKN9nHjkaUUwTEUtBcFG4I9SDoCv7b26gYZ9ZFf4AN6LubtdAg9EQ
 9MyP1qXdsrpf6lVBjhtR+jkUHhbkN9sYoJg4agJyOwQxdznNexYYSuiL/km14eREwUkc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x3DPsizR66wJCaQJx0+u3kmJi3wdWuq2hudqePkWk8w=; b=X
 e0RqjON1lUQiQip2qbTYt2+53T2neDhxlZZcN/sfMqCKQs3JJp9qOUjJVCIrQ/ud0a2RIDFal0VSe
 QwTIdQAdSLsaGzdc+KVfJFUr57OQF/mUswdeBw4MQgSFhFLQr2TMQMRLPiZDlojQM5i4exX1k78hn
 CyZena2jX7EJ/vZw=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG6KR-0003jJ-EX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x3
 DPsizR66wJCaQJx0+u3kmJi3wdWuq2hudqePkWk8w=; b=QtV013WhTMJuxkTFHx
 qRqdZkEIoa/7jkR2nQn+YSkAwyMI99e165lJNYOIxK4sgLsfgKBj39XZoNyPh5jz
 STNZ8lo2S3P2ocaeaHoUA8Ih4CXQOi3yHnX+auUTKYxYrOHzkxzm8v0YO5DgQbHo
 oPu5BgOJtavW+dEzPr28GP1rg=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3N_oGTsxq8KSUAw--.15003S2; 
 Mon, 12 Oct 2026 11:03:35 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 12 Oct 2026 11:03:15 +0800
Message-ID: <20261012030315.978375-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3N_oGTsxq8KSUAw--.15003S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyfCF4rGw43tF4UZF1fJFb_yoW5Gr1kpF
 9xCF4xGrZ5Ww1UWwsrG3ZxZFyrt3sxuw4xWF4kZw1fXa17ZrnYkF1Iqa4rZF1Utr93JFWI
 qr4jkry0qa1rJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_9N-UUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAdiMmrMTgdgHwAA33
X-Headers-End: 1xG6KR-0003jJ-EX
Subject: [f2fs-dev] [PATCH v3] f2fs: remove mappedtodisk flag usage in mmap
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
which makes mmap write faults skip marking the folio dirty.  Moreover,
it causes the following race condition with filesystem freezing:

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
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

Changes in v3:
- reword the commit message per review (no code change)

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
