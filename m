Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767F5CCA47F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Jul 2022 07:14:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oEmra-0002gs-Ev; Fri, 22 Jul 2022 07:14:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1oEmrX-0002ga-Ng
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 07:14:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9DeTB1BlLGtFZlKSCseppW7W1ma7vwKEa7dw5sSLkFg=; b=Ruu1qknMOpFORCU0iDVEAQSbMz
 C1tgCXL2oAylTzGUXd01Eug2zC72Js4mRGIPIA/YAezEolwzWrpoBTdvGCHLpkJaff7FsnEvI5xgf
 OOZriXnWFdgGT+BEP2JHpS26Z2iH2/9RuuTdsoO3KSwtc+HgctdCtt2/f+cFg2VsQuPI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9DeTB1BlLGtFZlKSCseppW7W1ma7vwKEa7dw5sSLkFg=; b=VRNsZ1H8t6ZjSbPHje7lx5LQj0
 qyzp5uhDFKPwFko84PdAzrOOxrFnek6BwUyRKvh9W4lORHguTyhR8QOIvjgPvVdeiuD5pQtsJ373g
 0z0oU8rav2eXq5wNGi8XfJLjx1I551EjPvwCvyGMMrSG253vcL9jV/wQJyQJcg8UugYA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oEmrV-0000qd-Cj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 07:14:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E0F806219E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Jul 2022 07:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73054C385A5;
 Fri, 22 Jul 2022 07:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658474044;
 bh=Xi5JrwkGMRjNbBiivYG5NLjIO4EBV+YXLEfJAlDv+2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=II9Y3TRuV9mm5FKGUq5vXuOGQbIVBnrNvh78iv2geP1tmChv9AzzLQZYDqm4tQjb1
 S0pSKHPSNGTKRaUtmDdMPde0Dj5C5Wg8vaKKKjRtMslmfrBqMJ9MbHQSEdknxSyV5o
 c7lCTbLiFarDSsGfKNd+49lsVxNM1ITiOdNs5hOcoN0beKAa6M2vtbYYsrg43YGV4H
 8wht22UspK6ct/EI4E4Q3pUB/9MR8qux46/w5MfdrNHJxqs//qv8FCoqYj451co34R
 KfN393kPHJT0O3hO5nTk2Ihtyt6BrjkBkKiKdm5UVjVoJtBuBUktXJC7aho/mGlyvX
 02EQXEBwohTqg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Fri, 22 Jul 2022 00:12:25 -0700
Message-Id: <20220722071228.146690-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1oEmrV-0000qd-Cj
Subject: [f2fs-dev] [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO
 writes
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Currently, if an f2fs filesystem is mounted with the mode=lfs and
io_bits mount options, DIO reads are allowed but DIO writes are not.
Allowing DIO reads but not DIO writes is an unusual restriction, which
is likely to be surprising to applications, namely any application that
both reads and writes from a file (using O_DIRECT).  This behavior is
also incompatible with the proposed STATX_DIOALIGN extension to statx.
Given this, let's drop the support for DIO reads in this configuration.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5e5c97fccfb4ee..ad0212848a1ab9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -823,7 +823,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 				struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
 
 	if (!fscrypt_dio_supported(inode))
 		return true;
@@ -841,7 +840,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi))
 		return true;
-	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
+	if (f2fs_lfs_mode(sbi)) {
 		if (block_unaligned_IO(inode, iocb, iter))
 			return true;
 		if (F2FS_IO_ALIGNED(sbi))
-- 
2.37.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
