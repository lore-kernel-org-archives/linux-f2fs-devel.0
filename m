Return-Path: <SRS0=57LO=5E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE7C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:29:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA95020722
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DK6abDOD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="J1c3/Mvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jEsQN-0004ih-BQ; Thu, 19 Mar 2020 10:29:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jEsQK-0004iV-ML
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 10:29:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FW+W+ssiaKJ7qE6xiCANCDT85Ls/pJ3fOGbAeVdG0fk=; b=DK6abDODFHFHXtDWkYAMZ4CWaF
 tW7Pt+G32CcPaK8x7J0FwCJCdDP+h9I3XKXZnqh+yuMw+0/98rcCfaAYzIA6X5K8tGGXDGTcitOuH
 lhFzj7G4tHl1thS+4hAGmsg2q/Vtu1LKg/6/+N0JXinLVokDskUe5NN+ObxZL/VXw3+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FW+W+ssiaKJ7qE6xiCANCDT85Ls/pJ3fOGbAeVdG0fk=; b=J
 1c3/MvxjeTHLPh5s+qlEgneZCAV8GhWFRak/jfX7Rb7YuaFzp0jj4S1RKBgDp1RT3y0IYr+nIrKT+
 8VYqJLWpW/fBtTlJxyUGQdAxONCJcARmEuOtE+VwyYXAPMhfcnEdoMVOU2Yl0VxgFse8as2hKy5ZN
 ynu3wItR+wCQaQo4=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jEsQH-008kjV-13
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 10:29:12 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 16DBCD07119FFDBA9158;
 Thu, 19 Mar 2020 18:29:01 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 18:28:53 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Thu, 19 Mar 2020 18:28:49 +0800
Message-ID: <20200319102849.50135-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jEsQH-008kjV-13
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix wrong addrs_per_{inode,block}
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

generic/339 reports below assertion on image w/ compression feature
enabled.

[ASSERT] (f2fs_check_dirent_position:1366)  -->
Wrong position of dirent pino:4521, name:"....", level:9, dir_level:0,
pgofs:1880, correct range:[1882, 1883]

The root cause is we calculate blkaddr number in direct node
incorrectly for directory inode, since during calculation, we only
need align blkaddr number to cluster size for regular inode rather
than directory inode, let's fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 lib/libf2fs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5c064c8..c2960fd 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -504,14 +504,16 @@ unsigned int addrs_per_inode(struct f2fs_inode *i)
 {
 	unsigned int addrs = CUR_ADDRS_PER_INODE(i) - get_inline_xattr_addrs(i);
 
-	if (!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
+	if (!S_ISREG(le16_to_cpu(i->i_mode)) ||
+			!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
 		return addrs;
 	return ALIGN_DOWN(addrs, 1 << i->i_log_cluster_size);
 }
 
 unsigned int addrs_per_block(struct f2fs_inode *i)
 {
-	if (!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
+	if (!S_ISREG(le16_to_cpu(i->i_mode)) ||
+			!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
 		return DEF_ADDRS_PER_BLOCK;
 	return ALIGN_DOWN(DEF_ADDRS_PER_BLOCK, 1 << i->i_log_cluster_size);
 }
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
