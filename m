Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B43C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 May 2022 09:26:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nusi0-0005Jb-FY; Sat, 28 May 2022 09:26:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jack.qiu@huawei.com>) id 1nushw-0005JV-UV
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 May 2022 09:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/9zBYxh5EwPhBTme/XVge24vs+z9wy+guBj4MIYm+oo=; b=j9rGAIxCe5X9G7ohR4q/s0SKeX
 uT5pEAAZBLPfSUe/pZveUrsLOMKujH1Vq+8x5SSCkLo15zLcwsjYy5AreqjfLqnDvJfK0bA+6+JEx
 NjtKQT2bTlRgNU/pxdikSoTQLXlyKbAtjft/shwmNLFd0+aQ/NHdIABgAjzUmreskPXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/9zBYxh5EwPhBTme/XVge24vs+z9wy+guBj4MIYm+oo=; b=j
 LIRhIOmRp0yQpXwOuNpdhyQm7diLq5QtFXP47oA+82gZtKfk9oNdQuDqWRB/5qic1JjvWqVD+5n4P
 xzEfnG/MAMUpWxjKbHnR8tcODRgUaks78VOFF9i4PIwrHG54rr9hPa4kaQGXNKrDaHi/3jLIJtfzE
 2VtkgXqd7197KZgA=;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nushr-008JK0-56
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 May 2022 09:26:03 +0000
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9GTp2vTSzjX5q
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 28 May 2022 17:24:46 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 17:25:50 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 17:25:50 +0800
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Sat, 28 May 2022 17:35:03 +0800
Message-ID: <20220528093503.2608388-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500008.china.huawei.com (7.185.36.136)
X-CFilter-Loop: Reflected
X-Headers-End: 1nushr-008JK0-56
Subject: [f2fs-dev] [PATCH] f2fs: fix page leak in redirty_blocks
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
From: Jack Qiu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jack Qiu <jack.qiu@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When find_lock_page return error, page in [i, page_len) will leak.

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/f2fs/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 100637b1adb3..0e8938c5918e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3954,6 +3954,12 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 	struct page *page;
 	pgoff_t redirty_idx = page_idx;
 	int i, page_len = 0, ret = 0;
+	struct page **pages;
+
+	pages = f2fs_kvzalloc(F2FS_I_SB(inode),
+				sizeof(struct page *) * len, GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;

 	page_cache_ra_unbounded(&ractl, len, 0);

@@ -3964,6 +3970,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 			break;
 		}
 		page_len++;
+		pages[i] = page;
 	}

 	for (i = 0; i < page_len; i++, redirty_idx++) {
@@ -3975,8 +3982,14 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
+		pages[i] = NULL;
 	}

+	/* put pages[i, page_len) when error happens */
+	for (; ret < 0 && i < page_len; i++)
+		f2fs_put_page(pages[i], 0);
+	kvfree(pages);
+
 	return ret;
 }

--
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
