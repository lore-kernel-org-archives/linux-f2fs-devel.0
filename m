Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B943CAC5B1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Sep 2025 03:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GiL3R1hCl5chVLmQGWduFieYJcnshX/3xN4G5eS2GI=; b=FSKK5J3/6IXCZWC/FzYj76lWBL
	mKFFAFvJ/XGZ9PS0Wvh/8YyiFsfsfygeWu81pcszSHEkhm96hJh3d/UVFqBYm8nWOkeybC9HChCZ+
	7lRxh4qqabXkDFV0t1Agg+fCqSnx30Ogx6f5L4P4wbzegnjsW5QDdx4X6NN1L+QS/D1A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v1coH-0001Zu-LJ;
	Thu, 25 Sep 2025 03:38:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1v1coG-0001Zn-4W
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Sep 2025 03:38:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m0ngQBEKRAnBOe5IXQWtcZTMjUgiwDRSdQSMUChfbzk=; b=R9CeriNihagwkKOTSIV5BoQDvl
 jyvZzS0Hsyq9CYhAcVc6X1gm5medkpXXB/a1K1FQ80MiA7ioJ+FWACQFylvYyB/NPcLKdLyRXuhZl
 q+EweHJ1zGvOC/9tid0T7rm9/G1aSRRqo7ExHxHJjwk5lf8iENo8fdiTIBXRFpEc4atI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m0ngQBEKRAnBOe5IXQWtcZTMjUgiwDRSdQSMUChfbzk=; b=OmXZgcG8pJ+Y5oWRQt8f1kQb4o
 f1Vqma/gbbu/GLXmjXBPU/8dvHqDXijQwfj3f56AD+XyQ02Qkm60hqwm8D23+Z5jJd8RJZxrJhUj4
 D65LsT9hXYAMZPWej1lVhrqqwS0yAnIOJXN/Z/P2xq9n7cmcQa+ZlnJxJXXKNHKTzlF4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v1coF-00063W-Jf for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Sep 2025 03:38:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EB33A60378
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 Sep 2025 03:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FEB7C4CEF0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 Sep 2025 03:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758771488;
 bh=Fz4uvlQjIrYXRQxllfweAo4YqGKakfdQvU0kkaKPwJs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ILUW/NUo2Vd/lAnJnikQUUOmoGcIzep0N5pMRz9YtP6yPCPfo6w15lx4RYHPATKmS
 bMednfYthP4ZdT0IlXCYYwLPESg0TPcGs7zXW6cxKRV2CPbZ/PnAhwMwpXpgPvBPXn
 xnqmTnOhjc2IoVb6NxPNZqBoUYALR3ApSe9ffpn5aC7oHqBF8WKgMPjTTHsp77dEG4
 s1rYJ4TPKqDL4E4//sb2TCSOkeI99aZtQDNQH58DPSoUsFj2muU5yzciVHmPMDQyjv
 5fG4Xm3dWGPKii6Ox0kmBJhIMG/10agnmIuWZ8/r/ZtltFFpvH/tvKo3idpOB6bxGa
 xxoaCCWqH1Ijw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8B761C41612; Thu, 25 Sep 2025 03:38:08 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 25 Sep 2025 03:38:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: JY.Ho@mediatek.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220575-202145-Jwh4FCf4HX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220575-202145@https.bugzilla.kernel.org/>
References: <bug-220575-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1v1coF-00063W-Jf
Subject: [f2fs-dev] [Bug 220575] Unable to handle kernel NULL pointer
 dereference at virtual address 0000000000000000
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

https://bugzilla.kernel.org/show_bug.cgi?id=220575

--- Comment #8 from JY (JY.Ho@mediatek.com) ---
OK, I will try it.

At the last experiment, I used the newly added '_private' to record non-null
value and dump it when fscrypt_is_bounce_page(page) is true.

+               pr_crit("bounced_page:0xpx, pp:0x%px,
fscrypt_pagecache_page(page):0x%px\n", page, page->_private,
fscrypt_pagecache_page(page));

The result is :
bounced_page:0xfffffffe82282290, pp:0x0000000000000000,
fscrypt_pagecache_page(page):0x0000000000000000
(pp is page->_private)

I think the 'pp:0x0000000000000000' proves this page is not a bounce_page. Am I
misunderstanding? :(

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
