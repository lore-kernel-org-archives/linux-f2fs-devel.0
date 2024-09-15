Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06728C35FE5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Sep 2024 03:23:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1spfqs-0005cD-PR;
	Sun, 15 Sep 2024 03:23:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1spfqr-0005c7-A9
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Sep 2024 03:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gXMhjMlbDIwGk3hCX6P2UkRi1nTAyyL4fY0ECeztxe8=; b=BFO8QUFTJhsP4TXUXAolggp7kY
 0x7HwT8UXlN8eOP8vfugjVfu7Av62KhdhfVA+nb3Cq8oEMLWageRfFOoC9LtXWoax5TbYB9pDotSh
 3RN14KnosuCMpCchKDfmdxCNp1YlHzOnqqeGrZOVCH12J3FK0GEXfEG73eHRdZPtZpKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gXMhjMlbDIwGk3hCX6P2UkRi1nTAyyL4fY0ECeztxe8=; b=O
 e3ZHFI2GkDPsOGXq/mEO2wjapPJp+eXeXoDVAFl3UTr7IHMscxDoh6XQpCLRnTV3wxF7gR+OYct+9
 wEtHdYA6TZqRN4cDrCf4NxpNbj/+U/7ZIwQRM7XblczaXYC9Ogbo5QCzDFuwwM5+95jfB0EcoRwxZ
 yUY8O2pjEkmnGCjw=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1spfqq-0005ZE-Lg for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Sep 2024 03:23:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3F818A4010C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Sep 2024 03:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A56EC4CEC3;
 Sun, 15 Sep 2024 03:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726370573;
 bh=D4z2LbQM31Eu7rMfhCESWIT1U9N9nZd8stN4GhNdeA4=;
 h=From:To:Cc:Subject:Date:From;
 b=d0u7LlW5hygmEwzKpXkmkpP+JbUwYbvmanPcZjyv9t9YJWhycTmYTbXNbRjnQq1hK
 6VmEUWXUvXJGcN19G2D8oVJ6tP5TNbff3rugqacEKNCeyrOAlsdYsXBI3fTzm9txDq
 uAmiohsdmTOBLRWuAoKAuybdaxKJRWMLdcSIj4skH2c3J+LvV2fwOxpG0dH4Io4kjG
 YV/ZFS9Bblbr4Cqqko+7AAaiP74+sVe/tiRjNMCzTpAYDgfmr5e7J+osWthaCrtl0d
 txbQkbKGraH7rjV5Ae6AiZ35/V+jv9jm8HVq6Rj9zrud3KTzv3+iFc1QHioPRXIN6r
 ByjGs9Z5c0/mw==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 15 Sep 2024 03:22:51 +0000
Message-ID: <20240915032251.2300459-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
MIME-Version: 1.0
X-Headers-End: 1spfqq-0005ZE-Lg
Subject: [f2fs-dev] [PATCH] f2fs: allow F2FS_IPU_NOCACHE for pinned file
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch allows f2fs to submit bios of in-place writes on pinned file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d18931b7b094..c56e8c873935 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -792,7 +792,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "ipu_policy")) {
 		if (t >= BIT(F2FS_IPU_MAX))
 			return -EINVAL;
-		if (t && f2fs_lfs_mode(sbi))
+		/* allow F2FS_IPU_NOCACHE only for IPU in the pinned file */
+		if (f2fs_lfs_mode(sbi) && (t & ~BIT(F2FS_IPU_NOCACHE)))
 			return -EINVAL;
 		SM_I(sbi)->ipu_policy = (unsigned int)t;
 		return count;
-- 
2.46.0.662.g92d0881bb0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
