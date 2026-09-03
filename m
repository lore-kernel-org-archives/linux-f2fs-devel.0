Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07BDC624DE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PxGhXkFMPMGrYWmiMBTst0ZMBYKbN+aPnxPMIFxPRQE=; b=T2SrmBNFAHJplsedUEfceoGkC/
	sQtWEw+yx3UGTEuywtDjEniRTOQ7gjZuklQwte8QgqL0jFPHO7tucswuQXFgplcEF6v/5ScoiVUrn
	hwhEqY0Ru5yHB1Bt5FnDCF5SUKYGaAWLonf5HrMca/nmsSPibv49bSIh+KyWU1qfWwnc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2HGF-0003gq-Eu;
	Thu, 03 Sep 2026 23:54:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2HGD-0003gi-H9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uHu7gXF2LgNRnxV/HYKmzoP+vKk/shVS0drULysZU1c=; b=PyedFJqnTWuBSmZNBXwpiz46Z4
 ayWUkE+W++5EFSvtSWSF7SCMHBi2CUQcRWNO0amVvyEoZJWhPA/OTN0JKvCQ9uJjsGaibU83irX55
 7qCgC3q0+E7dMHeB4inWyYT/aiVU69kRxCx7lwAlPFnn5G4Ty0chUwCNAR3eIdw+JjCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uHu7gXF2LgNRnxV/HYKmzoP+vKk/shVS0drULysZU1c=; b=F
 v/AVEbikAdwUobdUhmzRrRSxAZI/Fn16fHfyLfsxqTV3YVgzDk27y5M0ODENwDXFYvUzwY1ICcgqu
 bwyrYruB5kb8CsQeCYY9fzjmH/x5gBDk/ZPcn2AY69grna5SlxnlTUhTzuflYBNGdv3F/6yqS2u7N
 NVxtyc3eypofYFo4=;
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2HGC-0002S0-MR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:54:25 +0000
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc2276e6daeso441768a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788479659; x=1789084459; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uHu7gXF2LgNRnxV/HYKmzoP+vKk/shVS0drULysZU1c=;
 b=Qw72bp6LSq1p0eLIT2oxKI9AVwdawtnVl5YPuRrNe4MV7bggINsvUWkxtAOnZ9zUO8
 kOuixkn5FCOQSIBar8wehvOj3eadmr/zXpfwTh030yhs7Ax16hjkZUEtfNCijn0J4x7N
 s6UKs8s+ovxtLqkLn/so/Bawbg15Pz4mqOYVF5U67r0D5vmnMO8VxhEWanA8NSp1WpfA
 HuSgzbNH/hhmdg/4tTgDLl+d7mncD21Pem5pFGOnTJbuOvxoC7m7+adALuQd1REIIJm6
 muTRWVMBar14zBooZu147BNT11t3aJRDrS5gB3Hp7ELNkDq8dWQe9jVqU3+Hvql/chKA
 LpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788479659; x=1789084459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHu7gXF2LgNRnxV/HYKmzoP+vKk/shVS0drULysZU1c=;
 b=aELzsj90CjegkK7VK0d3FOEb1nc44DB0nu6g52VRzqHNoiGG8eTgoh15wIv0ycUC3u
 X5+nd98B8DabQ05uiRaWv/PDNIGFtDiS3KB1o+g5NBVp4OzpBokFakL64hmUk5ag6c5j
 OWk79ech2BFyuPRtmZXn6U/8M5Rl2hp6nqt1z+fn0B5kv38QgYi5NlyO+zUhy47/JuBL
 rTOM7gcVQ1R9VHz0q/zB9Il0/cO1F3tc516q2iAh+HaKlhKgmox7x7d6mqNHvcX+EQNd
 7VDb4KvdI2y7zSdfoOjo5EM+4GAqd9HE0FgOp+zD3lBlFirs4OjOLCngS0lYnUYkhMVB
 2GLA==
X-Gm-Message-State: AFuF++l4zjKpv1BZcgpfqW8Og6E33up4kvCGchKAzt+fjTmyqVeSzyDm
 AtEg4aSxQSqbL3YwW7gSA0ZSBPU/lxw2Sjx9ujqZ90K0ioKU2Rmzrv9rlavxmczOocs=
X-Gm-Gg: AYBFou07PYNyJEtY1v+GmrVMxoGBEpQzOecxr6bTm+ti+QGGUVMsy5o/cQuW0e09/7Y
 Umg+6fNWwIqWRZFEtzxc+Icspv33e1CBO7HC6KubOspsDPLfIJjtCagrDq1/tt9Wlq63cIK2hhM
 5f1t9DtlUZnzZvMbn9CBelQDoUzBF8nJAhCGRwecdsYFCbLKATElomkI8FAIT42tXvuMvw3WRmy
 I9UnsfNnx4vV9724wO1GCzWS8qG/j765VAGhT7zSTQx0smHu0M+sHW327Z8xbQP3f1udE0L+7Ty
 z1tujpUWtXoiD1a1m68DyOR5BgdrGnD5S2dukzVV3m/XEMI98kQ2kOtcnQC501D1MAzvUMgAW4x
 bUUIBIkyFCINrWFS56+lZ5prdu/X6yKNEPJMakmqUubLNr0tm0VSCY6Yx8x/9TX6fNBLsLbW/Hw
 vyYf20ewUEKrz/PkW0CxVZmru2gRvPfE27hEbkFJcHeSSfWt+WJovQkRdgTylKHd2SVA==
