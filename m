Return-Path: <SRS0=E5g5=4P=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A82C4BA3D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:30:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEC324697
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="c/PmQQ8c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="b5yUX+iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEC324697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j7HNC-0006Gf-Um; Thu, 27 Feb 2020 11:30:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1j7HNA-0006GM-OV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Feb 2020 11:30:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AQFrci2zAX0cp0OC0eFA93OLqomTrxDjZCGvxX4PWvY=; b=c/PmQQ8cbMgKDI/m8q0P+Yltfo
 7wHwTQEk3w2GgZDLDZm+N74zw6+LpZmo+64MXqIhlrvxKkh5rtWjtFAhyKGZvUqleBzsuxhpwaaJC
 WkHkIq4ynHYUSyE5PzRVoHMaQY4B/y4+w9xpqWr0msn3xnDdkRX7FuZeOr353l9MIt8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AQFrci2zAX0cp0OC0eFA93OLqomTrxDjZCGvxX4PWvY=; b=b5yUX+iXB27dTuS5LQH8u7gByP
 1GKCmp6PEG1TUaBYrxSBBhtayLi8WfJeSYTQeweF5reimWs7ZwwevRHGeqy5NofR/vk3eDAbN+d69
 T7LSWUSS8JlkeZjh9c9LMYFv6fNu/QeJjH6VQm9idR/zEiy91GAEIBvZH4TVxoeU5LgI=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j7HN6-007a0H-7w
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Feb 2020 11:30:32 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A92B6C192E6CC6BD8603;
 Thu, 27 Feb 2020 19:30:18 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 19:30:10 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Thu, 27 Feb 2020 19:30:04 +0800
Message-ID: <20200227113005.127729-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200227113005.127729-1-yuchao0@huawei.com>
References: <20200227113005.127729-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1j7HN6-007a0H-7w
Subject: [f2fs-dev] [PATCH 2/3] f2fs: remove i_sem lock coverage in
 f2fs_setxattr()
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

f2fs_inode.xattr_ver field was gone after commit d260081ccf37
("f2fs: change recovery policy of xattr node block"), remove i_sem
lock coverage in f2fs_setxattr()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index e46a10eb0e42..5c3e82e7c0bb 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -777,12 +777,9 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
-	/* protect xattr_ver */
-	down_write(&F2FS_I(inode)->i_sem);
 	down_write(&F2FS_I(inode)->i_xattr_sem);
 	err = __f2fs_setxattr(inode, index, name, value, size, ipage, flags);
 	up_write(&F2FS_I(inode)->i_xattr_sem);
-	up_write(&F2FS_I(inode)->i_sem);
 	f2fs_unlock_op(sbi);
 
 	f2fs_update_time(sbi, REQ_TIME);
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
