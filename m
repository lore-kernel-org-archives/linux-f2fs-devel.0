Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581F606A33D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MeMGAtt8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bmQgZnWn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Gm6eSqHd;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CfNgasWc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=NDC5DmnknJExekZLfGAsEsk1Ytwmc8DXmwuPBKv39+A=; b=MeMGAtt8JZ5/WYCaGYkHGafgd1
	iFnXSgggO8JHxijEX0lcsDaaWRlqaYu7OF3s47hqfdeO2o+7pUQg0M9Tv/J2RHY2w32IV6qRv/OQU
	pl4hrmaEwPk2m04puxtsbEjA9lctTewYioBXqnLcEqxEMpGv05uyziCrEWQ41osMMjEc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxt4-000000003vf-1SfO;
	Mon, 02 Nov 2026 19:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxt2-000000003vX-2McB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aAt/D2xAxDDJsgiaipx8quTUg87/88xSQ3Xpia9P9eU=; b=bmQgZnWnXtX0++p54cGT+85vSs
 m7ItE9rAO1ux/FtBLh8XujfneN5GySvgMZ1GQVelQWnhPCedFkhetcYzXq9Sccosz6JT84KMkCY2F
 ydPnTHJZ1lVE0D09zpKtPxhJIKTd74p0VCGJwBfK6tLJnHmYC7IvGD5Iag+9zm69m7mw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aAt/D2xAxDDJsgiaipx8quTUg87/88xSQ3Xpia9P9eU=; b=Gm6eSqHdAT0YST3SxsbJijoqgK
 bLYXV57P2a47d+5dr+gOvUL8FEIP3zJmp4mzi3Vs97JFifoCbZ++amSKtwF2S7p/jrdwlw0R+PRVU
 Z4/hOPLXkTP9Cqvf1kXNXl5a1uZLR9MZslhKjiAodFqyKbllSyV0VgqQwR+DUgy0x/Lc=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxt1-000000002Cl-3nao
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:08 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cd69954c755so2474800a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648402; x=1794253202; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aAt/D2xAxDDJsgiaipx8quTUg87/88xSQ3Xpia9P9eU=;
 b=CfNgasWceqcDi0YKqe3JkXKyoCaOc1mAuFLM3YregNC3eA0ZjbAGJBlgvG8QjVZVXR
 if5eWCq8EiLoW1hLc46B8IevHopgfoik6GjqB46gfJ64Yjd+6u2QmWh0NSGZldo9OlN7
 zfiYty5HlGoggMDL0mBHU3CbnS7NvFGJIXNxgmGgwgKbrjJsb0zs93QAy5VkmZuQvF5X
 gqxe9WmHix9FF2yklwBe4YolzWCOQmbmAOUG4lwB6Cf4oPfMTKEK96vcTGmeQJfvotS+
 cbXu3BxF7BTTiaIKwLTcqvSFy2FEmmRe8o4UH2VhKLO3fS/IzzgCI9BlOiGg8zTyMfCB
 PAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648402; x=1794253202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aAt/D2xAxDDJsgiaipx8quTUg87/88xSQ3Xpia9P9eU=;
 b=MtAEGAQ8clXmXltGT76tW90mCGoPtERfDpk3Wd6+V2Xh0cegwozqiRVhn87HN1iyAw
 K+Rl3/GJJy+JkgmMi1jK0VCjU71pkkBEa/d7Q7yMpL/jtToheMXZtyU1WzX7/lk+ZQHr
 0KkRtBHAtcvCK7hNCskIdzfBMksefEg+KD9vFQ7IKmPY0SM6us+1FSdV/YT9saJgZkxC
 2nzygrey81YErY7ooe1DteeRfiFWKAtx9LzIcLgi/9jSNUUslHd7Q5btpzM/g1CAysW4
 rOp/GXjNKwx8O2tXtxdn74M/nZxdSNSZv6yDguJXigGs2tQROjisvJHolNVJ5z4kNzHN
 YBjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVvgnVynQOAuvZNvZtF1HaGiAgcKXDkP/O/1iNprvGBtL+4as3XoBDvdbuFjGQLDJ3fcxLFE1d0qoehwg6fZzx@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLl819Vk6Uvl8LPbmqbzGhnvivq+Qk3ry/J3dY8XgtNxDW+wHL5
 66otZDdtSkGhvVApQvbU8Ycn+6+GuGB+PoFyuWn9DNe/svFrlo4OuPyRImmrITKp
