Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADDCC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 30 Apr 2022 13:33:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nknDi-0000fp-B2; Sat, 30 Apr 2022 13:33:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nknDg-0000fb-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 13:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ykUR3fk0oEeFFKcr5Mjui5X+elQsRvaA50XVi52PI3E=; b=EukWX4fyNuk0CgcteP4kLg2nd6
 gtiBBJE8cvE47vlgsTyM/ZTFNxCzBvAEm5Z2Lsyfh5l2R/2p6urhX6RcqMgseiDLsgTTVBQAEdHD2
 OJnXH2MDubCslxzkxuZVUOYZ93V19bV+WFNXWAr2Ib7nu+gWw3Ew78Rld5QEytz88y7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ykUR3fk0oEeFFKcr5Mjui5X+elQsRvaA50XVi52PI3E=; b=fUrEqIEWd7nPpr4CkW6v46wGFo
 X30XohdzrSwkifdxzCmCZTRSWZa9TQaFL2AmBz04witSrbROi/ivLtKr8WDDkNEAqMq+0hAwWgeiU
 8EYzrpPwCiLoBerVUIeHVoql2N/nod+eNv3AfUHZ35woqSz0LRMsiI2GQlHssjVwd+bk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nknDc-00EsVE-UR
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 13:33:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 886E760E8C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 13:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEA65C385AE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651325579;
 bh=U7Z3Rq3wcrRI/Fbi9218Jp1wa+zbvj+mq17/TkUxIs4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=KJk3w8GbNzVuhia9tPvi46UCk+QRt/PmvsT3z6EDGkyWzzxds9nzWkjRJin9EP5bh
 dUf0bERwoqa3tGJtM87AwMQ/Zk+nMp+DTgl0ZX+xfE+7ty0p6KnxxJAcnOZGIO58BL
 63ORCTNZsGQgoXBONX8KXtL2JjC7HNzniJIBVLTtckTr+lu4/OYqcO8cEgjF9Cl7+2
 LBLo3lNr05blywe7jAArpf9IQA5KnoQy+n5O+pcwUvV9QfiKMEu2i8TeYSIfiCKgFE
 bo4y2kZGuaiTlS+gR4+kSPMfWO5oPCMwwZSq4GaPc9zbiEkCy5RIKQ3NpKgLpFoJKM
 wJMslyWcs9srg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id CF608C05F98; Sat, 30 Apr 2022 13:32:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 30 Apr 2022 13:32:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc
Message-ID: <bug-215900-202145-8APu5CWfEq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215900-202145@https.bugzilla.kernel.org/>
References: <bug-215900-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nknDc-00EsVE-UR
Subject: [f2fs-dev] [Bug 215900] kernel hangs when running commands on F2FS
 file system
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

https://bugzilla.kernel.org/show_bug.cgi?id=215900

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
I doubt this has been fixed, could you please help to verify with recent fixing
patches in below branch?

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
