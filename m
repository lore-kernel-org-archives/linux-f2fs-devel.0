Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3AECA5FFF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=POmTy/LkPCrdIS9Pr5gyQcFvjMWPjv4TLrEZ4+eX7Gs=; b=B76sTa6hW3gcKisqlJXYAtV5xh
	UgO7LvSKA9mf82NOL/KShTCm6IwFrFMLekAw1z9xzc/5Ay39LlOXdGnk+8L0y9Mex/B8LXA/VtalL
	uTVHWxXIvMSS9CkS0HkNrlnaRsKXi+rjV9+S3v1zklFYw3JX/+z3ZwqGY1Lo+ro1RseI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yw-0006sW-CK;
	Tue, 06 Oct 2026 08:57:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yu-0006sC-S6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GUebb0cGvHp4BdkfYsUDUeqJGoIKudolDlGlrishWBE=; b=IMld/AWiOAYFNT946uGZhE4DBF
 G0aSsboWosgCrj6CBuMV1L6fPHqkv2a9wvXT7X5BwFkfEXGax1L0k5RSJptA6gmLVR0vOhbeywywH
 RB9HlDGLkjx+nLj/63rdLLg30FLN0BYsMqiHtob1lokLquNQnc4S6e0S0GjPyl6hKMyY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GUebb0cGvHp4BdkfYsUDUeqJGoIKudolDlGlrishWBE=; b=ccneywn423zJ02E1/1zM9yHCeB
 H6xZb1yaScrplTbyZP1uh7ywrPr0MhWNfm9qc/1zMB4XqzDFUnfRRVKyfcBX/g6uYV3YLVQNmdGgO
 ZNH01lj++4k9ROS9NRgNivEt5xPNkm+TPwOUYH1Vy/1p+DdyqQq/ZKdDFSqWCBuK0Sdc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0ys-00026V-1e for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:57:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBBDB43921
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174471F00893;
 Tue,  6 Oct 2026 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277016;
 bh=GUebb0cGvHp4BdkfYsUDUeqJGoIKudolDlGlrishWBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ftRZk7nW1BpZgcaBlEa3E9brge7CnBItaVC9XUi9foeP1xoJ4BlItlOa6rD+wwwBz
 IfHAq5rdM5Ll70vEeQfd+/fpskwp9IshiWIdSTY7zOfvdoeBfGtdXqlRH4LZPfhTBk
 Oz6lZ3UvR/eziKyrTypFjaSoR6KSX3zQlMBr+d3Vf5HPJX28GNP+kfqitpMOcLtDk1
 3h67mLLhmJ59UAuZLOXKIPjogiAn9p0B97V+gcTnLG9YNNt+U+KD3ybukjzbqC40Ls
 y/P7C1gfuec3GZXhpuMklFnOf67KVuxdncgWroWoy4UPRzYk4YLxPjqdexppu9E9eA
 SuClHAo/EqH+w==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:47 +0800
Message-ID: <caf98f05a61c028dc1af75c11785cece28d400da.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0ys-00026V-1e
Subject: [f2fs-dev] [PATCH 21/21] fstests: _create_loop_device_like_bdev()
 remove unused variable
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Remove unused local dev.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/rc b/common/rc
index 58e4c234b0f4..5bc4c52bb8d0 100644
--- a/common/rc
+++ b/common/rc
@@ -4815,7 +4815,6 @@ _create_loop_device_like_bdev()
 {
 	local file=$1
 	local bdev=$2
-	local dev
 	local blksize
 
 	test -b "$bdev" || \
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
