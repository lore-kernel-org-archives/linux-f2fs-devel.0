Return-Path: <SRS0=L0OP=GM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5AC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 Jan 2021 08:00:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3984A23A9C;
	Sat,  9 Jan 2021 08:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3984A23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ky9AZ-0007Cn-UL; Sat, 09 Jan 2021 08:00:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1ky9AR-0007C4-UJ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Jan 2021 08:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y7h4t9ZDMJN+Hwj/l2yw29FavoNFy+9udtn/Nzpo4ps=; b=b47gfUo6I0eo8mx/Y+8ZA4ENK1
 s1+BG2Du99/CRi5GRdeD6LQeDineDmi8al5hOrZQlZzWcU67VhnuXXTXolCW9CZFjLPwRLqDPtxw8
 isuAlollFk9iS1BuhCikQ9GaUq0bjpcT+xBWeGYL4hXYMF6yxBTQy1Lv0m2g8cZ8aNj0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y7h4t9ZDMJN+Hwj/l2yw29FavoNFy+9udtn/Nzpo4ps=; b=Y/YcGspGVrfNZi49rTJ3JD1JGH
 IdttH35oeaKmev8rSMmt4yZ47AvaKGC4/qsX8b+7PHd13IZBcd+gMlFnMz1NE6hjPOhLH91nvV7nx
 H+tbCFYJxI7Urr1TRIfstcru+rdQyLVrh89r3L8NiYeEkVllCMo2klb6ABQvWrmYg+PU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ky9AD-00DnDl-NO
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Jan 2021 08:00:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 039A823A63;
 Sat,  9 Jan 2021 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610179185;
 bh=/5CziqsFBf55uwSNubqu4qN4xKuBe9W+HNnHEDG6YgA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kyyBQ5JaPqg7f6gAr0U6h5XPq4Yu0YdR9z02SEkW8Bhy+RlGqWR4BmIpWnzVs7de+
 wTl/w1EWyIe7Nc22bIFOXpgui7MJ9XplFddYt9QgHD84Wv0iTSenQ2f6l/F3728nyT
 MHuxxqUG7jNI5tjO1JaGj4GiRjMTdTfqO0NQj5SEojNg7Rf9uvfJoVtY1zXAXK1KuR
 UgRhWZiuaTsaNlOxMPKFXBcrGoYqCT3pWaxFQZBn14I2afW7TW/1ZF9na/pUewmINZ
 s5xO7jsfntWdMkTCOCf5siZ5Jt5VoGfglrrYC3f17ywLAORHqzTJful8Uejer2w0wy
 fdUJhCzLAPOUQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Fri,  8 Jan 2021 23:58:55 -0800
Message-Id: <20210109075903.208222-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ky9AD-00DnDl-NO
Subject: [f2fs-dev] [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when
 needed in fat_update_time()
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

As was done for generic_update_time(), only pass I_DIRTY_TIME to
__mark_inode_dirty() when the inode's timestamps were actually updated
and lazytime is enabled.  This avoids a weird edge case where
I_DIRTY_TIME could be set in i_state when lazytime isn't enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fat/misc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f1b2a1fc2a6a4..18a50a46b57f8 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -329,22 +329,23 @@ EXPORT_SYMBOL_GPL(fat_truncate_time);
 
 int fat_update_time(struct inode *inode, struct timespec64 *now, int flags)
 {
-	int iflags = I_DIRTY_TIME;
-	bool dirty = false;
+	int dirty_flags = 0;
 
 	if (inode->i_ino == MSDOS_ROOT_INO)
 		return 0;
 
-	fat_truncate_time(inode, now, flags);
-	if (flags & S_VERSION)
-		dirty = inode_maybe_inc_iversion(inode, false);
-	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
-	    !(inode->i_sb->s_flags & SB_LAZYTIME))
-		dirty = true;
+	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
+		fat_truncate_time(inode, now, flags);
+		if (inode->i_sb->s_flags & SB_LAZYTIME)
+			dirty_flags |= I_DIRTY_TIME;
+		else
+			dirty_flags |= I_DIRTY_SYNC;
+	}
+
+	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
+		dirty_flags |= I_DIRTY_SYNC;
 
-	if (dirty)
-		iflags |= I_DIRTY_SYNC;
-	__mark_inode_dirty(inode, iflags);
+	__mark_inode_dirty(inode, dirty_flags);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fat_update_time);
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
