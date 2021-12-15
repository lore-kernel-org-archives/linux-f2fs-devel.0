Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25A5C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Dec 2021 02:39:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mxKCG-0000iy-Gs; Wed, 15 Dec 2021 02:39:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <yang.lee@linux.alibaba.com>) id 1mxKCF-0000ir-RS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Dec 2021 02:39:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VLKZPSi0K/NMZ5All9TI2raXaXeGScEcjfI2mqf4gzo=; b=gaYWiYlQz5q6uK1ENsFeJzJUor
 8y++E7DllJgVciWfSsqzUbKj3YJznvVt2F4SuTSxD9R2q1HumtHDRjoZsDO61kjR0rPvb1/PfE7Jc
 VSujgkgDKUTJlcG0M8tTTOuNp489cF3kM/pd81Fl8a47sc5fCz8suDhYFvjSKTk5ZTNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VLKZPSi0K/NMZ5All9TI2raXaXeGScEcjfI2mqf4gzo=; b=A
 RamrSmJO706teMR91PCR1oNIAntRVcBr51zmYe8/Vbsy8xuaCH6qRkQ0+KpQGG+oQBWWHxvMQ8/Dj
 /mLlEcXl47FXqe7rpmxt4rMMrYSlG/cdUUf06/w8cB6utf5Vd6g3jwyGRwOn1t0DezK8EykEdP27z
 9QaQhMUNHG4ASgYI=;
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mxKCD-0003TE-E9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Dec 2021 02:39:12 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V-g8tNf_1639535941; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0V-g8tNf_1639535941) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 15 Dec 2021 10:39:01 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: jaegeuk@kernel.org
Date: Wed, 15 Dec 2021 10:38:58 +0800
Message-Id: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-Headers-End: 1mxKCD-0003TE-E9
Subject: [f2fs-dev] [PATCH -next] f2fs: Simplify bool conversion
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
Cc: Abaci Robot <abaci@linux.alibaba.com>, Yang Li <yang.lee@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fix the following coccicheck warning:
./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9e1cf44642ae..530c36b89bf1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -488,7 +488,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
 		spin_lock(&sbi->gc_urgent_high_lock);
-		sbi->gc_urgent_high_limited = t == 0 ? false : true;
+		sbi->gc_urgent_high_limited = t != 0;
 		sbi->gc_urgent_high_remaining = t;
 		spin_unlock(&sbi->gc_urgent_high_lock);
 
-- 
2.20.1.7.g153144c



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
