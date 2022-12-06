Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C912C3A5A7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Dec 2022 23:03:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p2gxq-0003C5-SS;
	Tue, 06 Dec 2022 23:03:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p2gxq-0003Br-Cz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Dec 2022 23:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qnTMbkAjRUa/yMasSflAbEh9p+orEQ/+kUf0OnKtuY=; b=PLQ01wAU1owUKbp3ZAsadajy6E
 stlN/mxdriRkiSUQ5Zr+hYiAHoudQ6BJwdydHDqaGDRXgjWEyZI665qGxFtJ9ix2CdtiXUvwXAocp
 enl9sudJSK7uFWhiNhV9JdKST71NXj7WmN7F1ReRlX5o0G0UFyaJwY6E34YJkOC1XIy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3qnTMbkAjRUa/yMasSflAbEh9p+orEQ/+kUf0OnKtuY=; b=iMUln74qgIp1o5b9CYzDyA0lU3
 7CHYN8z31nLWZLEig2VZGX2mweZHKVK1ArHK3atDrMc3jDfOSDbv+U6DjeVbJsRC2g/O52DQAdEIC
 cPI331+l+n/yTB8N7FALzpJUw3D8hTHBcl07lVIiH3AqqAiBgzIlby0woi7JEEMqDJQY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p2gxn-008Vmr-3R for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Dec 2022 23:03:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B39EC61852
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Dec 2022 23:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26DD7C433C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Dec 2022 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670367773;
 bh=3qnTMbkAjRUa/yMasSflAbEh9p+orEQ/+kUf0OnKtuY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=f8d8mCYzinOOSl9RFtylIY4qbtqsOH9KI5cs6LilijXT6wls2ZxE6Mw1P39aSfGyT
 p/wCrhtQBy+fF2UE6oJxueBCz79oO01CJv3vynaqoEgYXKCsYQquRQFFZrkQIXPpPA
 2WkWE4kRc0t17zwJa0MP+jCjSYa3//apizqpBFy+fr6V+NX3qGHXCnUTT+33aZ9roG
 QRCy31qWCt8zueD5XAG5pa7ScYAV7qwJHcsstm3CahvZHly4f/63VEu/RhEsbagHfQ
 nVadF4jr7iqBBBkfL5/YFekgo3Bom5dEyWOWGkn70GO2GItd/Ya+qmsJdFEXqEoGDw
 0ld15xu6a3hpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F3BD9C433E6; Tue,  6 Dec 2022 23:02:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 06 Dec 2022 23:02:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bogdan.nicolae@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-Cpg5Ph9SHc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p2gxn-008Vmr-3R
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

--- Comment #107 from bogdan.nicolae@gmail.com ---
I found that letting the machine go to sleep tends to trigger the bug more
often after it wakes up. You could try starting an I/O intensive task like
bonnie++, put the machine to sleep, then wake it up.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
