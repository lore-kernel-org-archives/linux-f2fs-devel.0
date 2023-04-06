Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A1C7618D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 17:17:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkTF4-0000sX-9Y;
	Thu, 06 Apr 2023 17:17:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pkTF3-0000sR-Cg
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 17:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gBMzRb3byJ7XwWhEAuJZynHOVSY8gQGK5gAmadqYA9c=; b=jFVgYvWmyeZrkEbHB8dGOPSBPa
 NFkohKHAzhNiLKjd9c1NknJdVYy4CaeL6XFzmlfVsLOzltfP71+0omG42UOmJ3UzvurCLYLXV38Sr
 /tYsro2CV28+qFKDTWD4ixyPCMyGc2MlcaDBmVdaKR260OJzRsanrbL3BgTjb8kPAdng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gBMzRb3byJ7XwWhEAuJZynHOVSY8gQGK5gAmadqYA9c=; b=Fyd6Uvea4E3YdCj6i7tOw3BhFP
 PjSe/j+cgzq3chn1w8ODpljvvhbH/rdDIKwPxAWSzSCnZPzNurCEHw37qwkZ8WCVb9WbUBxBy0d6Y
 kKVdeC8QjCW8tJUbjFnE/VF5PcsA+aMcOaq91DySI2LDmQkTqBIC0E9vsSJg9zMvnpW8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkTF3-00H2gn-OU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 17:17:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8C87560F24
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Apr 2023 17:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEA0BC4339B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Apr 2023 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680801459;
 bh=gBMzRb3byJ7XwWhEAuJZynHOVSY8gQGK5gAmadqYA9c=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=KJG9Fl4gpsWI56OhsdQ3Y5sO4hGxM5u3Dlzutwc8SEpDYqtLyZ387FtwmOGRMxSfs
 Ejkq4GY1XbgVIxOIkTS8Cdvj3DnIsYGDIzYXfCXp3avPZ9Ezx5HJlxPjQsUMPcbhOV
 ih9k7rMwUXgMN/DKbkI9BK/EvU49xVh/fmxx5ZLgQ0RRMEM/2CX5V0aPDG3TSmcbOZ
 kr7Swhnzx1oVu8ReCvMLmVITu3rDcyeAJZk0s5cf0wVyKruKCP7evPEGZszwrHbzoo
 ygu33n+ZWnlyOyJdyWjR7j2l198arUg3CKAOm5nOW+oUCND0lDaKjYrEKK1tJLChcg
 Ksn4qMWcOTx3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id CD1ACC43142; Thu,  6 Apr 2023 17:17:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 06 Apr 2023 17:17:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-NbY3pUeY1T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pkTF3-00H2gn-OU
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

--- Comment #147 from Jaegeuk Kim (jaegeuk@kernel.org) ---
Ok, I prepared the patches in v6.2.
https://github.com/jaegeuk/f2fs-stable/commits/linux-6.2.y

Please apply *two* patches on top of the tree.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
