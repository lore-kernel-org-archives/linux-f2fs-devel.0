Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6885FCD37AF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 May 2026 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DgfUsmRpUGQVpa0U3t+tVKGrnWYGWdXMrBYJImDoXHs=; b=AQcQgb4WeGO7y3QidDxv2gcehp
	HMlkQ8Dz2tmqdLTuGTsz1ZVoSVbF7MGCtME4buPN/FzPIErDiYrwZc8ueApUG8JBANv7QzjCXAt/N
	+fU7W5RPDGn2HjYKJarJrlRtt0/lhZT5UwAiBrvUY6wv9ISBh6kCsViUopgsVsJGUtYc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLzxB-0006IT-Jx;
	Sun, 10 May 2026 08:55:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1wLzxA-0006IN-4N
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 May 2026 08:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cUTD8DmBgrAgOg1kLekPTfYl+b/mAtHW0DsFh0hvY/E=; b=LtfSIuhZwitK4bdOPDcgjQjNt5
 HwrKuba66fkJ8Pyt1as954wVlBfsXp86ujUiWZrLuU+6IzsJGeHeBgV7bIpRLOtFA1FBhARsKP4BE
 w2DDmkm6xYXT4kwSb7TZDfhMuK6fxO0D2GYmhWqz3Kg5U+15kcmn95qw9jQFeDFfSNDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cUTD8DmBgrAgOg1kLekPTfYl+b/mAtHW0DsFh0hvY/E=; b=nIwlMhjrMB1/gK17/kzr8JF6Oj
 9qQJDEsCdlUvheU6Ls9jnJkHYa/c6xSLz9tyLXDwjIo49XLUZ7tZgrrjzBN/8A4nbCZTBBQfxrz4g
 wIt62l9aSM5u3YT1FpECNvwKLa84DiWWs4xr18EDWJfHZQ9vJP2jzqIMRz3N1bsXOjUQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLzx6-00059M-V5 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 May 2026 08:55:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7699B40559
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 10 May 2026 08:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59839C2BCB8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 10 May 2026 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778403346;
 bh=yk4CLSgAjqGEiucXccaIhaWB2lygaGTtWblghhOAm7Q=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=aGqmrVxjvkYysH5hM3CI+KVeUhdx/nzSUJPSXeuawG7Mc7VFKsSVCro2HhGWfnwvL
 Q0Bq25xWg8wLDt4giFFfxWE056wnGCtraVhAw2AFq4ZexuDbq/P83GF+cDt45SzzzF
 NZ2BnRhx7X26IlusrW/YdOkjQRed+3VGlfB1KwscxrrkQOxIJNkPycTnkw55sKA1Ya
 uRBHAj7A+1Ux/1AZ1Jq4QuM3hESdMeeDfhKhJVKiWPq00NrS5w76kgitKJo45Cpggr
 JbCZk5D//Jz03iYQgFjMud1ZhJqh3J76tHVT6r2d+KMOvyX3rFeKPjHesN+Uxly7XK
 0Xo92qp+cBPyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 4973EC3279F; Sun, 10 May 2026 08:55:46 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 10 May 2026 08:55:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cs.attila@zerodaybugs.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.ispatch
Message-ID: <bug-203861-202145-rmp0e6K5ws@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203861-202145@https.bugzilla.kernel.org/>
References: <bug-203861-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1wLzx6-00059M-V5
Subject: [f2fs-dev] [Bug 203861] Division by zero error in fsck.f2fs when
 fixing a corrupted image
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

https://bugzilla.kernel.org/show_bug.cgi?id=203861

Attila (cs.attila@zerodaybugs.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #310083|1                           |0
           is patch|                            |

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
