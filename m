Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 20:18:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oDAiD-0006Ey-Tr; Sun, 17 Jul 2022 20:17:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oDAiC-0006Es-HL
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 20:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fp1s98o7Yx1LKU+mvElMs7GCp1afHCtztV7o+3p01G0=; b=B6DLhhL2kYfOC+xMLF+k4Fr2yh
 g1XdzGIJ1dgRY/DC4+9/KJif5Wjn/eFLekZxBKvjbmWWMG6EwykzSpSs49rQBHTpMm1ojbQMnsp0t
 dbg+BDEmQRssH3nl1dwLj0GlnAS+ZsN15recb95CR/TmUqv1vsURvO90afn1PDxZEFrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Fp1s98o7Yx1LKU+mvElMs7GCp1afHCtztV7o+3p01G0=; b=MmOkT7BdauFi7ccIepd8AR/qS4
 /1U4NnTYDAGsouGZsS+/xKPZ2LexpwTloTrfqAErDCTgmUWkyFiELD+zYxB3MSHl8NaJTKPCxBicJ
 W1ErZ+YqMq+IAbh0+0m7sbr2tWDemy9DWJchTWUl8wTN94oO+gaqp1be2CffjWljfAV4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oDAiA-0022tv-Cj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 20:17:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7B959B80DFF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 Jul 2022 20:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30EA8C341C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 Jul 2022 20:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658089065;
 bh=Krs/5dNTbObqNM0/XSmBT9h+0cPheP1o/0KUPCEIB7Y=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Z4uLW+AZR4UozS8xOwrytGb+LBnibMPtaKaIUN3JNROYsqPWJ0INlouFYqHSSYuxv
 tUAobxwfKAk83WIUnoZXWThWmGVSxTeZFkDhDqpAQ0pSPKIWdCV1h7F6NYA4G5wN3R
 Sc1PJ9J7rlwPhxgyREzn398uJh+kuTeWxBly9x6Yb4rWPoCkO1sozSJZhUUMkbehU2
 1Qx1eAgXRRJtM3I2Kv0BoDi0bUdEIeuYn6Z8yx40FpQvvRs19xI7erGCe02Cy1cmiW
 XN4sRII7MG/QyrxThP63kVeXXmaINQP7nENr9RlLAxB2bafafEMlshGcT61k33tLud
 FYf58dwJSRBEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 1718BCAC6E2; Sun, 17 Jul 2022 20:17:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 17 Jul 2022 20:17:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ghtm2@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-216162-202145-MCl9zgeK1R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216162-202145@https.bugzilla.kernel.org/>
References: <bug-216162-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oDAiA-0022tv-Cj
Subject: [f2fs-dev] [Bug 216162] F2FS filesystem with compression broken
 after kernel version 5.18.1
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

https://bugzilla.kernel.org/show_bug.cgi?id=216162

ghtm2@protonmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #301323|0                           |1
        is obsolete|                            |

--- Comment #9 from ghtm2@protonmail.com ---
Created attachment 301448
  --> https://bugzilla.kernel.org/attachment.cgi?id=301448&action=edit
broken f2fs image

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
