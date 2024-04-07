Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850C1CD1292
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Apr 2024 07:26:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rtMv4-0000Nl-GH;
	Sun, 07 Apr 2024 07:26:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rtMv0-0000Nd-3u
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 07:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0LloRDYuts610/4V/5af8gJDJQZ8U/QgGjdw5MUHcqc=; b=WOMKkCdxe+mdf3kpDOHad3PGmI
 hKpePBSa0l2/N0rl7H1pM+j+JCpzv3lnODQD+U7p2FW4JhWESBgO24BT0FG3Hefl06Aw4xNirNilh
 C/cM7nwt4OQvIPK1swGhiLFHchWjhAm5ie1hy9uuGT89v8p5ih7RnA9cnScVnl//PNog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0LloRDYuts610/4V/5af8gJDJQZ8U/QgGjdw5MUHcqc=; b=R
 BINiyoJPri+gftD2ag5caflZ6DZ7p5J8Yh+i+3BJ2meAWJXB94JJSNGXwt43Sfd6a4BYpAwtwdZQO
 p49ztTf0vgnp+TMfkSk4G4b3aCVBvOhDZ8pzahKOu8UtATPEix6Ev0U/iLXhi7ek8TGkpyy3ZPKPr
 7yQWRIs/YpPRM7E4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rtMuy-0001Hb-9r for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 07:26:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3BF3560C19;
 Sun,  7 Apr 2024 07:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D0C433C7;
 Sun,  7 Apr 2024 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712474774;
 bh=4yvmXrQIABNgfTHlOdNy+K4jA8VXyviaTqDUNFlSm1g=;
 h=From:To:Cc:Subject:Date:From;
 b=eh5p1nnEUfUb58qHgCn+7+2N1aCyUBi8S8auz0nYi2fHS9xQnZ18VaOwgVlbs6KMh
 i+iNBSouoZzr3cvFNNiBE9RYE9rJx0q/bmK+FvZwNQeFK3gms9Xup1c9Kqi5WcMFyb
 XGa5XHsJS5PwepFX1hQ3OvowWsmYMLkSzKHf0m189bPFlR01tA6U9fabt9XLQPXdXC
 FfGmdfdXQMK5P7UFtvq3HintezEH/ZrTq1G1pH0ndd5GRRDi2ivKVtivT9BG3h3HXq
 WKFCIcjksTN1JeL5N2UGCyn+7bgEYRh+bressp72vpzqjISC/68IgBKUMnbcqpNnW4
 GBbE2gAVaJ5CA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun,  7 Apr 2024 15:26:03 +0800
Message-Id: <20240407072604.3488169-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rtMuy-0001Hb-9r
Subject: [f2fs-dev] [PATCH 1/2] f2fs: compress: fix to relocate check
 condition in f2fs_{release, reserve}_compress_blocks()
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compress flag should be checked after inode lock held to avoid
racing w/ f2fs_setflags_common(), fix it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2cd4ca8433e1..ca401cf8152a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3549,9 +3549,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3570,7 +3567,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3731,9 +3729,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3745,7 +3740,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
