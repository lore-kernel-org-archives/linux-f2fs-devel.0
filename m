Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C97EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 Jul 2022 23:03:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o7m9T-0003yA-QP; Sat, 02 Jul 2022 23:03:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1o7m9C-0003xu-VB
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Jul 2022 23:03:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLM/85uzm3nnW2YjHR4HWMnryjCoO89OWUiEXQ8C4HQ=; b=MHcXHUZgfXbdcZBNP0ZRfqGRVk
 gtLscjUQAZV5Sg+scqzFUwCenMqXaN+/pjHGEejiTiJjlVWM7iqrBU3bs5nq6X+oDECAOVae2UntU
 5jjGpkucCNjz5LpYWP18dM8GNpEM3AwnyRKYCwwNqNiMMVAmgUVWDk7mddjR+5d3jMoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RLM/85uzm3nnW2YjHR4HWMnryjCoO89OWUiEXQ8C4HQ=; b=HmEHnA5beYU6dr9TY0VSw2vfCJ
 FP0GQnlmQ4qXpeMatLxyMMqBeF3d4xSuGa8dZy1KZWVRzsL2iI0GrzC7iM7FTmy9839k+9ySsQN07
 amBTndagKiSeodgkoGZboCeOYEt4in8Wq4hcbQUZ/wqdAKdBhI5JvZqJrZLTOOGRDDQw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o7m97-0001O5-RO
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Jul 2022 23:03:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 999AA61009
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Jul 2022 23:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F5AC341C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Jul 2022 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656802994;
 bh=oNyYFxNqTICIdi2gJbD4lVyQX5o3aN55x6V18n73GwI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=n6xc6fbstnqfmfoElm8JxiYTh40wcHxo8VKTQ4Km73LI6jsu268QgkM0V5p5mA+Hc
 SDQez+vhjjNCDleWtO2oYwXncXQhVLc6wZZxtk4Z5/zZbb2N+0p4jgETYNGOZXZmjC
 MaN1vu8fnsAAniRbMI/AUstDq/KIwPVHb1fcO/Ym7auTabvRLbSlEgfM0KAyml1HOY
 qPup0bFauHh7jRfyRPMEI6HMr29tHCEBcVZUDxL8kaFhpZ7UiTRYGCpn65+VY6S09b
 vODfSlSY+czcmZ2yw3knvb2NptD6uhynqhVpzlkXuCKIsND9UhGbpAWVijg9OUEjkU
 DN1uER4GOQwYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BCECFC05FD2; Sat,  2 Jul 2022 23:03:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 02 Jul 2022 23:03:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ghtm2@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216162-202145-e1t1mA8273@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216162-202145@https.bugzilla.kernel.org/>
References: <bug-216162-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1o7m97-0001O5-RO
Subject: [f2fs-dev] [Bug 216162] F2FS filesystem with compression broken
 after kernel version 5.18.1
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

https://bugzilla.kernel.org/show_bug.cgi?id=216162

--- Comment #1 from ghtm2@protonmail.com ---
Created attachment 301323
  --> https://bugzilla.kernel.org/attachment.cgi?id=301323&action=edit
broken f2fs image

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
