Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B312CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTT21e3WqI/K4SBDGPfNLCuOuzRDGVagXt+YMy6FJPI=; b=cuSSnMYsZbUntZ2d+iB1u6xNj1
	2bGRWAU5eZGL+xUcR780agWJgGf0DEOQxyFH9YY64OTku7y6xXFKjWBYznyA9bjAoKyDG9lDrf9mW
	HIhBhVk9V+WLMdF5rKf+/iDrFe1Iexb2ncj8vJE79l+Z/dgP/ALaMOAUxDTLDw2WoJX0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKx4d-0008KH-Dn;
	Thu, 07 May 2026 11:39:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wKx4c-0008K4-3v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kVuX94Iz2b8YVPiuHETQElidzcF5zqAX3ffek0Jegng=; b=EFQ+SL+AKTc309nqZ8Kxt19iol
 wuzgGyNcx5XTGZQKzK1ciWOboCW4wvejrFVLyZjWq2bnHFQsnjVrOboGpsQGfR6b7QAql4emRsSpY
 0i9g8alPn455GzZIDVxa+xh7tj0vww1sSSH4OjeqNaateb3gigK5yQXL97E/7OGbEikg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kVuX94Iz2b8YVPiuHETQElidzcF5zqAX3ffek0Jegng=; b=lZdjKoIGXMVt/xC6mgKuhk4VMq
 TnNujOLoquYOuYIuEZThG1D25rlegdknTgTBif/Pri3LHoDN/J6Z3LEXiMgJxIuagEN+409DZOkeI
 ks5mpMcGoe8bfn+9D4CZrMswHds9drEfALI4jRsc2xY9vDviWq6/U41CIpYAIfDSzHS0=;
Received: from mail3-164.sinamail.sina.com.cn ([202.108.3.164])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKx4a-0002kb-2a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1778153960; bh=kVuX94Iz2b8YVPiuHETQElidzcF5zqAX3ffek0Jegng=;
 h=From:Subject:Date:Message-ID;
 b=ON48Q5Xk84ENcTd8HX/JlVNzHsBqScSSaeW8wL64YU0PjuTcA7lCY//WPHodbbXoS
 mUX2hp2w+l9njlzLCE1PWw8xAC2bdy0O3eOMbnvXWU84BjxRmuOiYAtXbCa4F8FCUB
 hEYLD9udnU0ewqGnopfE4WPHtA1jkxFXUSbt4klg=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 69FC79D6000021A4; Thu, 7 May 2026 19:39:11 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 8417104456906
X-SMAIL-UIID: E9691119C981482F8564CEA154AF0E1A-20260507-193911-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  7 May 2026 19:38:39 +0800
Message-ID: <20260507113840.1353304-4-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507113840.1353304-2-monty_pavel@sina.com>
References: <20260507113840.1353304-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1wKx4a-0002kb-2a
Subject: [f2fs-dev] [RFC PATCH 1/4] f2fs: replace raw dnode pointer
 arithmetic with f2fs_data_blkaddr()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

The raw __le32 pointer arithmetic in f2fs_truncate_data_blocks_range()
directly accesses block addresses via get_dnode_addr() and pointer
increment. This pattern is not friendly for inline extent access where
the inode data layout may differ from direct block format.

Replace the raw pointer access with f2fs_data_blkaddr() which provides
a proper abstraction layer. This prepares for inline extent support
where the data block address retrieval needs to go through a different
path.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 71385ca4163d..a769780a6122 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -659,7 +659,6 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	int nr_free = 0, ofs = dn->ofs_in_node, len = count;
-	__le32 *addr;
 	bool compressed_cluster = false;
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
@@ -667,12 +666,11 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	block_t blkstart;
 	int blklen = 0;
 
-	addr = get_dnode_addr(dn->inode, dn->node_folio) + ofs;
-	blkstart = le32_to_cpu(*addr);
+	blkstart = f2fs_data_blkaddr(dn);
 
 	/* Assumption: truncation starts with cluster */
-	for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
-		block_t blkaddr = le32_to_cpu(*addr);
+	for (; count > 0; count--, dn->ofs_in_node++, cluster_index++) {
+		block_t blkaddr = f2fs_data_blkaddr(dn);
 
 		if (f2fs_compressed_file(dn->inode) &&
 					!(cluster_index & (cluster_size - 1))) {
@@ -715,7 +713,10 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		if (blklen)
 			f2fs_invalidate_blocks(sbi, blkstart, blklen);
 
-		blkstart = le32_to_cpu(*(addr + 1));
+		/* data_blkaddr may exceed the boundary of blocks. */
+		if (count > 1)
+			blkstart = data_blkaddr(dn->inode,
+					dn->node_folio, dn->ofs_in_node + 1);
 		blklen = 0;
 	}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
