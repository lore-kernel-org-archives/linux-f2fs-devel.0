Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34498C6FA8B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Sep 2022 07:54:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oauYo-0000m7-Ct;
	Wed, 21 Sep 2022 07:54:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangqilong3@huawei.com>) id 1oauYk-0000lo-3s
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Sep 2022 07:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AthiQf7zA39IxPfnOYlSHBcZnIJ2RLQOb39rdpZ6gBo=; b=cQk/6IEZkikRi1x1WpNZMQb1b7
 wHH3xX59L7y+nGErrJH7B4/nehyb8VupqPuWq4lqtmxCzJFZIU/DyLz13E5frwoh28Q/f7lCof68d
 t5prBeJhqNnSfv9cx/etIIIWjgXbrJYslX3kTzEpIjCixTfmEDuyxxQiNQ58ljdBtCII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AthiQf7zA39IxPfnOYlSHBcZnIJ2RLQOb39rdpZ6gBo=; b=jvDoyl4/uf5/3/JNpPGkloUj2T
 cMSHkzQTujc0I9z7XXDGRLRrN3EmewKLmCk4mmjwtzLJ9AIGiD5hZfezVNJN+Jmg6EWn3cdNyd3/s
 ON3UxV6UyomMvfehWl7pufCybd8pK18XjTvWdYxzoJg/tKL/twjf1M+4zxF1dj9CiFCk=;
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oauYh-0004gd-JK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Sep 2022 07:54:18 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXVwR2rjdzpSym;
 Wed, 21 Sep 2022 15:51:19 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 15:54:08 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 15:54:07 +0800
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Wed, 21 Sep 2022 15:57:37 +0800
Message-ID: <20220921075737.36708-5-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20220921075737.36708-1-zhangqilong3@huawei.com>
References: <20220921075737.36708-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Headers-End: 1oauYh-0004gd-JK
Subject: [f2fs-dev] [PATCH -next 4/4] f2fs: remove the limit and
 no-compressed file could use extent
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
From: Zhang Qilong via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It have supported caching extent of no-compressed file and we
just remove the limit in readonly format f2fs image.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 fs/f2fs/node.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4f500c2ecee8..880259bec0e4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -845,11 +845,8 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	dn->node_page = npage[level];
 	dn->data_blkaddr = f2fs_data_blkaddr(dn);
 
-	if (is_inode_flag_set(dn->inode, FI_COMPRESSED_FILE) &&
-					f2fs_sb_has_readonly(sbi)) {
-
+	if (f2fs_sb_has_readonly(sbi))
 		f2fs_readonly_update_extent_cache(dn, index);
-	}
 
 	return 0;
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
