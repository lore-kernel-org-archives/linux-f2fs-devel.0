Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4BEC6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 07:52:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrvQA-0005eD-SS;
	Wed, 03 Apr 2024 07:52:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sweettea-kernel@dorminy.me>) id 1rrvQ9-0005dj-O9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g5/nbByVqCKvlFFsoo9KP8QOs7QNQNFrVFGTeGkgKhQ=; b=FxpyaXsaFFKGMIUmX/05alV+7m
 vYSE6BuKDxpa7BC+7jnHZSDhEPP9uKW0UGIbDebLLUj7GdyJdU1vZeSFCf9qYA/yNOB9ZaqpntZ6u
 GnlJbhJvIX48x/baaaKSiSurN5uwyCrg12Jl+LEEnNKjr2ffjxyHec/pwhxBDkcfSe9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g5/nbByVqCKvlFFsoo9KP8QOs7QNQNFrVFGTeGkgKhQ=; b=Qhkr1bFWAz6Tqh+USOMyVW42EP
 emBG4sIi9qMJxrdySZrK6AyDSyHVYgpMXHSzqHPIKWrVv6bq/EglN0ZTv2fgxy30aO79aHwi6Jbl5
 nAt4m8rTu2+JFkE1HIgV0WQP0g8kOm+Rsy7uCzNwyAygxjiiENkcp2lB7YYBY9h73urw=;
Received: from box.fidei.email ([71.19.144.250])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rrvQ4-0001le-Eu for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:29 +0000
Received: from authenticated-user (box.fidei.email [71.19.144.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by box.fidei.email (Postfix) with ESMTPSA id 2C7F680892;
 Wed,  3 Apr 2024 03:33:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
 t=1712129607; bh=F4ceUdWui/mdlAkWe1dY+ZhhuS2I1dZLc64k4/7Uo2Y=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=hcaS2gkRusKnpHkC/vbijCe7K6kF9RnpgEZv+Yk/8S8mIdGMFNwTXjeMXk6Lzd5UC
 Hi6eke4x6kTY5FTxTcqF9nhsH8Hr3kFTQUa72oYAdA2naZe/2JZk8LMUs8EZmhcKSY
 k/lGHBMstPOaB75DA6K8YXP0rh0o1c3RFZhWnNym3ibZiv3ynGaWsJBeOu7qdzY3TA
 kYfAZI95Huok41dLHVC+Ns1ZqhWUMwMY3vTUK+9A3S3+JnYeD8Y4AY5Ve0v1vt+t1v
 /GbaAWudyNoOzpYQuXbt5o9acwJnV+NKZdaow2b6f9Pu+wdl7RXj4U/v8OpFOXiJXJ
 MGXyDIMLsHiBQ==
To: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Wed,  3 Apr 2024 03:22:51 -0400
Message-ID: <0b492e10a9034c8fb08ca654c06471575e8bb96d.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
X-Headers-End: 1rrvQ4-0001le-Eu
Subject: [f2fs-dev] [PATCH v3 10/13] ocfs2: fiemap: return correct extent
 physical length
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
From: Sweet Tea Dorminy via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/ocfs2/extent_map.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index eabdf97cd685..229ea45df37b 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -705,7 +705,9 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 	unsigned int id_count;
 	struct ocfs2_dinode *di;
 	u64 phys;
-	u32 flags = FIEMAP_EXTENT_DATA_INLINE|FIEMAP_EXTENT_LAST;
+	u32 flags = (FIEMAP_EXTENT_DATA_INLINE|
+		     FIEMAP_EXTENT_HAS_PHYS_LEN|
+		     FIEMAP_EXTENT_LAST);
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
@@ -782,7 +784,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			continue;
 		}
 
-		fe_flags = 0;
+		fe_flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
 		if (rec.e_flags & OCFS2_EXT_UNWRITTEN)
 			fe_flags |= FIEMAP_EXTENT_UNWRITTEN;
 		if (rec.e_flags & OCFS2_EXT_REFCOUNTED)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
