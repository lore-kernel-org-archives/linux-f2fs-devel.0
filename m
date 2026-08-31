Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA92C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TruJ3FJGTQFKcjEX+YxJlMhmJzmmQ0ga9QrsAzpxxjI=; b=eI86yeefFfo7/HXF0mJnVYsSQL
	LDt/noDHsqgcU6SaIgpfAUYOlV0JYiHmlWF1OFBfWALQHokEIuSNPJ/ltZOerDaCE6kl652izZ3y2
	JRrNdAvbZlWRfEvcpAP/l0BK2p9K3VRqNNk1Q6nZ8gXqa64PhdRZ7rf3oMDcJNUFDuEs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1A8T-0005FD-Eo;
	Mon, 31 Aug 2026 22:05:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1A8O-0005F4-VJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 22:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RMi5i5iPklymXSxIAMEXceLLJGJAAAwbDIEES0t4V2Y=; b=BYNjfsMH7GzFzKp8uqfVlq8gD3
 M6suIje9rPvJgvgtl1WEO+uuiM7Qh83cRsheEhn5Jnhr8vaTZrblCbZl6KOJ8w7NM7ZMMv7LYoDq3
 VWwjJM3A1/k6we2htxjzErVxx5GoO+PsRD93bW6J4lg7LxLk3gHTrWUbdofi8tAoO0hw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RMi5i5iPklymXSxIAMEXceLLJGJAAAwbDIEES0t4V2Y=; b=I
 orGfrHJZNSkuTxr7QlLHgL6nJv0bJa7QqA2l7yDh4/6tygOl1XaiQ3KmFyEtbNoyBwFi1GODSeRfl
 rGlaC5hzV/+X3MDJkyQ5Fq47HywpKhUyPmf/TmXABevy4VWk32VRIWyvHQxJLv4efOwDdnK0nVfCS
 eT9PNHTqJcN0vlBI=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1A8O-0004IF-3P for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 22:05:45 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so38840065ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 15:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788213938; x=1788818738; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMi5i5iPklymXSxIAMEXceLLJGJAAAwbDIEES0t4V2Y=;
 b=J/6fEhf/Mm+R3Gx0QMFZYt45wvE1kCzxSb4UyRek8xWAAi1ks6sMBYUzSlvBnSMzAc
 5i/RbEhTNvFmMv1IBh91FOohNsat2h2Fva5pEqrn2ncMf3PGnegmtvFPNh7TTAzVOzvp
 0nfQN4U/7EZzSGAZTiW1gAaaAMpmMdLQWX00lH+l+bZ7TTPcS2gXSr6Uzxc9HakiNmLu
 04gk/WYF9B+KqTKQRIjIkUU18dKal8T7o+FJAkX227vtqlSGHNZRvblmJvIXyqVI4CGu
 TxjjWx2PqMA/nquH42lfOiuwzxWRSDdhRqbe4R/+QFJzNNqB3244omM4OxLflAC2byaa
 4t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788213938; x=1788818738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMi5i5iPklymXSxIAMEXceLLJGJAAAwbDIEES0t4V2Y=;
 b=m+YzPE2ReaUlRvMZnTWrEaTLEB0zIhCrMAPKopMMRsmHtkQqOYP+TNWOO+izVxVFZb
 ZNMxdZEidMopoCG0S/Kvvi3anYmfQrmf3upe2yqMaKRwezLdWAIR3SsDnb9JUBb8HnCq
 rLRsfEhdRKySRoNw3TlbCK3dVpl1qC1OsueGe6vhTooCtPt3zK9q5AxYs15e8GrehHj1
 r5iszy3DAwjCVcChLNyn+NHRBDKlq52VXLd1bz9/pcjZ9NSqGU/L/o2sMfssUKVbeIzX
 P0EAq5vZu6YtXcU/NLVHuVUedJ+1Hv9lXJ+QvKPIZrr6x0RRfrf81s9Y1MDSzhDf9Moi
 wCdQ==
X-Gm-Message-State: AFuF++l3ApIFRFG7BmVOMq9AWZsXkmFlrDD5hgJ2yd/M7BsTC7c+P7mt
 Y7sVPU7RRYkSiZgQ/Z9sM5HAmGExKaKZOe+M1epIPuF57Dif4oQcu7Vc3VRavRg5qY4=
