Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E71C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Nov 2022 16:50:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqdQ6-0001px-I1;
	Thu, 03 Nov 2022 16:50:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oqdPv-0001pl-Cv
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Nov 2022 16:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FXwUqrdrVki4bO2qVisdtV3Yz7YUgUZ93cbUPxgTT9g=; b=Ve76erTzMmDC0jwfavmBhBBDa4
 EuslOp3s9FDL1OcooLbHgl/v/eWHd3kGsK2DkYfX6jGnteO76+l6yvdA0G9TtOMLa9g/wYakkLRoI
 nS3/8Jth751irQLn4/yuKgJOJ/fe/oQn83ZM+30Gw0qHDpZ9yESPTL9eJKyHyNMdwALI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FXwUqrdrVki4bO2qVisdtV3Yz7YUgUZ93cbUPxgTT9g=; b=IUoc0Xmmpyp4vdJT0BwJ0kJ9jb
 oZ/tXXEDHzZorngOoLUNx7cJ0lOccObmkl9wOI211ArrT0gXFkuJ+d/1fTmg5q12Rlz9Ebty+UYNM
 HwlgBo3UBvT6VErgZnty0XK4U56vsLl6cyVUC6MHvREM2SZXGBaugcqD/LFaHGPfVe/Y=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oqdPu-0003Ao-Li for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Nov 2022 16:50:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BE60EB82960
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Nov 2022 16:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BD0FC433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Nov 2022 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667494194;
 bh=FXwUqrdrVki4bO2qVisdtV3Yz7YUgUZ93cbUPxgTT9g=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=b2408g6t8Ox4MN9O0jVb3Nc2Xb25b2/B3ZXojlqM1Kp0UwWQ5JEFqTcEzE+xb4oJB
 ynjtpydVMiTraz673cdfi6lt7slDs9JSr4xNKXPfYK+chZimwbCMaCq2rObuJcT1eF
 du0Qw/bmCjIJnfzoWXVta0zy3dfnLyKPGR4CvKHuMfTnFk5sK5eYpBnayvQLxuOxm3
 ASbQEevWbakKjl6g1hYH4kN7VyfrQkQoOtGGi4oZwach8iG57epz3Ah8vMwpI7GnSF
 prOQoLboj1ofBEAx3liVvj2w9N16x8pizV6XmVJzuv3rPlzBLdUObdSulCMON7SlUA
 UlMpBXTgeEoiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 373FEC433E4; Thu,  3 Nov 2022 16:49:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 03 Nov 2022 16:49:53 +0000
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
Message-ID: <bug-216050-202145-balbvZ76yO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oqdPu-0003Ao-Li
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

--- Comment #75 from bogdan.nicolae@gmail.com ---
Guido just pointed that out in #71: the issue appeared since 5.18

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
