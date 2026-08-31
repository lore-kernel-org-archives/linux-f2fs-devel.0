Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED356C624C6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U9cKUBQOJ4NnVF/KwO4ZEDZnBW06u1hs2+oE9/c2mVE=; b=R1kJosfSNwoAd7YmFnFp3l5Kyd
	I9F1bIg0pYWy3KH1CS2KDLOW7neTs3UHn5Lt8qDfiRI8u0cMI/zpPcxxLBMguT3N3w6dexGok+MXk
	WXWShRDaweT5OqvbLcdhaJ40B1oflXNIchk2hnqo9tZhd7MKooescJctYy4Jht/4PTUc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15vG-0008Vr-0x;
	Mon, 31 Aug 2026 17:35:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15vE-0008Vk-AA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NrLEV+P2I7sA236ztoqXL6dgwfLc2PQ26Z83hstTuik=; b=Am0/+6IdLKs4OSrHFBWm5A8Bbw
 iXh7Hstb19eU54faAYWGotaKQa6BNJuv8D43o3wN1snLRqlrM812UI213nktyTz8jRGQSqgT/x0JR
 /xPeauqNS3J9bt9KoNV8YUNnR9+e0RvukACUFzxvf7AypXCh56CLvd8ld7kXK9GUCe6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NrLEV+P2I7sA236ztoqXL6dgwfLc2PQ26Z83hstTuik=; b=i
 OPR6tUDr/SsJKr79R3w9LwWpVE6f4DChyrjY1oGosYZuv/zbAlpk9LN46g/RzavcKzaEv8GcM0eEQ
 5lHHLtnu9hEftboxv5T1GlDiCh0BYf2dWsh68XLaJsQJnntjfva1W+YsK3RBpNDJXBbKbGhQXxBwc
 0C+qTACQ7aeZiLRQ=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15vC-00034w-75 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:35:52 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a668cacdadso578735a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788197744; cv=none;
 d=google.com; s=arc-20260327;
 b=MJoNl41rfkzrNUkHI6hUyimAsmQcGDm5/+oib0tUMLywdGVsIuaimTLwBfttSUsQAW
 SWVe+4xcLkDp6jCZBa99slM2TdDH0/OAH8Gf9vDJerI3ySqfFl9GU1u97UXNbhkpHNi5
 3EG+V5yj2z2COHmhoccwHVssqVHLk2tSiUYVut1tO7xQwPvzLJB1ZYJ/Sf/HwwFJIrBi
 f+FpFawtp0y4WgWulrBf1vFU6DFWJK466VgBVgXe4cUYnHiAFYDMgAQs6NKoh9SlL/cN
 TV3UTOsP9q8LcYF6QRiAXV6dHZrTG4eRfZZtAZdn2YLh/ljBLCczEKzMxdQgWYeSBW/5
 5Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=NrLEV+P2I7sA236ztoqXL6dgwfLc2PQ26Z83hstTuik=;
 fh=VuKasonysUlrzBqN1m+Uwp6MGXQbTFgxS8WCuR8ZZ+o=;
 b=WcqXqOFtNjFYPTktV7A4uAu3dmqLuTommCdyvChAAswVGQI+mGRUviIJyhzJ7EnonI
 noDPKN402o2MSRxh7K487mBqMl9rFKb1h/jOVjw+B9GdDRe0tXhhVJ9rOxJg2f4leDVg
 SEOAzGO0dtPSRBDFXj8wjvXman6pIooFMSo8vAQg98COy9cJAGBWLqC0/WZOUir0u8iX
 rWxvlwGf8lEMwMG/oB1oeoxhIoxXzqTki3h1SID4cDa1DO+q95UtQBSC2Y1qz27USmOC
 XnR5p23tlfY71KuX1bp7jRjZi5Lsid3eGSnN9CNsxdih7EAxxw+p9jb/aO3sL9DVsgDJ
 uECQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788197744; x=1788802544; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NrLEV+P2I7sA236ztoqXL6dgwfLc2PQ26Z83hstTuik=;
 b=RjuQFbA26Z/OvxdSYetyeaVK5UpeQltbe9Tf+pxw58kjmMadhgmXQffxjOO8eOVqkT
 BG49mqX1WQBma+rLS6MjFauHi4FCfoJdsHWvL4+mI8JxwSOBE8dc7c9cdVeax61YqcKe
 Db8ymTvO/4KJ/9a3NktF8rI/ld3tV41BuCU5FNjlb0u/6zva1ZP9VPtCwYLRO33HCpr9
 Rk12tX4/SnMgxURnC/nJKgqaNbVGVELjHANam35+QNArhUxcjE+5EXpfZ/i/vNLhKbBG
 RTioS58KcFLIHFJUPxeVxOpDjz29RyuAaU7VcGQ2/tuMfOsq5qCbjhPPJ3XLLEmUM0ix
 Bavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788197744; x=1788802544;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NrLEV+P2I7sA236ztoqXL6dgwfLc2PQ26Z83hstTuik=;
 b=sQnXFtG8s9cBucVR6OKaYGTcbwWpCJrGUADO4FVmbDBh9Y3rOiQ5iPKHDHvWqPS6hG
 tv+6LX7gtm8csMa7314tmN/O/UzWGCEXmGD7VzSfHsuBifMv13xR80SZSSFxsKzkL4oq
 KD/UNeK1a+5+RWVPvVJSQ++r3YTnSYiMfs5NZAoKH35uHP4c0a2Ihr9z7zsq91vNTqax
 XhCOgj7EaExlu7alQc0tu7wYwrgLidwLtBe+eFnTR0x/2VF/EqQi7TEbObx3irwlKaTs
 iR8udwvE0N8rd0w19qkVuK1cp5JI2e83e4L3FTT0iewL4y/Xr0LGtOmSGda/LXMK00DT
 VQgw==
