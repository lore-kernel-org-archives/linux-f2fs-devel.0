Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C971C678D5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Mar 2023 07:46:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZoUu-0003rh-H9;
	Wed, 08 Mar 2023 07:46:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pZoUq-0003ra-Qz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Mar 2023 07:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=twJWKQA00hPHTLrWV5mV9Q/AuG+uErhA/uMbIhBklqY=; b=YWmGbTEonYc5xT0kMrF3Wq5xOx
 EPNIqL3IuD78/oAdzznxSDvEP9xv01/oFZl1DVEzfGwg1GD2gti7RMdhxT3T1BJbwwWfmQqT89LF0
 CG6rlPHlxAx8thov621IW0DRxdWQE7uMovdSeRqz9OvhEjAGjben5OpTCA65JlKYqFGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=twJWKQA00hPHTLrWV5mV9Q/AuG+uErhA/uMbIhBklqY=; b=ZawknP2PIcxzpOP8vAis8lW/xy
 kT1TP7h7K8UzbjzgiWkDV3bJNO0Xt7HnePPsz++VWhv7rvdj/zPAN2JRPsJ4lR5kIlZSa9Nok3PF6
 w3MD0/E6gUgXrPmhuXGaPfePmSorg+FXqZVNBH89I8W9C7IjubK9ddBJE2Y/XLdIo9S8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZoUs-00054R-5x for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Mar 2023 07:46:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 32457B8169A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Mar 2023 07:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C78D5C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Mar 2023 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678261552;
 bh=SQlEFOSs0Nz8NqEEi7jq6dOt2FIIf0T07n53Nq8M3WY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=BoSeg4f7sqRhQRveCAyA9uoHEBmJeUT5Wls7YZ8ogUI8ORGO+BgKDku7QA2FdpGmQ
 vttGvvDFxXgZOnX2otxp2rnnr1gfObsp+rZ7e4wFSMCa13EjJT4HNrLdUZaJPeM9fJ
 rewj6e0+ZiASpUPIG0mU6EflUCgxXr1JdIG0piohIcWLNl10lInvMT/ALEP8eo7egI
 RPA5LfFK2ArCd0rICIFUjFuDRs/zRtTqL+azLf443ktNGNqXCLiY5WGhvSs1flpM4d
 sG5gteVyjbMhvtdNcCJAUPfpm4/NhvIw0yK1prVLaBrppQ+nYQJDFM7DQJFHmZ84T3
 AiUXSRU202yFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9FF31C43143; Wed,  8 Mar 2023 07:45:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 08 Mar 2023 07:45:52 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: File System
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rhmcruiser@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215902-202145-wTbeNbAlf0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215902-202145@https.bugzilla.kernel.org/>
References: <bug-215902-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pZoUs-00054R-5x
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

Monthero Ronald (rhmcruiser@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rhmcruiser@gmail.com

--- Comment #5 from Monthero Ronald (rhmcruiser@gmail.com) ---
And is the panic readily reproducible without the  - 'test_dummy_encryption'
mount option too ?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
