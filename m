Return-Path: <SRS0=Ywyj=C6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E46C43464
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:17:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCB720719;
	Mon, 21 Sep 2020 06:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="m0TFa5au";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bPkzXjI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCB720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kKF8p-0007EM-3S; Mon, 21 Sep 2020 06:17:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangxiaojun11@huawei.com>) id 1kKF8m-0007Ds-Qn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Sep 2020 06:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yeS8v6/iSrpfWHkyShZqav1xMe6/fZONVoNm1q6uhBM=; b=m0TFa5auskRME9QHOS+QrJLK+A
 BjPoqVvvd71cp3MhC4AI2DpxPp7iDsnM5oBCjVEahBZlYcHbfLPAKYsoA/CGLj30HTBt2orMalIp3
 1XTeyWcBdX+7Jq/vAMokWe0JWXxUe9rHaLlS5ou9ON2+PMbh1v+53wtiJXU1Oqg9jjBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yeS8v6/iSrpfWHkyShZqav1xMe6/fZONVoNm1q6uhBM=; b=b
 PkzXjI3svTjVPB73iEGGBKEJQrje4RPbZXTQ+D0hk0F9BTRfkmt4qKmHw4riafCDge6jwdzVrTmRO
 wMLSG2zNbQMwy41vDnoIRnFqINFJDyUYmrjE4ZHd2vbtamTMzbrZnuSK1TL8f8XW+L1lW+cLVy1mn
 HaKQ+izITyi2g8xI=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kKF8Z-001Rj7-65
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Sep 2020 06:17:32 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 34DCA683669A1B257E7B;
 Mon, 21 Sep 2020 14:17:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 14:16:53 +0800
From: Wang Xiaojun <wangxiaojun11@huawei.com>
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Date: Mon, 21 Sep 2020 14:19:16 +0800
Message-ID: <20200921061916.1917750-1-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
X-Headers-End: 1kKF8Z-001Rj7-65
Subject: [f2fs-dev] [PATCH] f2fs: remove unused check on nid
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The case where nid is 0 will be checked in f2fs_check_nid_range.
Remove the unused check.

Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
---
 fs/f2fs/node.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cb1b5b61a1da..c61d5b52e29e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1319,8 +1319,6 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	struct page *apage;
 	int err;
 
-	if (!nid)
-		return;
 	if (f2fs_check_nid_range(sbi, nid))
 		return;
 
@@ -1342,8 +1340,6 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	struct page *page;
 	int err;
 
-	if (!nid)
-		return ERR_PTR(-ENOENT);
 	if (f2fs_check_nid_range(sbi, nid))
 		return ERR_PTR(-EINVAL);
 repeat:
@@ -2193,10 +2189,6 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 	int err = -EINVAL;
 	bool ret = false;
 
-	/* 0 nid should not be used */
-	if (unlikely(nid == 0))
-		return false;
-
 	if (unlikely(f2fs_check_nid_range(sbi, nid)))
 		return false;
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
