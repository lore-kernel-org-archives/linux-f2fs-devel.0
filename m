Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37905C7EE2C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 08:27:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzCV0-0003m2-QR;
	Wed, 17 May 2023 08:27:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pzCUx-0003lu-1m
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 08:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=djDfp/RRblAdZ+qFbz4xYZLtO7O+Y63PPFgvbyOtcvk=; b=GOMjKb0wGxx2bhyTeOxq6E+8TD
 gOzEuOyCinY2VxdZSBiyOmpL115CwkY9eE9ph8m3Lf7O2QTSQDq2JQHBTnGhuPgpBxla5v8NX+uJj
 QcCwRK6DWb1XD7Z63VoKtKymPsRaXJMCq3aCOW4tV1jKHw1DnBYsf6SOgKzTftSz0TS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=djDfp/RRblAdZ+qFbz4xYZLtO7O+Y63PPFgvbyOtcvk=; b=AFZXDc4YfLpKtGQX+Z5VbHE5eV
 AP+B6xDlN+vhnjUlZFDHeuHy24KZhFB/ihItnhjXZc8g0xFGdtQE2f+RlsPgzJ+H9HKJwEBqvmjpV
 j+5rttzEFtgUb3eSu6skXLjfHvVPP/gDT0pR+7XhyCBtW1Wt2CHyCxbE9JpR0ygX5CSo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzCUw-00AqVL-A2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 08:27:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E991A64398
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 May 2023 08:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C24C4339B;
 Wed, 17 May 2023 08:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684312016;
 bh=uS2u4IltUkAClq+msBoWRZCWsmFWrqV/LxWB6PcUyjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OP1ftbJqQvM1i1Cu4zAuXyRPAHiQHlSl4S4nmhzRVMhnEI4V9436V/I11OzO9zA4X
 4e78RegXZV71/sVjFNnq+uWjGDlNbtn0qy6u4gCqvwE2gDuC6BZG2+fLurv+brrKWt
 0SiLdj3YmJvTq8qfaR6121HJPyhYkspPRIX/TBAJFd45orVcdar0B9MSWNrtqPgnvm
 Ud/GSSQ3bP3hJ53vMWE7iYhm9XbeV7VjP2Dyd9iCETflEiq/1hC57R/aYvEiX0A5hg
 0nczVNKXzdCRiNomgjV+EbR4kT9/Xb+aX1nVw5YL3mh6lzfXiluaBolDjKGgdeT3we
 DlTZ+XxFgmCuA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 17 May 2023 16:26:30 +0800
Message-Id: <20230517082632.748914-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517082632.748914-1-chao@kernel.org>
References: <20230517082632.748914-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pzCUw-00AqVL-A2
Subject: [f2fs-dev] [PATCH 2/4] mkfs.f2fs: remove unneeded nat
 initialization in f2fs_update_nat_root()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

- remove unneeded nat initialization for root/quota inode due to
it has been initialized in nat journal.
- name f2fs_update_nat_root() to f2fs_update_nat_default().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 mkfs/f2fs_format.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index df6bde2..620f779 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1413,12 +1413,10 @@ static int f2fs_write_qf_inode(int qtype, int offset)
 	return 0;
 }
 
-static int f2fs_update_nat_root(void)
+static int f2fs_update_nat_default(void)
 {
 	struct f2fs_nat_block *nat_blk = NULL;
 	uint64_t nat_seg_blk_offset = 0;
-	enum quota_type qtype;
-	int i;
 
 	nat_blk = calloc(F2FS_BLKSIZE, 1);
 	if(nat_blk == NULL) {
@@ -1426,24 +1424,6 @@ static int f2fs_update_nat_root(void)
 		return -1;
 	}
 
-	/* update quota */
-	for (qtype = i = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
-		if (!((1 << qtype) & c.quota_bits))
-			continue;
-		nat_blk->entries[sb->qf_ino[qtype]].block_addr =
-				cpu_to_le32(get_sb(main_blkaddr) +
-				c.cur_seg[CURSEG_HOT_NODE] *
-				c.blks_per_seg + i + 1);
-		nat_blk->entries[sb->qf_ino[qtype]].ino = sb->qf_ino[qtype];
-		i++;
-	}
-
-	/* update root */
-	nat_blk->entries[get_sb(root_ino)].block_addr = cpu_to_le32(
-		get_sb(main_blkaddr) +
-		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg);
-	nat_blk->entries[get_sb(root_ino)].ino = sb->root_ino;
-
 	/* update node nat */
 	nat_blk->entries[get_sb(node_ino)].block_addr = cpu_to_le32(1);
 	nat_blk->entries[get_sb(node_ino)].ino = sb->node_ino;
@@ -1660,7 +1640,7 @@ static int f2fs_create_root_dir(void)
 	}
 #endif
 
-	err = f2fs_update_nat_root();
+	err = f2fs_update_nat_default();
 	if (err < 0) {
 		MSG(1, "\tError: Failed to update NAT for root!!!\n");
 		goto exit;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
