Return-Path: <SRS0=4l6L=LE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F5C48BCD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 03:29:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6596140F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 03:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6596140F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NzJJSTWKgIuVYX+OTZg5C4gY21HG6eWoOtDjDFDLDg0=; b=Hhcfms9EIxNrevevJ6X4yY9hFF
	bLWpsbnwODmX6ot05TeDiFjzAvzZD7dU9JjfO+Z/SviI17vw1O6C+Inxo3/VHnG7xJreQp8tilQ5d
	dvYn8LtY41WA0A6uh+ZeB+JATrbqqndlCmjKscjQ+CyIOB/zINuZZ1GIHQT0xTWTbG+0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lrBNW-00021x-J9; Thu, 10 Jun 2021 03:29:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <changfengnan@vivo.com>) id 1lrBNV-00021h-2V
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 03:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jeChl1QdQxxfyySObZhCmebu2OeF+XAlEeho9NETFLg=; b=B1FkhNMWacecay3RhFXEjLbe9V
 Yqn9x5dRtY/SSrqVBAnKHSuMvwcmOenR37wI1w7iGi/CzCG9NeaPoy6TXMY2YMcZ9gcD42XDMwPvI
 wH5fAPkzaNmbDJZsaVkViF1PXuia1MLbJjUiekhxFPQvWN7ZF/YWOM5Oa8H7sSpq/Y8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jeChl1QdQxxfyySObZhCmebu2OeF+XAlEeho9NETFLg=; b=Q
 1+oX5qbGau+NAIGhUfIVnfr8aFVbiMrKGUOfppBvHQJx+RSU3iQWvigPZo3BBj9jT/5lb6RV1p/Lk
 8vrYDoZ3twL4ghG1g9Fw4Au1zUJ9SM3zQgBqH4RC0jngVn6We6SLS0bhl9Xg7Y4EhgTlfiuXztr4k
 9q5NgjvHvGjOs8+0=;
Received: from mail-m121144.qiye.163.com ([115.236.121.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lrBNH-002yNM-RT
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 03:29:10 +0000
Received: from comdg01144017.vivo.xyz (unknown [218.104.188.164])
 by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 446BDAC0605;
 Thu, 10 Jun 2021 11:28:47 +0800 (CST)
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 10 Jun 2021 11:28:45 +0800
Message-Id: <20210610032845.84744-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGkNKT1YfQ0pDSx8eQ0oeSx5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Okk6Cyo6DT8XTgIiMSMVFzI2
 SxcaCQxVSlVKTUlISUJOTElMTExIVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WUlKQ1VKS09VSkNDVUpNT1lXWQgBWUFJSk1INwY+
X-HM-Tid: 0a79f3f71763b039kuuu446bdac0605
X-Headers-End: 1lrBNH-002yNM-RT
Subject: [f2fs-dev] [PATCH] f2fs: compress: remove unneeded read when
 rewrite whole cluster
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
From: Fengnan Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Fengnan Chang <changfengnan@vivo.com>
Cc: Fengnan Chang <changfengnan@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For now, when overwrite compressed file, we need read old data to page
cache first and update pages.
But when we need overwrite whole cluster, we don't need old data
anymore.
So, remove read data process in this case, I have made
some simple changes to test, tests have shown that this can lead to
significant performance improvements, the speed of sequential write
up to 2x.

This modificy just check wheather the whole page was dirty, because
when writeback cache f2fs_prepare_compress_overwrite will be called again.
when update whole cluster, cc in prepare_compress_overwrite will be
empty, so will not read old data.
when only update one page in cluster,  cc in prepae_compress_overwrite
will not be empty, so will read old data.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d4795eda12fa..9376c62e0ecc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3307,6 +3307,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,

 		*fsdata = NULL;

+		if (len == PAGE_SIZE)
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
