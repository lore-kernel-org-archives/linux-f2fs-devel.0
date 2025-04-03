Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BBFC36014
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:06:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u0Ptl-0008KV-PN;
	Thu, 03 Apr 2025 19:06:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1u0Ptk-0008KO-JO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Apr 2025 19:06:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qb0E12Aj23t4mR3CfqG+OyJZoQ9PFx38u9GXRQz+GXs=; b=Pp7ACZUixcOFEo8nDQbErNLEcC
 KZARto0+uG84IKfg+/8o08VfztdNrvKP+hcvaGEAZcbjsM4f5/jv6DLvMB/tru2axG+4+lnHRMpO4
 rA36AJwhgQep4RwxosTmA0rKg4LZwcZwYZ0uSmN9U5V+V2+fOjZTIa1EifSBMy19vIPs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qb0E12Aj23t4mR3CfqG+OyJZoQ9PFx38u9GXRQz+GXs=; b=LDqW02FiJaF5D7FNABoFlh2QH1
 3Fu1MRO9esHCNWroomZju3vyuir6oPrUkQYK5a/2jHamgjqXMx6lhTnx8wp3ZvRjSzLMP2E2P1dtb
 R0sViqaRsqMvu0KQcpP2RM+6kpWmNus/zl5CoEubD1TTRFjzv9T0c/ubqjQMkWHy6DA8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u0PtU-0002wz-Rt for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Apr 2025 19:06:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B4BA5C6C8D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Apr 2025 19:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74882C4CEE8;
 Thu,  3 Apr 2025 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743707178;
 bh=0+wjraBOKQcfYMWpbGZu3h4vudmozFUF00WLgRV4iaw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I9p3KYJKg7bhpsjf5eWsxEut0Lplh3cYQgyFfNqr9GbSbBvJ7KoqA5iVlb+V2LjDR
 5HH0JsRXhASLXw5SGKb9iJDiF2JSQKNsGdGnqKDxQmIedcRKxO37PeL98uOcYfJW9W
 LEkl+Mbwq3tL/vSpoFDGB6ip5dmxLn0pUZd/8vGmT4UbkOajPHAt2k5c6pQbTtUdV2
 dosKZEjUYN67vsOcVP/u9AZvnGyxL1Pf8EpYPBFo6Vd4KrgDzRmsQKokw72FvHCV4i
 Inl0xQ73z5+zzm/4xSsmhh4rHZzRirtC29qvUn5deU34u9/DOCSOi2ffc5DT44NFNh
 R34sltuKpJRIQ==
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  3 Apr 2025 15:05:17 -0400
Message-Id: <20250403190555.2677001-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
X-Headers-End: 1u0PtU-0002wz-Rt
Subject: [f2fs-dev] [PATCH AUTOSEL 6.12 09/47] f2fs: don't retry IO for
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
index 10780e37fc7b6..6135eee771cc9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -751,8 +751,12 @@ void f2fs_update_inode_page(struct inode *inode)
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
