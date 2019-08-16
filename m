Return-Path: <SRS0=leBL=WM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E59CC3A59E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:56:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4232064A;
	Fri, 16 Aug 2019 05:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lYb8uLdF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GPHznl6+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="biE0xC2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4232064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hyVEJ-0002GW-48; Fri, 16 Aug 2019 05:56:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hyVEI-0002GP-AC
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Aug 2019 05:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JjuURzPCN38irn/PVSTdROCE+Fuyt8hvQwWUhSnEHo0=; b=lYb8uLdFxqvrRkPmGFeJK97w87
 lW9/4Si/dlkFcGf+Bt8Kpv47sboL+kxW/wUJax0y6etlEMBoCNIuJP7DLQlowNud+oHd7kIi7yrPG
 SeWHlq1otcwdcSUHiqMdek7nz3eZw3+pk6z+Gz/TGGlgoISC2mgBCslIPLz+krqRjR5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JjuURzPCN38irn/PVSTdROCE+Fuyt8hvQwWUhSnEHo0=; b=GPHznl6+RJUw54YsuKuOIfqVf5
 IHJrgD3SjDKFDBvUnlwoaz/To8LWAsss4CDrgy8n+f681N05sGJ/wtfjrHQumX806YR7/Ij0ZUExO
 OaxXdi9ckmS9OKGnMQ4UqFxV26H1FYmYSp661G2ppvG+NwLefA+p+rbDVXy4Gw4JVWW0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hyVEG-007xJe-BO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Aug 2019 05:56:50 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B5C312064A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Aug 2019 05:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565935002;
 bh=l/GbltjBRn9pVcB/bU3jK0Y2TdVWlgpp24wjDO2j0OI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=biE0xC2DufQvp3+NAwIO5w4jW0akOURNoBybKUbt8akk9FDoEeIVz+QsBpcLYGo/k
 aav1Wb0WuMVLtXB0jYq5ojYh9akc47wQNZp5rfEYcJ+aWWGLKDvxERanrdeTmMfBa4
 PZo8krkNdmROGXURgAqFFauI+kUd//d1oQXx4puc=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 15 Aug 2019 22:55:37 -0700
Message-Id: <20190816055539.30420-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190816055539.30420-1-ebiggers@kernel.org>
References: <20190816055539.30420-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hyVEG-007xJe-BO
Subject: [f2fs-dev] [PATCH 1/3] f2fs: fix buffer overruns in FS_IOC_{GET,
 SET}FSLABEL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

utf16s_to_utf8s() and utf8s_to_utf16s() take the number of characters,
not the number of bytes.

Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index eb1aa9b75eda..d521a582d94d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3094,7 +3094,7 @@ static int f2fs_get_volume_name(struct file *filp, unsigned long arg)
 
 	down_read(&sbi->sb_lock);
 	count = utf16s_to_utf8s(sbi->raw_super->volume_name,
-			sizeof(sbi->raw_super->volume_name),
+			ARRAY_SIZE(sbi->raw_super->volume_name),
 			UTF16_LITTLE_ENDIAN, vbuf, MAX_VOLUME_NAME);
 	up_read(&sbi->sb_lock);
 
@@ -3139,7 +3139,7 @@ static int f2fs_set_volume_name(struct file *filp, unsigned long arg)
 			sizeof(sbi->raw_super->volume_name));
 	utf8s_to_utf16s(vbuf, MAX_VOLUME_NAME, UTF16_LITTLE_ENDIAN,
 			sbi->raw_super->volume_name,
-			sizeof(sbi->raw_super->volume_name));
+			ARRAY_SIZE(sbi->raw_super->volume_name));
 
 	err = f2fs_commit_super(sbi, false);
 
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
