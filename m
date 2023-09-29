Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E5BE71D40
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Sep 2023 14:51:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qmEpo-0000Js-Nl;
	Fri, 29 Sep 2023 14:51:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1qmEpn-0000Jm-Cv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Sep 2023 14:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=87Q82B9JM2vjwkA2bXdEisUS+VjRdYFmsMpxrLYTQh4=; b=bWWiowg2EK2NahZz+hSMrqqB1G
 adUZeiKk6uuIOKo0AQUXhN8vXnTmhN52DVSUUZWmuc0njjNomegJa5mnf5LpwaS2/Hk28jGzYiLnD
 RHwOtv6cTgeNFyaqhyMA+lqU5SFmXvmdZoWKdUOK/IYS0IAULYbXauglFho9KMWRZLhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=87Q82B9JM2vjwkA2bXdEisUS+VjRdYFmsMpxrLYTQh4=; b=nMXaNwYMD9cRWO+1uGmWhbOV5j
 D6EermMYF8W2uyyiMboT7gUNzlkLGkAsE5KNRW5wPReK4/rQP+yQrOlkL13h/W6nXuqbD38G8cl7I
 lXjWfgViyHgx87XJvszUHl+3KAH2Xfdoon0UH6hTjdBN0zesAMS3yZd7HJCV4UySHuZY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qmEpl-00BdF4-Nt for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Sep 2023 14:51:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 56C3261EE8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 Sep 2023 14:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03C0FC433C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 Sep 2023 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695999068;
 bh=CQlx2HoO/HLZKvz9W8ZWeWqglqXaii0O8G3/GCam24c=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Jrv6o4ADjNPsBhF7ygpsCGABd8NADiDoK0hzlw7qXUUBI4ULuTSfczxYjgboUfHWV
 exW2yRScK2bx3srI/EOrK5Ncpez3Vkc3moB7quBZriF18FfdXlMB/LXbP5v/nZ7F/C
 oTrITZ4yqxsXCvSik2t8hFVn8vhmsYKNSX+pMpLM/yNH/6JromVgIAqqzY1yuSRpiC
 XwYbx5GQo4O3IFR1NrBZ5yW3HaW+lFhEIQMj93+fU3gUy1P4+rg/vwcYbesgkbhCNx
 vjVJe2MIRvpvWYyPMFqAayQDbJM2pO3wFUmse1O6dUd+iOyBndjLHDEw+fk4ScZ9Tz
 j3cx/6MZS6Q+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DEFEAC4332E; Fri, 29 Sep 2023 14:51:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 29 Sep 2023 14:51:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thiemel@centrum.cz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-210795-202145-2ycWO6nyFH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210795-202145@https.bugzilla.kernel.org/>
References: <bug-210795-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1qmEpl-00BdF4-Nt
Subject: [f2fs-dev] [Bug 210795] fsck.f2fs - 1.14.0 - error when not
 /dev/vgXX/lvYYY path provided - [ASSERT] (init_sb_info:1017) !strcmp((char
 *)sb->devs[i].path, (char *)c.devices[i].path)
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

https://bugzilla.kernel.org/show_bug.cgi?id=210795

Tomas Thiemel (thiemel@centrum.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |DOCUMENTED

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