X-Gm-Gg: AYBFou1NVBy62cxGieChyCtWfmpKUCBuG7xe6VbMPxaPwVG6Z5pckB1vSfDypMq69At
 1YOYBGeCaQNEUMNrmiezjpmHSgAwKECJe2Jp1gb4SnNunBs6GI/qZj6yJ4Wg7x6pCC9Of0eZ2Oz
 xs3skxtp4CXkSjFEev+nCXkeYPEYotOLNZke2Y8J4qGPACGzKNQ/e2YuJVb9zVE1n54ekvxOxgq
 Au9VHiUMRxbws8HpO26XryE/w053e4wagx7dCCATX8rYpr9QRAIABUEzS102F/iTVGZYIkp32A7
 RGtUS/lhyTugGsAdtwj+m6al/gKGSSt2mxEf0PIMHmvpkBFj4O7bixb1knTGygJYwuezdc9df3e
 rklaEBiWg7a8QPkgvs/x3ltLLFNv8nvxp3CodjqSqpdKW3+7ZFZfcXYaFDRhUWbdVI6ldr1WdMM
 +4Nx4M3HNIUqZ7XmnBlGjvvpSk0wCQXktJXNcWyvftbo9BfCpsFn3lWtXvBxKpHdyHviJz2Rdr7
 Bd68Bc4UPxtS5jjS9IMp5NO9O2w+zXcRvJk8KhNJIAoRzox1LzTYb9GyiEvVuurcmGFREKh6G4i
 Zj1WDvLjXW+Wl+37hCFC1MRk45vkaFkXogc+n09UNvJed6TV5gEOEXts7tZqyo/fgVHPCXRvnOa
 aMdXKue5cRDp0SXzgbQ+ujXV/hZmgBMEE3+R06yHeb0Pw/w==
X-Received: by 2002:a05:6a21:3945:b0:3e1:aa91:7134 with SMTP id
 adf61e73a8af0-3e928ace8d8mr9717391637.72.1793648402077; 
 Mon, 02 Nov 2026 11:40:02 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:00 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:32 -0800
Message-ID: <20261102193952.3002018-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxt1-000000002Cl-3nao
Subject: [f2fs-dev] [PATCH 00/20] f2fs: support block size smaller than
 PAGE_SIZE
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

F2FS has required the filesystem block size to equal PAGE_SIZE. On a
kernel with 16KB pages, this means an existing F2FS image with 4KB
blocks cannot be mounted, e.g. the userdata partition of an Android
device that moves from a 4KB page kernel to a 16KB page kernel.

This series lets F2FS mount and use a filesystem whose block size is
smaller than PAGE_SIZE, such as 4KB blocks on a 16KB page kernel. The
on-disk format does not change.

With subpage blocks, even an order-0 folio holds several blocks, so
the series builds on the large folio support from Nanzhe Zhao [1] and
tracks uptodate and dirty state per block in f2fs_folio_state for any
folio that holds more than one block. Most paths then work in blocks
instead of pages:

- Patches 1-2 convert the remaining page based index and size
  calculations to block based ones, and add the superblock and mount
  infrastructure. Subpage block sizes are still rejected at this
  point.
- Patch 3 extends f2fs_folio_state with per-block state, identified by
  a magic number, and allocates it on demand with __GFP_NOFAIL.
- Patches 4-7 handle directories, the per-inode dirty counters, the
  read path and GC, and the write path and writeback per block.
