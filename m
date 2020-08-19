Return-Path: <SRS0=hFix=B5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233BCC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB399207FF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="HyDCZ1XB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Ztizml65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB399207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k8UNN-0002v9-D3; Wed, 19 Aug 2020 20:08:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1k8UNM-0002uw-DL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 20:08:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vm4MvJCgQVshrKKudBfukweOtsJSg62vp/cL3OYUq3c=; b=HyDCZ1XBPnI3trAKpSpvsJaPFq
 vl8iiTfY0d6aQornTO/5uwIlKhrrLKg85rLIrgL0yNkSAHygPXWgzNTOjmRAsYJ7sMbq0dvSmt63o
 U5kbtfqLSWEOUbkEihpO+ygOtPjsjzGbcvgcTuCChB0ZiKXlTr5IzjPdeidp51qSllgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vm4MvJCgQVshrKKudBfukweOtsJSg62vp/cL3OYUq3c=; b=Z
 tizml65ZfsUbR6o6fUsVNZGsqP37PgrJI582cMeXYWx22RpeCcDYQQvJYcDyDGH24On7eG4PpgE/k
 1Im5sqYxh+66nqtD/iHK2uVyTcme7qtaj3Ne8s5mqwDZZ2Hx+xhpOy/LNTyuxW/b7qsiH0eJX5Qf/
 /8um6jUDHAJ3wH6Q=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k8UNK-00CjrQ-JA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 20:08:00 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id BFAB2295E70
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 19 Aug 2020 16:07:29 -0400
Message-Id: <20200819200731.2972195-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Headers-End: 1k8UNK-00CjrQ-JA
Subject: [f2fs-dev] [PATCH 0/2] Consolidate DIO behavior on unaligned EOF
 read
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
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When issuing a DIO read past EOF on a file that doesn't end on a block
boundary, behavior varies among filesystems. Most filesystems (including
the ones using iomap for DIO) will return EOF, but the old generic DIO
mechanism changed behavior accidently after commit 9fe55eea7e4b ("Fix
race when checking i_size on direct i/o read") and started returning
-EINVAL.

This can be observed with a simple read over a file that doesn't end on
a block boundary, forcing the last read to be unaligned.

 while (done < total) {
   ssize_t delta = pread(fd, buf + done, total - done, off + done);
   if (!delta)
     break;
   ...
 }

On the final read, delta will be 0 on most filesystems, including ext4,
xfs and btrfs, but it started being -EINVAL after said commit, for
filesystems using do_blockdev_direct_IO.

BTRFS, even though relying on this generic code, doesn't have this
issue, because it does the verification beforehand, on check_direct_IO.
Finally, f2fs requires a specific fix, since it checks for alignment
before calling the generic code.

It is arguable whether filesystems should actually return EOF or
-EINVAL, but since the original ABI returned 0 and so does most
filesystems and original DIO code, it seems reasonable to consolidate on
that.  Therefore, this patchset fixes the filesystems returning EINVAL
to return EOF.

I ran smoke tests over f2fs, and didn't observe regressions.

Gabriel Krisman Bertazi (1):
  f2fs: Return EOF on unaligned end of file DIO read

Jamie Liu (1):
  direct-io: defer alignment check until after EOF check

 fs/direct-io.c | 31 ++++++++++++++++++-------------
 fs/f2fs/data.c |  3 +++
 2 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
