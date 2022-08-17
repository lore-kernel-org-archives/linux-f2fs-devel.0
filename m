Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEDEC25B08
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Aug 2022 05:08:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oOBI5-000310-Qn;
	Wed, 17 Aug 2022 05:08:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oOBI4-00030u-Ma
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Aug 2022 05:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uf+peP98t+5fo7R395tbNHG5XXaPNPt3JpgWUa3Vjbk=; b=LJ7QVazkIhAbyQPjRhEWijHLmj
 cRTvKb4bQaLfzML/PKjTXTQfA8jCFXVzoQ3LiWgeJwbIAYIMdmv/CLei5Ca4NRY4bk5EzZxxR/cNd
 3Urp81DJwL/LVhUo5vuZ6UyRulc+E9tPRl+bxseUMNco1sIfaRrZbwOXA3a0MaezrTfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Uf+peP98t+5fo7R395tbNHG5XXaPNPt3JpgWUa3Vjbk=; b=Ocr4JlV+FcIPyyNOsEpgOAxqoM
 /B5SYcHYKBVwilV8gIvU7DyuTDKIgptmt9Z97D6A2eP7JnCoEcRgupxm18dl0i5BrmDjzmIFquie+
 MhR8xN6UKdO1aoUEx3EJiHQZmyGE2TWBMipqQsgrdbI3P8xo1SuNmKE8P2ip6x++U3vI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oOBI1-0005vu-BO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Aug 2022 05:08:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBF0614C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Aug 2022 05:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D334C433D7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Aug 2022 05:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660712898;
 bh=Uf+peP98t+5fo7R395tbNHG5XXaPNPt3JpgWUa3Vjbk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=sJOssH/in2eJioLKSUhx0XPYfGq8J+Yenw2DWeQRNR+Xcc+2DxK43CMelzMuimv7E
 rodAdC+79CXVIf4FtKV67voNTkF766SXhgvhxkEiv0XEYs+PlE0Bmuc06ogkdcPNYx
 pIDJivDtyTc6wq2P4DxcNVPSy9QgNYPEMfl9qSVOMgPaXqvzawngIpWm+7gAeBC8Od
 aLGh5KKh6Hxqow9bkT2FmMzLJVfD3Z429DBs7XXhhCLk0ZfstrS9qbRSv0czqy8Ah1
 Vwuim2YKRAO/90u6s60nLNRHbMqgC+fl65bkwqYyk/JzOfrxxCSe4l6xXF5/+DrQtH
 BYv4B9xxaPVGw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6BD6EC433E6; Wed, 17 Aug 2022 05:08:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 17 Aug 2022 05:08:18 +0000
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
Message-ID: <bug-216050-202145-3zfmpTve9c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oOBI1-0005vu-BO
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

--- Comment #52 from Yuriy Garin (yuriy.garin@gmail.com) ---
Please, share your experience - how do you deal with this problem?

I do 'sudo systemctl poweroff', but, it takes hour, so, after waiting for most
services down, I just press power button.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
