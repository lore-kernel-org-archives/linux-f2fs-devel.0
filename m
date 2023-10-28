Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FC7C4167D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Oct 2023 23:48:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qwt2d-00044w-4P;
	Sat, 28 Oct 2023 23:48:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qwt2b-00044p-Ey
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 28 Oct 2023 23:48:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZcPY5/BzsnqcyHJSvOrRBKwLZNiaMvuEtewfcOwHIA=; b=e+m4J2LOtLWfsdVcoyGygAVPX7
 RMJpjEoQ9TNZV+RyO+T2IKstBC4GxyNzlZT0vOK64kETXo36XbYpziZJurgvxUFWIrtUD6Kb5K0hI
 JhhifSHr/nYRbcNAX2wklVc+T9ISH7KWniU5a04dEgGAn85l7OlkDGnAsVYHm6g1hWxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IZcPY5/BzsnqcyHJSvOrRBKwLZNiaMvuEtewfcOwHIA=; b=m68aHbS+64a6aSIfHRGpgAPwtc
 3rI1SiTRclB9cFLYzG85uFyT6ZeAZ5Qo3XpMBQwcm6dTjYDbVDiE0WdVIL/iPZtSDXoBMkYjtGEP8
 P1oJum95cjVABe7fCkqTAB6E+hEYg/iwlzI6kWCUknzkva3krpLGK9veDQUmQSdGXyO4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qwt2a-0008Fd-Po for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 28 Oct 2023 23:48:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B4BC960ABA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 28 Oct 2023 23:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2605C433CB;
 Sat, 28 Oct 2023 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698536897;
 bh=r+94NpyAwgKlFb2DfaqEeta8MWEtiPaiZ3Z/pi+3rXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A9Ui/gVC4LMKpvM5GjXtgL1Hkgsfk8WKYO1YPDybtbmkIBN4iG5ft14QWR2PFlpHW
 JY59TNq/u+XR8SSImfURLMkGTM6iEvuZZ7TuaRHEbYEUG0vZcEVTXLKuCwGpOb9jN/
 VknOgUboQS0xQ5yi5pwiL3qKpeuJE1vgHh5lC9aKyNNF547lN8TK0SFvOc4HyoA8sL
 nReLbRQXcNgLkC8Lg9f2Q8PdHak6qwiZKdeHHLfR2wH+OIFcbgRKEgUd4kPDDZeLfe
 jIPbkJ73Ds2eZ8+GNLe+HlQrcGKgHV5oDYQukNVBiJh4FQL8UeqbbwVn2waacSxFBy
 3QC0FogbWoVUA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 28 Oct 2023 16:48:13 -0700
Message-ID: <20231028234813.496851-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231028234813.496851-1-jaegeuk@kernel.org>
References: <20231028234813.496851-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1qwt2a-0008Fd-Po
Subject: [f2fs-dev] [PATCH 2/2] fsck.f2fs: wrong report on xattr boundary
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This avoids false alarm on xfstests/generic/425.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsck/xattr.c b/fsck/xattr.c
index e291ef4740ba..3163639b9d41 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -44,6 +44,9 @@ void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
 		get_node_info(sbi, xnid, &ni);
 		ret = dev_read_block(txattr_addr + inline_size, ni.blk_addr);
 		ASSERT(ret >= 0);
+		memset(txattr_addr + inline_size + F2FS_BLKSIZE -
+				sizeof(struct node_footer), 0,
+				sizeof(struct node_footer));
 	}
 
 	header = XATTR_HDR(txattr_addr);
-- 
2.42.0.820.g83a721a137-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
