Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD0AC04FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 May 2024 11:41:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s6qXC-00083V-6R;
	Tue, 14 May 2024 11:41:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s6qXA-00083O-NU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 May 2024 11:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b667kvnAKy5M6S1a/8l2BlP/ChRZ58gukBAXN6cWENI=; b=QzCW0CaUv2yN5qmLS8XhEaHxex
 2GvGd0l5i+38hdg+PUjBA2THbs+bBhG3eVcfAJR9cqxDbboIXoZWsXxwVHKD82uj+zMITj/YhfiMR
 Fc+2Hkn80LGZKv2P8YnKxpQAbR3cL/k7jOZnVuecf/hPBzobkPJgrJSykTmXnnEclYFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b667kvnAKy5M6S1a/8l2BlP/ChRZ58gukBAXN6cWENI=; b=LtgMHNDephfa1oD4UAmhJg7oDh
 Ll5SnR7RXO7ypP2jT4I4L65yvz0d8oQ3rXr0P670MnEzFTbpssNj/1kOCnjY8PdjqtPBYgV2CpN+8
 VzvuOL4zDW8B+7MeS0+tPY98W8MZ0vIzAnbYSXo/999ksWgcrsbtaWLbcgZWAbMxfKfY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s6qXA-0004Jq-Ad for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 May 2024 11:41:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3471860B3C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 May 2024 11:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 070D7C2BD10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 May 2024 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715686882;
 bh=b667kvnAKy5M6S1a/8l2BlP/ChRZ58gukBAXN6cWENI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=iy1OE49GKYlAL37MeoiNk2pCE0jkTrwSLyVh8uSHjizu0126AurKT3xURrVC8JpIF
 bTO3cYMovEoBTeeXwQycbOyKfFa3N1rX1W6i6jGzzD5SdntZmhX3Ulv5TOrPKT4iIo
 dVJwQUHw6tLflly8TWyFdpUH2Em8NHWeMplQLmHEejh7Q/4aY1tDTbglBpzR/SMuoX
 TeKF3kIWpbUCvXSnG7C+5oOViS3PkLtZk0zeWVCKHIJO9aFJ3HRl0P2ufMvHyA/qLX
 ip6zZpzRfR7QI48pvpsf94Mo7q4CGnYhWE64G95gEGQWXosXbUSjvVZHqYm8nwKCH+
 0miiqdoasm7bg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id EC7D6C53B74; Tue, 14 May 2024 11:41:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 14 May 2024 11:41:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218770-202145-RJ5Urk05Je@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s6qXA-0004Jq-Ad
Subject: [f2fs-dev] [Bug 218770] fsck seems unable to solve corruption
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

https://bugzilla.kernel.org/show_bug.cgi?id=218770

--- Comment #8 from Guido (guido.iodice@gmail.com) ---
The problem persists in the released version of kernel 6.9

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
