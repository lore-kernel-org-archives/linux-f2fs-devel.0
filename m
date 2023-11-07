Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FAAC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Nov 2023 23:23:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r0VPf-0004On-KL;
	Tue, 07 Nov 2023 23:23:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1r0VPe-0004Og-OF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 23:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w5GPYDrKrHOcV7RdC+Qp/RiFS+g83/O4GF200mHidIU=; b=m1VVxH5yRINIxVVJcIEMNcGHcC
 lCgUzxKYXmBCZL6iZlEAkUyJVzPgZa+xeGRcIZ5BJWXQ4Rl8s28V/isyJhKiLsBzBxo7+dcdH/+aZ
 DvRsZ9XYbiK0rtHUrM2J7eYpQoMojl5Fs7TphNATz+mQ/SAuviZ0fiunHCCpYPVBNFW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w5GPYDrKrHOcV7RdC+Qp/RiFS+g83/O4GF200mHidIU=; b=HdqnGUA0RMGrRhXca/S1l7MkUf
 UtXNhsSpo8r0q5SUDCLu0O5NwNJzqlKoEmju0HRWmeGnIAXUYkh/1AIs5X5xzU2WMbMDrMkvcYo4p
 nuCDfRJdD22Mq1INb0ldVBYg6o9eNTT1+1LVyhm6no6P+uo3YKRrW/a9XZweOf+DatKo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r0VPY-0005vk-V9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 23:23:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 898EC6142D;
 Tue,  7 Nov 2023 23:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B89C433CD;
 Tue,  7 Nov 2023 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699399383;
 bh=brWxIczyVCBvO4AyUa+zsOYOVfm9JnL6XsF7XTe1ClA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W1EJ0yRLJUMO6Isaj4lW+kzy8zr9AE6x5LZ/9K7OoEohb+TcWwX8WOCys8z7vN0QI
 iHxf+TJCkU8b2UtmUSIhytx/oeIgzojmLG8tXSaygP8jBkxhoLS+dy/Rx8f59+j/g0
 SERiq2CaWopBZwhSd0nmWdpXiq1b6WzYEniork7BvH4opJb8ZgawnKJD33OIRlYcUI
 udmqn3A9OIesYImqZTDELUs51D8GwVAvU232Jp0GBsNR3dziVjZXJV7Dab86YW3su5
 ZHzVOgySAz/IoAGAejleNYzf+MLw6Bbz/dEUXHaKoHl+GMWYfzMF50dqWF7Zz/LE0z
 XeP6rND9qMmQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Tue,  7 Nov 2023 18:22:08 -0500
Message-ID: <20231107232231.3775605-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
X-Headers-End: 1r0VPY-0005vk-V9
Subject: [f2fs-dev] [PATCH AUTOSEL 6.6 14/18] f2fs: fix error handling of
 __get_node_page
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 9b4c8dd99fe48721410741651d426015e03a4b7a ]

Use f2fs_handle_error to record inconsistent node block error
and return -EFSCORRUPTED instead of -EINVAL.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 248764badcde8..ed963c56ac32a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1467,7 +1467,8 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
-	err = -EINVAL;
+	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+	err = -EFSCORRUPTED;
 out_err:
 	ClearPageUptodate(page);
 out_put_err:
-- 
2.42.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
