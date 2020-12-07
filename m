Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D5C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 11:01:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176DA2158C;
	Mon,  7 Dec 2020 11:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176DA2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmEGS-0004KR-Ki; Mon, 07 Dec 2020 11:01:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack.qiu@huawei.com>) id 1kmEGN-0004KF-IA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 11:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0qtkr3tAsrpYcUrtndWYjtWMU6l9M3lBUsXC6KSa6y8=; b=FPwUNKyaTlwnHhFR8oabWi6AlG
 2w4lBjT4BhGqBb23YY/9l6jUEtQADCaa9B3C6ZtGZdHko1PEW2IA2CTbPSxArXwbXTIyfWPobLpGh
 pnB933EE+I5P4WLPfBT+rOmb/qFGT4VGBm6fhxv23uSDxvjAT9sXTuExM47SuxX7djQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0qtkr3tAsrpYcUrtndWYjtWMU6l9M3lBUsXC6KSa6y8=; b=bxz9zte3VejhuxDjQt5LD5Yhss
 uzXkW5HFQA/aEuS6cu3+fHb/NPG7yvzqD/ILliJHFxQEJRKaLoh+vpditFNC9zx1DIiQ0G9LCBdqD
 pe5xh23Rs1WjOq1Cs13sV98AF5l4CzM7QM1FRWzfd9cDPGL8qqCeXVoG9qVGHSp+lIIQ=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmEGJ-001rGW-Cg
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 11:01:03 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqL1w3VNjzhnrf
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Dec 2020 19:00:20 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Dec 2020
 19:00:49 +0800
From: Jack Qiu <jack.qiu@huawei.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Mon, 7 Dec 2020 20:01:14 +0800
Message-ID: <20201207120114.25642-4-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207120114.25642-1-jack.qiu@huawei.com>
References: <20201207120114.25642-1-jack.qiu@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
X-Headers-End: 1kmEGJ-001rGW-Cg
Subject: [f2fs-dev] [PATCH v3 3/3] f2fs: inline: fix wrong inline inode stat
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Miss to stat inline inode in f2fs_recover_inline_data.

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0a8f7eefca7d..c37747f7028c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -297,6 +297,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 		if (IS_ERR(ipage))
 			return PTR_ERR(ipage);
 		f2fs_truncate_inline_inode(inode, ipage, 0);
+		stat_dec_inline_inode(inode);
 		clear_inode_flag(inode, FI_INLINE_DATA);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
@@ -305,6 +306,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 		ret = f2fs_truncate_blocks(inode, 0, false);
 		if (ret)
 			return ret;
+		stat_inc_inline_inode(inode);
 		goto process_inline;
 	}
 	return 0;
--
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
