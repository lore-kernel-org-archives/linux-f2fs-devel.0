Return-Path: <SRS0=NCuU=6H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C8C2BA19
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:14:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2728B2084D;
	Thu, 23 Apr 2020 10:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Lp0OcYvC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ho8XllsX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hNWyVtbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2728B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jRYsS-0006W4-Mf; Thu, 23 Apr 2020 10:14:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <bounce+103f7e.be9e4a-linux-f2fs-devel=lists.sourceforge.net@mg.codeaurora.org>)
 id 1jRYsR-0006Vv-2k
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 10:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XkTvNo/jbkM19vHDq0zRKvy3gJ3iYXjBL0TBCr698Hs=; b=Lp0OcYvC2Xm1cM4S4hf0quzQPI
 J/hnW8N5x0lwTkamkBbhBYJe3Y62oVzNZySvKVOaqmETg1Vso0jlnh6Ofb8ELnfhB7IOSTjRVQFrx
 5OBS17acOJTUZ6tkWIKklDy6g/h4X2NzBdcW2QkacG9j0LUMgHViHA2j/mN2yAQdztz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XkTvNo/jbkM19vHDq0zRKvy3gJ3iYXjBL0TBCr698Hs=; b=ho8XllsXBQh9MrE5ODbSg8l+qM
 rJcpMiGWf4LFq6HojDVTKE722AAedmF+iXccRLMfIBLtD/epHtpdWrki+0aMYKG6BQobuHOS8H19Z
 Um0CfJTE98JyT1a5n1we889eb0b8MId4w53JmVQq5ym/hTTyzdMtJfSyduBOqlLU43z8=;
Received: from mail26.static.mailgun.info ([104.130.122.26])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jRYsI-00B8bS-E3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 10:14:39 +0000
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587636875; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XkTvNo/jbkM19vHDq0zRKvy3gJ3iYXjBL0TBCr698Hs=;
 b=hNWyVtbR4OLRXN6mRAQpoRd7ytaT7inh8JedvUw32570dGjmmk/tvBGzo67g97MSY8LZ1Hwu
 6KtyOF7PD6b1VDeRh5waNromVL1VpdsR/cxPEaQSNYBrK+YagDxz+IWmkSSep9OtXYstDNST
 07KHucOBiJcqfsa3bJK7aNVfGJ8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI2M2Y4ZiIsICJsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea16a6f.7f3bbae7b7a0-smtp-out-n02;
 Thu, 23 Apr 2020 10:14:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D3A98C432C2; Thu, 23 Apr 2020 10:14:06 +0000 (UTC)
Received: from sayalil-linux.qualcomm.com
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: sayalil)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4318FC433D2;
 Thu, 23 Apr 2020 10:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4318FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=sayalil@codeaurora.org
From: Sayali Lokhande <sayalil@codeaurora.org>
To: jaegeuk@kernel.org, yuchao0@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 23 Apr 2020 15:43:52 +0530
Message-Id: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-Headers-End: 1jRYsI-00B8bS-E3
Subject: [f2fs-dev] [PATCH] f2fs: Avoid double lock for cp_rwsem
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
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Call stack :
f2fs_write_checkpoint()
-> block_operations(sbi)
    f2fs_lock_all(sbi);
     down_write(&sbi->cp_rwsem); => write lock held
<>
-> f2fs_sync_node_pages()
    if (is_inline_node(page))
     flush_inline_data()
	page = f2fs_pagecache_get_page()
         if (!page)
           goto iput_out;
	iput_out:
	 iput(inode);
          -> f2fs_evict_inode()
	      f2fs_truncate_blocks()
	       f2fs_lock_op()
	        down_read(&sbi->cp_rwsem); => read lock fail

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 fs/f2fs/checkpoint.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5ba649e..5c504cf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		goto retry_flush_quotas;
 	}
 
-retry_flush_nodes:
 	down_write(&sbi->node_write);
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
+		f2fs_unlock_all(sbi);
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
-		if (err) {
-			up_write(&sbi->node_change);
-			f2fs_unlock_all(sbi);
+		up_write(&sbi->node_change);
+		if (err)
 			goto out;
-		}
 		cond_resched();
-		goto retry_flush_nodes;
+		goto retry_flush_quotas;
 	}
 
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
