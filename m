Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B01EC47071
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Nov 2023 06:26:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r3VpV-000085-26;
	Thu, 16 Nov 2023 06:26:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r3VpT-00007y-0G
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Nov 2023 06:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5iXeEcEqiRYpmeSIt8aCITFPceGAZWzrZRvTG0xcYrI=; b=A5QXm2ls9Uog2bpSQQFq4NS3OD
 zHljvDxaIbFvUj5Q06a045gtTd4q8+3BtvKic+ZXx1cCxTGsb7z4cWjlzFSwUJqtpQ+1pzVJUedRI
 hiHJRxTYndDqvVyxvOUkkxWxzjlOu1bRrK6vjgFBmpPYGoqIILSOCWX2qGEVyBxS5P0E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5iXeEcEqiRYpmeSIt8aCITFPceGAZWzrZRvTG0xcYrI=; b=gp1s116E29H219FTY8g+0AVIKZ
 Q/zupuJ0S1KazUe950Dm1bFzTrjWA0XCVTNKtLDrsyF2/NYJ2gqBl0MJ86Bt9E+IQ//hgWIA18VIV
 LV4xXy7lmuX8gCXQWkQWimTFBxq8wYg7yOCxU7epTW8WDd0vE0xAxE3C4hiPOT9sextM=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r3VpN-0004aq-Mr for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Nov 2023 06:26:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0A6AAB81C8A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Nov 2023 06:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E298C433CA;
 Thu, 16 Nov 2023 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700115966;
 bh=4ui5+7aVz7Gqv0sQoth9MwnoQqqjL6flt9PtV4MBJnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jHDeTQZSCIyaqUr9vYjCrR938zf9P6Ll63wLDGPERCA0VvpwEVjIIG0g0icc4cZLO
 TTnT/WcHrP2GHjvkhHL+gPcvgoyuuVypIAHkfs4Sj5R1afufTAaJ1rxCgIfAH9oOBq
 PJCzQdFVSDGtt9mHy59T4+sLSw1pa+CAqjwXze80vBsBJ1pwUjaO5BEDxp3Cje+UXk
 wYHj0HcvrNTY7iPM8CbPqNQTu59+WLXrvsVoyqmFMnVNVBGKdcS86byQg1img9iYd0
 NZmqmjR9LhTa/lcfhJ3NbXUgZPUkuKPOsDIqhRC9Le8sCPORXc+2MGRMOlyGJOVedu
 Lkc9Lbou9tu7A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 16 Nov 2023 14:25:56 +0800
Message-Id: <20231116062556.2451839-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116062556.2451839-1-chao@kernel.org>
References: <20231116062556.2451839-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1r3VpN-0004aq-Mr
Subject: [f2fs-dev] [PATCH 3/3] f2fs: fix to check return value of
 f2fs_reserve_new_block()
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

Let's check return value of f2fs_reserve_new_block() in do_recover_data()
rather than letting it fails silently.

Also refactoring check condition on return value of f2fs_reserve_new_block()
as below:
- trigger f2fs_bug_on() only for ENOSPC case;
- use do-while statement to avoid redundant codes;

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/recovery.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b56d0f1078a7..16415c770b45 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -712,7 +712,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -720,12 +729,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
