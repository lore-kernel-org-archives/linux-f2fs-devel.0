Return-Path: <SRS0=ikBs=FS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B24C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Dec 2020 09:21:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA40620771
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Dec 2020 09:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kok30-0000MF-O0; Mon, 14 Dec 2020 09:21:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kok2l-0000Ll-VB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Dec 2020 09:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NNqZ1jNwIEQWqMwh7TUFhnYCWZUWGLixYSU+gzKtXBo=; b=PsLF2Gwij9b52z6cspQtR2bc2g
 zfELnv112fpqYLvdsvgE17TSvNgnRYnE5+4XWW7C45hARsUtEedi9iRhHOV90svjiD4Tiyz5gcXzA
 J6wyCGHCUDdWtNEDCCSUOJH7oOxoMY2UiDXDNQT9XrCcPZhs3Le/MyETNQfOdzYLMZaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NNqZ1jNwIEQWqMwh7TUFhnYCWZUWGLixYSU+gzKtXBo=; b=c
 Nkw/DPjL+QAu6Hy+krA8eWMHPjcdqJUQJ3E45yHIJ4uAGxdlZfxAD2BIq8lhiIemnzK/HSmSc0kH/
 vjEqDGroH0kHUL49cXMiHYIOkP94sv0SXsjzCJRUIy1S20ofYeHC5NFuNI9TPRW3IQZDHCf3tn/BC
 xf81GvFfc93MBWag=;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kok2d-00DPI0-Sx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Dec 2020 09:21:23 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CvbTV4tSCz7Fq6;
 Mon, 14 Dec 2020 17:20:30 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 17:21:00 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 14 Dec 2020 17:20:57 +0800
Message-ID: <20201214092057.21629-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1kok2d-00DPI0-Sx
Subject: [f2fs-dev] [PATCH] f2fs: fix to tag FIEMAP_EXTENT_MERGED in
 f2fs_fiemap()
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

f2fs does not natively support extents in metadata, 'extent' in f2fs
is used as a virtual concept, so in f2fs_fiemap() interface, it needs
to tag FIEMAP_EXTENT_MERGED flag to indicated the extent status is a
result of merging.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 894c5680db4a..baa9ccf84e2c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1971,6 +1971,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	if (size) {
+		flags |= FIEMAP_EXTENT_MERGED;
 		if (IS_ENCRYPTED(inode))
 			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
 
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
