Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04E5EA4E07
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ub1mf1z1HD5QN0Vlp5VRQcP+vMP88GTbxvHgFqCoXY0=; b=WIX1G/I85hro/+9LE0ZBnNKauO
	ptUsxtgEV5n42sEQ8Zv4K3LSZES99OHh1uOJA6cBRDtsOr8nUWlOtPTSJzNUbWxYKK5AmG8m5M+XW
	dwzMmT9h4ldLjXzcU+JyCUi4UBtCJqFAKdmGbdIJn42w60igEBAlzSWb0eVnhqBFyr+I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vx47W-0002PO-Ki;
	Mon, 02 Mar 2026 14:19:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+ce5019daea4c3780914a+8226+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vx47V-0002PE-G2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Mar 2026 14:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jZYzU/9Jj6dU7rQhTTpeYwKqyiuou9e5/FVmJO4ciTI=; b=hBWnezJHpOXwLu4jzhKiYHSuZt
 1HnZhAikng/4qMAq27+sLnys4TavD7dwF+WI19Xah9ib+/9OyHoeIEHsXSHQidzm8iO8DPPxHvF7j
 BKvO+CeqMJXaJhfo78zqtnYO/zFs4lr0uGS1wfae776Tb5Ji8KbAOFUZIXnO0C7Ty/Xg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jZYzU/9Jj6dU7rQhTTpeYwKqyiuou9e5/FVmJO4ciTI=; b=Y
 yZoXUtO95GzyvbW94AB8yFMmez7JLem2TxI4+gXRHlOnEszeWiMtEbQxO7TfU/Y6eLd7aYMR9j5d6
 pTmuZPPofG1u4lXH6VsIAbj/Qd9fXms+JraFMXHFbqA5Rv/IjPV6q8Ota14BrUSYvorqYnKFSHCGq
 mv1uHddlWrbsirEw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vx47V-0001TS-2v for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Mar 2026 14:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=jZYzU/9Jj6dU7rQhTTpeYwKqyiuou9e5/FVmJO4ciTI=; b=F1v0SWDrYaZF3b2OzFDhrUiQ/K
 FSGJGTXZd9YMS/D0V14LhzcRuKPXY05RMQWipxHZMAF4QBL+MCp8c90JfZarVpGQBkYVqJ7RZ9OYA
 5EyqyePOl0aywNTTE3XbL3kXqqN7GRu/g8kg9FZTuJRjPpNUfxyhpBJk9yP9pjAzjvJCt1ElAN1JU
 X3CkDeESlr1/LzCEHypEZp74xOSbOP4ZtHQyY9YANZ63g3Cw8F4liTnHkKaFpj7nllaBNvLQkAcrT
 TLGtFDlBH4Inf/cEkv4M8XT4xpYrif0YGo6V8oYvJiwlpfRVUS1eIO7c7WysreR32bInNs+2vu3yJ
 ceQ7hVzw==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vx47I-0000000DDRc-1w0f; Mon, 02 Mar 2026 14:19:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Mon,  2 Mar 2026 06:18:05 -0800
Message-ID: <20260302141922.370070-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vx47V-0001TS-2v
Subject: [f2fs-dev] fscrypt API cleanups v3
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
Cc: Christian Brauner <brauner@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

this series cleans up various fscrypt APIs to pass logical offsets in
and lengths in bytes, and on-disk sectors as 512-byte sector units,
like most of the VFS and block code.

Changes since v2:
 - use the local bio variable in io_submit_init_bio
 - use folio instead of io_folio (and actually test the noinline mode,
   which should have cought this for the last round)
 - add an extra IS_ENABLED(CONFIG_FS_ENCRYPTION) to safeguard
   against potentially stupid compilers
 - document the byte length needs to be a multiple of the block
   size
 - case to u64 when passing the byte length
 - move a hunk to an earlier patch
Changes since v1:
 - remove all buffer_head helpers, and do that before the API cleanups
   to simplify the series
 - fix a bisection hazard
 - spelling fixes in the commit logs
 - use "file position" to describe the byte offset into an inode
 - add another small ext4 cleanup at the end

Diffstat:
 fs/buffer.c                 |   18 ++++++++-
 fs/crypto/bio.c             |   40 +++++++++-----------
 fs/crypto/fscrypt_private.h |    3 -
 fs/crypto/inline_crypt.c    |   86 ++++----------------------------------------
 fs/crypto/keysetup.c        |    2 -
 fs/ext4/inode.c             |    5 ++
 fs/ext4/page-io.c           |   28 ++++++++++----
 fs/ext4/readpage.c          |   10 ++---
 fs/f2fs/data.c              |    7 ++-
 fs/f2fs/file.c              |    4 +-
 fs/iomap/direct-io.c        |    6 +--
 include/linux/fscrypt.h     |   37 ++++--------------
 12 files changed, 92 insertions(+), 154 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
