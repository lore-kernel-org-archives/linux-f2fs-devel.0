Return-Path: <SRS0=1yAE=CZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E1C35256
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:58:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5A02078D;
	Wed, 16 Sep 2020 07:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aR3mYsRy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JI/u0gqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5A02078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kISL7-0005oc-7d; Wed, 16 Sep 2020 07:58:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangxiaojun11@huawei.com>) id 1kISL5-0005oP-Jx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Sep 2020 07:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xWVcQ8R0ajqyG9WhsYUgyKc/TFDPq0fcvFzizFOaGbs=; b=aR3mYsRyegCtR+WMqjne9H/uMr
 dVimiqThtNZMTGwXJkMn4G0saZb4JNyom1K8b/psEPoxOsSi+JCC5jZjOnAPnh24KxkKgy21lu33N
 M/SPq09E7Bi2JF9iLqmtWXOlP78Lr/ZGv2FvkFaTeskjp0qV85i6+NNNHlPnv2IpWvSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xWVcQ8R0ajqyG9WhsYUgyKc/TFDPq0fcvFzizFOaGbs=; b=J
 I/u0gqLBXl3zPi1UO3N2D8ZUi8tYx9hPdjgmMBDB0dRF+TY40eiidM1sG1ykuVMhtH6JnFyWq/wQw
 wzuWTRgNl2JK2u3qb8MjFKn6UgzbwX0h6h1WUbU9dMhtqHO7GZlwtFFYu+e8xuYf3ghGZbnGlXfFn
 3glHCJ8vduf7ksVw=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kISKx-00B10Y-VW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Sep 2020 07:58:50 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D3AEBF5703915BF31C5E;
 Wed, 16 Sep 2020 15:58:32 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 15:58:23 +0800
From: Xiaojun Wang <wangxiaojun11@huawei.com>
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
Date: Wed, 16 Sep 2020 16:00:46 +0800
Message-ID: <20200916080046.2417806-1-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
X-Headers-End: 1kISKx-00B10Y-VW
Subject: [f2fs-dev] [PATCH] f2fs: change return value of reserved_segments
 to unsigned int
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

The type of SM_I(sbi)->reserved_segments is unsigned int,
so change the return value to unsigned int.
The type cast can be removed in reserved_sections as a result.

Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 752b177073b2..f28836a9903e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -500,7 +500,7 @@ static inline unsigned int free_segments(struct f2fs_sb_info *sbi)
 	return FREE_I(sbi)->free_segments;
 }
 
-static inline int reserved_segments(struct f2fs_sb_info *sbi)
+static inline unsigned int reserved_segments(struct f2fs_sb_info *sbi)
 {
 	return SM_I(sbi)->reserved_segments;
 }
@@ -532,7 +532,7 @@ static inline int overprovision_segments(struct f2fs_sb_info *sbi)
 
 static inline int reserved_sections(struct f2fs_sb_info *sbi)
 {
-	return GET_SEC_FROM_SEG(sbi, (unsigned int)reserved_segments(sbi));
+	return GET_SEC_FROM_SEG(sbi, reserved_segments(sbi));
 }
 
 static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
