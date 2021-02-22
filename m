Return-Path: <SRS0=nBYv=HY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315DC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Feb 2021 10:08:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680DC614A5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Feb 2021 10:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680DC614A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lE897-00008n-6o; Mon, 22 Feb 2021 10:08:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lE88N-00006h-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Feb 2021 10:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jMJRNKISOBGNc0oBzZsf07QPtMcwmEMGeSu426xbN5s=; b=RcvjXyq3iB6cWxh7i66/QzBwyg
 n49fmBL7GEDcGnxYwG4jhI8qrtBq60zTPvNXMfK+rBIXPD2XkrBiIlvo1UfKKfjmEpfcTE/TyCOwJ
 jin4CcGQ0O5kvOfWRIQl4Kj5VvOOkPCdtKTQ92ChFedPbkuAZUnaJ0VEvlkDV5d+MbiA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jMJRNKISOBGNc0oBzZsf07QPtMcwmEMGeSu426xbN5s=; b=C
 ArKX6Kz6kk03lJn8Luyc943VPA7oNgIXlJFwbxUlc8dRtwwMDc28hJnlh8DL3ffGAD7TdcgxUxIxO
 MPxSakl21NdEbcxssL62UQMplT86/YwOUcq3YID2KfQnFXatgvcEoPJB4oj0tXTgdlxHh5drtelWI
 8Awq/WT9orFIJFwI=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lE88H-0013wn-N8
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Feb 2021 10:08:07 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dkd9y69fqz16BRj;
 Mon, 22 Feb 2021 18:06:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Feb 2021 18:07:39 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 22 Feb 2021 18:07:33 +0800
Message-ID: <20210222100733.120224-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1lE88H-0013wn-N8
Subject: [f2fs-dev] [PATCH] f2fs: check discard command number before
 traversing discard pending list
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In trim thread, let's add a condition to check discard command number
before traversing discard pending list, it can avoid unneeded traversing
if there is no discard command.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index deaf57e13125..1e674c117ce3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1769,6 +1769,8 @@ static int issue_discard_thread(void *data)
 			wait_ms = dpolicy.max_interval;
 			continue;
 		}
+		if (!atomic_read(&dcc->discard_cmd_cnt))
+			continue;
 
 		if (sbi->gc_mode == GC_URGENT_HIGH)
 			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
