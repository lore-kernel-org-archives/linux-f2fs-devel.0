Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B6EC3DA6E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Dec 2023 11:14:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rHiuN-0006WP-OR;
	Mon, 25 Dec 2023 11:14:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1rHiuL-0006WB-Nh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Dec 2023 11:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bJKmg5dWC6PvhPyN/ILONUpG+S84b3jK30LUbs6ODL8=; b=MdXoOmTsooOqCQoUJ09HrSY377
 pkuVr7hiq+BQppABX+6Vo+dASxDezEzIQYcCXB+WvDC9Htp+OYz4MoI7bTtZUFuuGBdfvJM/lAgVW
 RZAiyEAUOZTL0+TOaMTRkwKQxLBkwppqLsDZ5L/G+uwbdVGYGuiTyg9/FnMmcMiOTyis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bJKmg5dWC6PvhPyN/ILONUpG+S84b3jK30LUbs6ODL8=; b=m
 3G0ANaPTW7U70rpJwiD9+58hOMwBaN+yZWVl69DELL9GaGyXR5UaEBGTrvzVIT9OXCobOSqlHsX7G
 e/6Uo8lLs/KEz36pbZbdM2uuwMqld1WLJKr+Xz/nsM3uet3/J24Qk2ReuodEcoaM0o/mvtvRpSKw3
 M67D0ayz4WDkYhLk=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rHiuF-0000EB-Uw for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Dec 2023 11:14:04 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 3BPBDK38091375;
 Mon, 25 Dec 2023 19:13:20 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SzFTq2vzPz2QYWd5;
 Mon, 25 Dec 2023 19:06:55 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 25 Dec 2023 19:13:18 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Mon, 25 Dec 2023 19:11:55 +0800
Message-ID: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3BPBDK38091375
X-Headers-End: 1rHiuF-0000EB-Uw
Subject: [f2fs-dev] [PATCH V1] f2fs: fix potentail deadloop issue in
 do_recover_data
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
Cc: ke.wang@unisoc.com, zhiguo.niu@unisoc.com, niuzhiguo84@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

There is a potentail deadloop issue in the corner case of
CONFIG_F2FS_FAULT_INJECTION is enabled and the return value
of f2fs_reserve_new_block is error but not -ENOSPC, such as
this error case:
if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
		return -EPERM;
besides, the mainly error -ENOSPC has been handled as bug on,
so other error cases can be proecssed normally without looping.

Fixes: 956fa1ddc132 ("f2fs: fix to check return value of f2fs_reserve_new_block()")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/recovery.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 21381b7..5d658f6 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -710,15 +710,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			do {
-				err = f2fs_reserve_new_block(&dn);
-				if (err == -ENOSPC) {
-					f2fs_bug_on(sbi, 1);
-					break;
-				}
-			} while (err &&
-				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
-			if (err)
+			err = f2fs_reserve_new_block(&dn);
+			if (err == -ENOSPC)
+				f2fs_bug_on(sbi, 1);
+			else if (err)
 				goto err;
 			continue;
 		}
@@ -727,15 +722,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				do {
-					err = f2fs_reserve_new_block(&dn);
-					if (err == -ENOSPC) {
-						f2fs_bug_on(sbi, 1);
-						break;
-					}
-				} while (err &&
-					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
-				if (err)
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC)
+					f2fs_bug_on(sbi, 1);
+				else if (err)
 					goto err;
 			}
 retry_prev:
-- 
1.9.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
