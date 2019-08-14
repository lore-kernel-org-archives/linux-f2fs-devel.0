Return-Path: <SRS0=U0XC=WK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CDC32753
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:15:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E9C2133F;
	Wed, 14 Aug 2019 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PhKEIdMU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Ef75vbEk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cieztrNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E9C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hxu3k-0000sg-Ee; Wed, 14 Aug 2019 14:15:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hxu3j-0000sU-90
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Aug 2019 14:15:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0NFmLcgDO1gDFN9df2j062MJdjVty2Ma9cSLuV1bLQ8=; b=PhKEIdMUY+41RLgOC5mIBveABN
 jlzIAMp8XEQyNQvtGYJCc98f/TR5pfeJ2AuigsxJmOH9kQMsE9kz3aB80ByF7JXKzN8hdm9M2E91W
 32kJLxzeFCG4P+tx3cmp3vko5DZdCLE6BPofLXAvIqHV/IBxk+UnsEw6rtsBonzNaBAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0NFmLcgDO1gDFN9df2j062MJdjVty2Ma9cSLuV1bLQ8=; b=E
 f75vbEkDzOzQHHFSPZAsktNeuS7WheiX15Fip/N3oRDIkrdzJucz1STmjQmuP/K7/uIt2QQLTEH7L
 lPLHk5U9YdXC2lCQwolyiOSetLsUlr4VFR/qb9kuxzgVy9l8ywnNtW3/KBxlZxRsb/vg+DvpsYZxL
 UUoBj09cpjyJkqEU=;
Received: from mail-vs1-f54.google.com ([209.85.217.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hxu3i-005ylQ-2I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Aug 2019 14:15:27 +0000
Received: by mail-vs1-f54.google.com with SMTP id i7so8218491vsp.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Aug 2019 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=0NFmLcgDO1gDFN9df2j062MJdjVty2Ma9cSLuV1bLQ8=;
 b=cieztrNnY9MaOLBvaTgMtpkOmNrmsytFhJnM40dt4vdsw/YRfVSMwiLkbeDP888Wr3
 +9xLKQJedFBluqICNxOM4nBq0ZSv+JbrAhlLCHfLOxuZp78ynr++XIBB9q4w1YopewZC
 WQ27uyz75Eqc4ZWSzTvYcYzDK2pmdC07fSN7FIUnfa/qxi0DjA5SMeNzpASp0qa+4MQ/
 K5SxiLaHXxIEgJK18t5FHdPfcIzJQRaO9fSCd1f5tEZEeLrAeh3hx60Mfcw8Me+qB3dx
 VohHBVan4o5NxExX3dwPA5FlbAENMJh1bEZ0Bn/OTZAYcev4wnevZmzILZaeUih0Deh8
 XU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0NFmLcgDO1gDFN9df2j062MJdjVty2Ma9cSLuV1bLQ8=;
 b=OV+50PytXzaXBTtAkGbzNuAXhfJVrtrKQ+onZvtIjFs+wbg3dwd1rQdBzflPS819Z7
 pOBSmzHt4mCgySVFc6QkD36JXS6+HV6/a4Avnb8JJjnTlEwGYfz1Z/wWgmDrzJZ9Zk/v
 JtYhoSBwZs+BhHuO4y25KDD2/z0dejk2DGyeFAJCyNiQEVAsvfs7iskIUnpuKtAPav9I
 pCE9Cb0ra+3cvrE65WO9XY/O9EMwdGN8TFB8aZq+VvKeffwtvUJPyHWy+Y40hAxym3ZM
 0bnixnf7rGc7uv5joELIu+L42SeEouWVkrYkH4RUvLsyccxf7/nxJ8UfZTBm6nbYfKWX
 xumg==
X-Gm-Message-State: APjAAAXvjQTKAY7IibE0JJMUC+Hwxhu9uPTL0jCJ0jDaZV4KuqwWwjuK
 LeVZXl3EArv5NjJfVZ7Y/8o5IEBRScxBCy2U4RjH71OT
X-Google-Smtp-Source: APXvYqxB5sa4X+WHz4gzIiEgXvts9QvztrdSvBx+aPzNv4k6OVMdDwlmnWkWRr+rtJIs9e62RjkA3+AT32pWGNj7HWo=
X-Received: by 2002:a67:80c8:: with SMTP id
 b191mr31212339vsd.113.1565792119645; 
 Wed, 14 Aug 2019 07:15:19 -0700 (PDT)
MIME-Version: 1.0
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Wed, 14 Aug 2019 23:15:09 +0900
Message-ID: <CAD14+f1YGinNQuVKc371vgJGJaaqYWqcaP6WwSuP1mwf-D2Tzw@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1hxu3i-005ylQ-2I
Subject: [f2fs-dev] f2fs: dirty memory increasing during gc_urgent
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi.

I'm reporting some strangeness with gc_urgent.

When running gc_urgent, I can see that dirty memory written in
/proc/meminfo continuously getting increased until GC cannot find any
more segments to clean.

I thought FG_GC are flushed.

And after GC ends, if I do `sync` and run gc_urgent again, it easily
runs thousands of times more.

Is this an expected behavior?

I would much prefer gc_urgent cleaning everything up at first run,
without having to sync at the end and running gc_urgent again.

Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
