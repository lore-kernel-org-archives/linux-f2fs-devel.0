Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F7CD29DCC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jan 2026 06:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nahIxhf76VUO9ju+swntrdkZWivM5R6ED5SN1kI1Iio=; b=klGUuWEmSIFe8CTn4+IV3ylnA1
	qMlTf9EPXXKMm9NnhNCDYddXWYKc7I9dxYG4pkJ/9QWQBBP0EOTAfD0rcYLA+n8FfdO9kR7HiZ28O
	n2JFnMimqzr8vI9C6GeawoD78FDR9d625ZcXPn4y/WgLRtgjYfAP87u/g5pVARY3CWfA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vfXVS-00026n-OI;
	Tue, 13 Jan 2026 06:03:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1vfXVQ-00026e-SR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jan 2026 06:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2aLQeYtu+K5EzjSQ6r9+FB2ZQPvK6slHt1xFf5fjUFg=; b=lVuwGI9icIdnAXPtrSHMn7ARoa
 pGeRwmgIuw15FYKeabX1qNc1JmjvEK2012BKP4GKnIWSNc9O2ugYACiYt75YIY8nPPpgmjVPlUAw6
 mT7uQeMUBpGQhvkkH+Q2PMb3e8l62fPzYOcDzWWICcyELesFx/VtO3UmPr3old+PpUGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2aLQeYtu+K5EzjSQ6r9+FB2ZQPvK6slHt1xFf5fjUFg=; b=MNjd4Q9pBs/G/h4pu0mxWAbgNe
 6oSzchZX9dYeG9/Iv4AWbPcW4+gkKCl1XovJb19ZNQ4y9wonpa6ABD+/4f3PjXlLk99Fa29J4x+GC
 EHtbDgWaMrV9wgunXiOrz2X8gWd++9fGeHjHJqjkk9uoJ/9s9Je/T2tdE2GpSJdX2l2Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vfXVQ-0004Bc-B8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jan 2026 06:03:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C207E43C37
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Jan 2026 06:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A076DC116C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Jan 2026 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768284221;
 bh=HmD44rt22X5BawYRkAzvjvdzCTHh8anJkym2ljUW6rg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Q4b9f+WifqLCUDeIp2oFW4b0o6HL+uqkfA/MkzHUaYYEglDw20XMowy+UaHZH9zZR
 XKrV8VVSnSqIE4SB+MdnGGDpsXyZGkgkRe0kbhXYH2LzFQ9qUNPb5EuXIHqVB4WNeK
 F12CCnqLIfUrrvvkjN7Q99iKYHwx1hn5BjHjKuUOss4r/+1vdc+7x4j5acZ9hIYohn
 ipvWG91hBO2tyK4fHlL+artPoBx8UKz8HmfEv13INjLGvZeQWPu049H8VRnM4InfFd
 qhiNM77mtZPt8L5NBZIZWmiMoTiNAY2Ya2kyxLExSXMNqHrQrhD29WbJwzH2QIwnyM
 17dsw52yCR8tg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8D516C3279F; Tue, 13 Jan 2026 06:03:41 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 13 Jan 2026 06:03:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guoxiaolong2008@gmail.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220951-202145-3smS9mBnss@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220951-202145@https.bugzilla.kernel.org/>
References: <bug-220951-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1vfXVQ-0004Bc-B8
Subject: [f2fs-dev] [Bug 220951] swapfile activation bug causes data
 corruption when swapfile < 2MB with fragmented extents
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
From: bugzilla-daemon--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=220951

--- Comment #2 from guoxiaolong2008@gmail.com ---
Hi Chao Yu:
Thanks for your fix, I verified the solution and it does work.

stress-ng-swap-7946    [007] .....   346.972372: f2fs_map_blocks: dev =
(254,47), ino = 16800, file offset = 0, start blkaddr = 0x77d0d, len = 0x1,
flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
  stress-ng-swap-7946    [007] .....   346.972376: f2fs_map_blocks: dev =
(254,47), ino = 16800, file offset = 1, start blkaddr = 0x1f6801, len = 0xff,
flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0

  stress-ng-swap-7946    [007] .....   346.972378: f2fs_map_blocks: dev =
(254,47), ino = 16800, file offset = 0, start blkaddr = 0x77d0d, len = 0x1,
flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
  stress-ng-swap-7946    [007] .....   346.974392: f2fs_map_blocks: dev =
(254,47), ino = 16800, file offset = 0, start blkaddr = 0x1f6a00, len = 0x100,
flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0

The swapfile can be mapped correctly. 

Thanks.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
