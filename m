Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB1E77170
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Dec 2024 17:12:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tIsuz-0006qw-Cl;
	Wed, 04 Dec 2024 17:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1tIsuy-0006qk-81
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Dec 2024 17:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q1Qxk46IUwHCpGIrk+q27UA9wsOAwTqjESfcnOrK9/4=; b=Z6MfuQAKLG4Yr12cOBtD1YyuXp
 /el7+i/YmK/RwV82Hc6Hj0YsnpMpoUVY+GDN2CrvGMD/57espFJdixvf+R5W1b411BMDCBUZJ3yN3
 w9WWAhs8fwVTmhbPzAOtFVvrgZMx4w6orWBXxh6k8iE2RJ48B4iRFr6DNIdnrOSYyOZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q1Qxk46IUwHCpGIrk+q27UA9wsOAwTqjESfcnOrK9/4=; b=kCFm1isA1Ax0cyJq2VjpqxrG28
 GrV/lHgXR24pVrolWRxuRd4nu8hVyZZC+iWJGAxgGrB6VNf+MgFjgiVtji8SAr7TyK9ula2fMzhv7
 bI0JyCDBUW9VaBv9nLzRPyWVJq3VzDO4JygEjPgM3pS5kBerpfBd96TY4G1Ok6DyZ670=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tIsux-0006Cy-8K for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Dec 2024 17:12:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0C4175C5649
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  4 Dec 2024 17:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF68FC4CECD;
 Wed,  4 Dec 2024 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733332312;
 bh=3pxWEnxr6XMjjy+AhRxPK8q2FLeIUsRi6U5y2ZV0sxc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iD7H+vSx9rwCuZ9mk0FQJn0JXsOxFsbunCiF7red3OCmOfOdLXbAD5Lcxkvsb0hJh
 8uXm6/nVIDADypKNKpAnj5BT5769gsOKTWMcOL16nA8Ug04X2ZEFQ1FNa32ncyu3Hs
 xzBWhTzsS0tVzQxvxXxjPZ2POTh1drXRT4feevl+WHP9kf2VxjufR69LemPxHJnZKZ
 9B2XQwUfieL1XC8gi6PLebYvkQd3zOS0ThrOvZ4ePY/ZvmZsY7tPn8aAtzSf7QJl0k
 UNQd3+iH9LdLzPO6Wh46svD15tm89BXRSUac+ot3AfWmTGhkgAfTKDmmviOQrDVK/b
 mN48tTEYDohZg==
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed,  4 Dec 2024 11:00:01 -0500
Message-ID: <20241204160010.2216008-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
X-Headers-End: 1tIsux-0006Cy-8K
Subject: [f2fs-dev] [PATCH AUTOSEL 6.12 13/15] f2fs: print message if
 fscorrupted was found in f2fs_new_node_page()
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 81520c684ca67aea6a589461a3caebb9b11dcc90 ]

If fs corruption occurs in f2fs_new_node_page(), let's print
more information about corrupted metadata into kernel log.

Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
NULL_ADDR which means nat bitmap and nat entry is inconsistent.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 59b13ff243fa8..601ae810349fe 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1331,7 +1331,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		err = -EFSCORRUPTED;
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+		f2fs_warn_ratelimited(sbi,
+			"f2fs_new_node_page: inconsistent nat entry, "
+			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
+			new_ni.ino, new_ni.nid, new_ni.blk_addr,
+			new_ni.version, new_ni.flag);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
 		goto fail;
 	}
 #endif
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
