Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386C0CC6B30
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 02:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nuWCGuh7Um1jsH1srSRsTe9a91TvdYB2SVW6nl5xcSc=; b=aiuUiPbOvWksuwEgAC/WSx3QD+
	SfjMWSxmj2aDmzsEFSs2q4emU+b+gOOmZWS6LgJ7pqC0kdZDtuv6bIULzx4bYDA/HRe0lqMFHueMu
	pQFFxyK+ZO5HzkR+fRckaGrM2b98DQFPPZaIzK6gyRa4dgP0gmbRgJxDh4vDyo1vaWQ4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHBf7-0000j3-UK;
	Thu, 15 Oct 2026 02:57:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xHBf6-0000iv-5z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 02:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IsDm/3n5TTGtnRMOmw6WlAZLpwcXANG4w05bJxvvhdo=; b=MZCH/wfCtyYlVh7hmbYlQIEiDc
 j3ZC8GE3n92Jbk0XyakRTgMa6nVDEYOjpYedGEmEuKPzsjFWm306rGgHvEsqgDLe3AhWQPbzaA8pt
 mP3s0RhqBkghBlY8d1YqIxJtUxi1Ih67PR5o6LsSe2lqnbLT4lP1bxVJERIc0THfhi9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IsDm/3n5TTGtnRMOmw6WlAZLpwcXANG4w05bJxvvhdo=; b=e
 aK8Vr8UzF1aS+TuBRfCi+VUEErJ5l9wL13jC0BgbElQS9J8ViJBa61pIDOHMMaB2R11KCkNadLmy4
 6x4NmUPTM23gE3zeEpykTMkWUoR8J/NCcsBENA02NoWEIuFl76AkpIfJdLCVy8mfizq8xWUPJzHOD
 RTCrHctipdpipKa4=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHBf5-0003OF-MG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 02:57:44 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso7603395ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792033058; x=1792637858; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IsDm/3n5TTGtnRMOmw6WlAZLpwcXANG4w05bJxvvhdo=;
 b=RDJMZmQDLCTMH0W2SjZHNOrOAUWgVeR0c6N4PHbzytwpB+pKBA6HqgXLkX/lrhbNtj
 7T3Lcb11oddyZ8uinleey1pMl8qJAo4uu6YPGvBKxAtZpHPAk0flltRWF9RCbRLM4O1W
 riN+lGDIxMCtZmmdAtgw1HJLv9LZxsP/f72xeOP0y/TGXG4cmEHkZ8S7LNIJqFWAs8fX
 gykC476QjCC9ZE424xguYBWD4wIUxPXVTBJ2fH12OAC7GponIxE+Ul01BAnXZFqNFzsG
 PEU3Ejj2g67YdLY8A9nXH0ARoy69bJWBdeWFvj/OzGTP+B58pKEXW0OpWt22LpSXhvHj
 RZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792033058; x=1792637858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IsDm/3n5TTGtnRMOmw6WlAZLpwcXANG4w05bJxvvhdo=;
 b=hKBYoe/f8jAZ9MZ+2hZdC297RhTPuh+JPZ35h9ZxqBVhP7cRzxvtcNVEbLGiuNvJYd
 k0eiYEOEJnhj3NS1qaGey3t1G6+A3srL58yslwx5RJjHOenQT74RSWd61jfG1PvyEtSs
 sTbomTEVXKzm32/DJoWQavwWCeauOhIwgfQaziL3zDWd31Lq4+W01Ll3yJBse56Z5rOx
 QrnGZgXc5hsuyGiyi3I1jjpEhrMDslvnjKA7McRgtB4jxMO2YtOpLAjsDHFLCiFI2QDs
 btTMfcE7+3+/5JRI5pgFkyvtZ176a7pypaTCcLv2V2e6sDTo99mhFDNY/UiSGXcwvySa
 Sg+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKKaG5mG925yEB1OlbzFsbH/a1DR4YCQEp+dLwDZI3Bzt0vW2vJcGEnoaEaun8qNgtQ5NQX8ZtClmDFRqnf2LV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLR2xCnY4TISjuudFoPA5soAKFqL1TVgOHda0QlUDGWx+NXebGb
 oUUEeBUZVuzdRgiH5yDKGOX9mtSZUfdpppWIZJ2YQC6EJ032KOxTOP+PL5ZUFxVf
