Return-Path: <SRS0=s44c=KF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6BC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 May 2021 09:30:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6801B600EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 May 2021 09:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6801B600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lg2Fd-0007Yq-Al; Mon, 10 May 2021 09:30:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lg2Fa-0007YZ-WB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 May 2021 09:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PifZ1I00dhgN1XKRg9/6hVSl/yNrdKAMoEaPBURIzuQ=; b=LM0ougrfzyFKDxbXffAmW/W/+V
 gd4JyAUHB49J6LUZNQVHRdhuhT1XwHp5+SsIzhYIbuujpd8CG0bEgPxmDlProcYh2LXpzTAABZYzf
 farCQF6gTKcmQnfKPaXsrrU1OCEBkDMxtRq1cIN6yfZMjZ7CjXraTjElZHDYixI1a710=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PifZ1I00dhgN1XKRg9/6hVSl/yNrdKAMoEaPBURIzuQ=; b=eUquVusiWcesNjTqRvz1LkhugL
 2MOA0Yy27Z3odPq8r4qPIgs7W0ErOTLn0OblckEtUSBF3jXB0qzRjD95YQLaU4KChJVrRU9Qo9PS1
 5eAArOkobyjTGnebWEJoyl7tyuE/P9+q7jq52FprH5uQYHELzWaVmIgiJawhrQIsbydo=;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lg2FY-0014iP-NO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 May 2021 09:30:56 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FdwhQ6XLkzCr8s;
 Mon, 10 May 2021 17:28:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:30:35 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 10 May 2021 17:30:32 +0800
Message-ID: <20210510093032.35466-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510093032.35466-1-yuchao0@huawei.com>
References: <20210510093032.35466-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1lg2FY-0014iP-NO
Subject: [f2fs-dev] [PATCH 3/3] f2fs: compress: fix to assign cc.cluster_idx
 correctly
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

In f2fs_destroy_compress_ctx(), after f2fs_destroy_compress_ctx(),
cc.cluster_idx will be cleared w/ NULL_CLUSTER, f2fs_cluster_blocks()
may check wrong cluster metadata, fix it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 340815cd0887..30b003447510 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1066,6 +1066,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
 			f2fs_destroy_compress_ctx(cc);
+			cc->cluster_idx = index >>
+					F2FS_I(cc->inode)->i_log_cluster_size;
 			goto retry;
 		}
 	}
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
