Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2446C47DD9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jan 2024 15:15:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rRw1T-0002a5-A0;
	Mon, 22 Jan 2024 15:15:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1rRw1S-0002Zz-Gl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 15:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5Ca2Jap1DSHM2lQ9RpPacr9jQZ+OewicPF5UAk+Ycc=; b=HRsAEO+57Ht4jezNSFTyAMdXKo
 V+XALwPWzuHsfwpOXJxKgNf6i0E2Q2dKikL8wAVubh+//5t/86Vdzs6nJ0+uH641rilN10ZDRks+Y
 KXP9vczQq9LQvTJq8rlb3N+UcAq9b1ac1db5CCMHzEQ1THgI/9zB90aZw5d0vfUNwN3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E5Ca2Jap1DSHM2lQ9RpPacr9jQZ+OewicPF5UAk+Ycc=; b=a
 tUQHLHVVOo15RVwH1A8xYJjFqIlXv/xGsqObKW8vnaKdV0hBipnpOj78vzBlqq65I3gDtILT9brJi
 AXJA7b7XPmEXk2rYpvvGJN3ZJh8ZhfP1V/9BaJBBuQKPjUFH3yVfq2uqOhQSQkrf6G/nhmaUVBLMq
 LPSD4Tmht0ptkD4s=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rRw1S-0004Ap-0I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 15:15:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 78740CE2B24
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jan 2024 15:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB0AC433C7;
 Mon, 22 Jan 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705936524;
 bh=z/q4voB+EPDamF3u0eqwmT9u48yKxLVPnuOYra/Tn6c=;
 h=From:To:Cc:Subject:Date:From;
 b=B+HEGo5HkIk+FQS/1l2VcoUlMcdzwvCuWENhqcYVt5nTr0BzGycBBCWHZxrQ4LoNl
 pCTG83j3ydR9lSQJnH7D+df2lKleegK4fRzIg10cNte5BK2WfnqrLnkyJBt/jjGS+C
 mudfXslXm1C33FwwgnosQvjufbx2E4xcPHOtbwsk9LkKl7jPhas2AZn0oVwr0fyaae
 qa9WrGjm/Ysbv+dCAgEwg9ihE9xQmwo8979YAItR3bCPvVRMgsGUQlepbUlwekC3tk
 Fwh2n+vZS1kP7/YQok1qqcX8K9XrxFmQzGSRKxDqIlHJl/OTJb1Gli9cMjcpUiHt7c
 SnYR7RFIJoO1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 22 Jan 2024 10:14:27 -0500
Message-ID: <20240122151521.996443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
X-Headers-End: 1rRw1S-0004Ap-0I
Subject: [f2fs-dev] [PATCH AUTOSEL 5.10 01/28] f2fs: fix to check return
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
index c3c527afdd07..2700e0fdd3e0 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -641,7 +641,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -649,12 +658,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
