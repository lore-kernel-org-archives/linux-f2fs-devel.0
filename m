Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC84C44536
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/SceiDsWP1bskNXIsMjSj3YXZriVBHNZEk5sbkcyCc=; b=l2D1pwMOAQKBrtIo7cxj3efoqO
	mi5mvBhcsdQv0Az+CAWiPOoGfSzCx5Apn7LjMa0ddV6JDE/JzzjcHimNEuYffhTGKit8bnJOKoIZc
	xe2tXcrjuc84q1B3h4tEqUqmMSgc7pcaIX793pD9XD03bWmIEvjh9IJm8xTvKpNoIbbE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFS6-0002LQ-Fa;
	Tue, 21 Jul 2026 18:44:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFS4-0002L8-SC
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XpEl9TVCjCt4k8Ve7nvAqsy/U7zJqeQ1T+WDEOslgBc=; b=N9mNndhLRK9WgzCatU1qkr77Ui
 Ka62FspQ1oCDJAMbav/p6zQ2BZX9vJwvj3kzq2ajNtwPeC232ReBWFgWAXTeAY6UNmG+dlENwzsG2
 1AP+Gc6wW9fM3nIy1P2Ief0xF7NpBZoU3erPESkmo56gD2tMjA+sFLi0Hb4FbWcWdrPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XpEl9TVCjCt4k8Ve7nvAqsy/U7zJqeQ1T+WDEOslgBc=; b=QsjPPx0rdg6IzA+x0icsAcVTiQ
 RrTLsdkqP+tH9P/CDRITdGP4iBsKjA1WJ9gg/5G76W8hJTsTibWyRC6RvWhHyzNFyDyTuIVIzjIpZ
 nfAoBiW4aebwx0KvJr1oOazsDzACwxzdqeMgL2mUzQWf0cJ0fpwDuHNavq+mwud1DECk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFS4-00030h-5i for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA07140507;
 Tue, 21 Jul 2026 18:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2CB1F00A3A;
 Tue, 21 Jul 2026 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659458;
 bh=XpEl9TVCjCt4k8Ve7nvAqsy/U7zJqeQ1T+WDEOslgBc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hgOVDzGGfFdhiVGu4VvoW4/bsW4BqyrSEWYWCeX9RWJiqbyVeVWfiYfwhD9CUDRVA
 ID4HfE9XQGpem32/LSATgWY0fvcD9S/1VlizqDX/jZ52VYlQ06uWn8Osve+dB7Y0Ik
 cfe27uEnjp0Pv4rwMwdVckGyM+DIdSM32a84c0mvth5US1TyQehpHVpZVtnZUMMufU
 SfI1svk6P6qy45/iBNSlZ9gK2Oeq+lvmIkcAOoP1BLFiUptLQCV8MW+O/62TKzgMl7
 8NdmeJXnfGjUfW9VuzF83ne8r2YdS53ryRQBS0hYCKjeg1fAYOSLMGlKBzD+6Ukw8x
 weUOeb7QATFFg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:45 +0200
Message-ID: <20260721184346.416657-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFS4-00030h-5i
Subject: [f2fs-dev] [PATCH v13 08/23] fsverity: hoist statx reporting of
 fs-verity flag
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

All filesystems supporting fsverity report this status by checking inode
flag. Also, BTRFS was missing stat->attributes_mask, which is fixed now.

Fixes: 146054090b08 ("btrfs: initial fsverity support")
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/btrfs/inode.c | 3 ---
 fs/ext4/inode.c  | 5 +----
 fs/f2fs/file.c   | 5 +----
 fs/stat.c        | 6 +++++-
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 272598f6ae77..de729c44d6d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8040,7 +8040,6 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(path->dentry);
 	u32 blocksize = btrfs_sb(inode->i_sb)->sectorsize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
-	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = BTRFS_I(inode)->i_otime_sec;
@@ -8053,8 +8052,6 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (bi_flags & BTRFS_INODE_NODUMP)
 		stat->attributes |= STATX_ATTR_NODUMP;
-	if (bi_ro_flags & BTRFS_INODE_RO_VERITY)
-		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce99807c5f5b..99fa7a28951f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6250,15 +6250,12 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (flags & EXT4_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
-	if (flags & EXT4_VERITY_FL)
-		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
-				  STATX_ATTR_NODUMP |
-				  STATX_ATTR_VERITY);
+				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..9b531a016ed4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1024,15 +1024,12 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (flags & F2FS_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
-	if (IS_VERITY(inode))
-		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_APPEND |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
-				  STATX_ATTR_NODUMP |
-				  STATX_ATTR_VERITY);
+				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 
diff --git a/fs/stat.c b/fs/stat.c
index 89909746bed1..ae1299bd7436 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -203,8 +203,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
 
+	if (IS_VERITY(inode))
+		stat->attributes |= STATX_ATTR_VERITY;
+
 	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
-				  STATX_ATTR_DAX);
+				  STATX_ATTR_DAX |
+				  STATX_ATTR_VERITY);
 
 	idmap = mnt_idmap(path->mnt);
 	if (inode->i_op->getattr) {
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
