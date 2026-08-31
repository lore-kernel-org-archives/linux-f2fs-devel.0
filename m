Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D907AC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CohoLc8rOqoN6PLi+c3Tl55PQ2O69HXaM0UxzJuJMhk=; b=N3KnrTayQQS21xx9CV7EpB3sYZ
	d4vBVw4XIENUP5vELE1hdlijfq1jsR+BHvRu0HSUJVg7+T7BxmdPS1IBesDyirWHEu0i41rTLWs77
	WrfpF+4Ey7wqOVixQf0Gul513FgKAekbQ2XXbXt3vJkx5/i9GOHPpszyFoJA2ypzO18s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15NH-0004WG-1k;
	Mon, 31 Aug 2026 17:00:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15NF-0004W7-KF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:00:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E8GNPZNfb7DfVRA5Y4zrLXAJh8rcaabLYwavFKkKh3M=; b=L9KFUeCoWPQGILrdJLIvtPverv
 cZbUwZxbf5Erv4NA7bq5i9EcxVrKnMBR4y2EYjlPg1vXx7CljRmdzNDddupu43riwLKvFyySM3WY3
 JOaDRCBheR6LGfYJZLpZYqogqxl7+Emm5fUGJGkxZxuZk60/rGEe12cpYLkDWoNloFKE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E8GNPZNfb7DfVRA5Y4zrLXAJh8rcaabLYwavFKkKh3M=; b=J
 L5EnhDB8LFgOyb5rdugozcBQ5WP6lGavWEq+ZNmzUqNpfC2P0OlxgJe2Jdd0DxyeQ9l1PTOsKGFS9
 C6V3531SsqaD0vmYygB7JUgr++C30W1qHwp6pQyrm8j2jpmglird1ZcNwTNcAZUDyRDCmoBq3Rp8Y
 e3CU5EyfZ3XTq7jE=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15NA-0001Lr-6i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:00:43 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a6108734d5so5503131a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195634; cv=none;
 d=google.com; s=arc-20260327;
 b=bK/B9QLHit3C1sm/ctb68atI95fUngYvULBgqZYn/q89PP8M7L9tc65ZuyctmrLNCC
 Y0jRkEVp0CD2HnheS+K55e7zB0wS0WEFhDvV3lgTqKaKhEz2iu37h2OmPzuZvGWGnVgR
 hUmuEdGqyhf//8LNgRCiiF6FmlwHcCvWmjLfmScNZyc2Z3IDwi8P4hb8fJy0bOeeAHsr
 eA8IbPe3DwRi9rv4uvrYqa+fV+anSTCbmjY3fHk+caR3qsSGaP1zKLzRPSZk2j1HH+bE
 A0geJghcyRxHDRSgGgtHVgl6CG7Tw3sZ8lT5uNLd9dUnyNo/BxqYOJmLeHeYElLaCH+c
 yDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=E8GNPZNfb7DfVRA5Y4zrLXAJh8rcaabLYwavFKkKh3M=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=RxiS3ydWa2XGZfjwU4m+t3C5yCYq+e3NVsr9BOkTfWI28NXV8r1Y91M45psxM491PO
 lnkxU/tSNeAYfW1DcQrnfW+wsr9sn08FTr9lHo8paq3uSJsDYSZgBk0C8m7BnQGo7N3A
 93Bz19AoTAl4P/maybpK+qOGHNlhatrXVD7oThjq5p2fgse2Dr39DfKbNaisab2xP3WT
 Nt+UhzxgiiHyBbOg4TnS8CzezR/bIjI1L95JUZ4s04BdZR4EeDyqoTScNw/Sk1iCjEwl
 OrnwVrDTppJTfUEhaw9Fm775zwMC5BuNy+8PWNxmAE/GmuXJIRaHfZvDY2ly9nY77K4l
 YxsQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195634; x=1788800434; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E8GNPZNfb7DfVRA5Y4zrLXAJh8rcaabLYwavFKkKh3M=;
 b=cygdFbkDiMRQtpyCZVQK5oLteWGkjVjQroPtXQ90TYOeCNV0FeldrBwVP2cnLGcsh1
 IRPVD82vkzJtDhJJfG82QcDot4bsfiBfALPLSW7NFe++ulH8iq+nytqLmIygpd+mZWHa
 mjlEzhudTzfWXkA0pRrdfX5eowJ9SWQsuoL5OfeDFCeM96BOiazeUTnGvgZOd6gZ8haa
 L+MN3IpQ5CtJBk0Y+awVZNNzXCaXe7lKV+hO3tGDUq2ctO8XBO9rlG0yWJkjMJoGBf96
 3oHh+CxqbdTV7oG/lJ1CWXpmd4O5VkxhSRgV1hB3H8aWPIOwjVQ4wPrxN2g/5fYq5X8N
 DbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195634; x=1788800434;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E8GNPZNfb7DfVRA5Y4zrLXAJh8rcaabLYwavFKkKh3M=;
 b=F6BYMvZZ3USf5xQKBrmCVgKE1dY6aHGRStU08BXxM/xsGWemWBi+UdV9i9j2d31OKi
 QmYgOJdLF+gqpvueYYTjO95bNt8upaePdAOlb/ZaN+q6tDAYghJxNTzIEuV5u6OV9ZjG
 uyChU0QKYBZOmJ43QlRqkf9SNgVOM8jcY6F0vNG1N6seMcfiJxKvuLhEUVM3LG06G+qk
 394K61S+b5oKeLLvqmgKdlCuCt+ujbVT3j9rxVQqFtY3db2JRxIOIdvpoLqsgx38QIqy
 4ddhnwHh59+DNb/FeY0hSl5Z/hR8ExcKnuhw1jYJvBi78B29k1c3VqRlg1x/jRKYJHDD
 FyRA==
