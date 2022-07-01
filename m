Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C849C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Jul 2022 01:21:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o75LV-0005do-0P; Fri, 01 Jul 2022 01:21:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1o75LT-0005dg-Pa
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 01:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VCWCD1P4Cvk9UH+pfIJamjspZiP2pvMaAuvwCWn0S8=; b=i3ujotIDFfL8zRotdxiOfLZiR6
 BoA3tR8yTxM8VDQ1yRdDcQCzqFj1nkG2h1JTTK7OWmWEqN2KC5B4vy0S9p9fUW7kJb2QKdZiXltB5
 kzjHleOv8PaeuvK8wUJ4TG6fz00NHsJ7BGxuQXkY1YKPMh3ha7WctXW0YkyqA6SLrNkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2VCWCD1P4Cvk9UH+pfIJamjspZiP2pvMaAuvwCWn0S8=; b=ccHlgg31kMGDbxyKTewK1l7rPH
 muR7eqmVnXVqW6BOCTF9rzMZdm3U0UbPEL+c8ueETgTxPKHFsTjlwBcMxAhCwkwjIwJ630hhvQB9B
 wljiS7BVzH2lf837fOmGTf9LCEEdv0bKj1Fhe64+Sw+pu/wB+/winFcqsQMC0i0meOa0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o75LR-002stH-RI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 01:21:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7726E62052
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Jul 2022 01:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C84C2C34115
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Jul 2022 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656638471;
 bh=2VCWCD1P4Cvk9UH+pfIJamjspZiP2pvMaAuvwCWn0S8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=MEKCFiEplDzI8KMO9jZ+JW7ypa63gGb7x4hpZX3AHO2z5ILm4eoh6eWwfA3BXa7Iq
 zEjKo9f3gysssmO1zmoYEBFn0yXCYffNrSBKTh6zy6AxQJbAhurxzovSTFpknjOns8
 nBXK9C6lJJlywN1f/zcP82DNFmeqM4GnHtYPErviNIvxwZx86xQjOjOA8o1yhje6p2
 lg7V0PvipKRaqHy3y8bz58Wf+1Ecmj2gDr9W9L+r9x69dNOmbcehebmq1KnhNQXu5/
 qS7PDxqP5Yqb1Ksi13yF2ZcUOsZWZx69OcLtm0+rxxGcblZNicnAaoT3Vl4ASqW7Pw
 Pef+kZh4XrI6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AA5ABCC13AD; Fri,  1 Jul 2022 01:21:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 01 Jul 2022 01:21:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-iKeLBj5VUy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1o75LR-002stH-RI
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

--- Comment #30 from Chao Yu (chao@kernel.org) ---
(In reply to Chao Yu from comment #29)

Sorry, please ignore this patch, let me update it as an attachment.

Could you please apply debug patch? If once the bug reproduces, let's check the
printed log for more hints.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
