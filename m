Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B2C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 30 Apr 2022 04:35:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nkeot-00081S-LP; Sat, 30 Apr 2022 04:34:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nkeor-00081L-Qr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 04:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xz+7EW/E9yF4FKz8IEXomdpt3XzKBHaJlclHR/eRdns=; b=Xk7CT4bCS5e3xaGxKJZCitG0gz
 TodMk0WEzZKOdwV38Wnu+hrKNHEKnmLhVSO3DO2LgV2w/sLqKBDR4T3krx18xQdpubEPydgbn7Wja
 JZd2mWJIgPd+6eNYr8VRbDMCgw4FKDvvuBMRdTtxnADhdb3o7s5gcHsRjGqQcAmFLz2c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xz+7EW/E9yF4FKz8IEXomdpt3XzKBHaJlclHR/eRdns=; b=AcDX/wOiiEjA86fbmw1BO+OTCB
 UhmjJ6BQBykA1NJsQZQHbNtxzES/cq4fBjRQpHuiXhtpev1oFGQOGChdCWahFrQS7DQ2XHU/RYQ0p
 TGJtGX6ndjOwjnhvATROtFq6jvGcR19/xrfYYYn6/SHJ3Ovm7AiWpXQI6qU+CRxi9rkg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nkeoq-00EXxp-6C
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 04:34:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C9D5B60B33
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 04:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29245C385AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651293290;
 bh=Xz+7EW/E9yF4FKz8IEXomdpt3XzKBHaJlclHR/eRdns=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=d6aWA33GoTwzncFXSTLXhswMGsc4DsXGO3NsIBJGiN1LCkfTY3p67bG2J5b2357m7
 RQpgTJ2XX1gWKmoOKxKMug9boJ5NR6MQRDPEumm4FjyCdg0nBzRt0UVyit3jxar1tn
 UKiTNPwca65l0vmLG5iDTS87TiHy/xNsTiPnqoWa4w11IKOAxK5F5nJij0/MYiqLL6
 XZL8GKEfrtn9O0e6Q0PEIqSirNGUsWKLMmlTE93t2YMHjWffmQveL6e5ab/TpLaDr1
 To5KZ120iqpF0srCr5pmHZsDmjEYw02FT3+NLf4pvbVvFy9lOOm/kmaA4xlH79iz2H
 79FDe7sX56z0w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 0B3E3C05F98; Sat, 30 Apr 2022 04:34:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 30 Apr 2022 04:34:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215916-202145-5GRQfh1B1U@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215916-202145@https.bugzilla.kernel.org/>
References: <bug-215916-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nkeoq-00EXxp-6C
Subject: [f2fs-dev] [Bug 215916] kernel BUG at fs/f2fs/segment.c:2560!
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

https://bugzilla.kernel.org/show_bug.cgi?id=215916

--- Comment #4 from bughunter (yanming@tju.edu.cn) ---
After I compile the kernel again, this has been fixed. Maybe I've done
something wrong before. Thank you!

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