X-Gm-Gg: AYBFou1o5OeBF6OKJaueJie0pYK9KFokmrJFmjQNxOG2ielFsydm3u2udTY5XEWFgiW
 +wfT+ZpeulfwoytOrOLkOraXPTQA5XQpJV17SZhaBUqOXfPLtl5uvQPC2J5yeB9s3jh5PdWbsYE
 hCgb3wN/Q9lHY9Smub+0UVEsdHWy5mvp3Dx9es1qoTKR/gs+FSm+pIAPrjlCbFSPi3A1CKhCrE5
 z1wufmM70KS7GQGC3j53WCkTy2tPZiZgHeeKskSaWDRaVKzrbf5LsXef6m+KLB+apZkuVpRSMft
 WKMxVzM3ZbYkuaDqnRsIiQwhJSklTW+nBR8jLd4C5pbLzadvlIUxshUrlb8bx94sod4zKt1VZBl
 RUzsvkrcHqrWKA/fjrOVTUifs9W6/6fDqaRvSb6MhGKX4WHZS/tyij7DyOYP5hsGwUvXVzrbEtm
 XzsZR31gr7fLDGhuf+knnSAYWXNpI4b9cJOLeUc88uNw91zipXus/WWwD4Akg2keUfUQ==
X-Received: by 2002:a17:902:f786:b0:2d8:d4ce:7e3d with SMTP id
 d9443c01a7336-2d8d4ce836bmr326161875ad.18.1788213938327; 
 Mon, 31 Aug 2026 15:05:38 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:91a4:c2d8:1d54:21ad])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d951b52bfbsm3131575ad.17.2026.08.31.15.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 15:05:37 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 15:05:36 -0700
Message-ID: <cover.1788213716.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1x1A8O-0004IF-3P
Subject: [f2fs-dev] [PATCH v7 00/11] f2fs: prepare metadata layouts for
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
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

Changes since v6:
- no code changes
- return to inline patches sent by git send-email through direct SMTP; the
  previous Gmail API transport reflowed long lines in text/plain bodies
- verified an actual SMTP-received copy of patch 01/11 with git am; its long
  hunk headers were intact and the resulting tree matched the original commit
- send the cover and 01/11 first and verify the list-received raw copy before
  completing the series

v6:
https://lore.kernel.org/lkml/CAH=xXfE6o2sLwcYdoH9cayZpbf389y8PeJ_aDRty61i7q4QKow@mail.gmail.com/

Changes since v3:
- no code changes; v4 through v6 were transport-only resends after the
  delivered inline patches were corrupted by line wrapping

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
- arm64 16KB-page W=1 F2FS build at the series tip
- m68k W=1 F2FS builds with the two reported randconfigs at the affected
  patch points
- SH W=1 F2FS build with the reported randconfig at the affected patch;
  fs/f2fs/file.o has no __divdi3 reference
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
  f2fs: parameterize block size and mask macros
  f2fs: describe node tree geometry dynamically

 fs/f2fs/checkpoint.c    |  75 ++++++++++--------
 fs/f2fs/data.c          |  85 +++++++++++---------
 fs/f2fs/debug.c         |   4 +-
 fs/f2fs/dir.c           |  51 ++++++------
 fs/f2fs/extent_cache.c  |   6 +-
 fs/f2fs/f2fs.h          | 122 +++++++++++++++++++++-------
 fs/f2fs/file.c          |  84 +++++++++++---------
 fs/f2fs/gc.c            |  27 ++++---
 fs/f2fs/inline.c        |  11 ++-
 fs/f2fs/inode.c         |  22 +++---
 fs/f2fs/node.c          | 171 +++++++++++++++++++++-------------------
 fs/f2fs/node.h          |  89 +++++++++++----------
 fs/f2fs/recovery.c      |   4 +-
 fs/f2fs/segment.c       |  60 +++++++-------
 fs/f2fs/segment.h       |  32 ++++----
 fs/f2fs/shrinker.c      |   2 +-
 fs/f2fs/super.c         |  83 +++++++++++++------
 fs/f2fs/sysfs.c         |  10 +--
 fs/f2fs/verity.c        |   6 +-
 fs/f2fs/xattr.c         |  10 ++-
 fs/f2fs/xattr.h         |  15 ++--
 include/linux/f2fs_fs.h | 131 ++++++++++++++++--------------
 22 files changed, 636 insertions(+), 464 deletions(-)


base-commit: c966d29e01bbf829f8bb4a39a49811c56cdb49c3
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
