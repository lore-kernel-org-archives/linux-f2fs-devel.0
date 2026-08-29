Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DBBC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bT0cDZiyPLD3ZzJdDs7zqvPZkq8gIxqai7fJdwykha4=; b=UEvBvHCgCDYJwRTrB8OF3JSwT9
	ADX98sYkR4NPmv5qc300GmkLR+iAQ8blNuCJqko/UwElUzhB8h6k/oKFWQIGn3Mlpj/EdpjaK8jJu
	5rsagWxy4TSCQuLQclAjudhjnk492n7eUuibxJsMVWMyS2wST8mOuFIwyuQuZf3EC8hU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0NB3-0003VY-CW;
	Sat, 29 Aug 2026 17:49:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0NB2-0003VS-TB
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zjeV7NCdLgAGDWJtitErfI8jcGCQ5aP6bLcxQ2n9l7s=; b=D5D8uLSLqsngIs4hAuYVA2yQ2h
 n+5dfboiNMzS9jXM9kwIb5pjv13/xmtEAIsirSmAlMWEyUxYHTJiZevg0M60xDXAo8xclEQTDOuyi
 EBSRGacFejGH+tFMiJQH/X/45oHlEvzlHwEoIvSfjmViNCya9h4PbqH2qL9Ck6zn8mIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zjeV7NCdLgAGDWJtitErfI8jcGCQ5aP6bLcxQ2n9l7s=; b=X
 wzu87LzhFH248QoA/nNXPlbJ97F0pbS/IezwjopnXnOB7Rsx2iLeVzgeaprU2OGg1iE7CUqxyXrMx
 4EkfWznh0V0IpqNENkB3LOVoUJesoJYdsREpwOnlbjDGMSSuwIFKB3YiBxL8uGCYyUFW1ptUDYosR
 cofp4AlSjYTAl+vE=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0NAz-0005vJ-IU for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:49:10 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a6143cca69so2876506a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 10:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788025743; cv=none;
 d=google.com; s=arc-20260327;
 b=UcuSCYeuuVtC9OYIxp4E4VLjJT6Tt4BhDtR6Vs+DKdD8sEZv501vYx4mNKi8kKPyot
 RoldSrWPI4Gh2tJy2rEbzhFzJZ33eT083MnqmBEWuyNDCOkmDmRfGz98cYLif7MncP1H
 lLK72DQ0/ZDowT062eB8eXHnJSlhUX48psE/oFDTZhN/ZkFRnBGJKn7uh21iLvv1mY2N
 4fza/M+d0cqIXao+0Cu2vMgVKOmg8akYNaJilVNJcbynlNhYxDBKkGm94uEW1mpwbkUP
 SvIvO60bF6MrzyqJs3cwO/PLSqtCACSczGc4kWf+Z9p1SnCU8eU0xLecc7E5FKaiNQqj
 xeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=zjeV7NCdLgAGDWJtitErfI8jcGCQ5aP6bLcxQ2n9l7s=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=XH6txgNJWm25MBe1S3AFLcZHQ4WTCb4UV3H647KMm7Z6LTnbDpRW6dsLNmtRzClHxh
 DFDUzpjuGVOIBTKfoB02LumET/Pu3EGQmDjiToFzXxzcSwwgzRQqX4e7tY6RXbnIq+pu
 8DClpSLynDaf8TWen0fSmzRuR4DPztCo+i/N+4SnV0uNaWf6Ap+vOUyanX6YJQGuLt4v
 /Q9/Zg5f6Zsj/qRi8irykt++GduRnL6hm8DoQblEdaXP+YvId5bSUOvYHm0GldktezEf
 vlv+nL+baz59K0R5+7BROHL45xxLYAMqbZLkXn2j7MvZySZPDjFRXqWFuwzQ36/5YT1d
 tc0w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788025743; x=1788630543; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjeV7NCdLgAGDWJtitErfI8jcGCQ5aP6bLcxQ2n9l7s=;
 b=EYk/UthRIHVo/9vEz/K+Z02H6L7v0yjbqmZiv2TQ3R93JkAQMy4+G32cqdVzJvVjXa
 j+uPKgeLzxDPbt5WCk2rvtjdbzKIUg6JlAPfXDDqIXBiFLcEbCrc6no5fxVpNo8iLR2R
 USHQR8Hol7+ja6xQl337Chd1RtOzk0/YN8SvPbn7LtGgtXHzUA8xQpfFbn5toPJWDpVF
 K1lGUAMKYefVoEd8Q1irCzTZt7GB4/rJLofcHgiuj9yjZLOIu2c06OvT1xK/5ZOJJ222
 7MuajbsqME7a+2VtyQpBl3uKsRsqIh/7/jz1m3HLdx0SGCaQ9NhhQcpwGPMuLnouDbsi
 l/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788025743; x=1788630543;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zjeV7NCdLgAGDWJtitErfI8jcGCQ5aP6bLcxQ2n9l7s=;
 b=BucXQG4UbAMQvDdo0br+StqhyEoaVBkV4e1NoeuhdvmDde0cu2vW0jMxk9OyT4JoLe
 MuZa2vy4IM9KP88SHS0T3Jp2TxF4xzR3ENOAeWQE/yYY1WnaDJVBNvHsdz4/RLfwJRHD
 IPq2prq378lsLxrPvzwNzbrUvZlJ1eNLW0Vz5WL1+fRlMdcqqRr1s1Jyd/Vb8kxIApBy
 y5BD9+y4SqrYqMwjKOLa8XcHLFAWSH70uV+R/ZNzSiz76bc4GQ/r6ZWtNOT4L04ITRhM
 m3U0QfP7H+8dRxXGMPci50CPE2l53g+f51iL207dS4ZZzNPdC73Wqaj7+bnODrjn3tTh
 bdIg==
