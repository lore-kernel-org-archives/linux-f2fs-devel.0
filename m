Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB338E77188
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jan 2025 22:42:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tXpcc-00050U-Kg;
	Tue, 14 Jan 2025 22:42:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tXpca-00050N-JF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jan 2025 22:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nqKDYlCD4yT5wJzS4oUlS8l73Hw9Uq2JHSXIZGeGYXY=; b=Qm4xa9b8UyaJMY8qmM4l2fITSW
 qG/u2IHqopiVBgZh4C7AtEV1RI1mDXDvQu6RfjRJkTJpumkH6gyXkBP439fHNs37NDzeiNXQJsQrf
 ik32vHIY7IotTlUNeXYsUHl2xQdFShzTLaOU6Y+mj24zpBgqy9BcNn5WTckaHovSFLKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nqKDYlCD4yT5wJzS4oUlS8l73Hw9Uq2JHSXIZGeGYXY=; b=P
 EdgPXaaku5j5sgDpKPvOE41dSbdge1aP1YcIQggEh/vypJepsT89/3zwLZ0FA7wTKJX0LwK3wK8Q0
 zBC6Xoenxv7Kbf8PkETWCFm6pwucjoWdnlG4qeTOuOA7vujC51QCt26oftSWajdOJfgjyN7N1ulqk
 IxQtCs9Mkz9NHF1M=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tXpca-0002s0-Nf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jan 2025 22:42:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8C5F45C5997
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jan 2025 22:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A97C4CEDD;
 Tue, 14 Jan 2025 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736894567;
 bh=ozBBJa0Pn5bDWGXB7U+vlkXn2dlyZcYl2o5Yx9WDsxQ=;
 h=From:To:Cc:Subject:Date:From;
 b=YbWSZA+vy2V2+3lVqQAM8FHnstga4VwEjIyE8nya2BgoFrkQJtYH2k4WUuLvXASBT
 On0gxkhv4P6AYPip5D0kNbVCb5OmziisS+tuVGtaPgwIdpJqOcOOOCZNxecEeujNoV
 J5x69HOhh18Cj8EsCQ0RddsOpx9x+E6Tp898Xb+Uzyr813utxW9phQFBTuaD6P4T6c
 C2kSh/oE0TQo4p86yvUnaWvb0u/dWB69wtUSYW0mPA+CiMdUDgdkh/8A8oexnf2N0H
 0xy0OfaOUAUXL2UuWlXMkPHlLkCUG8kf3PXl1fYHSPZFEo+fITDTvmbbH0ThSNn2Xn
 B5TARsMFiQobw==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 14 Jan 2025 22:39:53 +0000
Message-ID: <20250114224242.1630478-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
MIME-Version: 1.0
X-Headers-End: 1tXpca-0002s0-Nf
Subject: [f2fs-dev] [PATCH 0/2 v2] add ioctl/sysfs to donate file-backed
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

Jaegeuk Kim (2):
  f2fs: register inodes which is able to donate pages
  f2fs: add a sysfs entry to request donate file-backed pages

 Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++++
 fs/f2fs/debug.c                         |  3 ++
 fs/f2fs/f2fs.h                          | 14 ++++++-
 fs/f2fs/file.c                          | 52 +++++++++++++++++++++++++
 fs/f2fs/inode.c                         | 14 +++++++
 fs/f2fs/shrinker.c                      | 27 +++++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         |  8 ++++
 include/uapi/linux/f2fs.h               |  7 ++++
 9 files changed, 132 insertions(+), 1 deletion(-)

-- 
2.48.0.rc2.279.g1de40edade-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
