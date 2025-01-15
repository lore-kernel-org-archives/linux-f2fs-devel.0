Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073BBC02180
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2025 22:18:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYBiZ-0004lg-M9;
	Wed, 15 Jan 2025 22:18:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tYBiX-0004lX-WD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Jan 2025 22:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZH3FC8jLJrToI4zTUxTYu7lPzGVMNcokhjRaRCl9R6U=; b=g8X9rh7c3ZsxMPi8GbcRiZYPDm
 o+ddiX6u8VZGCbGrrGlrisZIg91Jgxk0vmsziV/rle1ho0i+HAY5w8hIug3Hizbm/2WAaGJDE4zr2
 1brHcCnGVkhM89VVqUZZtpxgznML2srKJ8verRgeOYnS4dAerGrRriOdaeySHzmsPs0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZH3FC8jLJrToI4zTUxTYu7lPzGVMNcokhjRaRCl9R6U=; b=P
 64wyVioS2tsb7OR9KV03+acNDjmGNXz2RJoSCFNipBfc6xQsCorhwp9vwwRmIHGmLuLkHgGjljAC4
 2ciz/KEy8XL0G6a+lFYCevb6X5ezMwqUpSQGBoPq6tvTWg6mJu/liqHPIO2CTidLQ9evPbo30nr0w
 PwR06o10RRdhNojY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYBiY-0002T9-67 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Jan 2025 22:18:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 127F55C5F0C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Jan 2025 22:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72980C4CED1;
 Wed, 15 Jan 2025 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736979499;
 bh=4kIsyU5rXlE9mJi6lc1dgFWaOsh3YjfD1MJ8YxXEfHE=;
 h=From:To:Cc:Subject:Date:From;
 b=CiZhLZis9cbUuPEn8ToQCFY/JaNvClQNwvbK2d/zIc9vZGLzhUgzL6DZnInE+BJ65
 /NEqory891caawzwM6y1dB2Ow6YNB/Y0JqFaRXtqz0yJCV1UaJNdqX28wQNb8SU6TA
 XqGeq5XGNVY1Bh1SdenM+favpDOPr+RB21vgja3U0K1VUvPoXyDWrqGNszsBKNPSKs
 G70loWi5s+3uI9jIPi1nNuxOWNb/sQOWGC70B2zJiTaD/iM5Aeun1oaUT676LZFFiZ
 j5yxBdMtvUAzNzKdNaVqmRXGhH7yht0I/WstHD8TcpgKMNa8BANEkBCnHHfctzrJ3v
 CfWE/m3lbndlQ==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 15 Jan 2025 22:16:50 +0000
Message-ID: <20250115221814.1920703-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
MIME-Version: 1.0
X-Headers-End: 1tYBiY-0002T9-67
Subject: [f2fs-dev] [PATCH 0/2 v3] add ioctl/sysfs to donate file-backed
 pages
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If users clearly know which file-backed pages to reclaim in system view, they
can use this ioctl() to register in advance and reclaim all at once later.

Change log from v2:
 - add more boundary checks
 - de-register the range, if len is zero

Jaegeuk Kim (2):
  f2fs: register inodes which is able to donate pages
  f2fs: add a sysfs entry to request donate file-backed pages

 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++
 fs/f2fs/debug.c                         |  3 ++
 fs/f2fs/f2fs.h                          | 14 +++++-
 fs/f2fs/file.c                          | 64 +++++++++++++++++++++++++
 fs/f2fs/inode.c                         | 14 ++++++
 fs/f2fs/shrinker.c                      | 27 +++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         |  8 ++++
 include/uapi/linux/f2fs.h               |  7 +++
 9 files changed, 144 insertions(+), 1 deletion(-)

-- 
2.48.0.rc2.279.g1de40edade-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
