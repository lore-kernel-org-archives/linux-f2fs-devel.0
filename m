Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8BDC624C6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yq4iCb7LC6n6nSQmUHh7CT/TbRvHgRa673pWlfHQeqk=; b=Fibw2wL1w1A4vs9xcHNNyA5srx
	jjZfeYthCZg04q8glDP42L9tzSkTjMq4nvqceOL6YkYscW3iho/qXBTi+7ib82FYhBEibbgP04GdF
	r3Dh/JF1w9/ZihZozReyPqbLLzjs3vq6T1+nWnUtqRXh3UmnlY2BOzjiD9gRw3kEkiHs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15d7-0005tG-7Y;
	Mon, 31 Aug 2026 17:17:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15cm-0005rx-5o
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BawYS+YToQeTJe78LwNv7pU3ko9ZF/cuwfYOG/1d9E8=; b=EKdhcm0+8GV/4TSAZl+PdvZFZz
 Np+zl56Z/csIJWJpIiOlESGkXgbkPPkgtRXPUlrtDKoeq3chCPmFLYL6BlFfBMJ1d33atH9bIAh9D
 o1nmEkEjQuyI7e7xoMIYDb/Y5pfekYgw72pONZlVuBBAL0rtaD2WhKHCMYbIjDSTRHCg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BawYS+YToQeTJe78LwNv7pU3ko9ZF/cuwfYOG/1d9E8=; b=I
 WhbAb5DWETVerFozMfgvlVrMkxSZ140Ch21A4/so8EP8cSzVTyrZOphnCGp1xKwE5ZxGIdq5HpYVK
 5sQfnSB4T4R6Dim6ss2Pr6Fdx/K/5GCbjl/hEcIApF98IbS7ucxSYnbkVD3J2iI4BpOwWtxA3eDVX
 ridVLqRIo6OZ0uCA=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15cm-0002Sj-D2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:16:48 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso5075615a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788196602; cv=none;
 d=google.com; s=arc-20260327;
 b=TuYRPuyBJ3sXJNHVGI39U54caXQBIBlesQ4VNSwJAMRUJ9dcmhRVbyRmFidCGOJQ3U
 11mMnBeY8yzGpibipf9M3xi8+/kENYapmVyFJyW9mCNDAGR7ZzoVygKxWiUE/ouE5pw9
 2T/hsKbgD6PeuNp6+R1sAezV52LwTvKvFYttDkO/5A7hmxrY7mpGHGVj2z0HB2i0Vrtl
 kLGDbb3s7cwITwcRLzg2iTuaUOjPC3Y9jpjoQ1E9ODQN+c95bN6/EnPoTZ13NUl+e+yf
 rFoIE5jKoGmZyV0ICTlRmKy5XOx7u6IulhVpD1VxOo+gEej0t1VJzTzXeDey8mrA5lZ5
 KYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=BawYS+YToQeTJe78LwNv7pU3ko9ZF/cuwfYOG/1d9E8=;
 fh=VuKasonysUlrzBqN1m+Uwp6MGXQbTFgxS8WCuR8ZZ+o=;
 b=glIojBmYb58pRh4vmklIyPoLf1qvpZ+75U2+1hHcYmJmlaq6vGaXu4jA4Dg49pMQno
 DUYIFXKFu6sh93QM7te2nKMD2FnOBigaxK4bHZyEFD34oz/TZ/lSXfH6BM2Id7umqBDU
 VIycrD8Oc3tkUM68GMUKptcWSUsDT9B2F4gIJcTHDuj91zjuLLgCojD4CZom4+6jcQvU
 uLiawM++2k4MMMclZgt3Dt+00io0HAEnDZUQDKFn5et5MMMNsLZlmxumisoNqT94zuAf
 OKKnWDs5OscrPh4dBBqAwSGikQBLT5f7/K+1uR9H/jdgyb1gAiUHpBSt2gq5Xnl+ULJ6
 ZRJA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788196602; x=1788801402; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BawYS+YToQeTJe78LwNv7pU3ko9ZF/cuwfYOG/1d9E8=;
 b=aorGeE+xyYUkOOom7XqbElVzdv9VdpKlhvKOrj/rngCiG8/oWC66UmnYg68EmDQGI1
 vlumqegGanEz10jGCKtxaA5vv2PstWPsILDHnwNgi5dPRpBLoYMZhyq2x9UtlBBXY7ZS
 WfJOjzEsMsmfXRzEX4mmWEj95vOZ3t1eS1yiyh8bsTveV/XRr4lcX50pUkUHw2m88vF9
 AekhORSGafQPrKxi7w1W9WjxfQj/HRT4wKHy/cyq+rxCb99/f8bhmkcVPWtsCXOrYR1E
 EBgAR4ivYJZQsPpkpndNAIph/I8/WsF5qsrCOZ5DFaUU/WrXoPFxha8o7vUJXpEc/eEM
 IYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788196602; x=1788801402;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BawYS+YToQeTJe78LwNv7pU3ko9ZF/cuwfYOG/1d9E8=;
 b=l8r7agE3gCqChBvzhtyFW4tJKHanNleC16f0ieiDs3ewXZta2JVApVIqSZA++CdrWO
 FXJqK8VKi6DejbmP9wQ9/KajPpFG2/WUEVIhiH80UOpvvF/DAa1jpwgsom+1EhYBuWQb
 JwW69FOrbhA3PCY65BPd/odeszWW6EBcWinAOsu1oM8NEMuqDj+ZA+0GoQJs+z57BDHx
 BFkgKcjPEU1qZxE61kOLjQdDfOWMoXIFkHJ//GLKrmcIehQ/tlN5zrYjBKgCKOMt3iEP
 ik58qYQZ3Yx/4fRSn5DRtKKRdXWAmgE1j8th/6ca51RUVzws+fOGefWpKlpImfV6VUI5
 vaUA==
