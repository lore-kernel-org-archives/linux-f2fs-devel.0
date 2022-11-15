Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DA3C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Nov 2022 08:06:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ouqxl-0002UU-DK;
	Tue, 15 Nov 2022 08:06:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1ouqxj-0002TT-4c
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Nov 2022 08:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yvtr49pNh3+YoJ4ae3JClAmS2zwBSI79g0VED+ox+JE=; b=Q2dIFgBzkVnMx1n2A2XYhyBU6e
 q8dLVRcwRO+qm+9Na/xUoTEqaZf4yuc1MQnbPslxUG7AJrQxtw9VwPFG2v1hFlH1lSbsXnuGUCU5X
 XGFE/zDS2fP0HbremTH7K683AIBtkFWzlx82l3n4fp/0N9hdcYuRa8OJotNnSsPlc1cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yvtr49pNh3+YoJ4ae3JClAmS2zwBSI79g0VED+ox+JE=; b=QgMeN5Y+7KUlF3ftohrPA80VQh
 Sn+k2q0kOOJRr+qR8fDhBwOQiVRAC2idzCJXFxg0Ky61K27L/ua6kdGvPbvaRTv8kRxRydDTryBN5
 te1hF4pnq6PRX6qtOirQRQ3lwnidXVwkBxcqxH/P8Ahr85vQrKMHp8Vg0Urj463uIIKw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ouqxd-0005oW-Sl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Nov 2022 08:06:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7D4F56155B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Nov 2022 08:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFF2CC433C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Nov 2022 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668499579;
 bh=SH3q8zi2lcXfGWZxHDeNVuNpsp7s1x+lcN8Ao/ot/l8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=a3+fHDo1R9Oa5QRpccOIgK3g+Z3j1I4VTwKDLqHz48lSnJJZ3dGZ7ujUORyGaPjFV
 6hrojrE/lHeuZlFHvwMy0J7+LyiZ3qkuDrt05Zy43VEMuP5B40NGZqQ5wVC+xwvm5J
 gAId2mMSvwFLUu6UJO2MRoa7HZQpOMhYVqGRRGm9iL87wZzqVobMYhLH9E9INPI/vH
 QD7tFot9t/psR9BtKbtR4nd3SOB21TpvKiXBb5wmdFeWuHEMKs1T7LJwIYxKC/d1X/
 N6nrDbitzt29nmjv/X41LWpjFu4xCTdiql3FmIVPImtsRTgCvNqe0NHQqHtQpWInhv
 8KqHN8wOH9wMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BAB3BC433E4; Tue, 15 Nov 2022 08:06:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 15 Nov 2022 08:06:19 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216050-202145-30FmHPUffd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1ouqxd-0005oW-Sl
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

--- Comment #87 from Guido (guido.iodice@gmail.com) ---
Created attachment 303184
  --> https://bugzilla.kernel.org/attachment.cgi?id=303184&action=edit
kernel log (with patch on data.c applied)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
