Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6AFEB64D9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jul 2023 17:16:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qIuUZ-000440-OK;
	Mon, 10 Jul 2023 17:16:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1qIuUY-00043u-Cf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jul 2023 17:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vv3Er/mOxe3omVlohm3XaMOWNn7c0ak63S+3EfatYUU=; b=Rm9F3EW7ox0lEzSmiTc3S2ifO4
 MVHkTIxHFaHXvUgiyVyJl0hmTUHYqa5gyPYhhOCwcbpjglewIJ3HBdC9Z59eGWEiyof6/22hU+7dr
 D+0nCtEr8pU6ywymCDE2PihBE6TNT5/KQWwu5otjrGCXBoLcUlzXo+VJDzxKQtL5EVk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vv3Er/mOxe3omVlohm3XaMOWNn7c0ak63S+3EfatYUU=; b=D1QM83QlO9CRntWCBAHX3bwLbL
 Wl1G7KAr8mRze2cypy+pUCDnl/9uPGP3F9XDMemGoBpragVq2jJOOziqDETdoNzXDrCUzJ+ZoSiTJ
 MS89ZfiKAFpS4DL661unF30Lvx60jpQydecmi8C5kZBqgmeaxUe14BsLFK9KH5B0Y3cw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qIuUY-003Wav-O8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jul 2023 17:16:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 879D56113B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Jul 2023 17:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE38C43395
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Jul 2023 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689009359;
 bh=vv3Er/mOxe3omVlohm3XaMOWNn7c0ak63S+3EfatYUU=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=up/VIe/40lljWbgpnIlRf/TfaefNON3NZBRBtS0bXro0/ZWfqLfenn0cz8q8x+uq4
 wnGcZ64eWLqI+BqjLLDA+Dma4oDVhPhIMfs5s2V5ssRTFuSrBl0KSN1zeeLrQBO5pA
 WZwr0DZ8lt9NIMLNaaElJQvvkxWKSIJ+JigXoTjwPMOi2eaplnCkvQjHh6+OTtsMd2
 CRPaNYwihglX5Zy5kxPLgI8AB/HABZwlQ7I+LHZGrvfx615UicQEE6GPgCiBqUGspk
 UhgMFowbHvBz6BnEGy22659uL4mbAXUsNsH9qPfrq2PM3rTWO8KDhfpaI3WAJVIFSA
 rSREi6vzoPbuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9D64EC53BCD; Mon, 10 Jul 2023 17:15:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 10 Jul 2023 17:15:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-eaHQi6IFtq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1qIuUY-003Wav-O8
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

--- Comment #174 from Jaegeuk Kim (jaegeuk@kernel.org) ---
Thank you for the reports.

I still suspect something happening in page cache tho, as a safeguard, let me
try to apply [1] to -next and -stable branches.

[1]
https://github.com/jaegeuk/f2fs/commit/400dc2a4d7ec96a1fc4168652a0862e7edab3671

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