X-Gm-Message-State: AFuF++l5da8jnL7JsAojLfsDzk7OSQ2jrdcAxDsL9l27Me0QvkLrqZoV
 nHsYNNYFOHiNkOQwFAk66cPqFHzWtIIQA3wWyAOr2xvp4Ih5ewrqzArGXsHwjL9hdWjXJbYL2YS
 sFXE+QI3SWJH7sI1XcXh+63oaGtLHxQWszC49KMY=
X-Gm-Gg: AYBFou1hPdjRQQreWhCa5qzkfU9GgtFyFIiMu4fgBIBEqMqqXVnJ1ItJ4eIqk7RpnNb
 aJHfynDqW+xTxLxkVfC4TT2ERluq7ov4rWHq1AuIDAC1j/6OYiY/z/fNJ53QXpDpW/f+pCJVJzY
 rD0cQ+wH1v+C9NeMy8C4Ev5aej+HMTK7/kvXa+aM66KBdS/yfRforoNeUTQLVIUijEv/0u5dxBL
 frxrVkRcT+ET6ZC/RLLwI+u1X9kA3yg+xg3GcLGgR7foyNFIBgYR44lTbibQmQQD+nXeKKlv20B
 kG0qtdbY+pRnFvlNjVkj5VhyO2TkMFiwmWfsjz+mTT846jEJbTnyR4IATNqsfw0XNGDvMNHh1pw
 tQME=
X-Received: by 2002:a05:6402:454d:b0:6a1:b0b:ba6 with SMTP id
 4fb4d7f45d1cf-6a663acea3bmr1478385a12.15.1788195633057; Mon, 31 Aug 2026
 10:00:33 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:00:32 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:00:32 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:00:32 +0200
X-Gm-Features: AcwNN1UFAGEwWCwWZWpiOlmQtnMZ_PTDICLYCNR1LpT8T-x7XvvfaJMNhxScSik
Message-ID: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15NA-0001Lr-6i
Subject: [f2fs-dev] [PATCH v4 00/11] f2fs: prepare metadata layouts for
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
