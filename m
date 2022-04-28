Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69371C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Apr 2022 02:53:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1njuHj-00075N-1q; Thu, 28 Apr 2022 02:53:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1njuHh-00075G-Lj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Apr 2022 02:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nqZxgHNMpZEUYBIf7/KdtbN2PGnys3rFmk1MHN/Q3LQ=; b=Jke0EYNI+VdxkOFg0+aXIxpeMw
 Eal2OvQq1zaRsMbjpQGwYlRS20+0xxIwu6N4OX3HEjUHvT5NgCPqaZF7YFoQ5D86ypt+LViniKO5i
 dh+3mYg6WxOKqQAoueqkMQpfui2cy+7hLDz0lHNJeQV5HN9GoxnCBC+oJDShQe0X3t7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nqZxgHNMpZEUYBIf7/KdtbN2PGnys3rFmk1MHN/Q3LQ=; b=KElQl/hpekByMUbOqw3xMXr0IO
 P2HtocpNRY8llKiSHimaQIxrpmhSn1PU3QUwXF7yT+dQkRuoxv+YohDVWtyVLkQzikvSrl49VfK12
 fUqF90cpQbtGm2D/b9VLGD7/NhwS2reRBb+3iWf3dUSae7qMMXMaOC2xWqiEA97hpVV8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1njuHf-0007Pc-E9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Apr 2022 02:53:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 22EFDB82B33
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Apr 2022 02:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBB7CC385A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Apr 2022 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651114407;
 bh=ZRSCQqxwEAcKBw2cOFLVISmcu/EuJhb+RIHgcUw//1Y=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=mfC4bKFQZwQOdVyAzh+TkGfVSdZmzY+90bJ9af5L+KAbz5spsGqD05KT/MsqVGie4
 IsyHN2/XhQywcVe1f/lI3rA0wcufq6+2ix4oafgkWbmNHCzscH71dqJB/v91ake9WI
 kgSeFQL+hIcOUCw2Mbm0UDx+M8JNZRU0YarfUWEaWLnh9TwQVrKq4nP7dQxINuSyuh
 HHw8yGQlkeWSYM8ncS3iUAAiwCMUizY9qXQ2/J2n5xRt2MJa5HCimKZS5BAWLlOIsa
 +k9LdR6hojAmXCKyVluo4z1VE+k77Dx5DZHBR/ra5KyQMWE85VzsOGb1V2WOqDLlEy
 eQyFb0J/p3D6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AD385C05FCE; Thu, 28 Apr 2022 02:53:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 28 Apr 2022 02:53:27 +0000
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
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215893-202145-sjeVznqt6u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215893-202145@https.bugzilla.kernel.org/>
References: <bug-215893-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1njuHf-0007Pc-E9
Subject: [f2fs-dev] [Bug 215893] F2FS Bug at fs/f2fs/checkpoint.c:192
 f2fs_is_valid_blkaddr+0xbf5/0xe50
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

https://bugzilla.kernel.org/show_bug.cgi?id=215893

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
