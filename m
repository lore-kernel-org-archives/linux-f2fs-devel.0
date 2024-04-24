Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F55EC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:20:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzbbZ-0001mh-1c;
	Wed, 24 Apr 2024 12:20:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1rzbbX-0001mb-RA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 12:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=STmjA/kxWrvr2ezub27oy70CKaETFRBT0DhylUuRdm8=; b=P+nlugCL5zk1tLocDefb0Kd82x
 dwhbeS+nqFgdL9nk5REWc03LLBgiYIJ4BO//cjEWMBqANEgcl4r6mkSHaSDUhBb1beeOvnOrp//JM
 SKg34Hk0eKY17mQYhPPZv3HK0lhsYJELZGWJD5HAfyf7eudOkpxjiaojdTnO26NYN23M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=STmjA/kxWrvr2ezub27oy70CKaETFRBT0DhylUuRdm8=; b=DlGAr4Cdl2uKCNZ0BLZjG67r+q
 yfdaaGd6qs0lNnkKbJHQgrIrKjf1QL5WgCEMzpSwNgsqu+4IZufBNah/Y3AjRGwKIvBrldU/Fq26B
 2cCglSCSAu8NeD2tU8wZi2SzXmVNf10LxcikgAreyUlbYoA1Lz/CHAT9qSagFAg/uDVQ=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzbbW-0000ze-Hb for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 12:20:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5A51ECE131D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 12:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E5F8C113CE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713961195;
 bh=Ows7Mhf0cEHp+Rj7iVj0CTgeLlIhR4pU/PeKrOpOE18=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gN/fm4CkDAdHQabFTQD7ymt7/E8iTFzAuG340wCmMj1D7/jiKvijOSpqfG+SSfFF2
 N5kYahD8IeivEFDuYsopbE9mMEtVHk6+tfT8n/QWGOwcH7HmoHcdWvKxFKSZkYWIKr
 n8A5whR8Zf0tiPCwFbvDS9dCPMn7sTznocS4+V7h/tMPj5l8T+Pnv69U/bwjSOYa+8
 0TZHt25+iy0kZg73Z6fS6C/0MpFCETwnUkivu2TcwN5TJE7F3yQucP2PW63abjRrgt
 Am3FmlMEoYe0dNMdh4x9cJxSkv1TXslHRKibsAShBJi/741v/8oHUV/V1KnX1bUjJu
 8ioG2GdF+9F0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 5C5B4C433E3; Wed, 24 Apr 2024 12:19:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 24 Apr 2024 12:19:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218769-202145-dIxheF5aSh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218769-202145@https.bugzilla.kernel.org/>
References: <bug-218769-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1rzbbW-0000ze-Hb
Subject: [f2fs-dev] [Bug 218769] fsck seems unable to solve corruption
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

https://bugzilla.kernel.org/show_bug.cgi?id=218769

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 218770 ***

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
