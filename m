Return-Path: <SRS0=Qzrr=7J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B8C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2020 10:28:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E511208B8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2020 10:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RzNQKdOM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="brzpPz2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E511208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jdtIB-00024S-0I; Wed, 27 May 2020 10:28:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jdtI9-00024L-Qw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 May 2020 10:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tokL2Ahp5f3sIgITPU1xb6FsgZO64Cf9G0Q6+gH7/nY=; b=RzNQKdOMHMEkFIdtseofpg3y6e
 chRQ9PKXOGBTj86WOeiAg7ub5ihLSkv6+PDyDW9Moly0u2Xm7fPqESuoXNJOCagicmXAlGSc6PuTd
 BOTwoc4YP7n9TCueZgFvqPAB/XMpM2HL3s6G9E9lUxfDTEn+oq3fQCBQTzpB+634OY9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tokL2Ahp5f3sIgITPU1xb6FsgZO64Cf9G0Q6+gH7/nY=; b=brzpPz2k1f/jp1ytiTZCnWnk2Q
 HGJ9Y2Y8MIwW5nRVM+W6BR/PiXOODXuLiB8t853GgBdeAN1VWQ55boqcGPQAhby/Ey5bkFU9Ougvr
 K1sFbyHk6xDdFtbrQ5PwmThn5oQZx/j+bIApnxLTZSGKh9U0+2JwlccU0p2FPkKgWs60=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jdtI7-0007ZA-N6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 May 2020 10:28:09 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0562BA029DB6410E33CF;
 Wed, 27 May 2020 18:28:01 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 18:27:55 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Wed, 27 May 2020 18:27:52 +0800
Message-ID: <20200527102753.15743-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200527102753.15743-1-yuchao0@huawei.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jdtI7-0007ZA-N6
Subject: [f2fs-dev] [PATCH 2/3] f2fs: remove unneeded return value of
 __insert_discard_tree()
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

We never use return value of __insert_discard_tree(), so remove it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1c48ec866b8c..ebbadde6cbce 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1221,7 +1221,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	return err;
 }
 
-static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
+static void __insert_discard_tree(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len,
 				struct rb_node **insert_p,
@@ -1230,7 +1230,6 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
-	struct discard_cmd *dc = NULL;
 	bool leftmost = true;
 
 	if (insert_p && insert_parent) {
@@ -1242,12 +1241,8 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 	p = f2fs_lookup_rb_tree_for_insert(sbi, &dcc->root, &parent,
 							lstart, &leftmost);
 do_insert:
-	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent,
+	__attach_discard_cmd(sbi, bdev, lstart, start, len, parent,
 								p, leftmost);
-	if (!dc)
-		return NULL;
-
-	return dc;
 }
 
 static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
