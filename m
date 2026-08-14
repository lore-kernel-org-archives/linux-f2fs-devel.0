Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0098FC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVJpIpsg/IMv2mdGYIM38ni3ujCJNGhUPpqFWnNVHAI=; b=X0ERmHkNCFhelW4PfhfKapS32g
	c/TYi9PPMI+X11mYqIM7+hTC85FQTlEDk1toA7y8cpwXPf/SA5ZcIOQlVO42frqAljAU8XwPMnj75
	NXEAaHjr27pZRlWauDRSka1jllGmKfTFCOkxhJzNz2kU4UunX5WtHXNAWpsAYGIxzHJg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoCG-0006Pk-RI;
	Fri, 14 Aug 2026 09:27:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoCB-0006OS-HF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FcfrVvu5lchr1e1sUVC5XjbFLS3hhJKHv222lwYU8aE=; b=bjEbuVq7zxKYJ0iA8e6PvqxDp0
 4sZbPs/hiA6y4COfDPRLG+plt2jFeAIbnB6M+IkTNx0pxsqaN6JhkeccMhI6cr2Nwij5gBItNbS/c
 b3KyYwjKLQCjiYkNrEoKPbelVrP5p5HXnhDhhGcL0fIQorySUNxhE23s1YWO0bi0L/1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FcfrVvu5lchr1e1sUVC5XjbFLS3hhJKHv222lwYU8aE=; b=Usr33gS8Tn7cHNLRHKDeOi6J3T
 LveQBlLJtOf4vW/4k4Xo8sOQC9AT/8fs5+yo4SPnPxRKJKcOGp+fIVtQgYzRJBm6s3kaPejo38eE0
 Ia1j50Mgdh91Xde5TW9qoMW+1SIMijF8GMiNabrRTgFCIJJU0gS7izGAMoffqyManw+Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoCC-0000r1-FG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:27:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85E0F4106A;
 Fri, 14 Aug 2026 09:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0991F00A3A;
 Fri, 14 Aug 2026 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699635;
 bh=FcfrVvu5lchr1e1sUVC5XjbFLS3hhJKHv222lwYU8aE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fhO+kJSic4st/GaZfDT/Wi9+tPgzsrJZ2HW+GBlSBmv1Ycgc6PHiBW51kFO1T5GLQ
 n25hvGdwvsfNd8xI2lGbM+7RWeS51bpC3nVWEeY9MWIXFFxD+JAO4puyDn3g8eC0b3
 D98ddNpvhIK1kfU4q0KzE/3dIGWU1hrIe6kUnlxLoUVJuTrQ1WTvL0vyJrR8yQ6hT6
 v3DMM9sDuIktccZ8Kvz7s+FgMNTXXVtoOCaO0l/+1NnKHqKTDE01dGzYoBlKUFBN3T
 ZJyTLXnlXFCbR3vaHHa90OVIFvzkN1HuIOit+CSlr6u3JX3ko35vJ+0dNYiN1+R0fj
 FUXwy8LX+IeQw==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:37 +0200
Message-ID: <20260814092448.1818082-21-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoCC-0000r1-FG
Subject: [f2fs-dev] [PATCH v15 20/25] xfs: initialize fs-verity on file open
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1bedf2ef647c..a9775415f3fd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1721,11 +1721,18 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