X-Gm-Message-State: AFuF++lXMyt3xp7jXgDu2n+dTlECI2N3Tvsb/Mjvjpo51T6XvIYTetj6
 rdyYXeZZ1nFTmRTToixhcg9EFmbwwYy8sG9cD569tepDVDNFprVbg26HX0n6BolY5H/xRXCtG3T
 DMzrFCez2ppwMOMM60n87+28vSRsgpKrYZnP0
X-Gm-Gg: AYBFou0LeqKUFns9f2jrqgSLC+jcxnOxPKk4F5iZqkcC/8TygzThVVfUAi8gxK2TeMS
 KGd1mrJqyJyPTpTckI2aC5xdrD/7cv5GtfDdC6n0zNC6w0zi7NtXpfv1SFQC+JK7bx7U6Th7KR4
 6oli4y4tARzeMJUpzZq5gNHSB+dEMGQhM8tI7GphoGceQBs+4jn+XGuiPMHR7/EKspWv8R9c6gg
 8s/r9p1HsWayj0WIsuvR4A40d8LfQz7GceBWBxN+9kSl4+VicF2NY3egwoAyB3dZK0pPh74iuIN
 hKygyRpiVgeE2v0kG1sC3J8UDQ7zFKyoRHS7TnFx3YOffcGmERsYZ/eF7eSOn6UiFHtmIkFhVmd
 unEu1zAb6gXxQ
X-Received: by 2002:a05:6402:c2d4:b0:6a6:d40:6d16 with SMTP id
 4fb4d7f45d1cf-6a60d406e0amr8037773a12.6.1788025742752; Sat, 29 Aug 2026
 10:49:02 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:01 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:01 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
Date: Sat, 29 Aug 2026 10:49:01 -0700
X-Gm-Features: AcwNN1UxYcFtMsRCZ2QxoFaPr_61cYZppUzVUR8sFKE168lb2ME5_XzR8EnEYfY
Message-ID: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0NAz-0005vJ-IU
Subject: [f2fs-dev] [PATCH v2 00/11] f2fs: prepare metadata layouts for
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

Changes since v1:
- rebase onto f2fs/dev at c966d29e01bb
- drop the unrelated free-NID underflow fix from this series
- split the preparatory changes into 11 focused patches
- initialize sb_info earlier and describe the xattr layout explicitly
- separate sector, byte/block, and block-size macro parameterization
- update commit messages and address checkpatch warnings

v1: https://lore.kernel.org/linux-f2fs-devel/CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com/

Tested with:
- x86_64 F2FS build at every patch
- arm64 16KB-page F2FS build at the series tip
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
