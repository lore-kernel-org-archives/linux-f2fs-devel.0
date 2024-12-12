Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5F6E7717F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:35:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tLefb-0005xi-3u;
	Thu, 12 Dec 2024 08:35:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tLefa-0005xW-4M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Dec 2024 08:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DKqCiSj53/3mBhE4bFlH/mRDHphhn5gYvtbDflZ0E2c=; b=dslaEWpJx76IZlK3+d5qNFN7eZ
 m1Q8J+beQw1TSwEr5JKRs2asbXhtxOuryYD7v10GzfP25SQPm3PqAWqB4e15R7xhyL7bvBvC42YOE
 sNySS4bZoBT/G30ODFdQjVZQKzP53uysglnwbeMglOCTVIbSzmONk+en6VI6+VyY7pjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DKqCiSj53/3mBhE4bFlH/mRDHphhn5gYvtbDflZ0E2c=; b=QjUesezJgywXzYt/ZkGcUaN1yP
 gbc+lwNvDuzNRNfWCADl8gnW4NwKidFW1F8lpp9aGlmpDwUXk1P9/jyRUAfodNP41eWh5cmRBLRug
 s/wXEbsXEYD/YsrOofbSezyt7ORCx09x2PlsneM8z2CCOCM4VxwIdImpfWQ62w+eDgHg=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tLefZ-0002kZ-B4 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Dec 2024 08:35:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 633A4A42660
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Dec 2024 08:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55F4CC4CED3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Dec 2024 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733992531;
 bh=mcexTfoz5/C2tWM1On/pVgTkq0jaJnVoBh0TI+yoaz4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=m8h0H1HgypB+8ObzxqXTW2d6cANWIZZzw6Ta6pFxdrbpwB/M/Doy527DfIcWj5hep
 oKgnaX22O3ssKwpX9Qx1NXRFOd4jnIH6BgvJ2Fj/LCmUF99AwBDPuVWFfUhPxySAwP
 z5zflS8BtqQiqVjCQ4pg/jG61noEVN1lWvST6LOvLJ0NdBEuJ8qYoF4KunxyDE2J+z
 k6gmtatKKae6JxgnihVeHVkU4JsV3bpeaPJqaiF8qL7BQ+75MVtkOx5VWmM0wiSrpG
 lvMNamjJ2lb2H5Q1YbHyeK3xh48r3kizE+MPoWpWboPZ2+9vjBpKLbwmIQlNmSFAmW
 41/h09HFAXQNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 3E299C3279F; Thu, 12 Dec 2024 08:35:31 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 12 Dec 2024 08:35:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219586-202145-kW1nufkiR3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219586-202145@https.bugzilla.kernel.org/>
References: <bug-219586-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tLefZ-0002kZ-B4
Subject: [f2fs-dev] [Bug 219586] Unable to find file after unicode change
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

https://bugzilla.kernel.org/show_bug.cgi?id=219586

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) ---
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
reverts the culprit and supposedly fixes the issue. Can you confirm, and close
the issues, if it does?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
