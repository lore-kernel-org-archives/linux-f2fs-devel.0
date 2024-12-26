Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E41E77188
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Dec 2024 13:36:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tQo2n-0005bu-QN;
	Thu, 26 Dec 2024 13:36:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tQo2m-0005bi-Gs
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Dec 2024 13:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kt3Qk+boIYy8WUUU47uFg1V6Ji7N+e3gAqANKMjZyag=; b=KU+m3bv8Oa7s9d3zMbvTt3l9Qy
 O0z/4PWt8ps7iFScghoGU2bgRoILTsvrQ5I+EXVWwU2a/7mKsmfQ+UumM4qM6jKBHWaeNklVyZuct
 bOWrz99PxfZrpAtqd4PILX4MGG8TfYY2WcmaxAuyeI4jL3k+njUAdKLrPtF4v81Yhg2w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kt3Qk+boIYy8WUUU47uFg1V6Ji7N+e3gAqANKMjZyag=; b=O
 g2vW6ZmKRHJ+xeBcufExz08bspRth0q848gTUv3JKFM5kHJWedQPf//XMtTmg747G1iDFWY0GfV1D
 uu/XPQTLoRNiGayZ8hUNJRlNIvFRTUeZX683UI0JQ2M5AgBRZBsW0P2INFSnuE7oPd62WFZD5lC6+
 n0hC/vPZ7kKd2EYQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tQo2l-0004GR-UQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Dec 2024 13:36:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E37815C5B9F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Dec 2024 13:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7378C4CED1;
 Thu, 26 Dec 2024 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735220206;
 bh=axv6cSW2RM8W3th5e/Zgs1HjJR+2PNuK3eljvf43enM=;
 h=From:To:Cc:Subject:Date:From;
 b=YnQ8DIKWQqx2ck8QXYCSpB7KIBaf1sVUzsoIUeTLWw7l2QrX6pwbNn/FcsgTS3qIH
 elLbzYzCk7xDkpsgVGfwn0qvUZItU93rJr4bBNC+DcjQTyA3wJYYjNasHMF1oAFNuO
 kci53t6yB+j9hJ6Md8wd3GeNVwZdYMwpOjGD6LOKTNsh5sPfUkF/hEr3B45zMO/Ex+
 YuStr/l4K+WcPb7Oj0vxUr3FWMVGAIrIL2qHt0ix77+KhDcCmBtddwgbDuUcdjLX5h
 XZYbjkTcWz+7mGbO3GjVbDC/f5r04uMNJXnqsBlVbjDqetzwuMKAIuaMzPvOu/HoB2
 PEWiMcAAjF2GQ==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Thu, 26 Dec 2024 21:36:30 +0800
Message-Id: <20241226133631.9486-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1tQo2l-0004GR-UQ
Subject: [f2fs-dev] [PATCH v4 1/2] common/rc: support f2fs in _mkfs_dev()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Then, f2fs/* testcases can use this wrapped common helper instead of
raw codes.

Suggested-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no updates
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 7b5bc0b4..ecac2de8 100644
--- a/common/rc
+++ b/common/rc
@@ -833,6 +833,9 @@ _try_mkfs_dev()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
 	;;
+    f2fs)
+	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
+	;;
     xfs)
 	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
 	;;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
