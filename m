Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF1BC6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 07:52:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrvQ6-0003Ur-1r;
	Wed, 03 Apr 2024 07:52:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sweettea-kernel@dorminy.me>) id 1rrvQ1-0003UO-OQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SC6Anwg36IOtJKdJbxvqGVUkkAdxWSEE9g3JzlTq28=; b=Gs2G9/XViZgLHVO+IlCdAYI1UD
 BVTf9C5TyR9HPL9GN7hfwIMpwCH17erX2BHBimTIwwvMxcNcnodBtupprJz0lVvnvqjdy7eEKu0wI
 SXANgJMM1xzcCR1JMKo/XLOmFkosdvs5xuE1AL+/hL2q37fYvdpL0g1ARWlwDXT9U3pc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2SC6Anwg36IOtJKdJbxvqGVUkkAdxWSEE9g3JzlTq28=; b=C
 1+L7MNGq3CdWym0GJHv3Uetjmt+CdVC4w4DEYVzgW+UZRGLAAuEmThq/xevnIvLzr7lMP8TEXszCd
 8yqrGnPswhZFuiwITTbdIwwhyuU6URJYcarolZNgqZEKb9des/rxIJZw4U/dDTRCwnQsYl7hL5/eI
 vQ80rpnE0gIMDiEw=;
Received: from box.fidei.email ([71.19.144.250])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rrvQ1-0001lO-3G for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:26 +0000
Received: from authenticated-user (box.fidei.email [71.19.144.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by box.fidei.email (Postfix) with ESMTPSA id 83D2B807A2;
 Wed,  3 Apr 2024 03:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
 t=1712129583; bh=B8T21JVbOLWLZIWqX9Kk4W8YEBxzK1vo2nUprAs1Et0=;
 h=From:To:Subject:Date:From;
 b=RMMhudxb7EIzCkqtHOmFwCDPbzgbWgn5vp8COLdnfwf+qsRdUrHavuwlRc5bMVEiY
 kgw67uVuJhjs63x2OaL8IC0tPgouh2AcqwdGCEWhTb0V7eUhPxFrhru47kQh7HeJWE
 t2+MhGmN22+WGDmkykhpSjR9PhQJTk/Ep//iqUjzwTzOsSU6sq4vsvZfyhow8doZ7o
 YhR7ehQgYH/ByQMLhSyFGRFnpzJKYoUFAaoDiZASvkHxaV54iofPU6PSNKQFMJWjB0
 8EOfG2D66AkPESDO8GJmrHFQfKL9137B2ksLw3d3FgnT9Fd+KFJNw/QioT2Nr/hMha
 orctZOIBXFCvQ==
To: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Wed,  3 Apr 2024 03:22:41 -0400
Message-ID: <cover.1712126039.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
X-Headers-End: 1rrvQ1-0001lO-3G
Subject: [f2fs-dev] [PATCH v3 00/13] fiemap extension for more physical
 information
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
From: Sweet Tea Dorminy via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For many years, various btrfs users have written programs to discover
the actual disk space used by files, using root-only interfaces.
However, this information is a great fit for fiemap: it is inherently
tied to extent information, all filesystems can use it, and the
capabilities required for FIEMAP make sense for this additional
information also.

Hence, this patchset adds various additional information to fiemap,
and extends filesystems (but not iomap) to return it.  This uses some of
the reserved padding in the fiemap extent structure, so programs unaware
of the changes will be unaffected.

This is based on next-20240403. I've tested the btrfs part of this with
the standard btrfs testing matrix locally and manually, and done minimal
testing of the non-btrfs parts.

I'm unsure whether btrfs should be returning the entire physical extent
referenced by a particular logical range, or just the part of the
physical extent referenced by that range. The v2 thread has a discussion
of this.

Changelog:

v3: 
 - Adapted all the direct users of fiemap, except iomap, to emit
   the new fiemap information, as far as I understand the other
   filesystems.

v2:
 - Adopted PHYS_LEN flag and COMPRESSED flag from the previous version,
   as per Andreas Dilger' comment.
   https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/
 - https://lore.kernel.org/linux-fsdevel/cover.1711588701.git.sweettea-kernel@dorminy.me/T/#t

v1: https://lore.kernel.org/linux-fsdevel/20240315030334.GQ6184@frogsfrogsfrogs/T/#t

Sweet Tea Dorminy (13):
  fs: fiemap: add physical_length field to extents
  fs: fiemap: update fiemap_fill_next_extent() signature
  fs: fiemap: add new COMPRESSED extent state
  btrfs: fiemap: emit new COMPRESSED state.
  btrfs: fiemap: return extent physical size
  nilfs2: fiemap: return correct extent physical length
  ext4: fiemap: return correct extent physical length
  f2fs: fiemap: add physical length to trace_f2fs_fiemap
  f2fs: fiemap: return correct extent physical length
  ocfs2: fiemap: return correct extent physical length
  bcachefs: fiemap: return correct extent physical length
  f2fs: fiemap: emit new COMPRESSED state
  bcachefs: fiemap: emit new COMPRESSED state

 Documentation/filesystems/fiemap.rst | 35 ++++++++++----
 fs/bcachefs/fs.c                     | 17 +++++--
 fs/btrfs/extent_io.c                 | 72 ++++++++++++++++++----------
 fs/ext4/extents.c                    |  3 +-
 fs/f2fs/data.c                       | 36 +++++++++-----
 fs/f2fs/inline.c                     |  7 +--
 fs/ioctl.c                           | 11 +++--
 fs/iomap/fiemap.c                    |  2 +-
 fs/nilfs2/inode.c                    | 18 ++++---
 fs/ntfs3/frecord.c                   |  7 +--
 fs/ocfs2/extent_map.c                | 10 ++--
 fs/smb/client/smb2ops.c              |  1 +
 include/linux/fiemap.h               |  2 +-
 include/trace/events/f2fs.h          | 10 ++--
 include/uapi/linux/fiemap.h          | 34 ++++++++++---
 15 files changed, 178 insertions(+), 87 deletions(-)


base-commit: 75e31f66adc4c8d049e8aac1f079c1639294cd65
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
