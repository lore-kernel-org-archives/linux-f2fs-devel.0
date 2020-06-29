Return-Path: <SRS0=zfsZ=AK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE90C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2020 06:17:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2366523134;
	Mon, 29 Jun 2020 06:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WAArj9AS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Nb9+9nhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2366523134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jpn6w-0000Tf-Rm; Mon, 29 Jun 2020 06:17:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <SRS0=zG+Q=AK=bugzilla.kernel.org=bugzilla-daemon@kernel.org>)
 id 1jpn6w-0000TZ-60
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 06:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jcWgmxhD4vJ/rdZ5SjyW5mWQXdOjIMRqfHHTsBys0B4=; b=WAArj9ASsFz1OYR9kiCw6uCL3R
 Tq1IZWR7YvHWNV1qmEftzxN1nqkKwcAwznTHrXXA2v+igrgAvecBWdcrOd88R25vfvBm3ukEvcVl7
 Cfj34TeLNrYK9v3+c1TE0qnv5YsqRpTPCFFRgahn6X6TvXQuaxPB+RHaM4XyXULwEczw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jcWgmxhD4vJ/rdZ5SjyW5mWQXdOjIMRqfHHTsBys0B4=; b=Nb9+9nhUFnscO5Yh0+5DMHgAtX
 agpkPGFo46wqOLYsQQvEzqPqV1Nqrt8ZYyaktN0d2xsO/zwFQs6oTWcUcjqObQ0HV8hF8bKNiVA96
 eSUhMXSjQ01bqB2ajSTS6YPJaNmrK8vmqpqQU+5TvT0BFLRYaDSogZBbyWlOHEWXo+1o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jpn6t-004ZEL-0a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 06:17:46 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 29 Jun 2020 06:17:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zKqri0@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208325-202145-wQGCCxe9Df@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208325-202145@https.bugzilla.kernel.org/>
References: <bug-208325-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1jpn6t-004ZEL-0a
Subject: [f2fs-dev] [Bug 208325] f2fs inconsistent node block
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

https://bugzilla.kernel.org/show_bug.cgi?id=208325

--- Comment #2 from zKqri0@gmail.com ---
(In reply to Chao Yu from comment #1)
> Hi, thanks for the report.
> 
> What's you mkfs/mount option?
> 
> I've no idea whether this is a f2fs bug or not, as you said device can be
> trusted, so almostly it should be a software bug.
> 
> One case I can image could be that apps bypassing filesystem to write data
> via LBA directly, then data can be corrupted.
> 
> If possible, could you please help to add below three patches to recompile
> the kernel
> 
> https://lore.kernel.org/linux-f2fs-devel/20200628122940.29665-1-
> yuchao0@huawei.com/T/#t
> 
> [f2fs-dev] [PATCH 1/3] f2fs: fix wrong return value of f2fs_bmap_compress()
> [f2fs-dev] [PATCH 2/3] f2fs: support to trace f2fs_bmap()
> [f2fs-dev] [PATCH 3/3] f2fs: support to trace f2fs_fiemap()
> 
> Then, use below commands to see whether there is apps are lookuping LBA:
> 
> echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_bmap/enable
> echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_fiemap/enable
> cat /sys/kernel/debug/tracing/trace_pipe |grep f2fs

Mount options are "/dev/sda2 on / type f2fs
(rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,fsync_mode=posix)".

I patched my laptop's kernel with those patches but I don't see anything in
"trace_pipe" while I'm getting invalid argument errors. Also I noticed that the
"nid" and "node_footer" are the same always in the error so its only one node
block that's messed up. 

Maybe a raw copy of that node block will help find what caused it ?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
