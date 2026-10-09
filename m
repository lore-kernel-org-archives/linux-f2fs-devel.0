Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516B6CA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dkIfWROVUE7GMdBHYCV2OwWm76bPXSBgM7t9tcr/Ve8=; b=AiRpvDWjec/AeRlKocOLVBSlQS
	IlVcrYoBVMBaLJTqfWmV3tK9roSTNqck90H8OvrXgn9GjxTxebWfZxf4beBAQCUeU2Gnb5K10Wjh1
	IePpBkvywtgUefS0aZrGcEAKi8PJOOqlwhFWkgvdojtQVEFM7DI54Z1kH4zSXlDiTizo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDEs-0008Ck-EF;
	Fri, 09 Oct 2026 16:14:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDEq-0008CL-1w
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3k1ppIEuCg6VxqNzLJvicq1GS9iGcFFQBOVeJMbwpLc=; b=fw0rFAvjP0rOFVCVuepwpUKVML
 w6CAO3ShfyNoTX+J3nSlnKyg8CHWav/oZ1Hb97JEH6AkWtQxI3wAHvaHyJ7dqAPDBvh6cU/POALow
 UXXRc27rUzu2Gm1S13Wk4FtThXaPYB/wEU741l2in7NdsmT1B5/0A6n9642V31PIMDhI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3k1ppIEuCg6VxqNzLJvicq1GS9iGcFFQBOVeJMbwpLc=; b=IWigKJNGnpXLWTJnDLdbjfZu9C
 OKZq2PozDDJzJK5xXba5/Kw3VKtIBF8PcNfogvdkZ9DSbH7sM4vM6aqVCpOVt6+f8b0EDqRJI7qi3
 uCajtJ5bh6LzGztBFXKkDXFHc3w5RoiP2fyang786vdy66Anl4gopkLWPaAhyeumM6mU=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDEg-0003mW-V2 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3k
 1ppIEuCg6VxqNzLJvicq1GS9iGcFFQBOVeJMbwpLc=; b=CoJJIYMdEZnfk+Fvbs
 riNrqrg2sMrXY+d0n3okeALJ5QSX80SGh2Su4hh2K5YwVlrXxntPULMiwOntY/ru
 cXUwq3u1A0Mz8Q2D5igr04LCdxIwFOUUXO6tSWa0LoGU4NioZQlADPBV+yyggQ3b
 WU1xL1znvde/Xh9XR97pJDUXQ=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3V46AEslqHAsZBA--.38226S9; 
 Sat, 10 Oct 2026 00:13:42 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:12:14 +0800
Message-ID: <20261009161224.4163796-8-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3V46AEslqHAsZBA--.38226S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryUXF4UAF15AF4xKr4UArb_yoW8Aw48pr
 yYkF1xGrZ5GryDWrn7W3Z8Zr1rt3sxC3yxuF4kCwsxZ3W7WrnY9F1fta48ZFyjqr93AF42
 qr45CryrXa1rtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUZ2-UUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoha+jmrJErZMBwAA3I
X-Headers-End: 1xFDEg-0003mW-V2
Subject: [f2fs-dev] [PATCH v3 07/17] f2fs: remove mappedtodisk flag usage in
 mmap write path
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
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
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
index d45fbe0db161..59f065eed712 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2572,7 +2572,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index aade9a04d8f3..e7471949faf2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -218,12 +218,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via generic cache */
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
