Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A93C4167D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Dec 2023 04:01:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rDGR6-0003u4-Lr;
	Wed, 13 Dec 2023 04:01:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rDGR4-0003tu-Lp
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Dec 2023 04:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7oyHNZMo4mmcyex1TUA8F2PqAmpoXuN7x+RF9mDAjJU=; b=gXs2h6QM7l5Hk/Qv/luGnStXf5
 s5oaOXb0f+us2PcjQObtIkQH9p5hM9KC/Tt7qPA3rfWxpxWvnmG0u/WCDz4VYgQDr4aZ5veGGwQS2
 mEisPCFqxcdZi3TZTx+Hq23CGAy8Hq4xo/LeYkC6Lshi5pgGb0JdzIYiOI4kdOwHN9VA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7oyHNZMo4mmcyex1TUA8F2PqAmpoXuN7x+RF9mDAjJU=; b=g
 OOikR8xtwvikso60r+G/mdfPQeekp05IzX/t5AZFpLFSdypm1As8LzAjtbYjPzEoX6TMbPrQtJH6S
 Fhyy3GGpW6fCwwC55vCvGLt4C1QygraejjWSXZpmTHRVfzn9hAZ+p3G5ioVgDZDPCllyrr6o+dDYa
 VpssSVWQMjRR4IqE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rDGR3-0004CC-4w for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Dec 2023 04:01:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B7EC9619DA;
 Wed, 13 Dec 2023 04:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3940FC433C8;
 Wed, 13 Dec 2023 04:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702440074;
 bh=DRMYZj40lbcWfG2b2XHABri8yPBHqvMleMODO+067Q4=;
 h=From:To:Cc:Subject:Date:From;
 b=RnuIwKpvICnNkxkoQ4G5NyIrJVQ1JZ0A4IWhLvKjo8UYFU45J27Ouevh5RMtI8Fbt
 pjQPq/ehfu6+DPF8HvtVg6/1pXt6ZoqgB1KNrHtvMCWf6JY0h+/g9rkW2Vutcqc/lk
 c/+D70YAstXKvW7Nik6jQK67Gv3vmWKvux1UOseyiRPkofdWJq0m92649iuFo6E/uW
 Q4iUT1xYWgP+LJu5AkcvtOqi4vNVr5PylkV9LgD//M9hnByfy1xXOKaKfnt1APJMxO
 8HQFJpj5rMgvHVMdTYWkMRDbU4T/GbQDTWVKRSvn+pAoIFgvOO7MRMETmQb3g86HH+
 2A7YlHNfcpmmA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Tue, 12 Dec 2023 20:00:15 -0800
Message-ID: <20231213040018.73803-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1rDGR3-0004CC-4w
Subject: [f2fs-dev] [PATCH 0/3] Move fscrypt keyring destruction to after
 ->put_super
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
Cc: linux-fscrypt@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series moves the fscrypt keyring destruction to after ->put_super,
as this will be needed by the btrfs fscrypt support.  To make this
possible, it also changes btrfs and f2fs to release their block devices
after generic_shutdown_super() rather than before.

This supersedes "[PATCH] fscrypt: move the call to
fscrypt_destroy_keyring() into ->put_super()"
(https://lore.kernel.org/linux-fscrypt/20231206001325.13676-1-ebiggers@kernel.org/T/#u)

This applies to v6.7-rc5.

Christoph Hellwig (1):
  btrfs: call btrfs_close_devices from ->kill_sb

Eric Biggers (1):
  f2fs: move release of block devices to after kill_block_super()

Josef Bacik (1):
  fs: move fscrypt keyring destruction to after ->put_super

 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   |  7 ++-----
 fs/f2fs/super.c    | 12 +++++++-----
 fs/super.c         | 12 ++++++------
 4 files changed, 17 insertions(+), 18 deletions(-)


base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
