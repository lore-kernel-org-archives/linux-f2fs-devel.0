Return-Path: <SRS0=SE50=KI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265EC433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 May 2021 00:45:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FD0613DF;
	Thu, 13 May 2021 00:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FD0613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lgzU6-0001JE-2I; Thu, 13 May 2021 00:45:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lgzU4-0001Ix-AM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 May 2021 00:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a7lqz1YMO4nJsCE7QHemad004Yq6KpTnxtK1z5Oekfs=; b=B9RX2bGRd1+HpKqhb9qz1uTHXB
 YBH8YynSBjAP3mZxmEXkzrVJkDzCp8MyHQMF8ZD8/5DytFKKjWX2Jsg6+ODuuFoTRgXLBXBz3Klcx
 Z2VVQTglhtOLyMkBEoRrrGBPnJdlcjfSyM0YcRmdVh+b4gjY4XqyWdYpiP+VDm2w/lxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a7lqz1YMO4nJsCE7QHemad004Yq6KpTnxtK1z5Oekfs=; b=W
 AEPnzSoNV0409CkaLdD2lAiSp5vjdRG36OKqMGW01cuvyvSVSnZSH2xeRM7SjwNQ16++dbTdxKTpg
 E6U4OAgeV5/80JSMWlYNGfL9EhpxL7VjtTvdE/4g/xnX02FXxMBOnJo/yt1KzcexhYMfI2E9RPlQx
 3+KkJqcMqJM4Y0Gg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lgzTv-0003Eh-MM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 May 2021 00:45:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06A4F613CA;
 Thu, 13 May 2021 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620866729;
 bh=bInJzrzMTKEfUz71kqIhWS61jCi+MWogtSHtDwqlFXc=;
 h=From:To:Cc:Subject:Date:From;
 b=XWnkDbHOGwNKujT3ouCBL+/UL2qYQXQwpCsGEfZuLF6Y9UHT6eYU67L87ad12otRu
 hfLx/HoZrPYiSrhbnEJeolCYrIW7IK6CJmdXuOR1D92tcK+tYk+xMPgQt+TSGsaGBV
 9nQG65XCgM0f6qLljD+JA6/9ePcid0jJ7Dt7sAim4b0C1wlk3l5wbpgudFugCzO17u
 LhMSmi+rMO3+E5U0ByiUFBrmkdFo8aprFmysz8w/yI6M5RB8SD97UWWTvat7ov1I2u
 vtjhbk15f0Lsu/a6hwl+VMOcTdXGD7OIvkg0eiP5GXfvvIMZxK2l+/xMhRKVcmZOQS
 Wat533KHjDEKg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 12 May 2021 17:45:27 -0700
Message-Id: <20210513004527.3721604-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
X-Headers-End: 1lgzTv-0003Eh-MM
Subject: [f2fs-dev] [PATCH] f2fs: return EINVAL for hole cases in swap file
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This tries to fix xfstests/generic/495.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41e260680b27..009a09fb9d88 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3896,7 +3896,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 		/* hole */
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 			f2fs_err(sbi, "Swapfile has holes\n");
-			ret = -ENOENT;
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -4052,7 +4052,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	return ret;
 bad_bmap:
 	f2fs_err(sbi, "Swapfile has holes\n");
-	return -ENOENT;
+	return -EINVAL;
 }
 
 static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
-- 
2.31.1.607.g51e8a6a459-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
