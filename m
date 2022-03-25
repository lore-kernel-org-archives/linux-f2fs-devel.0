Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF337C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Mar 2022 22:19:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nXsH1-0003KY-0L; Fri, 25 Mar 2022 22:19:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nXsGz-0003KR-C9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Mar 2022 22:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FljcZVh3W7uLZxl6ei1TjY1o9mXpbtl56eHdc/1kPCg=; b=QNPDCgg5K9LWXgvGQ1cR+5uv6g
 p9YsS1VKAPfv5lBcMIxoOYQStgueXCN/s+X1G8WgB+TdT88yzPU8F3L0A/wzwq3d220mrd9935G9A
 +6ZwFRAcL0rt4+sZ+McxbYx1hUhBdEQauDcsEFgqzDueGns/YnHxzq1Z91qUnVivtWTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FljcZVh3W7uLZxl6ei1TjY1o9mXpbtl56eHdc/1kPCg=; b=Rz1GZO9oBpM5WmUtqVUyEb54FO
 m9yNoE2QE6qp8cyqTU9T25ym4mtbhaL5paWsJzvU65y/OljUKOVZLoNMbvLwk3+SY4m5SkTGxjFsa
 wWO8wyj38mWCnEk6dE1rBPvGp2DaJyIntc9buiW5RrfukxbsfRy9auvLE7jzYba2aj5k=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nXsGu-00CBwr-8l
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Mar 2022 22:19:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 06E6AB82A0A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 25 Mar 2022 22:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C380CC2BBE4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 25 Mar 2022 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648246725;
 bh=U6cMtcO3+0iYw9vl+WPPxjHenjpFJyu6LWByv+Irr44=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=aQB6Ji+4/v6m8ngIcWKoXBHQPoVs2bOxxIE5WxjSCf5/WuT5dZWG5UAWvimjItPB1
 ShgNTIc+E17gzRdG4Xksgty4CutTaUqzytCm6+UMLnRJuAq5SltvwfeqRuBF7pPn9a
 s0vLJ8bN2zLVeZfLi6KAuN+nEuxXSDAcD1zncihRMsYMy2MiN/S737kspL0To4SCCQ
 RyonHoMilH55RLRedfeS/yFTpg7IrKrVAw19e9PrTdeopYOI5IlbtRvr51ACj2Wp2S
 Fqep7FrsR86o68VBfDqvXPzDvNaXdN0d6tVCgjrVb5WlrFUilM+ifl2tw+d1FPZkwe
 JL45PYUS0biFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id A60EDC05F98; Fri, 25 Mar 2022 22:18:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 25 Mar 2022 22:18:45 +0000
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
Message-ID: <bug-215709-202145-OzEbZiOejo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215709-202145@https.bugzilla.kernel.org/>
References: <bug-215709-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nXsGu-00CBwr-8l
Subject: [f2fs-dev] [Bug 215709] kernel deadlocks while mounting the image
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

https://bugzilla.kernel.org/show_bug.cgi?id=215709

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #3 from Chao Yu (chao@kernel.org) ---
Thanks for the test. ;)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
