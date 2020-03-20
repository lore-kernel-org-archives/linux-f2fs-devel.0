Return-Path: <SRS0=ZXqV=5F=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD728C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:18:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E9B20722
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="K4djlVxU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZfF7N8O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E9B20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jFEjL-0006tp-2u; Fri, 20 Mar 2020 10:18:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jFEjJ-0006tg-FI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Mar 2020 10:18:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cwHbJYtBoQwmX0FRMtdn3s0sPRmBsR+qBtVknd9unqM=; b=K4djlVxUVEjZkyluCRPBEfhaFn
 nvPzLMLepTcwp9ru6et/8vk10ytDJKLSQ+caLoa0U7wBlhhtbbZpWfV2DD7cHP45UlX78CcTcK3A8
 PZD1VgkXu/sE+MUawXhKyrBteFt31QCUXjZP1yCi7Rsn7n2EUhyBCvipLOCmNjhQRgkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cwHbJYtBoQwmX0FRMtdn3s0sPRmBsR+qBtVknd9unqM=; b=Z
 fF7N8O8h7AlkQCLNDcRkfMpwH6IgDUdaXmvjVCjXe0iXOtUZd0xvG+gB/kxKjG46ZtyqAdXDRzKgb
 BKSlzPLMYHTsSQ0JdQ1QdXyQAbKDNzaURCMgo8sCddaeTPUNb7JDbu/rMzkgifYfX/uWRf3FlM7la
 5tcvFRLyEsF3L3T0=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jFEjI-009uUu-4j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Mar 2020 10:18:17 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 90D8F7D434C29BE33801;
 Fri, 20 Mar 2020 18:18:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 18:17:59 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 20 Mar 2020 18:17:54 +0800
Message-ID: <20200320101754.36958-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jFEjI-009uUu-4j
Subject: [f2fs-dev] [PATCH] f2fs: don't change inode status under page lock
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

In order to shrink page lock coverage.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 27d0dd7a16d6..0971ccc4664a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -850,12 +850,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			0);
 	set_page_dirty(page);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
-
-	if (inode)
-		f2fs_drop_nlink(dir, inode);
-
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(page);
@@ -867,6 +861,12 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		f2fs_remove_dirty_inode(dir);
 	}
 	f2fs_put_page(page, 1);
+
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
+
+	if (inode)
+		f2fs_drop_nlink(dir, inode);
 }
 
 bool f2fs_empty_dir(struct inode *dir)
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
