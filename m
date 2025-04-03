Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D2AC36014
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:03:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u0Pq6-0005qK-Ir;
	Thu, 03 Apr 2025 19:02:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1u0Pq5-0005qE-E9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Apr 2025 19:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LT//OrtLz9w1KfJxtt/wcQ+0AuiMuDU3k1C8kmEKHEI=; b=Q1vqBfOnORRzVi551mhGDf2atU
 X/olRrYZ91hHx/Q6CPbm0vrRSaQWYDOcHABorWtzNWU7jg01+EtI3e7nXg0ZU+Q+47VbQUJiWUAgU
 ybakauahFACNOyEgPlT0YXmGfY4WrumUvUooGEvJFf3XHz+aOdmxrzc8crZJ6vnk2XSA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LT//OrtLz9w1KfJxtt/wcQ+0AuiMuDU3k1C8kmEKHEI=; b=F3BSVfOG7lTFAQCpD16+b3OLQE
 pUpRwTTno3fvoc3h3Gw7ZDQQn19PWI7ajd7s1AqMbKU5rePoHw7YHrxgIvLYta+FfkJMHzNwml/KK
 i8J7dP464DGO5VOxJQO3NM16zSFDwVAvBHRsPjd6f53r5j120kRpEAdlD/sZMh2fiq3c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u0Ppq-0002iv-6l for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Apr 2025 19:02:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 897A161143
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Apr 2025 19:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCCEC4CEE8;
 Thu,  3 Apr 2025 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743706956;
 bh=ktphqHlHc+qHY+dP4whpQVX97Exe5E0m0Nbmj+5KDJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=poQ7a+9+w/PR8EVTQF8w96pd9U5V0gC0Looga2RWiY4L0Ikptvx255gsSKtqG6Oxy
 T0PxG9WVaKZ6lFEgDlvWiVfi4SgdPJoel9eBQihET2JlBpmmkk5C53teG/ZcmlKLrJ
 ElEHtFpQGbv8r1SHtiU/F4HxS7ZZzuWVusmxXQlXVtd3IDPt6eZ1a8T+AcekY4q9qA
 sGR6azeLKINw8KL+6s8k6f00tI8Pp5/Vp1oX9XCo8NH4gLD/7IgKGGmzEaXKuCb080
 NTGljzCX8BwgGuIN6yQ02gEJtLxgMgHMP/VAaZn0EXDmGTJjxYBOfkvDbBk0hq1yGs
 9Jcql9d5PuNlQ==
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  3 Apr 2025 15:01:26 -0400
Message-Id: <20250403190209.2675485-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
X-Headers-End: 1u0Ppq-0002iv-6l
Subject: [f2fs-dev] [PATCH AUTOSEL 6.14 11/54] f2fs: don't retry IO for
 corrupted data scenario
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

[ Upstream commit 1534747d3170646ddeb9ea5f7caaac90359707cf ]

F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]

If node block is loaded successfully, but its content is inconsistent, it
doesn't need to retry IO.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3dd25f64d6f1e..f238be29a70b0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -765,8 +765,12 @@ void f2fs_update_inode_page(struct inode *inode)
 		if (err == -ENOENT)
 			return;
 
+		if (err == -EFSCORRUPTED)
+			goto stop_checkpoint;
+
 		if (err == -ENOMEM || ++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
+stop_checkpoint:
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
