Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C86C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6nhM6jCubtTQRdQf7r0+i+nW4GIEjIn5YTYrLWLpczw=; b=bQncr7uIE3SjEfTiZvrV2/485O
	xPRNIbiVsc8GUqzcqJKeLZrEFm/6PUnR963XaM9CQGP18LQD2o7ya6TUEjGBTKfx+MBCJF/ETMnty
	LCZam6DCWproh32M4Cib0zcJLUmPr/x9xIsxH7I/k2S3+UPGd+dfVPtm0LHR/7reTHtM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzLLd-0007Wt-J7;
	Wed, 26 Aug 2026 21:39:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1wzLLB-0007WU-8f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zPpg4/2kYNXlQVEAkyt3FxBQhaPnP8EOgxLGCkf4X/s=; b=gKArYotHSgAo0twngzthdhZ8sY
 IJi04RUvZWp/+Xi10j2ca2EomwmfaeCbC13OvZgsclxiak3Q49toJQCeoKkHvTN0nlkShjr34+BFP
 8+1xKbX14nwuRY/R/K8+vQeXuG7fZyDK3Reds53Djl4pcJRIzjerhp6qURDdttPaXwMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zPpg4/2kYNXlQVEAkyt3FxBQhaPnP8EOgxLGCkf4X/s=; b=T
 DT+VrU646O4nz6tNiT1hA3zwefo+0xNOPRIKY9VwVNhJxWBkmHhjB/0qmxx25UNp9AD3mXIOp7q9K
 odSzaoWJNbCjliUG983wEXW3f6H7FTjP6Z3M5nUE2thRAF31MgUrOY5Qd9N1Y4//wjk5UQLYJ+rG1
 Qy7evg97qDZBs9FE=;
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzLL7-00025K-ES for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:22 +0000
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so2150749a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 14:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787780355; cv=none;
 d=google.com; s=arc-20260327;
 b=gRdEUcHcLqNdi8MUUlx8bvn25PsR1oYwR1GoJSxtT3cVcfBxtaWY7XJv5tSmLmSlaL
 V9tRHSSBe36kWWdBBzmvxyRnwRdG+BK1JoBfNUU6Y6GYFJ74OqVdKx5tw1zMhySvYs6w
 ZcCOVaae6AsLNZLP1A38nOeu+2nOX7meR6sxB7375+N6qpCjkyoPgW5ZKnMifyADbnoi
 Og37Ipy6gUiFigsKHFRuwtAlhjrGrU857O0E89483nuq8EkvEYTlFgsinylr+Bh3qERh
 roJEj+GUaZI92Y1tTX+a8HIUn9TuGlwtIk6Z+d0mT0nwhCKALmFGgOsRniCOj7OBEAGA
 e0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=zPpg4/2kYNXlQVEAkyt3FxBQhaPnP8EOgxLGCkf4X/s=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=awHCS8IPdV9QPvckVxsfVM3Knb6jHcwy2I4l4uCu2Qawu/kfM1YT3myM8I9zglMEWf
 6i+nrTcGG5EXLlmhcUXjwUud24PT+0X/gTJGIJinW1fXPfI2bNvGVXN13w9PvtM3bnNI
 6ozLtatF2hM4Mue/cNiSHiY1lSxPCUebRjNivDFMeFfYi5AzdAtYlWCqHUn7BmNN/gN4
 z9jzHAbkKNnORPRWaZEwCFJBWx5Cy6hRQ99ZfW3yg4GYKLt1oFN6MhevKcqbFCiulBhO
 CReveUz90hkCKb34VUX5bwO4cOGRI6EpfHQwtXFtXNc5i/ekfA62S+Fr+u6Y6d9TwEVU
 3eAg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787780355; x=1788385155; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zPpg4/2kYNXlQVEAkyt3FxBQhaPnP8EOgxLGCkf4X/s=;
 b=mw0ozgfniwMXNed3/GTViBKPBbGhKR4m/Mzh1OaGnDeD690SiBV2ZA33vz5u+wVbXn
 gc7pG+uplOtcsFK/y8RExIB6NNoKBYo5pOOhcBGsYzute7CEhE74FZMV051KjYiKY9fg
 3g2CCbP2Tyho+P1vl5IfC4J3CJxRyPtqusDijT2qEWcVuVDK13HaoP19Q/uM6rRoHK4F
 IaWQLCu7fK9baxrRogw+priutyNB13WinmDV94bqY0Os90NJESMG6VHNedHYhjDuovcR
 lNMbFoBFBYEMioMzDsD1K84OSKXDQN4B1AhZX+fUF/rvGbL2gCMjUN5AyFuPtz/GRenv
 otiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780355; x=1788385155;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zPpg4/2kYNXlQVEAkyt3FxBQhaPnP8EOgxLGCkf4X/s=;
 b=Ug2jBH0TqJX9NonvQnHrlnlzQdjo3CIMwCwJJsz6TPg+0ddspA2JQVHpt7FMRST+Cf
 SrgfesMBEPAzpAR5hXVTVDlQZAarL3PxjseQy+aOei8Bh8Ct5KOVjyEsdupFD+GB9yZC
 L5dF13qwRlfVdtvOTdAHAxSbGb9lape2ZA1kV3e+dsBAVZsvB2u0WsJG9tYEH2UR/uu9
 rcPr7RgGl9Hx+5/ScLKTaTd5aIk0M1cfGMEjrrnApZsBiLHbUNU+c3kd2xd7rK2XGD3u
 hefDLlZbc4ZHhxHhof1IRhCtIzySgGFAd1uS+9cr8QlKEBVbvxs+TNoU+TsS+QYwzphx
 llvw==
