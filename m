Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2A0C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 16:56:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkStz-0000cJ-EG;
	Thu, 06 Apr 2023 16:56:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pkSty-0000cD-75
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 16:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ym5p5E4N0DJL/gtM0DUxUh9CSMpONm8Kkb7mI09y0oY=; b=Xj+EO6cDe92XcXqEYSoxkaMBFP
 syGGaiskI6g8ntwWF5MQiWCzlq2dg2j9Pyj0xULXmqoSQEjlZnwT8cJau3mtiF45pBApFoLSwBRTH
 tmo072TFTFVeBkk9u9Idi5r/HBsHvYtlgNWbB1Ri73tLtSF1eCIUsnraBYMgrUgphgaM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ym5p5E4N0DJL/gtM0DUxUh9CSMpONm8Kkb7mI09y0oY=; b=DyshASTJ+7iJlAcf9uuuRyhBGs
 Lhy9dGvQP5XLitOb269Q0/ngA7OABUKz1bCyxeIhqfCc+fytKcnWLqRTrYte2Pv+g/vPX8LiW0lUG
 77KqHPAmyCejysRbUGu70B/wobKZFcSrJsCSD+xQmBs9HiszEKUHE3O9HDP4E8G2PSeI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkStx-00H1uc-Gv for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 16:55:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 24AAE60F2F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Apr 2023 16:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8537EC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Apr 2023 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680800151;
 bh=ym5p5E4N0DJL/gtM0DUxUh9CSMpONm8Kkb7mI09y0oY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=b4YdfX8FdCVKw50TI+QOCYq3p/i1070l6IpBaBvPqQsfF5pSeElnQNz4u7Qfd1Wq4
 tddEkxXv5mNap2R+6OtYdrYhBsPLw/3ikTB+9IJCjzJk93i6R/2R8qr6ZAnTLTVipX
 TFu+xRJuJtNVjveIepbealhxl4Y98ckNUcwN8bVJ8uMFEXKD2i8IcDUuE/bT7OPlOl
 RZs9xEwSMZe1Xd9t3fRpXWSWGN91psB9WbOKrU+NruFx7hqEF1r9sRIzrAqvZBNE5R
 QEGyjo27zugpTCuPpuC1MKoW0qlTbTGgTU5TDjG8B9MCfPq+fHopxaIMpyTQ/658aA
 MGNG2UP/tcSaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6F156C43141; Thu,  6 Apr 2023 16:55:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 06 Apr 2023 16:55:51 +0000
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
Message-ID: <bug-216050-202145-XbYlDtIeJN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pkStx-00H1uc-Gv
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

--- Comment #146 from Jaegeuk Kim (jaegeuk@kernel.org) ---
By any chance, does this work? This is the backport to 6.1.

https://github.com/jaegeuk/f2fs-stable/commit/a0ba9030bd28c01b3e308499df5daec94414f4fb

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
