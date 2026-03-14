Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0139A10706DC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Mar 2026 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0wyGcM0rWR3e/M8CqJieN6YPzwjxPtTxdT+AghwBh5U=; b=IHhvuFYszmDnXTEfMBjnHo7EUi
	dPoZLz9V2davK8YAJjjru/O28MwQ4r9lbhLFJPk7Bl+Itmrjq2bSezC8f7bf6NLru1XK9/ZUkNoGr
	Nm21aP/SNlSSuWHTEDn/TnNrTvTdb4ZSDEMMeuwk1TbFfu+ozFg7ViIQvwsm755lT1No=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w1QR5-0003jt-6s;
	Sat, 14 Mar 2026 14:57:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1w1QR3-0003jm-VV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Mar 2026 14:57:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h3X6wQYkOQicr1zPL50aSafEhVqpIWAd07pHg57YeVs=; b=gL0xufDkcn7s9exuMCJXTgR1UP
 smfuXKQJSJh1OrZVozoJCrVMxNbeTEF1M5nlrTX8jTZ3rzI3k+sdwuItG5GgsGFnkALRHJMp4TTb/
 FLYv/5jwGu5fs5+uzeoHeQRernez+b7bm/Pahp+VaCFbsHf6xlZegvOg4rFi3OO6Z/Rc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h3X6wQYkOQicr1zPL50aSafEhVqpIWAd07pHg57YeVs=; b=M
 HdHDtmIWLZFE9ueq33NyG3ipL/Kl50vzt3QUUKz1vLK096H5jCqpGoK6bpHIRoiNmNGril3REheJu
 XQdpXFlwYj5S0vpszJLsHg7OD2icSgwVuSlb+NCQThBOiTRHGmXTG8JIrdDUuuDG2nT7af9H+LfBZ
 GTAsHgNarjhfZkFE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w1QR3-0007fa-El for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Mar 2026 14:57:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A926660008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Mar 2026 14:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DD02C116C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Mar 2026 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773500258;
 bh=+afKRGHP6qguPX9qIsLpAmSHhAaEpme/UpIo6l8H4Fk=;
 h=From:To:Subject:Date:From;
 b=nk5otByi1p3jnj8X6kE8OfgJM9NM2v7RSvcKQy78qTMeUqN1yo0n/6S2l0n/m+4fd
 FMatsC55Yrc9qwLqx0p2mt0PA7+uBu52Yo658c65Bu35TE+qqDgC3PRigBn95dYp4b
 WZKqRtNHtA+1lrz7Y+pVHAIu454e+DecpYLsUuZXjtbsoW8lBvml4uKfdRLY98pzI5
 L30lFfBxWpjkBW61cqMr75ZSllT0dxo8kcpzDyrPwyxFmPDVKfYo41Xo5VQtNJhGLZ
 tIMXIxylUR/Y+QIG0sQv8NRwGVSBE7OM42UzczeWdyGUd4xDG18fQ1HhvAgA6S2lsc
 QT/jeqPrZ/Srw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 4FB9DC41612; Sat, 14 Mar 2026 14:57:38 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 14 Mar 2026 14:57:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ekonom1@atlas.sk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221229-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1w1QR3-0007fa-El
Subject: [f2fs-dev] [Bug 221229] New: F2FS partition enlargement with
 fscrypt not completed
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

https://bugzilla.kernel.org/show_bug.cgi?id=221229

            Bug ID: 221229
           Summary: F2FS partition enlargement with fscrypt not completed
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: ekonom1@atlas.sk
        Regression: No

Most important is this link
https://gitlab.gnome.org/GNOME/gparted/-/issues/311

Gparted developer says the bug is not in Gparted but in f2fs-tools

The source of the error was:

the file system was not unmounted
F2FS file system check tool not cleaning everything and requiring
additional mount and unmount

From your above supplied output fsck.f2fs reports the file system as
sudden-power-off == not cleanly unmounted. But fsck doesn't fix this
state.

lubuntu@lubuntu:~$ sudo fsck.f2fs -f /dev/sda6
...
Info: checkpoint state = 42 : crc orphan_inodes sudden-power-off



For every other file system a successful check fully cleans the file
system of all faults. But for F2FS it doesn't clear the "I need log
replaying". Only the Linux kernel f2fs code does that on mount.
This is not GParted's fault.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
