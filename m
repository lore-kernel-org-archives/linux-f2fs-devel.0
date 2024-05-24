Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5DFC25B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 May 2024 16:06:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sBzLh-0006Wd-46;
	Tue, 28 May 2024 16:06:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sBzLf-0006WS-5O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+7TUExgEv/fA5SbhHMUrg4u2Nu9o0RDTbxkM1mng6c=; b=Leltv5myxRZaKsJsG32WIQP1A1
 3xCffaXvu78l3RrK6uVUi5gp+1oN4ync0Zv6wFU3q0tTHTLaI/YDUrXtNn9U/0YUJ1r2FyWQGBvDf
 jyYeOGOrjiy2Nr0ivP5uSi/GoZjJLJHVzdg8BX+DhoIlGKcgHe5Q0HVpBIkbHZqW9JE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v+7TUExgEv/fA5SbhHMUrg4u2Nu9o0RDTbxkM1mng6c=; b=CDIeipBBhCqSb5v9bVrTh+ViwI
 JNrwy/8GnYvJYprZv48LNQqhr6zzK7z8c0YM3E43hFC4dwReXIjqnsgEuDQRtr8vFIpdJyR/KM5Yc
 L+44Hd1ePkJ3wnY1ZBAQIK08AS5kBWQLyAApBiIMx+jwLCT5jQCvUnTCTiZockwA5Kds=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sBzLe-0003zg-M2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:06:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9AFA8631A0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 May 2024 17:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFFBC32789
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 May 2024 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716571674;
 bh=g4D3HVj3bBzBjYfaHZYew6lkYOTdiNb+RS5iVMEQGWc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=m4OiPgs1P4CwkDdVPK2QEqMPMfPS8Er+W0bkDvLaM3rc6dP9B3ZO07Ra9BLz9x7yq
 PgroZJn2HGZVBrq9nWBWGkKpbXeiahcpD6JsXjAQACvoGw1jeIbrf9CHCfdLZ5ErQv
 v4AbBT1CifmkKeiCA555BRhcMxEtyKzYCKr3AFm3jE2R+7kwPxc8mIiYlDXjlZ6y4p
 wfOAwOyNK4i1+0udTK97Gma0SHSxtrnrd86XDa1vwkgZS/KeNku+oAdJlyJZcJrvvC
 7LGdXFPY7m7DAeN+FWZ9jFjL6fHmAQTRemMHK0k3GtyJe4dSEWbpwI7vPAg7Z5dKhV
 yF0yjUEKEeNXA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 38EA1C53BB8; Fri, 24 May 2024 17:27:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 24 May 2024 17:27:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: krkk@serenityos.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218870-202145-OuUCTgEKGp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218870-202145@https.bugzilla.kernel.org/>
References: <bug-218870-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sBzLe-0003zg-M2
Subject: [f2fs-dev] [Bug 218870] F2FS mount/unmount results in
 invalid_blkaddr
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

https://bugzilla.kernel.org/show_bug.cgi?id=218870

Karol Kosek (krkk@serenityos.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |krkk@serenityos.org

--- Comment #4 from Karol Kosek (krkk@serenityos.org) ---
Running git bisect told me this regressed in
31f85ccc84b82cc7eb122af01f5017fbe1e29289 "f2fs: unify the error handling of
f2fs_is_valid_blkaddr".

I haven't looked much into this commit, but reverting it on top on v6.9.1 sure
makes the error go away.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
