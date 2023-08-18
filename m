Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB2EE499B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Aug 2023 23:40:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qX95M-0000Z7-AZ;
	Fri, 18 Aug 2023 23:40:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1qX95J-0000Yp-UG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Aug 2023 23:40:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CJy+uUYKd5TQZjyXAC/AAWdzA+10IYysIPaGNnAkwjg=; b=c+UzgyviI2okpG3UZkI2TIPY1R
 cWxJVOmbPk1UEsZ0sSZ8vCmTqCbqvw8ZKkZqWgnCQEbpDG5JXZKxZ5E12DQ1xE5dvwkJEVxafsvVt
 lPDIdcd2wzeUUjGZvxWurrNl7DbxkUb+L0cE5UIo3E/cwqGbqHiDU6T+a0nxFpLD39bk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CJy+uUYKd5TQZjyXAC/AAWdzA+10IYysIPaGNnAkwjg=; b=mJDvVhZkRX+VaI/3dnjl1teJrk
 Vti2WrHZ3tYj5KFDgfrU2u2OeamjQldJuoeer5tOO99QGxC72nIJXOndit1vh1GSfTp5OvwtRZeFy
 VM6UtUy/XRUcTbsLp2tT6E1Vn9TYiXP+xHGOTtHu+vM6BAjo+LPxw7WEq13CHbjlJojQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qX95F-0095hB-Et for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Aug 2023 23:40:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9479F6334B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Aug 2023 23:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B704C43395
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Aug 2023 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692402039;
 bh=CJy+uUYKd5TQZjyXAC/AAWdzA+10IYysIPaGNnAkwjg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=mHD0mv3d5mffa84lWztoxFyZuA0IXSxlngdt88mbjEG0PBNx4ENFuY31FeJsDfQU0
 pR9t/AQIn3yUQuufMmwf0tY9LXSdalmQY+9ftKnpTXpjtHfAPrmZW3Gz57wipOkUNe
 pGuKChVuGcu8/x5c7rXFkPTCMW0QOKtEjq9DusXnZ5N330t/busryKY5gb/02NRkIe
 A0U5Xj8T3MAbakTueoT+rrgH9JrXdZlVq2zc/1t9WRgpYG1WPtcYST2qpTaQhQURIT
 ScLZ5bJ6PRF69Is4hly/p5lzO5K+MWeHJ0q1X3hxCoC7Z0VXbYoCK71QSLn7KutaYm
 aVZh0AUzzXRyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8C78DC53BCD; Fri, 18 Aug 2023 23:40:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 18 Aug 2023 23:40:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-XvlL2Acw7o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1qX95F-0095hB-Et
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

--- Comment #179 from Guido (guido.iodice@gmail.com) ---
(In reply to kelak from comment #178)
> >Jaegeuk has proposed a workaround solution as below, it aims to enable from
> >6.6-rc1, could you please have a try with it?
> >
>
> >https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=5a47ad28e6061c8fddf5c82d49fdc3280a80b2c4
> 
> 
> I'll try to build and test a 6.4.x kernel next week which has that
> workaround-patch included.

Did it work?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
