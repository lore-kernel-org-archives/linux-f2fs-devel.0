Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9BEC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eScfObfczK2LqtanhMysoHfjYZj/pu6Bayt2auM2cE8=; b=jX0mIj+WNRQxrCENOuaUtT+NUc
	qs+GolFoK8E10t8nB//aWNVdeAfwvj75Ov7TxWg2jTSBUdL7qtfhRI5jRwSVY+7V6vg30nOGkoi5S
	nVtut8BfBEFyXjohcLkTU2+bdd8SiK3DELgOx0liXoSbf6xVHkO9wTSgWBNSNdsJFiZM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnN2-000319-Fn;
	Mon, 03 Aug 2026 07:46:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chenchangcheng@kylinos.cn>) id 1wqnMu-00030Y-Ti
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ltxmUPF3tGqdtarp3BV51N8DOFy6kOr1xxGO/hQ5U8A=; b=T7tFnxHFjJPzgd0c5o3Y7MMn3e
 +Sk27D7zLbp5JWb4ik9o31+dYeyL39PdTuYQVQQowkcEhXtC3locSH2sR2tR5gIe3M7jVZeL5UEMI
 ZkQIUnX3SIC2ErbXamAk3Ahub/GK7gy1nNyK6TJ1iY8zZ03nFSCTjgeMlVWP2PVpcOTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ltxmUPF3tGqdtarp3BV51N8DOFy6kOr1xxGO/hQ5U8A=; b=AWaclyGIUP7LnnQD9gPS6eo52K
 ztpMRPfojRA3M824NPeIskxHO5OEU9lFQdlaxDG3bMlIQpN9txfQEehoNwvE7jhfE8GFdHsqvHlTW
 g5278fxeYY9hdGXv8mtt/cRm3zjgfa9K4puOtMMhAtpOjkM4c7NXA6BQgKKJrVzx7exM=;
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqnMx-0007IR-EP for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:45:53 +0000
X-UUID: 5396d3c48f0f11f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:015f9374-1893-4090-9b34-cf2db0364426, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:062436e5b30e25e69534dbe91d0b9e05,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
 :0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5396d3c48f0f11f1aa26b74ffac11d73-20260803
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <chenchangcheng@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1694666554; Mon, 03 Aug 2026 15:45:41 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: chao@kernel.org
Date: Mon,  3 Aug 2026 15:43:44 +0800
Message-Id: <20260803074344.219899-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803073800.218814-1-chenchangcheng@kylinos.cn>
References: <20260803073800.218814-1-chenchangcheng@kylinos.cn>
MIME-Version: 1.0
X-Headers-End: 1wqnMx-0007IR-EP
Subject: [f2fs-dev] [PATCH v2] f2fs: fix valid block count leak on data
 block allocation failure
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Chen Changcheng <chenchangcheng@kylinos.cn>, jaegeuk@kernel.org,
 ccc194101@163.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In __allocate_data_block(), when allocating a new data block
(dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
called first to increment total_valid_block_count and i_blocks.
If the subsequent f2fs_allocate_data_block() fails, the function
returns the error directly without rolling back the
already-incremented block counts, causing a permanent leak.

Fix this by calling dec_valid_block_count() to undo the
increment before returning the error. The condition
old_blkaddr == NULL_ADDR precisely identifies the case where
inc_valid_block_count() was called.

Fixes: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Cc: <stable@vger.kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..819631bb61ae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1532,8 +1532,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	old_blkaddr = dn->data_blkaddr;
 	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
 				&dn->data_blkaddr, &sum, seg_type, NULL);
-	if (err)
+	if (err) {
+		if (old_blkaddr == NULL_ADDR)
+			dec_valid_block_count(sbi, dn->inode, count);
 		return err;
+	}
 
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
