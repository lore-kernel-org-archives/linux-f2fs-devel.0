Return-Path: <SRS0=Zvp+=JX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3B6C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Apr 2021 02:12:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A394B61263
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Apr 2021 02:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A394B61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1laqjQ-0005iP-Cq; Mon, 26 Apr 2021 02:12:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <changfengnan@vivo.com>) id 1laqjP-0005iI-FZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Apr 2021 02:12:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bytXRgrkW4DeZs5ktGKv5LdwePhUqEY93ZuAFdVBRoY=; b=dAm9tXos2nbs3Vmd9sE573c2pc
 FNNSsjZ7xJIfJN3O3UVgty/Y2+s3KTN0DuGOOiHBlPRygssAlHDrlmGTZn8Z6+b2r8Pz3I6sOcEUC
 gEj/i2x08x8P9ouM3igbw+TwLfjRqaLEMjtI+3wRXo/amKsYcPNGrFzQEp3fZygSYNPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bytXRgrkW4DeZs5ktGKv5LdwePhUqEY93ZuAFdVBRoY=; b=T
 EjrnaYl7sv2dapy2/JHTbQEyt8mwCwcisfSmVVXQf6GEl0Iob85J8kx92NeiEJyiLcI2qbX6dalpe
 QTSwuKIrIfnjiFJple42N0uZLFtG3d6mt6xdNc4z7LguMjfH7rB1TL8VPwbVfHrJZ7XOgz0qjm//5
 VIFW3eOkM9Jf7H1I=;
Received: from mail-m17637.qiye.163.com ([59.111.176.37])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1laqjJ-0006Dk-8u
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Apr 2021 02:12:15 +0000
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.232])
 by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 1BB84980777;
 Mon, 26 Apr 2021 10:12:00 +0800 (CST)
From: Fengnan Chang <changfengnan@vivo.com>
To: chao@kernel.org, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 26 Apr 2021 10:11:53 +0800
Message-Id: <20210426021153.646-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQ0pITVYfHUlPQ0JCT0hDHk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohg6ISo5Kz8SHgI2TAETPRY8
 C0gwCTlVSlVKTUpCT0tISklLTUlLVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WU5DVUlOSlVMT1VJSElZV1kIAVlBSkJISzcG
X-HM-Tid: 0a790bf29e78d992kuws1bb84980777
X-Headers-End: 1laqjJ-0006Dk-8u
Subject: [f2fs-dev] [PATCH] f2fs: compress: avoid unnecessary check in
 f2fs_prepare_compress_overwrite
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
Cc: Fengnan Chang <changfengnan@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

when write compressed file with O_TRUNC, there will be a lot of
unnecessary check valid blocks in f2fs_prepare_compress_overwrite,
especially when written in page size, remove it.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cf935474ffba..9c3b0849f35e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3270,6 +3270,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *page = NULL;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
+	pgoff_t end = (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	bool need_balance = false, drop_atomic = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
@@ -3306,6 +3307,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,

 		*fsdata = NULL;

+		if (index >= end)
+			goto repeat;
+
 		ret = f2fs_prepare_compress_overwrite(inode, pagep,
 							index, fsdata);
 		if (ret < 0) {
--
2.29.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
