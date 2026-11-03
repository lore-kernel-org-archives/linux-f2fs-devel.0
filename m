Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38992606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bJpHuGFS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HnL6/k/a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=az4nqmUu;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nk8INlbW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=vT24J0TdwrAc4F2yR4H3n32wLZzkGbbjl/gIl2f0i54=; b=bJpHuGFSEVqtQSuJ66SKHxZqkS
	Pk5F0JMmrQ03rw3jKDsgnum95VTbdwLiqexf2jkMwNEHUsJU3tZ9Ldx+dUW3lxQ5HXgz5qXNjWV/7
	bolyUppPvr8ESBJKKHU+h4fyWe6t9OPxIBlzY8gd48nIZZUlL9J0LloiOM05r9ZKCKPw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO2j8-000000003BX-328Y;
	Tue, 03 Nov 2026 00:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xO2j6-000000003BE-1vYZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B4a8z0r/I2VGvLUdejIfW7bJVb0on3o/Uz/KMJ9QOCw=; b=H
 nL6/k/aXq68zN8NkMU2fzK+XYHH6k4F2O2tVr+RI002XdzAy1aniFlMGrcS2BXS6kC4wD7E1LVd0b
 vO6DP7xuYaaU0BTqBmpFnJDF90JNCXWjz733/kEFR3Q+JT6XHbxAG2qBGHPw3YQtH9/XHS7gkyeSq
 kA4GRV5FbEoerudM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B4a8z0r/I2VGvLUdejIfW7bJVb0on3o/Uz/KMJ9QOCw=; b=az4nqmUuLmZCXCb9rx97z3ZUO5
 aD6zWQP/Ih7mKLfoJ2vbatwdpIL+lDIbm5Tw2LRu+qpGz4nsknbkRWR6INqNbPxcvdCbK9zBVnL4G
 uPR8xth1ICQGrj3FbbwQZ7qrDlmHB+nSVJYfUwwm4rv2POiFMvQ+e0QfDfoNpFDUs6DQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO2j5-000000001op-2iH5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F65840F2F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Nov 2026 00:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F31F000C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Nov 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667006;
 bh=B4a8z0r/I2VGvLUdejIfW7bJVb0on3o/Uz/KMJ9QOCw=;
 h=Subject:From:Date:To;
 b=nk8INlbWrxy9Hq041JAk89InUTlVfLaHKuuk3/79qw4G0I3WHDlEQzwQ+Elsa4r7b
 VplG0mElaxoToNCCV+ShHChNsMXXeKDFbx/j0gwul3YSW1klL21g1OkrM7xz1ZLe7u
 OyniBHJwXb6HKSbpyuUO9zNctOhuRkIYgBuxYVRqxZLsCS08sv98auhYq7xzOciuj/
 jQaLF/ztHwLJ2dedTonlhY78CEbBHIymu1Pfpsl3ITiJeZlj2ek2huYG1Xu9jL23TZ
 xVLnTDIJ6W0kxuYB30ATN0zmuZHwpxZSkIdiW7K6ySl1h4ZQnIwA3UFKWVkoS/8Uba
 R4SKkvx62qb+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 05911380821F for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Nov 2026 00:50:06 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179366700465.755181.1615897042448504048.git-patchwork-summary@kernel.org>
Date: Tue, 03 Nov 2026 00:50:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO2j5-000000001op-2iH5
Subject: [f2fs-dev] Patchwork summary for: f2fs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: update inode ctime on exchange rename
  Submitter: Hungyu Lin <dennylin0707@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1198357/
  Lore link: https://lore.kernel.org/r/20261102004742.55105-1-dennylin0707@gmail.com

Series: [f2fs-dev,v2,1/2] f2fs: fix use-after-free of quota file names on failed remount
  Submitter: Zhan Xusheng <zhanxusheng1024@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1198383/
  Lore link: https://lore.kernel.org/r/20261102023647.1084979-1-zhanxusheng1024@gmail.com
    Patches: [f2fs-dev,v2,1/2] f2fs: fix use-after-free of quota file names on failed remount
             [f2fs-dev,v2,2/2] f2fs: free the quota file name that remount drops

Patch: [f2fs-dev] f2fs: preserve 64-bit FITRIM minimum lengths
  Submitter: Hungyu Lin <dennylin0707@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1197925/
  Lore link: https://lore.kernel.org/r/20261031233935.9600-1-dennylin0707@gmail.com

Patch: [f2fs-dev] f2fs: report sub-block project quotas in statfs
  Submitter: Hungyu Lin <dennylin0707@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1198323/
  Lore link: https://lore.kernel.org/r/20261101230552.55034-1-dennylin0707@gmail.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