X-Gm-Gg: AYBFou2aCG+En+OsDCh+NPRTWowkm46M5nxZ22bcZD2T1HNOk0GyLWvCx5C1KxQXYLv
 l4LfOrQGZe2n4rspZCraFcgbyucCaGf23GPv38La1BQhMGQHaaibehzMQ1kWJte6rEO5dIvvUrZ
 NOcL6tMglK2Pk4ILzUBtjaKGkyBKObD5YnB72wT/6BLBrExHk7gWuw64MhV2fQeIFs72znIwsuo
 js6K7U/+JTobV/bO6o65TcPTG9hoDw5eVapTWMWHzngoSP+Fzf6XPOzBBJ4ZtDRPupEXyx5989G
 o8ZVF1lhtrLdtL35W9wtxsTMFih8D2xwC5lafgsVVQgVyvWk/wggKdt6at56gIq7FGnio3HDPSQ
 LRkC246pX0YN0QDfK/oSzJc7Aill1eOZrpoaJNgJZcDdsznQ9VWWaMtPB5zqZGBdZmK8ouc2nUO
 Jj4rhVIXeDGNKq+mIat8at8cjYaukMsp1YeM3OtVPubGlJMrVKxOItqvFJ787KEMQGu0DzsTnXU
 vWIeaxdfxN9NlUQuVKpvAiCfoUxY+QEJebziV9POdg1YOMISvUypjwsV5NywvnjEu4ifKy0uoE5
 WDP6hEH2Y+F9D7E=
X-Received: by 2002:a17:903:32c2:b0:2e6:23e5:4938 with SMTP id
 d9443c01a7336-2e842bc54bemr163564685ad.22.1792033057837; 
 Wed, 14 Oct 2026 19:57:37 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e4eb2sm76539465ad.74.2026.10.14.19.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 19:57:37 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 15 Oct 2026 02:57:31 +0000
Message-ID: <20261015025732.1564032-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xHBf5-0003OF-MG
Subject: [f2fs-dev] [PATCH v2] f2fs: release a removed xattr node in
 roll-forward recovery
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

When xattrs shrink enough to fit in the inline xattr area,
write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
the file is then fsynced without a checkpoint, only the inode block is
written, with i_xattr_nid of 0.

Roll-forward recovery starts from the checkpointed inode, whose
i_xattr_nid still points to the old xattr node.
f2fs_recover_inline_xattr() copies only the inline xattr area, and
f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
the stale xattr node:

 - The node block is never released, and fsck reports "nonzero bytes in
   xattr space after end of list".
 - If the inline xattr list ends exactly at the end of the inline area,
   its terminator is read from the stale node, and the removed xattrs
   come back after recovery.

When the fsynced inode has no xattr node but the checkpointed one has,
release the old xattr node as truncate_node() does: check its block
address, invalidate the block and drop its node cache, which may still
be dirty.

Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
Changes in v2:
 - Drop the cached xattr node, which may still be dirty, as
   truncate_node() does (Chao Yu).
 - Check the block address of the old xattr node before releasing it.
---
 fs/f2fs/node.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 55008f18afd..13f977ca6d4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2831,6 +2831,43 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
+	/*
+	 * The xattr node of the checkpoint was removed before fsync, e.g. the
+	 * xattrs became small enough to fit inline. Release it as well, or
+	 * the inode keeps pointing to the stale xattrs.
+	 */
+	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		struct node_info ni;
+		int err;
+
+		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
+								&ni, false);
+		if (err) {
+			f2fs_put_cache(ientry, true);
+			return err;
+		}
+
+		if (ni.blk_addr != NEW_ADDR &&
+		    !f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					   DATA_GENERIC_ENHANCE)) {
+			f2fs_err_ratelimited(sbi,
+				"nat entry is corrupted, run fsck to fix it, ino:%u, nid:%u, blkaddr:%u",
+				ni.ino, ni.nid, ni.blk_addr);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+			f2fs_put_cache(ientry, true);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		f2fs_truncate_node_caches(sbi, ni.nid, 1);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ientry);
 	f2fs_put_cache(ientry, true);
 	return 0;
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
