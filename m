Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3F5C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HqPBoJBItnI8yljNOpuZzRtCXFFjR5f2mCTDaQ6MmFc=; b=Fqt9TyTjUJlZVxk6FxXAtl5ibg
	wIvm4C+yr4KrAPMCdVPKIfQhX54GwVXXe+MnGsBZS0AKhT5f5SL9Gx3nRxALc0dAosubag+xZvGX6
	TAZC31bP5zWIQJnVCLTWQSO4E7xwhpxOU00XZtjbDnzgoeF0SRIhhT6BoE1apByh8qnY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0udG-0004hX-4E;
	Mon, 31 Aug 2026 05:32:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0udE-0004hR-PI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mpPB7JHgUkLmwS0RUDvJF+z08BOphkdkr41jJfgnTag=; b=ILb5ubzOZEBVObu6FQadYWoWoY
 sZ5j8Ve7/UhMNzHX80lBYPeK3uuN/YEXYDPPhkxisXvxqt7wHfSVHdeguihhYJdHI2krDzwKKpwY1
 DO92sd/WsJTzx03bh6xyTUEmgq7p1U3L+Nd7yAY5kdpNdTNUGzw5qRMysN+T1dk8GKT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mpPB7JHgUkLmwS0RUDvJF+z08BOphkdkr41jJfgnTag=; b=X
 Fig1WyhYKV5P2cRnKp3TsBorACC7TxGAfawHJG7Byi3FZ3VhqWJ+uNmizuRxwFO+DmUQEahF2WTlw
 9aJSKgo7LZZb8hsmASg172uaq+dSyso4jty67H83bMGiOa4OA0NQaNv1fX5mVqxGq8C1gSj+uElow
 SWtakcmar0lASRG4=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0udA-0006X0-NH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:32:30 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a5e392b2b3so4778019a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 22:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788154342; cv=none;
 d=google.com; s=arc-20260327;
 b=Yr1cGAY57/4XK7HL0Kh/hjofntyeDdw+U4TrmzjMMlXQAY/MBbJgXhhq+XEvdV9jxH
 6pTAHdKOX82+G1eBTjp842Bm6DgwaKrKzuQU7bOhbetuAitHunDYo8r3CDfUyrKonbVE
 tNV+w7IqKmH4uQEHWhynxHPOxKYM3mPLCB/r/UOLvmmTNFrONdzhknw+DE37NfMUIOVq
 52Q5+vfqBXHA3xU0ST8EUAtu0kOxB36F4dpDQ/eD5/4gNmTA+GHZYHIXUPw9qXhQRbBD
 9dxvHUdSLfRqAjhawGJDwwVH7Dpg1GPlQK4K39fnwHIIMJCdc0gxthr9oJsu5pJDlwbY
 NMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=mpPB7JHgUkLmwS0RUDvJF+z08BOphkdkr41jJfgnTag=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=RVbhpxrWFsGiYNbgjhzwVY4mICTxJTjZ6crVVaAPo6EpvJwhoi+C/67Nqvud5Sl8Ji
 1B9dEZybv3xJvyHoygogEVQKIZbBGvrkgUEbyahwGDbiSpOMPeWK8ZqR0SwNNjXG4Gef
 1fwG0MR5GtaX0YhKJlSQfFqFSQNEullMBRRQnVP/e2tI0CD8tASpncZvVlypRuvdZs73
 JnXuq3BFh2+HY5YuUba/YAyiN7TlN269qzMtwSBdTK5z+7s/CMiXHo5/rBNxplbwK/nm
 c4QCk/9TjO/kJEsKu04rcKTptilwUZ+VvKa6kRkUkcdDbc7QpELKccEqOS9HCxhjjYR5
 H7tA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788154342; x=1788759142; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mpPB7JHgUkLmwS0RUDvJF+z08BOphkdkr41jJfgnTag=;
 b=UsvENMGq/zT4ND/Vmgp7dRd6XtIqiRqt3ItUDsRV9JrejeD5k6B6SfnbOt7BHFfEPZ
 stmNcdQomewQbFGQo+WERxqvS26HVKnKsJoVAScVjLHx6y0kmuv4rwuIKjWBKpqZpGtK
 NXoo6wZix2u2+kMGtwOtAX9hNDQ4h6V2Kep44Gk2dkjJrwwml8uHDEff81R+Mne+Ygg6
 TelqAC0c4M/FR3ictS+8tiErQYhPrczOGLjecA4Ot7kGUTRNhxZ7Ul2zKoeVmZ821HfX
 WNusskficrqZnUk+G3kKc/rV3fikHp2akOqUZX+JyaAKLERSlGl2JBFvD9Qyj03WXXrj
 IYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788154342; x=1788759142;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mpPB7JHgUkLmwS0RUDvJF+z08BOphkdkr41jJfgnTag=;
 b=N280GH/peDKEJkiYK58b48KhdJHMNBRAx9jVD+SWMVQ0VNdIWQhMqk7gcl91e3sreB
 WsT6JQTuybBG0YIgKiN4V1xNC4ST0h7awT2rSyyI7XA0jv+T8k3akGTYO+Qv4uO7TPZP
 ehpUlIX61gj2OTWY4E2uemPL6kC/mStJOW/0e1zEFHx+003Iceyo/0MH06iH9ds7mnTn
 79zQlhfmU8oU/JhTkDEKNC3pIQa+K3x6KIavY7roZU2E7KQa5KE2SNfwQpuGReKAxyIN
 sZAoVU9Svgl8s+HahrbPUCYHBHX4XQQtppyT71lG6JZIrpQcBhj5YDSNYeFVeMlxMCFW
 HSZA==
