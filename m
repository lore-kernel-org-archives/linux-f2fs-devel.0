Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7120C25B08
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Aug 2022 04:54:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oOB4I-0002Zz-7M;
	Wed, 17 Aug 2022 04:54:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oOB4G-0002Zt-KE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Aug 2022 04:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8l3LOn7PGB/CEulnFFuDdoSvomhGkegztvRvDBF9NUE=; b=VM07E/VcZafcpad4HhCZPUhAY3
 5mlYoTCAHrWddZPLiohrdBDWTeeufYC3w37Ga2W2kk5iuzWnSNP3PgGiD1KVH4tro/DrMpTe0+wgA
 IBL2I49NFFwQ6RRt4gW6a5i9qs3dv2Sr4z7geUBD3trbjPNjgZuwkNiB2n887KzwP00o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8l3LOn7PGB/CEulnFFuDdoSvomhGkegztvRvDBF9NUE=; b=GJsS/QxdiwsGzggd3zsxJ9Wt3r
 U9mnjolKv/Fk6AKL9JSTNOwelxvRb77nCcZM7Q46180gcxA6keoji3mGKhYbrBK7pJDr8S+Z0oXT3
 62YZlyUoiuHjLNncZwkAGogFTjiaXt5KIY6B9tKHwmXWEWB8mOO+1DeWgrbqi+TF0GYU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oOB4F-0004aU-3G for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Aug 2022 04:54:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 2F239CE1A9C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Aug 2022 04:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE62C433D7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Aug 2022 04:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660712034;
 bh=8l3LOn7PGB/CEulnFFuDdoSvomhGkegztvRvDBF9NUE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=TmPmLkKahSFREEwZpvOUml+2658OYbglT4fMhSXRzJg2hXt0V3rO0Vyul7QvZJ8gU
 7Hq6+hs3rN2UvMwO+Hxf5CF/oFkIjCmz5nOP+9Cnz04p1bpPEhfNH9A67uSgT3GQ27
 /sffl+kdEwCUPlv86ih2Y3PFQa33zh5IOc9bpQ5pUWmjQsWIuJRpRpF8ijeX3jC3aU
 GT8ZqlFW+2okO9aGnWRL7X7PjbCgUC+n506LFL3nGIjFgsQhOf6ihS6uiZlJQ4tKmR
 1c8/bWgheWmK30nLMYMdAVRFRhB0Mr1WDwySZXqlWMb0t+2835h+SNEEQUhqupK3yi
 CTf3t9tOHKXjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 35A60C433E6; Wed, 17 Aug 2022 04:53:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 17 Aug 2022 04:53:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuriy.garin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-ooGbXkSq3y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oOB4F-0004aU-3G
Subject: [f2fs-dev] [Bug 216050] f2fs_gc occupies 100% cpu
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

https://bugzilla.kernel.org/show_bug.cgi?id=216050

--- Comment #51 from Yuriy Garin (yuriy.garin@gmail.com) ---
Today f2fs_gc got it again just few hours after upgrade to fresh Arch:

Linux xxx 5.19.1-arch2-1 #1 SMP PREEMPT_DYNAMIC Thu, 11 Aug 2022 16:06:13 +0000
x86_64 GNU/Linux

What I have noticed is that I've left few instances of some custom application
with open modified, but unsaved files.

Is it a way to trigger the problem?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
