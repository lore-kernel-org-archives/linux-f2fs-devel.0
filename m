Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FFDC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 May 2022 10:06:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nsiTP-0005JM-CP; Sun, 22 May 2022 10:06:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nsiTO-0005JG-CX
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 May 2022 10:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Xc5Yo9QRUoVZbk/TNpN1FFhIjy0Afx7e9OtQJPwc+I=; b=HWnLGnkoGDu/zxhiBhXyc33SQN
 1cHWWmadeXr6Gb4PPLLRH7vvoaT8WeVkx6r50nYBZNlO3unhqHcexgqIS1hKmJGfxcHt/FR5OQAWk
 Zky8FEcP2RhAJMf981p68pghJrOBumOZRcJ490ikhjPo9Kf4GN/Gtvrfr0Sc1C0EPD48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7Xc5Yo9QRUoVZbk/TNpN1FFhIjy0Afx7e9OtQJPwc+I=; b=f7J9lmt0dzFRdwc8AaHMDn+GEu
 3jcBtODr0YSA4Y8/oN727n9QXsgVyjjDUYlAoCij92N/R/kUnVMj6MyvR45VBdV0FLuL76mzDcLLe
 7JxS2vFQEuep8BUOJPDzR6UKCVJZxDNUxvEH8eSFEWdFSkR4la1FW58BIH5ho3HffLJI=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nsiTE-000OhG-TN
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 May 2022 10:06:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 68D57B80ACB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 22 May 2022 10:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20D91C34116
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 22 May 2022 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653213942;
 bh=EIIkadOALemDM1TR4vyjRmdPtCsK8m7VEXmLwW4Xpb0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=LagZM4DJr5cIum9HgqeCplpc5jTETYwcC1sp7RgL7ANwp3b14f+yBXII3aDFHcAML
 0ygeSmQspHdg7yn2LWJQIAPS4U5gZVZjP4dKfvHoaWB3ZprXILMTNkStPxG7IaJfhY
 UapL42LG8kkn5gDTKL5f7TO3yIw/ac/8cpXCrNWHvuu7+r01Rx5FLjxyBCci7DtEva
 oPbfb6FehdX+HhuLtk0o3nLjJ6JBkcEleJPiKAKMvb1EdHLkfe08L2yFA8+zJbaTCz
 jjc+QMu/KKAXInLAgtYmzLDPKRRYLWUkOr4lyJLPVxS6jXdyg/0i7KOh1o7Jtcfe+A
 Z67swNZm0udyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 0583EC05FD4; Sun, 22 May 2022 10:05:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 22 May 2022 10:05:41 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: File System
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215902-202145-tTEWeHiZYx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215902-202145@https.bugzilla.kernel.org/>
References: <bug-215902-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nsiTE-000OhG-TN
Subject: [f2fs-dev] [Bug 215902] kernel BUG at fs/inode.c:611!
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

https://bugzilla.kernel.org/show_bug.cgi?id=215902

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #2 from Chao Yu (chao@kernel.org) ---
FYI, the root cause of f2fs bug:

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=677a82b44ebf263d4f9a0cfbd576a6ade797a07b

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
