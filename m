Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654EBC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MITQquML6hJxd3ESw4JEH94OzUSYrV/wwjjD+InWJO8=; b=DcBE/cfXVCBwC9DZ2mBSbywGhO
	ae1Xd/CijBcAvziFB//aR2qbmdFJuiSiQM3wsBvyp/nkaJU91Wyfmz9bGTjXL518pecp7w/o7O3U5
	wDz/rV8LakKvgTIPslvmUrZVIYdNOm/kEO7uJMQbQdSrTY31xfz/P7AOFPE6zujayZkw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wv2gJ-0003db-LH;
	Sat, 15 Aug 2026 00:55:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wv2fw-0003dH-9Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 00:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lRFy+xqBIB5eySclPFNhhxkulLTbBnRxOml5TQs6tZE=; b=cUwBZ2vA7l1zK0vB1dxaNIy9ZB
 5i2NUsGZh8+uwYNJCWqVP7z/FjMqz63xRkkf2m8te5oqBFuXW03QdonmslSwnfWGJQ1DtvRFnpnuQ
 M30rFVr85QNtsCg8ts1kLdSNUGtMPGHcMWz+HMoKAQT1Qd1qnRRCpMY+l9jkggMZbCnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lRFy+xqBIB5eySclPFNhhxkulLTbBnRxOml5TQs6tZE=; b=cI1Qq7X3Pf8OnP8Cgu+OqaQARf
 PbCwqz2pJFvH10GoDYwwpocgeBeW/Ykk//eY+OO/8hOgRzfjyxDXrduB6bcZTEYtk9CmQqAerI9Qc
 0jsUNIvAlAWdoQi2yfOEhsoeHfsYLuK81YS7t+INO/X3GE7Hf1RXyk8oeb/LI4lczwoc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wv2g0-0001nN-38 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 00:55:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00BC1601E0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 00:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F391F000E9;
 Sat, 15 Aug 2026 00:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786755298;
 bh=lRFy+xqBIB5eySclPFNhhxkulLTbBnRxOml5TQs6tZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Zc6guz/B8VACRe/ebwifYmy1Oe+oyG1vCETrJPobsCRoaAFwsgQHU8SZ61d+FQNPK
 wgWnsqbHnJtPl3hVpLb1yHUGptj6iqfK6vk3CpYbsDdL4x/yNMVo0s92PpGgpWyTrt
 LKbwayOmyIxNXqKrn9DGXtgz5XO5BVArLc5Gg/uuG1EEd26YsMDQShUy74Fx3alSE+
 OJD6pIgVcXj0MW2UTV8q1GRR+w6dMVzegsxAJPlh6v5y08CiV1R/1CTm5wanOt4Pl+
 pV1cG73CD3kQt393AFv/GkQvLHkbH+oX0xUOj1qGRt0stheWqByw9Z8JuFwf0PeOk8
 uwdaywHrCrkcA==
To: jaegeuk@kernel.org
Date: Sat, 15 Aug 2026 08:54:39 +0800
Message-ID: <20260815005441.1444273-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260815005441.1444273-1-chao@kernel.org>
References: <20260815005441.1444273-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wv2g0-0001nN-38
Subject: [f2fs-dev] [PATCH 2/3] fsck.f2fs: sanity check i_extra_isize
 correctly
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In fsck_chk_inode_blk(), fsck.f2fs checks whether i_extra_isize is
larger than 4 * DEF_ADDRS_PER_INODE. However, this upper threshold is
too loose and fails to check the lower boundary or 4-byte alignment.

When an inode has a corrupted i_extra_isize (e.g. 3692), it bypasses
the sanity check. Subsequent calculation in addrs_per_page() causes an
unsigned integer underflow (CUR_ADDRS_PER_INODE - get_inline_xattr_addrs),
resulting in a huge loop bound in fsck_chk_inode_blk() and out-of-bounds
heap reads and writes.

This patch fixes the issue by:
1. Defining F2FS_MIN_EXTRA_ATTR_SIZE in include/f2fs_fs.h.
2. Checking i_extra_isize against F2FS_MIN_EXTRA_ATTR_SIZE,
   F2FS_TOTAL_EXTRA_ATTR_SIZE, and 4-byte alignment, matching the
   kernel-side sanity_check_inode() logic.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/fsck.c       | 4 +++-
 include/f2fs_fs.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 06bf721..6872b00 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1038,7 +1038,9 @@ check_next:
 			unsigned int isize =
 				le16_to_cpu(node_blk->i.i_extra_isize);
 			if (time_to_inject(FAULT_INODE) ||
-					(isize > 4 * DEF_ADDRS_PER_INODE)) {
+					(isize < F2FS_MIN_EXTRA_ATTR_SIZE) ||
+					(isize > F2FS_TOTAL_EXTRA_ATTR_SIZE) ||
+					(isize % sizeof(__le32))) {
 				ASSERT_MSG("[0x%x] wrong i_extra_isize=0x%x",
 						nid, isize);
 				if (c.fix_on) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 432c80c..4225ffe 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -979,6 +979,7 @@ static_assert(sizeof(struct node_footer) == 24, "");
 
 #define F2FS_EXTRA_ISIZE_OFFSET				\
 	offsetof(struct f2fs_inode, i_extra_isize)
+#define F2FS_MIN_EXTRA_ATTR_SIZE	(sizeof(__le32))
 #define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
 	(offsetof(struct f2fs_inode, i_extra_end) - F2FS_EXTRA_ISIZE_OFFSET)
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
