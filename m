Return-Path: <SRS0=/SzK=74=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB576C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:45:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720A42067B;
	Mon, 15 Jun 2020 07:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fy1sSpbO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Oyu95cR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720A42067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jkjoZ-0001Yx-S3; Mon, 15 Jun 2020 07:45:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fangwei1@huawei.com>) id 1jkjoN-0001Y5-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 07:45:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dWo8u+/5XorankHj8n6CjFsdicaC2FYU/vfSvWOMs4A=; b=fy1sSpbOJ7atOp21PF3wcnj+cr
 lw+O/FamNIKGHjtKK/1spK2lGMQ2sLWnb9Hs4tRrbrYn4BSdpBatMhrhOnJkz2rl6cJWJsK/YVpYD
 8eum9yPoyVZgpEd8cFVgED7+q1Xcokh842GegEKZAVrTS4uEhVwtxNuYsGz2mjcnYQdY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dWo8u+/5XorankHj8n6CjFsdicaC2FYU/vfSvWOMs4A=; b=O
 yu95cR1HanUzLRW07lz4a4v+HrjeEDIT6Bxzxnev4PqjbhOMIDcaetacpeZR422vhm2k/C08EqeMf
 5bAFdE0THknWTMMywb2m59S0J8zJcLKvRvF453nG7c5fFcxyCT4GoT5mcPIZA14VRPFDHl/VNqyYJ
 IVIKFeXkugA5+Dwc=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jkjoL-006CoC-Uu
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 07:45:43 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4D0E6AEDD8C8F1502077
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2020 15:44:10 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 15:43:59 +0800
From: Wei Fang <fangwei1@huawei.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Mon, 15 Jun 2020 16:11:38 +0800
Message-ID: <20200615081138.11685-1-fangwei1@huawei.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Headers-End: 1jkjoL-006CoC-Uu
Subject: [f2fs-dev] [PATCH v2] f2fs: remove useless truncate in
 f2fs_collapse_range()
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

Since offset < new_size, no need to do truncate_pagecache() again
with new_size.

Signed-off-by: Wei Fang <fangwei1@huawei.com>
---
v2: remove the lock coverage change

 fs/f2fs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3268f8dd59bb..98721f9bef25 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1373,8 +1373,6 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	truncate_pagecache(inode, offset);
 
 	new_size = i_size_read(inode) - len;
-	truncate_pagecache(inode, new_size);
-
 	ret = f2fs_truncate_blocks(inode, new_size, true);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	if (!ret)
-- 
2.21.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
