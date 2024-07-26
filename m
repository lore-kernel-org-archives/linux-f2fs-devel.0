Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A0C3DA64
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2024 01:22:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sX9f8-0003Pf-9w;
	Fri, 26 Jul 2024 01:22:26 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sX9f7-0003PV-JX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 01:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRQJfLylKN2VmZSdbXRmPxRcoJ9JvkXshtfkNw8Wuls=; b=lQAnESa+FOGBVSF5WsgAga9WBm
 UAdYWG7SJu+izH+WK4qsQdFIIZKOZWH7l8cLm/Gh9uecb06Xvl5coQLe79I1ks2UgfkxynGBStWV1
 BPoCKaH8orRsNC7id7CM2RrZ8i+gZimvV7hqdLUxh2v6TeRDnHfacsyTksm7GCDOn2Pw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wRQJfLylKN2VmZSdbXRmPxRcoJ9JvkXshtfkNw8Wuls=; b=k
 PJ59WmDERH2cNXEyELtVmRBngpdmnr66viAthFewOrc97sA6Im9L9dQKTZZDBW1A6sdHz5DsQyWkk
 kKkQ1MaFXmonB8L9ricFv0Uq5ZUTcBdoM2/I3yleyMGgLGEVfL/ebpJMZ0moJqH7xU1cpwniSDca5
 wZHmvIvNZpi9Uj3I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sX9f6-0003IC-Vv for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 01:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9D8AF61655
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 26 Jul 2024 01:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE5C116B1;
 Fri, 26 Jul 2024 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721956934;
 bh=T4nX2JvG0FoiXpP8NRekGHbQn5NBbSpbRupQpyxiKDs=;
 h=From:To:Cc:Subject:Date:From;
 b=EwlujWMguyiHVCmfst4ahoKh4JFUOOA3OPNhQH5bY2y1Z0uaWwxdekIO95tBsmbzA
 N3XQy9ptg7SrmoulTej1Oie/aYItA7FaeChfuZrcDhF4q3O0nFFtdWg+QYOpIdndqd
 fIV/6o0oFFcLaXO/ZbMoleBsjX0BZxoad3v5ZOYOOeg1MLAmhLhHYkZ8tK0MjFRfHe
 CKcPCdtwIWrEl0cJ2XShYJQv0sadvxr5jj1QoOqsniUQIJ5szNirxZ2IOJT/kBo9bo
 pGokn3HAnnFOXtO7cVH7bZxc3B5R8+Qkx6iSz5RSJysnYeyVZerbBbSBaWzmtLpO+5
 T+RZov3e5utTQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 26 Jul 2024 09:22:04 +0800
Message-Id: <20240726012204.1306174-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sX9f6-0003IC-Vv
Subject: [f2fs-dev] [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache
 before on-disk metadata truncation
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We should always truncate pagecache while truncating on-disk data.

Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to use cow_inode instead of inode
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6c62f76474d1..54886ddcb8ab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		truncate_setsize(fi->cow_inode, 0);
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
