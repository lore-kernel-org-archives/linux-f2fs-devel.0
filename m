Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C11CC3ABB9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 May 2025 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SpY/Z/jTL6xekNl20d5NUhmb8yD3cCusLNAIdv5grM0=; b=AOqwZffWqMdmNwAWyVIcYuP3wq
	G2TrOv6ZAu+ChqkUaTSz1v/ukeh5CCq8EHBsJv/yc+2+CaP+unVizITcKGwYRYMycGrM7aAw20SsF
	g5+f1dJn3I1uuesTBZQ1S5+FLW0RUnlHUzyWznYQZep0H7nr2GI7zIgPCLT6jFQkTId4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uC4Xd-0007Xo-Bk;
	Mon, 05 May 2025 22:44:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1uC4Xc-0007Xc-DD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 22:44:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nd6IvKGIEGT6pJ4e0xq+G4fltvjEcMtvY69lkTl2Xvw=; b=OhxWlzK1AFMoo4ciL8xTXYyrfV
 ZfnOmEYrL8wXxCg36PEerF9l25yd1KrEFUcHCEHZnHxl2Gm4COCp8aWafMqbWpoKxaasHaoxX/gLb
 MsbPHq767mHddHrrxYKvPXe8m+TqcNzSpQzAvve3QR3nsegXTpeMWfCvI1R/ZBHN1UfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Nd6IvKGIEGT6pJ4e0xq+G4fltvjEcMtvY69lkTl2Xvw=; b=K8qUF0YFbS8PFgVJgoXXiKMVyC
 JzJ3a695iTHOs07kJWEA4MFjscrbC3WH3krU2bqzY/Pix0ux8RBGMJp8+HFKbVGkS3jSf3+ySqR1P
 FKgenIHMPXU0HWO4QjR4EMFRT8PuawFCsOxiFDqXjs3G57Nx5Of3OQppLefS9aKfCI6Q=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uC4XM-000384-Rv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 May 2025 22:44:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 703C7A4D046;
 Mon,  5 May 2025 22:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A40C4CEED;
 Mon,  5 May 2025 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746485017;
 bh=pKZWDRkvVRBjTimgpV36FBBnP2eXPkS+7OxJHRyIvrQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IfSL2NyXXJJVsq5pbHKxuzPYk2rzviLVYChGswDI8qJguALSiF70fUFW7VOtAXRC7
 kZhST4adGaslYqAL6CCr9mdYs2vmWqPtzJVqJv2nglWphQx19uPj6DeQQo29PCq4EU
 hAmwCbMtXc0cnkrOqZnBs6E0u/ptcl9H5TGWpBT75+1dY5QA8qfWczqO/ZOO4eWbQ9
 v0qLxG5tdc+F6ERw5BNBu/lfCFYN+B9Xn2kMe5poxb0I9PQumE0OVLSZQgkQJa68cb
 2gSmrUTWxaQ1a50P1NzI8+PVL///DWT3Mgo1YDPi7bWNymr9H6jSGqgjXSowBeSl5S
 9V7QpoNrMRJmA==
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon,  5 May 2025 18:33:21 -0400
Message-Id: <20250505223922.2682012-125-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
X-Headers-End: 1uC4XM-000384-Rv
Subject: [f2fs-dev] [PATCH AUTOSEL 6.12 125/486] f2fs: defer readonly check
 vs norecovery
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Eric Sandeen <sandeen@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 9cca49875997a1a7e92800a828a62bacb0f577b9 ]

Defer the readonly-vs-norecovery check until after option parsing is done
so that option parsing does not require an active superblock for the test.
Add a helpful message, while we're at it.

(I think could be moved back into parsing after we switch to the new mount
API if desired, as the fs context will have RO state available.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 573cc4725e2e8..280debf2df4f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -728,10 +728,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			set_opt(sbi, DISABLE_ROLL_FORWARD);
 			break;
 		case Opt_norecovery:
-			/* this option mounts f2fs with ro */
+			/* requires ro mount, checked in f2fs_default_check */
 			set_opt(sbi, NORECOVERY);
-			if (!f2fs_readonly(sb))
-				return -EINVAL;
 			break;
 		case Opt_discard:
 			if (!f2fs_hw_support_discard(sbi)) {
@@ -1406,6 +1404,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
+
+	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
+		f2fs_err(sbi, "norecovery requires readonly mount");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