X-Received: by 2002:a17:90b:564c:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-39b2612338dmr3303412a91.4.1788479658863; 
 Thu, 03 Sep 2026 16:54:18 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885d29esm2327688eec.2.2026.09.03.16.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:54:18 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:54:16 -0700
Message-ID: <cover.1788479509.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1x2HGC-0002S0-MR
Subject: [f2fs-dev] [PATCH v9 00/11] f2fs: prepare metadata layouts for
 runtime block sizes
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS currently describes several on-disk metadata layouts and filesystem
geometry values with constants derived from PAGE_SIZE or a fixed 4KB block
size. This series derives those values from the mounted filesystem's block
size instead, as preparation for supporting filesystem blocks smaller than
PAGE_SIZE.

The patches initialize sb_info early, describe the SIT, NAT, orphan, dentry,
node, and xattr layouts dynamically, parameterize sector/byte/block
conversion helpers, and derive node-tree geometry at runtime.

This series does not relax the block-size mount check or enable subpage I/O.
It is intended to be a behavior-preserving refactoring for currently
supported 4KB-block filesystems.

Changes since v8:
- rebase onto f2fs/dev at 5ad9409a9533 ("f2fs: stop using PG_private")
- no intentional code changes

v8:
https://lore.kernel.org/linux-f2fs-devel/cover.1788476500.git.zhangxp1998@gmail.com/

Changes since v7:
- address all review comments from Chao Yu and Daeho Jeong
- mark the sb_set_blocksize() failure as unlikely and remove unused helpers
- retain struct f2fs_orphan_block as a flexible-array wrapper
- separate the shared-header block-size geometry helper from the cached
  kernel-side inode geometry helper
- consolidate the inline-xattr size helpers and move F2FS_MAX_BLKSIZE to its
  first use
- retain the node-ID layout description without nesting comments
- restore shift-based block alignment instead of using 64-bit division
- move node-tree geometry before block-size macro parameterization so each
  intermediate patch builds without temporary PAGE_SIZE churn
- use a size_t format for the maximum inline-xattr size on 32-bit builds
- remove unrelated whitespace and other incidental changes

v7:
https://lore.kernel.org/linux-f2fs-devel/cover.1788213716.git.zhangxp1998@gmail.com/

Changes since v3:
- no code changes in v4 through v7; those versions addressed mail transport
  corruption before v7 was delivered intact through direct SMTP

v3:
https://lore.kernel.org/linux-f2fs-devel/CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com/

Changes since v2:
- use DECLARE_FLEX_ARRAY() for flexible arrays that are alone in a struct or
  used in a union, fixing the reported m68k GCC build failures
- use F2FS_BLK_ALIGN() in f2fs_sec_trim_file() to avoid a runtime 64-bit
  division and an unresolved __divdi3 reference on 32-bit SH
- no other code changes

Changes since v1:
- rebase onto f2fs/dev at c966d29e01bb
- drop the unrelated free-NID underflow fix from this series
- split the preparatory changes into 11 focused patches
- initialize sb_info earlier and describe the xattr layout explicitly
- separate sector, byte/block, and block-size macro parameterization
- update commit messages and address checkpatch warnings

v2:
https://lore.kernel.org/linux-f2fs-devel/CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com/
v1:
https://lore.kernel.org/linux-f2fs-devel/CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com/

Tested with:
- x86_64 W=1 F2FS build at every patch
- i386 allmodconfig W=1 F2FS builds at patch 07/11 and the series tip
  (no new warnings)
- arm64 16KB-page W=1 F2FS build at the series tip
- scripts/checkpatch.pl --strict (no errors or warnings)

Kelvin Zhang (11):
  f2fs: initialize sb_info early in f2fs_fill_super
  f2fs: describe SIT block layout dynamically
  f2fs: describe NAT block layout dynamically
  f2fs: describe orphan block layout dynamically
  f2fs: describe dentry block layout dynamically
  f2fs: describe {i,d,id}node block layout dynamically
  f2fs: describe xattr block layout dynamically
  f2fs: parameterize sector conversion macros
  f2fs: parameterize byte and block conversion macros
  f2fs: describe node tree geometry dynamically
  f2fs: parameterize block size and mask macros

 fs/f2fs/checkpoint.c    |  63 ++++++++-------
 fs/f2fs/data.c          |  85 +++++++++++---------
 fs/f2fs/debug.c         |   4 +-
 fs/f2fs/dir.c           |  51 ++++++------
 fs/f2fs/extent_cache.c  |   9 ++-
 fs/f2fs/f2fs.h          | 117 ++++++++++++++++++++-------
 fs/f2fs/file.c          |  84 +++++++++++---------
 fs/f2fs/gc.c            |  27 ++++---
 fs/f2fs/inline.c        |  11 ++-
 fs/f2fs/inode.c         |  25 +++---
 fs/f2fs/node.c          | 171 +++++++++++++++++++++-------------------
 fs/f2fs/node.h          |  87 ++++++++++----------
 fs/f2fs/recovery.c      |   4 +-
 fs/f2fs/segment.c       |  60 +++++++-------
 fs/f2fs/segment.h       |  32 ++++----
 fs/f2fs/shrinker.c      |   2 +-
 fs/f2fs/super.c         |  84 +++++++++++++-------
 fs/f2fs/sysfs.c         |  10 +--
 fs/f2fs/verity.c        |   6 +-
 fs/f2fs/xattr.c         |  10 ++-
 fs/f2fs/xattr.h         |  11 +--
 include/linux/f2fs_fs.h | 135 +++++++++++++++++--------------
 22 files changed, 628 insertions(+), 460 deletions(-)


base-commit: 5ad9409a9533bd345d5c9c3d5e3be7619c31a761
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
