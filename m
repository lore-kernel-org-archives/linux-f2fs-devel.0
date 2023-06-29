Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC4EB64DC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jun 2023 11:12:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qEpZt-0001JU-VS;
	Thu, 29 Jun 2023 11:12:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qEpZq-0001JN-ES
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Jun 2023 11:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=41mw5ZWBIjJXVFbysiQWooVvBluWKvyOZRLt7oTvhvA=; b=Akjct5gEqtWZV7OnejCxmCt9y6
 vgZYITUfSTYBdjCCHK+lBTbE4Fd3ZisSAGkFfIx9eGKlk7P49NtdI7mmYUWY6pgfCiD4gZW5XJXgL
 nSCJMS0v89Lb8YeScFisoD5/xAOqn/czHmYQU7ck/63mgCf31XyOGYj6OXUpKSopMPeY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=41mw5ZWBIjJXVFbysiQWooVvBluWKvyOZRLt7oTvhvA=; b=a
 mux033hPjImBcqsVHfGkGuuNA2UMoDzyC8OdLT0zxKneeaBdKEUoe33deVF4hc3unnw6miA1VCpP8
 pyhgmShuB71pHPxEI77tmu/ITQ0h1SYR+tJxpqJ/CdA5FJk1/WPYMORNYEPhrlip1+pGBLilbyHUm
 YV3bOZvjGS6cXwKM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qEpZh-0002c9-Dx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Jun 2023 11:12:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD266151F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Jun 2023 11:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7929DC433C8;
 Thu, 29 Jun 2023 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688037147;
 bh=Y8sghdOiJwlKu/ZFeQ3evxj9tX+ahO8njq44eT8tX08=;
 h=From:To:Cc:Subject:Date:From;
 b=nwZC34f9JBi2Y9cqCufRJhoX2Yuis6zIx6vi+Rf7No9RuJvP1g+Ns7N7p4O3CbEty
 6RqwE8IaSdx7hrR8Gvq7gweKBRUIbePEVeZTabRlORqrQwHq3vzkuznz+nXz9s2NSf
 e1XYZkLSL4I7ZNTVmDUD4H+ohxcqOMZ5xM2CQg+UBiOzLUYzPxfMtVasN5DZaKmUMF
 T0nrxBmHIJTkQ0iVPf6R1dVaDMsiFWcj7vTb24qyNex9wuLB5l2jRFo38mFF/NclJ9
 f7zxi/t+2QrMb+2ahMrND4GlDrCKS9XKBavmzbIB7EoZjY1sdeX2IT/C1bTSYTUdnc
 L4JiqkkjLiCTA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 29 Jun 2023 19:12:20 +0800
Message-Id: <20230629111220.3583389-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1qEpZh-0002c9-Dx
Subject: [f2fs-dev] [PATCH] fsck.f2fs: recognize ERROR_INVALID_NODE_REFERENCE
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch supports to recognize ERROR_INVALID_NODE_REFERENCE error
recorded in superblock during fsck, and force fsck to fix related
issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/mount.c      | 1 +
 include/f2fs_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index e5ffb26..e2d5ea1 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -671,6 +671,7 @@ static char *errors_str[] = {
 	[ERROR_INCONSISTENT_SIT]		= "inconsistent_sit",
 	[ERROR_CORRUPTED_VERITY_XATTR]		= "corrupted_verity_xattr",
 	[ERROR_CORRUPTED_XATTR]			= "corrupted_xattr",
+	[ERROR_INVALID_NODE_REFERENCE]		= "invalid_node_reference",
 };
 
 void print_sb_errors(struct f2fs_super_block *sb)
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 385d373..2f63259 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -729,6 +729,7 @@ enum f2fs_error {
 	ERROR_INCONSISTENT_SIT,
 	ERROR_CORRUPTED_VERITY_XATTR,
 	ERROR_CORRUPTED_XATTR,
+	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_MAX,
 };
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
