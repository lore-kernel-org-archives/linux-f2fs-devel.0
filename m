Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AF2C624DE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UBYQBQr3hZpH9J36dQnbMrTEbwKZxsaCoyptn1WA3hw=; b=Jihol5G8ORjzvNbjR34RPiU7Zl
	1vV/g2+MC78jT9uC0tzPcf85IdDgszYOIufGY5yh4YLZJF6qXsXYdZYj7N0MNGBcfARDMs//CqbMi
	s7Z1p4aKIENvnbrPmXH+opSxXfuYdYNqohRv8qe1xIAYpBPFSpm20GSBckqynndjKSSU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2GW4-0000cK-L7;
	Thu, 03 Sep 2026 23:06:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2GVe-0000bx-5F
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xkRazqQ8DBZA8pwlVaij6JLqPhgIEkspYHWRThtggmo=; b=MQUjC/8WDRUfqFN4dDuOmA20jg
 CbJg4PSln6Ngbs6fNnW2o16BFzxqfhjLNAsv1P8XXc55kxg0lIu0japn6/JUQDssYOfqqVzzX7mm3
 5FWeI06p2imM97UcP0TUfRRCXgnEvh1rU89yc9twpCG1XQ5v/OX86VSeoB11cewfLMAk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xkRazqQ8DBZA8pwlVaij6JLqPhgIEkspYHWRThtggmo=; b=l
 KhfuoLDUjnQ9ji4QMCPBLlKHfKV9oAtJmNLPf7FznxrSVfmNtKS3jt0CgQ9dMS7NWGo5qtI8NeTBb
 HKUQ96CGWpf1gv+fzaGR0/0xBqLv7LOtt78LETf/STJ7RJ/YNgfGQOk8DSudwO4+o6nMZzdkeM4Vr
 3LythR7aWP33gNOI=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2GVY-00077S-Vb for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:06:14 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2caced6038eso4221035ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788476767; x=1789081567; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xkRazqQ8DBZA8pwlVaij6JLqPhgIEkspYHWRThtggmo=;
 b=S7I/DGPG51aE7YjTJjxtOudrqvW70RFvM0zjkNt6N2Os10jzAVB27MbTy6T9Riz27Z
 FXjKgam22PFc/1+tO3HBlGk/btn1ZzIrv4t6ngEdcI5bk+U5fQFB73dr18f65+yu8Sb3
 hx6lBvBwf3+OfG0kK+jMkE8Lz29omlbfpy0iNz1Ve+P7rrx0atkACU4ILtmt6Yjgs3Hp
 jCZiHloI7PaLpMIP9rF9On/o6lo//hQxdV/Dc9lRQtLTmb0h2frk9Bjeo8oKjtNOVg91
 O9zunmpsCfX0MCCXX6zJm2dddnqCSD8cK4GhgOgcYr835A/jiiYw6Skw4gixl2bcUcVA
 R3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476767; x=1789081567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xkRazqQ8DBZA8pwlVaij6JLqPhgIEkspYHWRThtggmo=;
 b=bb/N4ethhHZqTPszsK2mORUbjCRfzcprUU/99IkYoLqnFNjG57HZMVvIqdv8COMifZ
 OxL9J7apmnLh5CSVwydRUxIN2Ze8X9SnevdhDvuaY5fw5inT3Mn0g2dFlnj6eJP6X/Lz
 6nw87YyMPRdNcygo89zsX79+/geqp7oRVF2G8uczsZUWbBmzku4QznKrHFSzWJVg0Y/X
 QV5v/k83q0K76G+YfbI1r2ZmtYxzF53M18kP8CPSm3ceOK0ZafaShF7ERsuyypj/aSp0
 08Ve8hevScBNhReEbnLWFHUfpLrPTmc7E6fy2F+q10sWsSBmQzA3ERWpJiPH6rnhteQE
 Hjpg==
X-Gm-Message-State: AFuF++mnw2jaa1RUxwUlYV0fdBgidD2qLiVI+ZYd4PyzEHLvEwXsP3Gv
 IhVCThODKxE+pCNnEQCw3ftp0sHBS+GuGE+takhHXnpKhmwSew74R15HlaLSQexRoMw=
X-Gm-Gg: AYBFou28w6qSUM7W3SlBFNTuvtJJpKFiZZy+8rIyB/YXc6/un+HKmttX7qf1KiIF+/b
 73gEqbD0E0koAcpkaMw9mgpPscbKoJ+hh9KT+Gyl4svC+fiFPipeTfCu/o0aZDFqaQD/493m/9u
 g3d6ZWBbyXWqjgPt02Vbf8lpaEt3DYIdoX5VsjCIWt1wLtZM0ARsIAw97MlRMBDm/qBycmJB+Lk
 bVaDVfDF4/mDZbn8Mg7FDxd4+CuHoqFHGsd3e0KrshiusSaQVO0sm/xADjxAKhoZhmmgBcyPG3O
 6gEnuQ22Abs8vUX2lcgCJHfzqxaY0txgfo/bIm2xc/QoW+CBWf5vrw7ZYDliLMwkrtGmEXh248u
 pslrxYysJIf6R1XH1yg34FPJ36ZlkdNs9Le3b3HXE+6AkcfbXYFKZV/OVHr8VBgVaW05UPr28T8
 2KVjGGLG5g3D9qtQecLAe7n5Jf0aCwc91KpbFImHqZa8DF72RBPrpal6etoIoDhAYdgw==
X-Received: by 2002:a17:903:37cc:b0:2d0:401c:2edc with SMTP id
 d9443c01a7336-2dafaee6576mr71597175ad.1.1788476766967; 
 Thu, 03 Sep 2026 16:06:06 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0c0sm1776075ad.17.2026.09.03.16.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:06:06 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:06:04 -0700
Message-ID: <cover.1788476500.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1x2GVY-00077S-Vb
Subject: [f2fs-dev] [PATCH v8 00/11] f2fs: prepare metadata layouts for
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
- builds of all five F2FS subpage selftest binaries on the complete branch
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

base-commit: c966d29e01bbf829f8bb4a39a49811c56cdb49c3
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
