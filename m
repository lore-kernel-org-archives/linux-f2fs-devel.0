Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455D1ECD6FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Feb 2026 01:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:To:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V8m7olhtowin9F6JCfZOF97CPc8rijV5gW+Hd6SR768=; b=OaQnm2HPYa4ogvigfPOdsdKXKI
	GkUEkbJTslO6sijXGEJW6Iz/meebng/MVq6q4akIdbygsqTL0huRI1PnZ2tmMjg5li+i+B99zWNdI
	ZwXG9v0HiRydoOeGIlmsRhJxfZOBi9aLA3nDqvi+LEh4UmnDhHi2+ZixBRWl9+KasBWE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqLUr-0007V5-S7;
	Thu, 12 Feb 2026 01:27:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vqLUf-0007Uq-O0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Feb 2026 01:27:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Axe4JVqGOHq91/GRJ51KI7un8YHnYch61vMn0KWlzr4=; b=OMgjiVe7PYrK8we70/PyT9omBj
 jknSNlwgDV0wjrIF800UUO7xrz9l3n6Z1EEBHV9eH2pNOHCaJV//pYvUYzkX3wdMazMN/jCOSnaFa
 QM/Wqt/KdixhoAgTzKvkR9FtQg4gRiuTQoVhDHQk0pf1XfeEKsc8TtikLxAYdK3ZXrhs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Axe4JVqGOHq91/GRJ51KI7un8YHnYch61vMn0KWlzr4=; b=D
 hexn89aquJ04FocKA0sMRQiC3I1r/pF/fm9bC+9Lw5qhY0kqgH41EMoBDwdh5lNXKeY5/aSgrjngM
 2iq2jsnd/0uOXFr155OMXEvaewVF8OxO4+e8Ngjxxo9Rl+ktXXYFaJ/0zNQJIa8HtJh25lPl07rV6
 wxqVseDJSy6FN7xM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqLUf-0007Fa-95 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Feb 2026 01:27:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DBB4A441D2;
 Thu, 12 Feb 2026 01:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF65C19423;
 Thu, 12 Feb 2026 01:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770859654;
 bh=LI9T8ckO6uZfvbB4i3LQ04OePVTEa752sUaYTpdWXPk=;
 h=Date:From:To:Cc:Subject:From;
 b=VC8TyQBQCl1ZNhvI97b3cMj0k5IKOhdi2Okelw9VVkk7vUJDiZ3dT48KDUuxLXv10
 xu6SI0aberuBRiUDCEFe2gbVLhYUq9NT+mc303UfLpGJ7BOZf/ZEUhYvLReS7i2qcT
 pIcUEvauojisi7uZBoWGx/Uni8GhfjBobkSGrio6+7yGMvkKeSZmMILVJrHYzXo1jP
 noWt5UlfqbSLMoUWlxFKjtRjbKlQ2g4Sc9pKo/gIutBZsrG4qLK6688ODfTQjzfNA5
 FsfL0F7pNpEYcTo/5jyFtG4573sqMz4vtmq1WCa2rBHhIo95wehrQHDH8UzSXYZdqu
 BPAvuQLionkcA==
Date: Wed, 11 Feb 2026 17:26:52 -0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20260212012652.GA8885@sol>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1vqLUf-0007Fa-95
Subject: [f2fs-dev] [GIT PULL] fsverity updates for 7.0
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, David Sterba <dsterba@suse.com>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 433fbcac9ebe491b518b21c7305fba9a748c7d2c:

  fsverity: remove inode from fsverity_verification_ctx (2026-02-04 11:31:54 -0800)

----------------------------------------------------------------

fsverity cleanups, speedup, and memory usage optimization from
Christoph Hellwig:

- Move some logic into common code

- Fix btrfs to reject truncates of fsverity files

- Improve the Merkle tree readahead implementation

- Store each inode's fsverity_info in a hash table instead of using a
  pointer in the filesystem-specific part of the inode.

  This optimizes for memory usage in the usual case where most files
  don't have fsverity enabled.

- Look up the fsverity_info fewer times during verification, to
  amortize the hash table overhead

----------------------------------------------------------------
Christoph Hellwig (17):
      fs,fsverity: reject size changes on fsverity files in setattr_prepare
      fs,fsverity: clear out fsverity_info from common code
      ext4: don't build the fsverity work handler for !CONFIG_FS_VERITY
      f2fs: don't build the fsverity work handler for !CONFIG_FS_VERITY
      fsverity: pass struct file to ->write_merkle_tree_block
      fsverity: start consolidating pagecache code
      fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
      readahead: push invalidate_lock out of page_cache_ra_unbounded
      ext4: move ->read_folio and ->readahead to readpage.c
      fsverity: kick off hash readahead at data I/O submission time
      fsverity: deconstify the inode pointer in struct fsverity_info
      fsverity: push out fsverity_info lookup
      fs: consolidate fsverity_info lookup in buffer.c
      ext4: consolidate fsverity_info lookup
      f2fs: consolidate fsverity_info lookup
      btrfs: consolidate fsverity_info lookup
      fsverity: use a hashtable to find the fsverity_info

Eric Biggers (1):
      fsverity: remove inode from fsverity_verification_ctx

 fs/attr.c                    |  12 ++-
 fs/btrfs/btrfs_inode.h       |   4 -
 fs/btrfs/extent_io.c         |  53 +++++++-----
 fs/btrfs/inode.c             |  13 +--
 fs/btrfs/verity.c            |  11 +--
 fs/buffer.c                  |  25 +++---
 fs/ext4/ext4.h               |   8 +-
 fs/ext4/inode.c              |  31 -------
 fs/ext4/readpage.c           |  64 +++++++++++----
 fs/ext4/super.c              |   4 -
 fs/ext4/verity.c             |  34 +++-----
 fs/f2fs/compress.c           |   7 +-
 fs/f2fs/data.c               | 100 ++++++++++++++---------
 fs/f2fs/f2fs.h               |  12 +--
 fs/f2fs/file.c               |   6 +-
 fs/f2fs/inode.c              |   1 -
 fs/f2fs/super.c              |   3 -
 fs/f2fs/verity.c             |  34 +++-----
 fs/inode.c                   |   9 ++
 fs/verity/Makefile           |   1 +
 fs/verity/enable.c           |  41 ++++++----
 fs/verity/fsverity_private.h |  20 +++--
 fs/verity/open.c             |  84 +++++++++++--------
 fs/verity/pagecache.c        |  58 +++++++++++++
 fs/verity/read_metadata.c    |  19 +++--
 fs/verity/verify.c           |  91 +++++++++++++--------
 include/linux/fsverity.h     | 190 +++++++++++++++++--------------------------
 mm/readahead.c               |  15 ++--
 28 files changed, 516 insertions(+), 434 deletions(-)
 create mode 100644 fs/verity/pagecache.c


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