X-Gm-Message-State: AFuF++lI5LMed/tbAmNdZCqSWCo+67Z2jNGli456qeN8nuHM0+1/GvKB
 t3J4CBym1mz4XPpHI+6dtFuRjHZtBdFT48VkzvbyLp/28MIv/gYX+4tb4rlyCoWe6y397jfKIkH
 odgB6n7EH07hC/9/1ecb/cgP3tH40uGtsz5aA
X-Gm-Gg: AR+sD11b81JjfLTbxI5T3nhRbkA1JArK46KaqT1OgeJACeRKJCBeeIdRI/w9oPbbtPC
 mN+j5Mq4jNdK1kJbsLJbhshJ1TOMR7EnKVXgJSedxJzY7/WSIqvd5llAi8QIOCoer/bGn1XI6pE
 tHv+rmpfGefc8Opw1gWMgzlrOGGqheGrAIPbAWdsO0Lr24UB5iy/FrmG2945HFD9hbLj8h2iiFS
 xVqG8IIhzTEbmKMS6mLdIOyMEgyd8opQST+8dY7+LFr+v/7JvkuNRmEgaLwowe4pwGbkULDYcpq
 K8EP7UlCF0vKTmker9VeFZz7wKG3bexcMJ7kpVQzAoP7NHTsEX8CUtoGzXENVWzIu9McrIlIgxT
 QCi2gcwbSkMM=
X-Received: by 2002:a05:6402:504d:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6a5df653f67mr3823591a12.11.1787780354691; Wed, 26 Aug 2026
 14:39:14 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:13 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:13 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 16:39:13 -0500
X-Gm-Features: AcwNN1UG9EACUwSLC_kUicrp_uLYav7JIwvDNltpLto-LKkaIlFC2KCRmJHHdV8
Message-ID: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wzLL7-00025K-ES
Subject: [f2fs-dev] [PATCH 0/5] f2fs: prepare metadata layouts for runtime
 block sizes
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

This series fixes a free-NID shrinker underflow and prepares selected
on-disk metadata structures for filesystem blocks whose size can differ
from PAGE_SIZE.

Patch 1 compares the free-NID count with its retention threshold before
subtraction, avoiding unsigned underflow.

Patches 2-5 make the SIT, orphan, dentry, and inode-node layouts describe
their runtime block-size geometry while preserving the current on-disk
format and behavior.

These are preparatory layout-only changes; the runtime geometry conversion
will follow separately.

Kelvin Zhang (5):
  f2fs: avoid underflow when counting free NIDs
  f2fs: describe SIT block layout dynamically
  f2fs: describe orphan block layout dynamically
  f2fs: describe dentry block layout dynamically
  f2fs: describe inode node layout dynamically

 fs/f2fs/checkpoint.c    | 46 +++++++++++-----------
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/dir.c           | 51 +++++++++++++------------
 fs/f2fs/f2fs.h          | 76 +++++++++++++++++++++++++++----------
 fs/f2fs/gc.c            |  2 +-
 fs/f2fs/inline.c        |  5 +--
 fs/f2fs/inode.c         |  5 +--
 fs/f2fs/node.c          |  4 +-
 fs/f2fs/node.h          | 53 ++++++++++++--------------
 fs/f2fs/segment.c       | 15 ++++----
 fs/f2fs/segment.h       | 19 +++++-----
 fs/f2fs/shrinker.c      |  5 ++-
 fs/f2fs/super.c         | 14 ++++++-
 include/linux/f2fs_fs.h | 84 +++++++++++++++++++++++++----------------
 14 files changed, 225 insertions(+), 156 deletions(-)

-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
