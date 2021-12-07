Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8680C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Dec 2021 05:07:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1muShY-0005j0-RK; Tue, 07 Dec 2021 05:07:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1muShX-0005iu-OG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Dec 2021 05:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1U4QTsjwqwbeSIDZz4oSAV6Q/fe8kFlVDDn2MjQeiuA=; b=JpRsCAf0p7s9CDJsAJzIq8irSH
 kyt/UhMziW264V9rsoGG59j42oS2jTvhTpRrxM2UuuL7ktM3GrxUeNJgWGlMD2/9FZse7Y7oncZ+b
 Zsil3QcfY9XsWhFSzq+wngPlyO4+PwK8J6HYL4JFIMS1UtU5k9+4OOEpVA/JLqm17xuw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1U4QTsjwqwbeSIDZz4oSAV6Q/fe8kFlVDDn2MjQeiuA=; b=dsE2cr2R3HHyXfk+XDpnR3gDGL
 ShC/IRR8WeBxTywRJUbSFJJ2IXb4q/N8aUNZyCUaMLVpBBknASQKlzbnqN1MIIkVsyKjgVFrMzkME
 JbqU7++t6t35X7yzkC+OMilZ72VJ1VC64AMvMGDR1aLEpY0qwVG1xQ0/SW3SeyNoP3dM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1muShW-006zf4-Vz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Dec 2021 05:07:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 4C2DBCE194B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Dec 2021 04:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E18DC341C3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Dec 2021 04:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638852574;
 bh=1U4QTsjwqwbeSIDZz4oSAV6Q/fe8kFlVDDn2MjQeiuA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=B737X2atuq8de7RRuvEDwbmF5AdDaHqJm6FNYXl8HwAg7MZr1wFQCgCLr8Bj50j9v
 1a7fur4Dp4TyyZGNBEathN8EaI33dyKMENENDkMeCZUGiTeIF5B2S+liDr7Q3odvA8
 eRDIyEM4M0zEQGzlwI+11rQaJNSarsbg9go5DGrsmgD55FTz1PARbqUuNocngK6tk/
 HRL0Zgm1OV96zkAYcSkespk95VZzHqXBi2e8ykq9viKim8gYHN2Opf3f+ee8WnEayw
 YXyteiZH8Er7/Zxf3phNhzT7VQgPqXBVZYtk/fxIcsC4cHYIpYCR8NaSkBG9zhCs04
 lGTuKp36DIKgQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
 id 5257A60E4C; Tue,  7 Dec 2021 04:49:34 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 07 Dec 2021 04:49:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wenqingliu0120@gmail.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215231-202145-FKfJ0jaWf9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215231-202145@https.bugzilla.kernel.org/>
References: <bug-215231-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1muShW-006zf4-Vz
Subject: [f2fs-dev] [Bug 215231] kernel NULL pointer dereference triggered
 in folio_mark_dirty() when mount and operate on a crafted f2fs image
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

https://bugzilla.kernel.org/show_bug.cgi?id=215231

--- Comment #2 from Wenqing Liu (wenqingliu0120@gmail.com) ---
Thank you for your prompt reply.The bug disappeared after patched the kernel
with the fixes.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
