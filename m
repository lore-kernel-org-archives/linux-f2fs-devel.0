Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F88C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jun 2022 02:24:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwE1r-0001Nf-Vm; Wed, 01 Jun 2022 02:24:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwE1r-0001NZ-Jd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 02:24:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cVNlTzDoCFDR+ij3auDa3SZ3UzyM79ltF0VtjW19WKk=; b=BwyTPdI/PdU1mu8YOJron4QbeV
 rYJq8fWbnnvt2p2eLypOQxywhmCH8VhkU4xkMO6ZNp0fgZ1zwjBQMppBdQDBET+8bHEoMtvAYgZQT
 XLMyRDndg50HCDkt+qxJQdbL2bwIuRPqKGVGcX0TPmuLM3u97BR0uiOWsW48SlUyrCC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cVNlTzDoCFDR+ij3auDa3SZ3UzyM79ltF0VtjW19WKk=; b=YH6dekS7WVaPmo5lJ4leaxFXws
 R+oYyOp2ed1SduqJHxdgYUYZXYMmIKOjaFOqUSRYb6Dv1eU/l60EHNJWsWs5AYVQMY1KmhU7oUAWD
 9v/zeDWXgCrd8sZyp/BI98yMfH07MehGjdDYIq5XVg/eXIxi/pGs/DBkgUWIEnNA+7/8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwE1q-000169-DX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 02:24:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 619B360C92
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 02:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5774C34114
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654050245;
 bh=Pzg1VXx3WCn+Ub4Pr9M+6v4nozKSNIyEdnwAOw/Ev3s=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=IgL/X6yUfBtEgYt25rL8ziRFmqRdTOWkNgf1xlDcm9FgzFYQS3v0kAqFmtFiywlPu
 XF73VW3N+p4YXT8Lr7+3K7gfg8vneE4KADZZ1i4rXk1QOhdup6tc1eYcsJnex86vnB
 N0NV+sUQDYtXESybTUGCy44S412ut8i5X1YDEtCdHy4dQkBXVVNXsB8DtrHlPIljTq
 imVMUzeCM6DfLinXMoKoqzd1Kv8fPEEWivLYkgYd3ZOmsf28troOK1KENXwq05nIGF
 fRhZf9wAxCWFjV1emqf1ZSrvtRMOc96xNiiNkJBw0aOCSiFZqPbsQVS8QtiY8B/exG
 2XeZL1vnhSkdQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AD120C05FD2; Wed,  1 Jun 2022 02:24:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jun 2022 02:24:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216050-202145-HVsGhCCHrg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwE1q-000169-DX
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

Jaegeuk Kim (jaegeuk@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaegeuk@kernel.org

--- Comment #4 from Jaegeuk Kim (jaegeuk@kernel.org) ---
May I ask to share some debugging information of f2fs?

# cat /sys/kernel/debug/f2fs/status

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
