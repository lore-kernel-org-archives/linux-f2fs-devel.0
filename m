Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028E1C982EE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aQoMmrHUxTHYR2G3PDXrA4bgqQ9OjbspEk7LbU8NjTc=; b=Is73GvulR/5+NQC+HoWR7wKJL6
	nt9kcW0FnYf7bjjwUnNE1DGNUfBADJCXOAOK8zqcSNOlLm8gE7/GX8Me8TbNDt5IwofIkT33baY74
	Z2ycNv7Wos4P6PmqLYTlv92F2gibfYgeoxFmKntOvAp3zmhRd4JHhWZb9JwfPi+oFyCk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8dKj-0000lL-Bf;
	Mon, 21 Sep 2026 12:41:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x8dKh-0000lE-FR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 12:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=36MABM9SR70Oy6aPH2t+jBEfLTxUPU8SztDkPPWdNL4=; b=A8Qj63fKlUaxa3ZeSdmtYDjuJ/
 PD6aSRgYiMtF/+hdo7YmMsa/E68zSROEH/sQSDJo1uM4vItvmn7/Ew5G5t0048KMcB4s27dYNDSdf
 T87B8yueTGDiObJgSDZctHaaTt4JtOIHpZ4X/Vt7SXk/qqoHdkdGxJ0jiOb1SybMNzxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=36MABM9SR70Oy6aPH2t+jBEfLTxUPU8SztDkPPWdNL4=; b=d
 dnnwzzHYjTgJig1fJSC/fFCUws5Tf1MCpBhPb0YHSBgtoW0SrYeKO+PPn0B9MaZIeXQtZCj/w2mpF
 yduE11unQpMGestQ9igun/ENUaWVL4aN9GX/bPdhzfBshH1T1URpudMxN+7CXay0c6d4lqkzgathH
 8+RG620Viexyso0A=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8dKc-0006W0-Ri for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 12:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=36
 MABM9SR70Oy6aPH2t+jBEfLTxUPU8SztDkPPWdNL4=; b=EYgzn/3iR51Z3H8cBn
 e9YMvoYGn9kG2Ozuf/kkYQ5RdA/5DcFQ9hd5HwUJxlHxiPqY62LP9++XGFF45KTA
 +hZshYjUiQ87nXs/leCNqahd9oANdiz0gFYCut3/VAXEVvWsnuh3BRtrpRscgIJr
 /ij2TsvrVxAd//2P4tFL+IPUM=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSkvCgDnL_rGJbFqB1vMAA--.60781S2;
 Mon, 21 Sep 2026 20:40:40 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 21 Sep 2026 20:40:16 +0800
Message-ID: <20260921124016.565348-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: PSkvCgDnL_rGJbFqB1vMAA--.60781S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryUXF4UAF15AF4xKr4UArb_yoW8Aw48pr
 y5CFn7GrZ5Gw1DWrn7W3Z5Zr1rt3s3Cw4xuF4kCwsIv3W7urnYgF1rta48ZFyjqr93Ar12
 vr45uryrXa1rtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_fHbUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAiCUmqxJchHKAAA3x
X-Headers-End: 1x8dKc-0006W0-Ri
Subject: [f2fs-dev] [PATCH] f2fs: remove mappedtodisk flag usage in mmap
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Barry Song <baohua@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
f2fs has no buffer heads and the flag is no longer meaningful.  The only
user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
which makes mmap write faults skip:

- zeroing the post-EOF part of the faulted folio,
- marking the folio dirty (mm dirties shared file mappings after
  ->page_mkwrite() returns, so this one was not noticeable),
- APP_MAPPED_IO iostat and REQ_TIME updates.

Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
f2fs_read_single_page().

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a3b02c067e89..14cea508ae01 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2264,7 +2264,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b0bdc7a977b9..5fc491c0a69d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -218,12 +218,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
