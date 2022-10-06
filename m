Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30615C43217
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Oct 2022 15:16:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ogSbu-0004Y7-DE;
	Thu, 06 Oct 2022 15:16:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ogSbt-0004Y0-IK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Oct 2022 15:16:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T20xZ2Id0fWfr9mHqukHXhubwI/1d7WeQeLLi3OVE8Y=; b=MeI5xtB1LVvbohNYmntxdQIJqw
 UnWp5KrJSZsxgehjbexnOmkGxyzEAuyZSwLKNd1BLkpi9vKwHf1tmhQiaswgOoSA5jDkUN5wgt7SX
 AG7gPz+UEGdhw3DK6j7TCVRBIFUSxPlQFSKhj7DV1qy+jBgvEESzqa1/qhi88h74Asxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T20xZ2Id0fWfr9mHqukHXhubwI/1d7WeQeLLi3OVE8Y=; b=J
 Ld272rC7wBuxY+H9BZhe94i92hjHF6EjqmaPyQuLBtEAMS9RFUEi2Focvse+uFe3R+OS5Vj8Xicyl
 V1BTaZaTgm/Hg5TZqBOB3lwnn6HeYXjTr8Hfa0SroDBmqAGU+UqSy8w2hMXKnJ5J5BvRZZXKAcpYi
 DIAcEQQqP0fTxvxg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ogSbp-00Ep3m-8H for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Oct 2022 15:16:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2BB6DB820C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Oct 2022 15:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B6C433C1;
 Thu,  6 Oct 2022 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665069372;
 bh=8SKqFBIYeThVUNjbIA0cdqEp2mrz/RMJNmMZ+5F8OOs=;
 h=From:To:Cc:Subject:Date:From;
 b=XQaOXXXy4SwGcbRfG8TYy5f5OmPewnH9LCPMyOj4VI8WZtookkwAdYlcWO6Q29WW6
 Y/SC/QRIfJYTYairRXDdw+Rp+1owutkJZjhBQF+upoi4tO1swjV6j2swTlB6lSxOzE
 L0jMwrhlXtsc2xvcLC1i6t6I+BFKEmLfEX+3myclUNk3DOi1vRAPXrGbl1vU0nAmLK
 5dzma3nYfO3nMacJP+YBZ/hL51Wfk/8VlHscKC1To/9WGWwdtobef4OJ80JtMDr3+X
 Vo+mlHa3Ch468z9Xca+PheKkOcNUuSeKus6HE6CmYKZnkwUF2cYF+eX4IWZ1AVs5ja
 p5h2GtTZYe4ew==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu,  6 Oct 2022 23:16:06 +0800
Message-Id: <20221006151606.58288-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1ogSbp-00Ep3m-8H
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix __end_block_addr()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The calculation is wrong, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/f2fs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 030d750..2fd241f 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -416,8 +416,9 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 
 static inline block_t __end_block_addr(struct f2fs_sb_info *sbi)
 {
-	block_t end = SM_I(sbi)->main_blkaddr;
-	return end + le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
+	return SM_I(sbi)->main_blkaddr +
+		(le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main) <<
+		sbi->log_blocks_per_seg);
 }
 
 #define GET_ZONENO_FROM_SEGNO(sbi, segno)                               \
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
