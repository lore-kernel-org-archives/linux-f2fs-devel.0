Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6CAD6E2C9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Nov 2024 06:59:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tDeg7-0001OG-PP;
	Wed, 20 Nov 2024 06:59:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tDeg6-0001O9-Ib
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Nov 2024 06:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gcjaCS0XkP9cJdvtvwzusmWSdnyyzh7L8xKBIrFtcSs=; b=MO7d/T+iIHKefM9MKEGzh9VVBR
 hRPdhrhs5JUDixVPmKSeNh22QMr0txuTIST4U7E7dvVv5PWRNlBS01bd3P4AZYKT2pGlmI6B1n/1T
 8eLZO1BGosI3fyzb32Icjqs8EB7eX2rHeCRtGewAIDttRTgaBZWSBOdGbQilZomrZ7nM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gcjaCS0XkP9cJdvtvwzusmWSdnyyzh7L8xKBIrFtcSs=; b=A
 NfmjooJmXvStq6xJo5+azsnLGnO+gDSUSGY1v/6P750Ae6lgxYaOf7QB6uCAqmuAbZPDG2NugwIlP
 0xAFvRc/NRnShZ/nUocSGbOCuUVHwqwxtyXiTBQ/SjeAFgbEC87mSf7HmEIL90XQAOZKlD8sObaHi
 eoJnFhgioN5FSA+4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tDeg5-0004QO-UO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Nov 2024 06:59:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9BB005C5A05
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Nov 2024 06:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F82BC4CECD;
 Wed, 20 Nov 2024 06:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732085935;
 bh=LiRywwvZ492JbxN5S4AePvfgAabtzpdorm4CPQMEHgw=;
 h=From:To:Cc:Subject:Date:From;
 b=lbJPWde65JhSqIPLmqicGq806xjhC1htnXJHo5WhnA/oGC8tkdAlBP2Pm8JbfR/BX
 4CPGImrm6bnCH6rT0kmTX+iu/oakcYzWjmoBlGpTx+r23uVPbxB35JCe8dnXc3jLgp
 5xSYdA05O8qasCh6/cBrc1W6onffrd9QS5qqYEFjrDbTrfWbbdFUduHZ6IPL/TZvdh
 TdUj2cvcRVt+Ai8bBRt1uy+LLM2fHs2Upe5FuBZ2h3BPtRryCWyoZZGeuaPpBOd9It
 nL6trIlvXO9WdXUGs5xNigD/gpMznciC6GufOYoZGymKXC4FVTF0SeYP0L4Zu3xWYi
 0/g0vLMPmyT1Q==
To: jaegeuk@kernel.org
Date: Wed, 20 Nov 2024 14:58:50 +0800
Message-Id: <20241120065850.1345670-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1tDeg5-0004QO-UO
Subject: [f2fs-dev] [PATCH] f2fs: print message if fscorrupted was found in
 f2fs_new_node_page()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If fs corruption occurs in f2fs_new_node_page(), let's print
more information about corrupted metadata into kernel log.

Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
NULL_ADDR which means nat bitmap and nat entry is inconsistent.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7d904f2bd5b6..0b900a7a48e5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1338,7 +1338,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		err = -EFSCORRUPTED;
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+		f2fs_warn_ratelimited(sbi,
+			"f2fs_new_node_page: inconsistent nat entry, "
+			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
+			new_ni.ino, new_ni.nid, new_ni.blk_addr,
+			new_ni.version, new_ni.flag);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
 		goto fail;
 	}
 #endif
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
