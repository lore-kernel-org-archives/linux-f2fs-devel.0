Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A673C3F6B0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Aug 2022 07:18:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oOwH6-00084L-2h;
	Fri, 19 Aug 2022 07:18:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oOwH2-00084F-MS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 Aug 2022 07:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rSSJQsavKS0eL6bPobrHLKdcFi6kDD64jEThaOrVxiQ=; b=ltuD65iaK6NiMdWv9BRP1Ph/z6
 YueXfu2DJeUFTxJqLpiphdBWO3kAiIztK128U+yjTwp/PWkCVMZYLWYe6RYvjX6KjXsXS7ES9OTlJ
 zzd+iyDC1Sh9SaWoxPEpKGq/3Xm0jDU3ahBElozl3fsx2e20tvqYSd75+giZFqPGMSiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rSSJQsavKS0eL6bPobrHLKdcFi6kDD64jEThaOrVxiQ=; b=Y
 xF/H9jUMBvXuR0HRZA8pmzt1pA/VvqDcFxYz8/EoCNStznVyaq04it6dZv4vCRvGteWCiwccIqrzt
 YWSutpLlWFinDePSXIIuGBbGDgSSRaXxFLkTvARXQetfLLXeGL3yOQGPnDPystX4R5Pp+p1XniKUA
 ZQmyAGTFn6uVxL1M=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oOwGt-0002b5-L7 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 Aug 2022 07:18:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0DFE461648;
 Fri, 19 Aug 2022 07:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A9EC433C1;
 Fri, 19 Aug 2022 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660893490;
 bh=urBqd6sIRU3x6OGrBbvlSl/MLtqpjSnSa5yBG6LG85U=;
 h=From:To:Cc:Subject:Date:From;
 b=EzTgxveXKG6RaPuiWCg5OL1nA6+W37vbIimNvAC3Mb3YdTdUMG7GirW7dF3s8YHGw
 7o2yhmFGYeuJPsb/xi8MA+QezhLDSy+m3VVxblZ813u3QfeWCh4OFiZnSqxcANQ6bi
 63pBjUwT4SMVj2xq4i5HpmhbZm4eSgjbRL0ka3B6kvbE8wUdyb12CHrxFVzQ14doVZ
 ZGoT13lAoImOFb45KcpBRN+HHzL2t/YhIsaaIl8bLYOE3VBIlWmZavxCATAMmwAHbi
 hG507ZrXL6BfEm03BNMLq3HrNE9X3GjxEs4FZvqaB9kqGh0M/F2Gd58fxURFZROJ6B
 0OcOmQDnPTHjQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Fri, 19 Aug 2022 00:15:30 -0700
Message-Id: <20220819071532.221026-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Headers-End: 1oOwGt-0002b5-L7
Subject: [f2fs-dev] [PATCH 0/2] fscrypt: rework filesystem-level keyring
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
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series reworks the filesystem-level keyring to not use the keyrings
subsystem as part of its internal implementation (except for ->mk_users,
which remains unchanged for now).  This fixes several issues, described
in the first patch.  This is also a prerequisite for removing the direct
use of struct request_queue from filesystem code, as discussed at
https://lore.kernel.org/linux-fscrypt/20220721125929.1866403-1-hch@lst.de/T/#u

Eric Biggers (2):
  fscrypt: stop using keyrings subsystem for fscrypt_master_key
  fscrypt: stop holding extra request_queue references

 fs/crypto/fscrypt_private.h |  74 ++++--
 fs/crypto/hooks.c           |  10 +-
 fs/crypto/inline_crypt.c    |  83 +++----
 fs/crypto/keyring.c         | 476 +++++++++++++++++++-----------------
 fs/crypto/keysetup.c        |  89 +++----
 fs/crypto/keysetup_v1.c     |   4 +-
 fs/crypto/policy.c          |   8 +-
 fs/super.c                  |   2 +-
 include/linux/fs.h          |   2 +-
 include/linux/fscrypt.h     |   4 +-
 10 files changed, 387 insertions(+), 365 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
