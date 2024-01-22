Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD55C47DAF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jan 2024 15:17:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rRw2w-00042f-PQ;
	Mon, 22 Jan 2024 15:17:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1rRw2v-00042Z-7F
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 15:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YWgxPGvUfJgH6QSIv4dZhfjh4llbC5YfnQQ5pZHkT5M=; b=kJ39IB7xf6t4AqjptbT4BLDK7g
 xyzWwyS8DYuQHsy1tju/kKE4ukmR4FIIEhjKe1O6GSTqC1/4xKKrB4AkJGdP+1j0rKMpz525w5drF
 rzXuDEWMrtVLw9IH/qwKA70BpaxYYcvfB7UPZrlLpk3eixbucsCl/8RqphuxwXkY685A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YWgxPGvUfJgH6QSIv4dZhfjh4llbC5YfnQQ5pZHkT5M=; b=N
 lMkA1GepUgIEHsVAXTkJUg1s+TtMt3686umMOW2Jp0zmap+Q1MoI1McrmGMWTLNXHV86NrdXvNKo8
 VSWxU+3kI/Olvk1t0R2pYyfMGUTG3wbs5bUF1wXKgXxHRa7FpWl3jTxQE6FPLgYbgDxKpKn7FTg5f
 y0x5XiSBG8VWW014=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rRw2u-0004Fr-E1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 15:17:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D15FEB80E8D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jan 2024 15:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E8C433C7;
 Mon, 22 Jan 2024 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705936622;
 bh=PHlstZOn4P8fYiw3yCJ5n92bZwgwDCDEX6GCLi15oTY=;
 h=From:To:Cc:Subject:Date:From;
 b=HxgWuOCuZy8iHc4ax3wwEp6au9fDDN93g+tkSMEQ/hvLrtEDziJLyzKTmqk5NhHzc
 PFDlgPALSVtgLbsIJUchV5aNvia9Hc1I0RFFbIfBTVdgwoIJndAFaGf6941qD8mf2p
 /jdA32X1OYqTwt7E3Ae/cmDPBxeLU/9+lV+P5Y/q8rTKFZ0VJr979M/mGTP/i0H2ik
 g6v9DDhKPFi74lAaJzK3NpLsHYGvfB/KDg8BAhje4y3cGFcJmtv2fI/NHnOlRgJO3Q
 8NW6D1UIdB0YnYCiUz6qJ3wxZfKM2u9PPk7HZok6VjTwM4avbsRDv1Qud08aSl0XOB
 i37RLpXhcceUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 22 Jan 2024 10:16:15 -0500
Message-ID: <20240122151659.997085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
X-Headers-End: 1rRw2u-0004Fr-E1
Subject: [f2fs-dev] [PATCH AUTOSEL 5.4 01/24] f2fs: fix to check return
 value of f2fs_reserve_new_block()
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
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 956fa1ddc132e028f3b7d4cf17e6bfc8cb36c7fd ]

Let's check return value of f2fs_reserve_new_block() in do_recover_data()
rather than letting it fails silently.

Also refactoring check condition on return value of f2fs_reserve_new_block()
as below:
- trigger f2fs_bug_on() only for ENOSPC case;
- use do-while statement to avoid redundant codes;

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index da123c6d3ce0..7e30326b296c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -611,7 +611,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -619,12 +628,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
