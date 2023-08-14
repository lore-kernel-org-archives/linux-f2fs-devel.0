Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83935C04A94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Aug 2023 18:29:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qVcK6-0002Vf-B4;
	Mon, 14 Aug 2023 18:29:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qVcK4-0002VY-Cv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 18:29:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DmDfc08x8VToh7Sjng6Vrs09G2EwKP0oP+4Qdk5vTl4=; b=idHtazTsqHrZgegDj9kst7AZ28
 zB7gPmabq5X9xdgqwex5lyQpS78tzei5/vLTqTFLnnBCL+bvnlWR9ekI73GiLKtXV73TzvPZT21O7
 oeFPf8ycr6TGxmvmXmvdTVeu21FAShoB61zTPT9IgXiU1R+X7DDfamrJ8Io5DST9KVwE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DmDfc08x8VToh7Sjng6Vrs09G2EwKP0oP+4Qdk5vTl4=; b=gFdJtIotfLGSBMW8yMLRT8Pi1k
 pFRESu+yYEEJAa5xYHP8HL49/oIiKuqBGeWqwX1X5U7oTv2Bz3D+NIKdd6FnIhGY8SOJ8LAHVXsLV
 4eXN2Uq6wUxKP1zVJcND/xtPg0AVXLnYwmclWiJgCNym5+gJdPJp6ObD6Lq5u7wtO5Ic=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qVcK4-005f0A-R3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 18:29:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 34D746493D;
 Mon, 14 Aug 2023 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E89C433C9;
 Mon, 14 Aug 2023 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692037776;
 bh=54AzBJPDSBowvAHeFULqDhusG5VK0CfhD6wbQR4h6H4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e6rJHIFKhproYAmLhuYPDBbc5nzyCpv9IcUSKJu0kxa/OHMVAgqKO0HWMccoUpXpN
 axXETeuc8RhcWiz1X2llfkhH/nmVJuvMJznEn7wJxaXRKwTTe40LCVD7wYxTKBlXUj
 mAmYHkmNelqqA70ITo1Ec4//Zg/FqZDagJPjTH4ME6LO615eQAk5Hlx9qTKZCF7WG/
 03fS/e0G7XM+4gfoJQXakB8Iusv0dbAmUw3wbm7z7sQdNmrpbjTxe6hs3f8E1uAl01
 vN5t0+mzk8/B2Bryfneta+q7gT+8TMJ6gKTmiKdsb1CSUpskiW2KaWQONZn/OTxPa2
 Df7klZ3FbMZfw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
Date: Mon, 14 Aug 2023 11:29:01 -0700
Message-ID: <20230814182903.37267-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814182903.37267-1-ebiggers@kernel.org>
References: <20230814182903.37267-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1qVcK4-005f0A-R3
Subject: [f2fs-dev] [PATCH 1/3] ext4: reject casefold inode flag without
 casefold feature
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
Cc: linux-fsdevel@vger.kernel.org, Gabriel Krisman Bertazi <krisman@suse.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

It is invalid for the casefold inode flag to be set without the casefold
superblock feature flag also being set.  e2fsck already considers this
case to be invalid and handles it by offering to clear the casefold flag
on the inode.  __ext4_iget() also already considered this to be invalid,
sort of, but it only got so far as logging an error message; it didn't
actually reject the inode.  Make it reject the inode so that other code
doesn't have to handle this case.  This matches what f2fs does.

Note: we could check 's_encoding != NULL' instead of
ext4_has_feature_casefold().  This would make the check robust against
the casefold feature being enabled by userspace writing to the page
cache of the mounted block device.  However, it's unsolvable in general
for filesystems to be robust against concurrent writes to the page cache
of the mounted block device.  Though this very particular scenario
involving the casefold feature is solvable, we should not pretend that
we can support this model, so let's just check the casefold feature.
tune2fs already forbids enabling casefold on a mounted filesystem.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43775a6ca505..390dedbb7e8a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4940,9 +4940,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
-	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
+	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
 		ext4_error_inode(inode, function, line, 0, err_str);
 		ret = -EFSCORRUPTED;
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
