Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF24C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jul 2022 03:17:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oB6Oy-0003Ji-Jx; Tue, 12 Jul 2022 03:17:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oB6Ox-0003Jc-Rb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jul 2022 03:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tv+jEhaanTptfjVUnWS1Xqbkw4WUJHeZX0GGvNQH4wY=; b=AgCNIOZnrkCIVfRY9ADcueDuS6
 mk2NjLvzmjqTQxyUPRl//B8GYy79SZ4DwB3Hpt0ifbfmYyNR9sdE/r81InpHJWsn5rEd0cXl6akg9
 D6bj6UqI/wh+O6ZaDZKjLpyR+e5qTuPT4Y9OXk5PqP3WrApZuGC+iiui9tf3AIjkcWXM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tv+jEhaanTptfjVUnWS1Xqbkw4WUJHeZX0GGvNQH4wY=; b=j
 C6dDeItFesRRosWvqVtRZb96n/RGH2c81qrWBT5bQ0awhXu52mzVBMiZfdbs9U461qQ+LLWU4DYkS
 mnmBBdEWurTffqfA1FMxPz+QR5gStXhJ9C+Nv6O6sqkKW2rGf105I41Eg2EwSWkSP20ui6ulfrFqL
 kUwOWaCuDiFwY5Lc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oB6Ow-00ELrQ-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jul 2022 03:17:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A8AAFB8164A;
 Tue, 12 Jul 2022 03:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A4C34115;
 Tue, 12 Jul 2022 03:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657595842;
 bh=pJZwIkZ8d/iC0FwubEOjyhKFFCOrbXxtTAMZJdtPyTo=;
 h=From:To:Cc:Subject:Date:From;
 b=FRI10TJMayIxzm0DK/SF54vPHxcSJF4ng0Y875nqKyU/93VneHNsvfKJGHciOt8fd
 mtUKqFEq2WGPnnJ8iDOXL16bdL8PGz88wlHUmEwZtMuvIcbUWXCnsztWJi04JJD10W
 Zp+DHemKT78QQ4BjYEQIIGmPsLebvg/0z/zGtbpFm/mNlwu1XNotvuJXtKrQGabwxD
 6yc5af56XEnp6hKgjIwisxOXXXijom/7RoeP5lDGCuEbEtF34BbD54F3Gbddx6Un6j
 uZcA9yU95J+fIho9wXmBqi8IsKAs1/dbFoMZ8eTKllg9PmKqccOFtXmeF5JzomilBN
 yRKnGZWQr4A1Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 12 Jul 2022 11:17:15 +0800
Message-Id: <20220712031715.355222-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oB6Ow-00ELrQ-UQ
Subject: [f2fs-dev] [PATCH] f2fs: fix to check inline_data during compressed
 inode conversion
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

When converting inode to compressed one via ioctl, it needs to check
inline_data, since inline_data flag and compressed flag are incompatible.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1d97d06e0d87..60508a949dda 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4417,7 +4417,7 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-				f2fs_is_atomic_file(inode))
+		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