X-Gm-Message-State: AFuF++m4O80zB/UZJBtUyi4SwSP8zMdGF/BU58dueySISdQzcAlliIDP
 oi8pScGXnmaWXo+gC2nAXXWS27dPtgQ2thsweXRazZ3/do5c/0FJ/jlzpo14BTAekX7lYaFuSZU
 u5uL9pf6krBuP22oJriT9wPfzKC0miCbnWfYKhik=
X-Gm-Gg: AYBFou1Bhenj2nykIA/wLdEiec1OtNsbzxNVJ4I2++HLG80v8QodopJzjzZ87NOEUBL
 uAQJCxPvl4qsbjdg2SKI4dmF460e+xz/lE8sXNzZcgP6FppTUe+o5UwBOSfOmGVtonWPGsBYvLy
 bh6dL1lwNR8aGlkfOvL/shyqBtUHTcLABE1qlAp5mTUMzCz3ut9F1BmugIot5JfVPG8bO/cNX++
 wo1V38lc4/ymgAB4CKmEzku2SfGjqAjzSWdVxF0vIzT+6fwROvs5Dl2iCIMkJCaKlGT7kb7119h
 XlzbVFv4avKm7zQbzUzBR9diiP3hbYDEZ2jhPCX2k86Z6H2cnYtnbvaNNrjOLqtolGqgi/X/TTc
 V5A==
X-Received: by 2002:a05:6402:43c6:b0:6a5:f4ed:50e8 with SMTP id
 4fb4d7f45d1cf-6a60d36ffdamr13496589a12.10.1788154341962; Sun, 30 Aug 2026
 22:32:21 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:32:20 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:32:20 +0200
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 07:32:20 +0200
X-Gm-Features: AcwNN1XUkvSukCcHJeY8_X3lDDomY3JH8BsRBHVzXeo5dnl6Lq8igF5_R-4UeAc
Message-ID: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0udA-0006X0-NH
Subject: [f2fs-dev] [PATCH v3 00/11] f2fs: prepare metadata layouts for
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
size.  This series derives those values from the mounted filesystem's block
size instead, as preparation for supporting filesystem blocks smaller than
PAGE_SIZE.

The patches initialize sb_info early, describe the SIT, NAT, orphan, dentry,
node, and xattr layouts dynamically, parameterize sector/byte/block
conversion helpers, and derive node-tree geometry at runtime.

This series does not relax the block-size mount check or enable subpage I/O.
It is intended to be a behavior-preserving refactoring for currently
supported 4KB-block filesystems.

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

v2: https://lore.kernel.org/linux-f2fs-devel/CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com/
v1: https://lore.kernel.org/linux-f2fs-devel/CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com/

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