- Patches 8-19 adapt the remaining features: range operations and
  mmap, pinned files, collapse/insert range, move range,
  defragmentation, swapfile, fs-verity, atomic writes, inline data,
  online resize and compression, and remove the -EOPNOTSUPP checks
  that patch 2 added for the features that need them.
- Patch 20 stops rejecting subpage block sizes.

When the block size equals PAGE_SIZE, the behavior does not change,
except for the fixes noted in the individual patches, some of which
also apply to large folios.

A few of the patches adjust code from the large folio series [1]:

- f2fs_folio_has_ffs() checks the folio state magic instead of
  requiring a large folio, since order-0 multi-block folios also carry
  a folio state, and the page private flags can legitimately be set
  before a state is attached.
- f2fs_ffs_find_or_alloc() cannot fail with __GFP_NOFAIL, so the NULL
  checks of its result in f2fs_get_lock_data_folio() and
  redirty_blocks() are removed.
- Defragmentation and swapfile activation mark only the target block
  dirty instead of the whole page.
- redirty_blocks() does not dirty the blocks past EOF.

Testing:

Built every patch for x86_64 and arm64 (16KB pages), and the whole
series for arm (32-bit).

Ran the xfstests auto group (excluding the clone, dedupe and thin
groups) on arm64 QEMU with mount options "discard,fsync_mode=strict"
in these combinations of page size / block size:

- 16KB/4KB:  default, compression (lz4, zstd, lz4hc, lzo-rle with
             64KB clusters and checksum), compression+encryption,
             encryption+verity, mode=lfs, atgc
- 4KB/4KB:   default, compression, encryption+verity,
             compression+encryption, mode=lfs
- 16KB/16KB: default, compression, encryption+verity,
             compression+encryption, mode=lfs

plus generic/019, 521 and 522 for each combination, and a 24 hour
power-off recovery test with fsstress for each of the three
combinations.

There were no crashes or hangs, and the power-off recovery tests found
no corruption.

[1] https://lore.kernel.org/linux-f2fs-devel/20261028154407.1601430-1-nzzhao.sigma@gmail.com/

Daeho Jeong (20):
  f2fs: use block-based index and size calculations in remaining paths
  f2fs: support subpage block size superblock and mount
  f2fs: extend f2fs_folio_state for subpage blocks
  f2fs: support subpage blocks in directory operations
  f2fs: convert inode dirty page counters to dirty block counters
  f2fs: support subpage blocks in data read path and GC
  f2fs: support subpage blocks in data write path and writeback
  f2fs: adapt range operations and mmap for subpage blocks
  f2fs: support subpage blocks in pinned files
  f2fs: support subpage blocks in collapse and insert range
  f2fs: support subpage blocks in move range
  f2fs: support subpage blocks in defragmentation
  f2fs: support subpage blocks in swapfile activation
  f2fs: support subpage blocks in fs-verity enablement
  f2fs: support subpage blocks in atomic writes
  f2fs: preserve inline data in subpage block mode
  f2fs: support subpage blocks in online resize
  f2fs: support subpage blocks in compression
  f2fs: count compress cache entries in pages for its memory limit
  f2fs: enable subpage block size support

 fs/f2fs/checkpoint.c    |   41 +-
 fs/f2fs/compress.c      |  518 +++++++++----
 fs/f2fs/data.c          | 1552 +++++++++++++++++++++++----------------
 fs/f2fs/dir.c           |  124 +++-
 fs/f2fs/f2fs.h          |  225 ++++--
 fs/f2fs/file.c          |  553 ++++++++------
 fs/f2fs/gc.c            |   89 ++-
 fs/f2fs/inline.c        |   13 +-
 fs/f2fs/inode.c         |    4 +-
 fs/f2fs/node.c          |   17 +-
 fs/f2fs/segment.c       |    7 +-
 fs/f2fs/super.c         |  162 ++--
 fs/f2fs/verity.c        |    5 -
 include/linux/f2fs_fs.h |    1 +
 14 files changed, 2078 insertions(+), 1233 deletions(-)


base-commit: 4c5e07aaeeb8a27d769a7e4e13d0b26aea0cb108
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