X-Gm-Message-State: AFuF++ktkmhqdmXvYNxdVCxdBN7mhkNXefsfAbQTqJn/1WfpvnK9rEjf
 HawCwEKcZq5Ay9Bi6ojefZ87Jn7azJK/oZEAAa0CdaAfkBE57qgfQxK2dYttvnhFaw7bcdIo/Ds
 RBX6i149OsnBiWzi6bqRo14zLQM26FaYx6StbPkE=
X-Gm-Gg: AYBFou0UsNwF1zmTlUzRMyvmo9k1Tp5JOWiX+EAHIXdReBnhDDtI05U1jM0u1ccDFnB
 CuDSWYmBRRY+O6ZnHHt6vMMSRX7T9Vo8U32VEwX4oGaIU35ZHKoogSymKTZJcf3f2M6h876/Cy/
 mkH0tNX7IlA6VDpcBG14rXSu7lTbFmqAZaE8/ZI7aDmVAlezFY7l7Hq4T3vHmrUc+/aNlHvKk+k
 SAZHpS5jNjFDfcOjIJo9XxojZ54sN9vvXYHi+3x/8Wv1OLUwGcu/C3c5mcu8URh0CKFXmpAFaKI
 5D3pf/laHlSo9uOc5H46M+u4IfbPrt6fS7Ee5qk16aDbbqT7LFhr+HKXbarcbrduHhhuE2XTv2A
 zdw==
X-Received: by 2002:a05:6402:505c:b0:6a5:def7:b872 with SMTP id
 4fb4d7f45d1cf-6a60d36ffffmr14896256a12.9.1788196601644; Mon, 31 Aug 2026
 10:16:41 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:16:40 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:16:40 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:16:40 +0200
X-Gm-Features: AcwNN1XtA5-tnGNDvaK43aUf8AA5pUFIOgzydLBSl0rC4kpzP9uEFI3HIlNEi0g
Message-ID: <CAH=xXfH7TPGt-zKXvJRNTgGDZKa1Xoq_sF3-WGs5kdsQLuYn4g@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15cm-0002Sj-D2
Subject: [f2fs-dev] [PATCH v5 00/11] f2fs: prepare metadata layouts for
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

Changes since v4:
- no code changes
- resend because the v4 transport submitted LF-only body line endings and
  the mailing-list copy still contained hard-wrapped hunk headers
- canonicalize the complete RFC822 message to CRLF before submission; the
  received copy of patch 01/11 will be checked before completing the series

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
