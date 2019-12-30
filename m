Return-Path: <SRS0=LqXG=2U=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9573C2D0CE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Dec 2019 09:42:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9524F20658
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Dec 2019 09:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="j1WAidrf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JOc5FHxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9524F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ilrYu-0007TX-Dt; Mon, 30 Dec 2019 09:42:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ilrYs-0007TO-H9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Dec 2019 09:42:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0+qh9ab/5f4IOzdRCEGR0lB75zeZTx+ildDuembyauQ=; b=j1WAidrfWz+lKyl6aKPyriq2mP
 WDYbbzCV1/I2Creah1i+QSiRa8/p89gu0Sc7ilO9IynK3564wyO3ZX0L2I7gkIR4tt0c7YcTJI9+6
 LK/KdodNLFIW7XttL60NqPkgcWVTWUcpSUCBMoO2IS1Z7y2MvihqDUwwteL5AQbPBEMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0+qh9ab/5f4IOzdRCEGR0lB75zeZTx+ildDuembyauQ=; b=J
 Oc5FHxaRS/0VW3ZWnCxiazvlD+4Gbw0YWotVeliDhNAzi2qoyWtHqdLc2qd7zje2GMJaW0puEZqeE
 vMEv76YBvsddcHUzEmv3wcxGsDp8+e3/Tl5bVW2qOJ2CMvkZMgvdtKAU2XUEzMNLiTynjueArtWyo
 yt4UnRPCGMQ4EEVw=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ilrYq-001UD9-Rq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Dec 2019 09:42:06 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BC6A7B9F093DF35E5D34;
 Mon, 30 Dec 2019 17:41:57 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Dec 2019 17:41:51 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 30 Dec 2019 17:41:41 +0800
Message-ID: <20191230094141.14141-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1ilrYq-001UD9-Rq
Subject: [f2fs-dev] [PATCH] f2fs: fix memleak of kobject
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

If kobject_init_and_add() failed, caller needs to invoke kobject_put()
to release kobject explicitly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f698ec883034..5152a7487335 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -740,10 +740,12 @@ int __init f2fs_init_sysfs(void)
 
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
-	if (ret)
+	if (ret) {
+		kobject_put(&f2fs_feat);
 		kset_unregister(&f2fs_kset);
-	else
+	} else {
 		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+	}
 	return ret;
 }
 
@@ -764,8 +766,11 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
 				"%s", sb->s_id);
-	if (err)
+	if (err) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
 		return err;
+	}
 
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
