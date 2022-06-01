Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49983C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jun 2022 02:36:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwEDM-0001za-Cq; Wed, 01 Jun 2022 02:36:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwEDL-0001zQ-Dz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 02:36:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ADcST3qc1mtjLQWhY1WTMLdamCduZIGfSmhFrzCSkY=; b=R1UMLryHM9yJac/QRQg//3q4CG
 j4RArSIKBGOSI7fTszUWx5NarKosDBOtwZlqHdMW+/cAfGEbiOSO5OYKhhLthqK2H3IObKiK2cQFz
 +m9IXaTwXVNRB6Ecalwu1ydHBpx93AkztMPaWH7nnQObPowxgsNxoFWvOcMCaMbALIos=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6ADcST3qc1mtjLQWhY1WTMLdamCduZIGfSmhFrzCSkY=; b=hqGtqgvBh+wGu0Wi1RhgeqZVsi
 Mx9kt2vogFoYi3R4GnqisfHm5VB8BDUGMCu4vh40l9NhCLVJYI/+V0Hr1Uc8X27leuU6ig87wrSiQ
 NzVDtI39tPrG8sG1Epa2AQQvQus3t0vkXVtwl3gma52SBQGZ6jwK9vgGg6LM4UT51Wxs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwEDL-00EKhe-Ia
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 02:36:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1B25560C2D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 02:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79ECFC385A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654050957;
 bh=6ADcST3qc1mtjLQWhY1WTMLdamCduZIGfSmhFrzCSkY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=tuk8XFP8zXMsRrIN2yCOyOKqX9tzA3pj5NV2KOZOQEU/81QQOE/3PBO1dSRaFJXrS
 8if7ZWwVPVCFsC046jF4rTDF1+p5p+L5NewQxnLbHoCLieja2dR7jBS51DqyH+ctvJ
 4dJm2itoA68SzCMExtxRxkEZwpnwE8SorezJgYx7PG4wEA6hcRX+rOwDXdFULXHysX
 CqxkhH7LPRYwuD9v98wT9jnpA54c6rDxWBJ0xNHpNWEdVBYdfPgnGPK+NF7UxUrXL5
 197UgDUqLKXM3OC8cXyjTdPij+1OwmatNHSbbV8BHjY/9eyjzi3Wj2hjVW2/O3Qa8m
 OYd6fOSp8NbZA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 67532C05FD5; Wed,  1 Jun 2022 02:35:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jun 2022 02:35:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: plague@privacyrequired.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-k32np0wLiZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwEDL-00EKhe-Ia
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

--- Comment #6 from plague@privacyrequired.com ---
Sure! Attached.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
