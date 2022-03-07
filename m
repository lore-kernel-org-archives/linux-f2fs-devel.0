Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B29C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Mar 2022 07:54:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nR8Bz-0004DJ-Pi; Mon, 07 Mar 2022 07:54:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jiayang5@huawei.com>) id 1nR8By-0004D6-L9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Mar 2022 07:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iJfFzYKgbydt9eP+mDBfvLVw+9lkF/kgraTbnaTDPIg=; b=SgFibD4tfikCUwLT5A/imG9Vyj
 lX1GXeFiiDYQj/sqvttOvanNL8uFX0dJqOLdTdQ/prN2+LyCB8o5OSTOSLI1xxoPXobuhrVYtoNct
 NxGNAc9lW0BlRyqYoTmOC5fgewIGQbl1UcGzQVL1Rdq9XRVLWXQt3Ot4Ld8ZogHNx+ww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iJfFzYKgbydt9eP+mDBfvLVw+9lkF/kgraTbnaTDPIg=; b=O
 A14l8TZZrqgIUJDP1lK/yKgp4uIq7KCDZQJY42gUsu0FEoEiLCQChDozvDOTpbDUWFVftoeAkoncM
 b+jzo5315LbWQlYaQmh9HAqY+lWZUcxKuLKSaDaszN8RFHEE6l6c4BrLVdVqDlbn6hrqlUyIdcgwt
 d/8Izoe/+Igh0rd8=;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nR8Br-0078eV-Cn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Mar 2022 07:54:04 +0000
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KBrJY0g4YzBrdQ;
 Mon,  7 Mar 2022 15:51:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 15:53:50 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 15:53:50 +0800
To: <chao@kernel.org>, <jaegeuk@kernel.org>
Date: Mon, 7 Mar 2022 16:12:27 +0800
Message-ID: <20220307081227.1353957-1-jiayang5@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Headers-End: 1nR8Br-0078eV-Cn
Subject: [f2fs-dev] [PATCH -next] f2fs: remove unnecessary read for
 F2FS_FITS_IN_INODE
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
From: Jia Yang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jia Yang <jiayang5@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS_FITS_IN_INODE only cares the type of f2fs inode, so there
is no need to read node page of f2fs inode.

Signed-off-by: Jia Yang <jiayang5@huawei.com>
---
 fs/f2fs/file.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cfdc41f87f5d..4b93fbec2ec0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2999,7 +2999,7 @@ static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct page *ipage;
+	struct f2fs_inode *ri;
 	kprojid_t kprojid;
 	int err;
 
@@ -3023,17 +3023,11 @@ static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 	if (IS_NOQUOTA(inode))
 		return err;
 
-	ipage = f2fs_get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage))
-		return PTR_ERR(ipage);
 
-	if (!F2FS_FITS_IN_INODE(F2FS_INODE(ipage), fi->i_extra_isize,
-								i_projid)) {
+	if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_projid)) {
 		err = -EOVERFLOW;
-		f2fs_put_page(ipage, 1);
 		return err;
 	}
-	f2fs_put_page(ipage, 1);
 
 	err = f2fs_dquot_initialize(inode);
 	if (err)
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
