Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9A5C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 21:04:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5CRz-0005dY-AM;
	Tue, 13 Dec 2022 21:04:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p5CRy-0005dR-FK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 21:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E0z2WQUL5iVww2g2F08xQ5yPnQmHiv2zYRtEd4x0UfA=; b=UFh6NPKBfxLjIWEoUisgxSJ1QM
 J0iqihB33caok6Fv3PSweX3Ix1xLaL3XIOJqTW+aBWtQtC2z7KjcwwB4653/Ek74Eox6CxSZ8Ekke
 qHGWXYhQqiklMYT3xW7P6V5jcycjnjZr+q5ljlVui0XF+6MNNsh7L8olJ4xrpi4PRsfo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E0z2WQUL5iVww2g2F08xQ5yPnQmHiv2zYRtEd4x0UfA=; b=EsxkLfSiImIq8XtViGL9nbS1G+
 muvz16GMrDnbtesENW7cZjRhUONPPVzEJsBkhhslCS12H//7yB11eOshlYYFY0t9ROQtm718jR50U
 +stloNAaboEpRUCgNmOit11Emz3Izkh50ZdKlVqu1vfpBd8hVZs740hvHPIWadpaeWzo=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5CRx-0003R8-Or for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 21:04:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7C443B815D1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Dec 2022 21:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 465C9C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Dec 2022 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670965462;
 bh=E0z2WQUL5iVww2g2F08xQ5yPnQmHiv2zYRtEd4x0UfA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=vAa/4mi3G8birSmW+U+eAtPCUPqc6pbw2ECRmHvwM4rIC52LYCTQppcHuWtScBnqk
 5AtXhF7EVVTggPXXdCbQckDe/fZ7LeZovgTPiIbW8CGLiM1meOAJdIFiAw4qXzk/2j
 /+T7hnrdbRNEBICbPVth/gGGoTl4UR1ohhrpFpHRbIW1XjejB4SUUZe8h7W6jSMu6T
 ijG0TOzyjReRfk6ZqfXZ2nMOWCyACyF3uzXgY1G48a9G3qv9xAB1tiWN3/l7oEfid6
 UC2v2mp1GAdAZKWJFpWv88W7Eqds06THxw+Nvxptzj7m90YTn3420qHY+OGLI3qhsg
 JZicULhYIQVsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 24746C43141; Tue, 13 Dec 2022 21:04:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 13 Dec 2022 21:04:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-kIizuaxd9X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p5CRx-0003R8-Or
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

--- Comment #113 from Guido (guido.iodice@gmail.com) ---
(In reply to Jaegeuk Kim from comment #112)

Now I'm trying another solution: I used fstransform to format the partition and
upgrade the filesystem to f2fs 1.15. So now I'm testing kernel 6.1. If it work,
well. If not, I'll try you kernel version.

Maybe other users can test your kernel early.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
