Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1C6C43217
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Nov 2022 16:52:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqdSB-00083Q-KC;
	Thu, 03 Nov 2022 16:52:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oqdSA-00083G-5V
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Nov 2022 16:52:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zBI6yedzgpOk9zE6Y84pITsVFo81uNokfhfPh7ERVqU=; b=Y/v1MsNjKB+9DmkTipnlMZSuXW
 LgVuMXb1fwsNBcLeyj5VmMiPsUq0TzGSjtnhNkJB40uiFe/iipd077g1m/O7WJ5m4atfnNEPt+515
 3oFTMXEo6X6TY9x+KuCkqouMNO6Pm91aeAWO6gQrmvflc6jhoQy+wopPft7+e5YluYd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zBI6yedzgpOk9zE6Y84pITsVFo81uNokfhfPh7ERVqU=; b=DaXd+SQLcqxcyDl8rN5EPtK2pB
 AwtrM/K9IeaZn7HJKJLIOHujpOBhwRfPheoI6YqWK/f38xsGSmA5/POfteFcAgnREGtrqZqCBpkil
 MMK5fNKsZQ7M0IXS8iFWBdorO2uP0qXOtyiSh7zhq/1R1+GvVc8pDXU1p8lPm4zrXX8c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oqdS4-00AqhJ-OJ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Nov 2022 16:52:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB5D61F87
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Nov 2022 16:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0B25C433C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Nov 2022 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667494338;
 bh=zBI6yedzgpOk9zE6Y84pITsVFo81uNokfhfPh7ERVqU=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=spI0ls3s0RCH97KzwRKITAr367cIgTLntmgPXFU0pcsgb0Gv3KPScdiKCUcZPkYLI
 JS2gGhZBgY3yHVnDy+3Kq12ivkPPBcMfR9swmjJbSnFB9ZDV5KUBuY8qGg/jIGprAn
 qgEz3w8kq3OdTwDmA5xG5LTHPRMEdGx/sdabTNQlZ1wnvBWVbxnlKnjABHHxgvgBZJ
 Z1F3qa1dqO0hgMcKcRAo9EfHUF9oNCTybqahaOU8Sdg/P1FvoKpvLEGfXxLE1PNdYN
 GwCf69iOJ4nup8fNTVXSxPsyxmsxYg4aeKHBPaN44qamg70DGShfhR5GZcyAr4F/GQ
 jhVDilHRT06FA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id A99F5C433E6; Thu,  3 Nov 2022 16:52:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 03 Nov 2022 16:52:18 +0000
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
Message-ID: <bug-216050-202145-I9sxjTdyVR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oqdS4-00AqhJ-OJ
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

--- Comment #76 from Guido (guido.iodice@gmail.com) ---
(In reply to Matteo Croce from comment #74)
> Hi all,
> 
> The only way to find where the issue is, is to bisect from the latest
> working kernel to the first non working one

the last working was 5.17.15, the first with the bug is 5.18

I tried to give a look to the diff in gc.c file in kernel, they are very few,
maybe the problem is related to GC_URGENT_HIGH / MID mechanism...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
