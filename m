Return-Path: <SRS0=yDIE=43=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A500AC10F27
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F622468F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="i/STG9Y+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="InGWMioK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F622468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jBeLN-00044e-5N; Tue, 10 Mar 2020 12:50:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jBeLE-00043Y-RZ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Mar 2020 12:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eKVSeJnBG497NH7PnYdsZ6xtAseHjzjl5wFVcEwKVzg=; b=i/STG9Y+jWz1Dk4P1W8klRaTr6
 RrbY1RSeix3KWu9iOwGzX6ZP6VM2UixdGb18v+KZrhFfzdN53ntvJ/PMHJ5iRr3RWDIq+qtyQOZiD
 AoTprMv2SpE8PynJ8e6IiSWd8zlcqbnHXNt42kgjC90MitPsny5eDi6rY4yTDJEuaa7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eKVSeJnBG497NH7PnYdsZ6xtAseHjzjl5wFVcEwKVzg=; b=InGWMioKHQAdhamTQDdcK/Tiy7
 Hu9JrJazxf4rdJI+vw0FCnO1qb/QS/DEEKdE7xO9nN3IiAqX+9sKcES+MYAETgwAaCslk3b7SiWoo
 Bed3h/FqXIj8MzBnRtVCptXTv4GkYIwPiUwjcWTUINi3aq2QxZFP88OSbIUgatvZi1Sk=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jBeLB-00Ec2S-C8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Mar 2020 12:50:36 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8A97E54CF64383DF3605;
 Tue, 10 Mar 2020 20:50:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 20:50:14 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Tue, 10 Mar 2020 20:50:09 +0800
Message-ID: <20200310125009.12966-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200310125009.12966-1-yuchao0@huawei.com>
References: <20200310125009.12966-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jBeLB-00Ec2S-C8
Subject: [f2fs-dev] [PATCH 5/5] f2fs: allow to clear F2FS_COMPR_FL flag
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

If regular inode has no compressed cluster, allow using 'chattr -c'
to remove its compress flag, recovering it to a non-compressed file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 08c19ab81c80..e04a31e21448 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1822,10 +1822,10 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	}
 
 	if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
-		if (S_ISREG(inode->i_mode) &&
-			(masked_flags & F2FS_COMPR_FL || i_size_read(inode) ||
-						F2FS_HAS_BLOCKS(inode)))
-			return -EINVAL;
+		if (S_ISREG(inode->i_mode) && (masked_flags & F2FS_COMPR_FL)) {
+			if (f2fs_disable_compressed_file(inode))
+				return -EINVAL;
+		}
 		if (iflags & F2FS_NOCOMP_FL)
 			return -EINVAL;
 		if (iflags & F2FS_COMPR_FL) {
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
