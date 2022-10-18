Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9508C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Oct 2022 07:34:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okh6w-00031j-IF;
	Tue, 18 Oct 2022 07:34:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyingliang@huawei.com>) id 1okh6r-00031L-5P
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Oct 2022 07:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u3iFX+780q70M5iAXRXrNHK6k0G09l3NwcIwK2MnBzo=; b=lB9bWVIU98W8RVYAqEQxxphND9
 CpTj99u0rqXDnnlSpn3JneGt/z7RiObVTf0GTxwUBPFQMC4dORcN/lpRrbxJB3nXM7k5vXtEquYHU
 eHwEeGpS/oPGmY2j/xUfRKiIklAxnfGcqd26ei4gBvghxn454V0VnmOKQCkewq00+lJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u3iFX+780q70M5iAXRXrNHK6k0G09l3NwcIwK2MnBzo=; b=W
 HRktRz5vsLsHDQKu4IXFDQdm7r+nYtkrmLaJXIcQvbSyU4qAI+GhyVVNx+em1VkV2Dlc6poFaqsqF
 VmF5sbE8CFUUifDR+Par8AnQzMOOlOEU2m6seCI4pyumpJfOQfvq3WSVT02WccJCYzM0Ppo6YTkIp
 GQ6bQMdx2VbIctSI=;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1okh6n-007z2U-HQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Oct 2022 07:33:57 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ms58N5jF0zVhwC;
 Tue, 18 Oct 2022 15:29:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 15:33:16 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 15:33:16 +0800
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Tue, 18 Oct 2022 15:32:40 +0800
Message-ID: <20221018073240.666374-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Headers-End: 1okh6n-007z2U-HQ
Subject: [f2fs-dev] [PATCH] f2fs: fix possible memory leak in
 f2fs_init_sysfs()
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
From: Yang Yingliang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Yang Yingliang <yangyingliang@huawei.com>
Cc: jaegeuk@kernel.org, yangyingliang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Inject fault while probing module, kset_register() may fail,
if it fails, but the refcount of kobject is not decreased to
0, the name allocated in kobject_set_name() is leaked. Fix
this by calling kset_put(), so that name can be freed in
callback function kobject_cleanup().

unreferenced object 0xffff888101b7cc80 (size 8):
  comm "modprobe", pid 252, jiffies 4294691378 (age 31.760s)
  hex dump (first 8 bytes):
    66 32 66 73 00 88 ff ff                          f2fs....
  backtrace:
    [<000000001db5b408>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000002783a073>] kstrdup+0x3a/0x70
    [<00000000ead2b281>] kstrdup_const+0x63/0x80
    [<000000003e5cf8f7>] kvasprintf_const+0x149/0x180
    [<00000000c4d949ff>] kobject_set_name_vargs+0x56/0x150
    [<0000000044611660>] kobject_set_name+0xab/0xe0

Fixes: bf9e697ecd42 ("f2fs: expose features to sysfs entry")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/f2fs/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..2ef7a48967be 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1250,8 +1250,10 @@ int __init f2fs_init_sysfs(void)
 	kobject_set_name(&f2fs_kset.kobj, "f2fs");
 	f2fs_kset.kobj.parent = fs_kobj;
 	ret = kset_register(&f2fs_kset);
-	if (ret)
+	if (ret) {
+		kset_put(&f2fs_kset);
 		return ret;
+	}
 
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
