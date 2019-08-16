Return-Path: <SRS0=leBL=WM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1DDC3A59D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:56:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7F0206C2;
	Fri, 16 Aug 2019 05:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kW0wOIhf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bMU9vMn4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHVn1gk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7F0206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hyVEJ-0007dY-64; Fri, 16 Aug 2019 05:56:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hyVEH-0007dC-Sl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Aug 2019 05:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xfS1vPuu64Fnikm9IZGzMseayvvgy/FfG1deuzy3jeE=; b=kW0wOIhffM0Rhw+kZvIP+QLTi7
 OtGcu3XZojvlM5x35oPZkH28wl2NtFdk7wFJXvSfnZyAOwaXKNTmH2N9ETe3k4HsULTJ3lasAK+WC
 O6FQYdpmyWBAdpAlmy0j7+x11FWiBaUjE8jPhRFP+aR2h5KJB09lTZ7Ow2LrjpC726kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xfS1vPuu64Fnikm9IZGzMseayvvgy/FfG1deuzy3jeE=; b=bMU9vMn4m80f9okf4Y/r/aWvd5
 ATuF23r2FyJdH+lIpordA7S1UsDHL4oUUKAD9mJT7b1iF3CZDQ3M9rmoV8GmVB3MGPjd6BvLZRv2+
 BgyX2Nio9GAiz9mBKORSMt7ikvluK7Buq+AeU3svLBk3dxoev5AFJBZBgAYUzkTedT/8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hyVEG-007xJg-Mk
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Aug 2019 05:56:49 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F2582089E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Aug 2019 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565935003;
 bh=/AqHkWR4+TrHIjTjNXYkX1LJ5QgrzjKRONFp9RpDY3U=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=JHVn1gk3Sv29SDO+kbNnRtpvKMC19B5V5HYEnzvK4BHjhl2e/6CLtSdK/niYVagIz
 xiDja6r2kv6oJ4D8LnuJbkA/hfFmc2HkykjOR4KMaBq9nxkzRnvikR9jJCJ+Tzqe80
 ZOyRP6XeAyhrdA2ydl9ydHV4ud/7HKhtSd/UP6I4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 15 Aug 2019 22:55:39 -0700
Message-Id: <20190816055539.30420-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190816055539.30420-1-ebiggers@kernel.org>
References: <20190816055539.30420-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hyVEG-007xJg-Mk
Subject: [f2fs-dev] [PATCH 3/3] f2fs: add missing authorization check in
 FS_IOC_SETFSLABEL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

FS_IOC_SETFSLABEL modifies the filesystem superblock, so it shouldn't be
allowed to regular users.  Require CAP_SYS_ADMIN, like xfs and btrfs do.

Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 315127251bc1..6939cddc542a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3113,6 +3113,9 @@ static int f2fs_set_volume_name(struct file *filp, unsigned long arg)
 	char *vbuf;
 	int err = 0;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	vbuf = strndup_user((const char __user *)arg, FSLABEL_MAX);
 	if (IS_ERR(vbuf))
 		return PTR_ERR(vbuf);
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