X-Gm-Message-State: AFuF++kvosFkf4TDVHGJEJSOD08ZozpIttKF4gJ5QWnCyg7yIDN4WtBb
 L/oY0jgI27QKD1jWgnofVYRQDY2zc9HB8Pv/SEKp9OA4ZbIK9bTCfIQP+sfZtI8vPUd8hg2S7U6
 BoI3u7825VuPg6kh19Fqua04OUKLHsKmQ2+XD63A=
X-Gm-Gg: AYBFou3CFYKfOyKMwHPjtc7wreV9i28K1fSwqySMjtrT1IozHRwawGPRPr6r1mZ2Q73
 obA/8+8OizLaTDavECLLx1TKnaoilBA+G7Pn4uUle2BKxZTWKhO5GcFGfvpuDYIJr9iCDA9Ofym
 Pi2arF1BnDD1gsFwdrCUF7IwaxQ11AmwFMUEVGLkF8TYhdwrFZ4hYyR4IKIzH9B7zD9xEx8DOkM
 sw+tkKSAiPbdoiyPKM4uDKE4L6KhpTNQndPwXaydC1sMHnpbDHIxteOLq86lY1kZpEjtYRBKMAO
 YdlToGsCMkboTEUG2uZdoHZ0sopJ74kR3+pLPIRsmVxDMywc/yL+DFcGkpIlnIRRhalwGZ+tZAK
 cSnSskNBOb6+g
X-Received: by 2002:a05:6402:1f49:b0:6a6:cda:1c9f with SMTP id
 4fb4d7f45d1cf-6a60d3a9c9cmr16793695a12.9.1788197743340; Mon, 31 Aug 2026
 10:35:43 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:35:42 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:35:42 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:35:42 +0200
X-Gm-Features: AcwNN1Wjkh5ICuspxoVciXOfblGjJOCL4nZYjxXDlIu24xNvA-SUFp-jzGh96OQ
Message-ID: <CAH=xXfE6o2sLwcYdoH9cayZpbf389y8PeJ_aDRty61i7q4QKow@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15vC-00034w-75
Subject: [f2fs-dev] [PATCH v6 00/11] f2fs: prepare metadata layouts for
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 Kelvin Zhang <zhangxp1998@gmail.com>
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

Changes since v5:
- no code changes
- send each diff as a base64-encoded text/x-patch attachment because Gmail's
  outgoing transport reflowed long lines in inline text/plain bodies
- verified that an actual received raw message applies with git am and
  produces the expected tree; the list-side copy of patch 01/11 will be
  checked before completing the series

v5:
https://lore.kernel.org/linux-f2fs-devel/CAH=xXfH7TPGt-zKXvJRNTgGDZKa1Xoq_sF3-WGs5kdsQLuYn4g@mail.gmail.com/

Changes since v4:
- no code changes
- resend with CRLF-canonicalized RFC822 messages; the delivered inline patch
  was still reflowed by Gmail's outgoing transport

v4:
https://lore.kernel.org/linux-f2fs-devel/CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com/

Changes since v3:
- no code changes
- resend with git send-email because the previous mail-sending path produced
  hard-wrapped hunk headers in the delivered messages

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
