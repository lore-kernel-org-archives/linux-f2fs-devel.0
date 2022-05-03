Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04303C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 May 2022 00:56:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nlgpp-0008Cy-FJ; Tue, 03 May 2022 00:56:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nlgpo-0008Cs-A8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 May 2022 00:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0NcuuWVe8Gyf69mj6hWZiQ1uqFITcsYVj2HrFuqAZkI=; b=VEWDekTrnhecfLixY7FD1crDJT
 ce+U4kGEaJfSl28EIYImroCeXKyNR6u+v5AWps3hKywSC3AsApFsd6knKfrnQoTefRPLRFG5QHeXM
 m3xIrhb/RFffZ7oC6PATE160Jz4n0Ui88xQ/7f+g3T1WJbMF5+wqGM9y/tKSNvZXielg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0NcuuWVe8Gyf69mj6hWZiQ1uqFITcsYVj2HrFuqAZkI=; b=aLnaK8M6nMVwR6MOjTVusXDY0l
 051/NSfSbo2JvRkn4UI8ZfEMcILHfZdPyAFQRd1y6j7vxKBTKf/L3RH5RlJJWZESd4AeuEIZKxctH
 NyDDTPxgsp28v4AJwlxJY9/ydHCl60uIAsdvJ5aCCE6BrrMCIYrgRfgf4quxyNMS7Ezo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nlgpj-0005Pg-Li
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 May 2022 00:56:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC596143A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 May 2022 00:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0BA6C385A4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 May 2022 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651539361;
 bh=x4QHnZ6CxNuL9xqqeekbYsTtUreAypuQMbsd4QpaStU=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=tQ3rb6Ec5rYw80+vvoAM/8nCeCFXChVja9QLtrrN9QHgvM46N7hrIxmvy8qmKg3Vs
 iYBJ40UBOHL8MMR8vxlh/rSYiWTNr+AnIbpyQkOXTO/Oj1Nqc43/RA0Swdb8HVgxip
 xu7w4GPLx+kO2jJeBHXmU0Dbi0TQwWlgDFeNN2z4B1FkdxUjXC1kLA9VOtPNaJCXun
 Bb9icmYxKaZflAW8YB/kcZms8sKg9qKjui6Ym+LhLOLuy+DbK9H/9xYWRqJuokhGFQ
 bcvXV0hdwta23jLFp8wfkM8BOqly5fWpLf7lVvpUzmyT60MkeX70lWVxGkiKUBUkcn
 2GuDOwAijoPrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8EB0BC05F98; Tue,  3 May 2022 00:56:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 03 May 2022 00:56:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215900-202145-v99IKwzTFw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215900-202145@https.bugzilla.kernel.org/>
References: <bug-215900-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nlgpj-0005Pg-Li
Subject: [f2fs-dev] [Bug 215900] kernel hangs when running commands on F2FS
 file system
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

https://bugzilla.kernel.org/show_bug.cgi?id=215900

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |CODE_FIX

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
