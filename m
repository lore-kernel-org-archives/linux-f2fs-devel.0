Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04703C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jun 2022 01:47:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwZvj-0007L0-0x; Thu, 02 Jun 2022 01:47:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwZvg-0007Ku-Ti
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jun 2022 01:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DzeMRe46OGu4xHdHkv3xJ0okeeT3kZeQlh08kOGqQi4=; b=llZ/PQCucg4sVCdMODz/y9EgDz
 1CrDlfyRHUAm4gccb+hKyIT2xlRCdujihmcURXMHXo/e5QjDn+nYyr3U5wKNAhsC97e6hTTi0zCOO
 bUilUMDPd/l915wmmCbENWk8R1TZkHcaHm041HXJPP+KaQI9aEJbQqUWn/eGne5tWHWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DzeMRe46OGu4xHdHkv3xJ0okeeT3kZeQlh08kOGqQi4=; b=P10B0dytODiHgLkGd1Z8khBQiT
 cweDdtchLctqjtA/uIfaksEn+GI5ANibMjzt22MdsiE13JCCh7HhkOQ1WQwh75byHNQEGpuEN8SKy
 4WW9SGHQSilqx21F6hrBcUcB2QY+NtC6aFBiVq6RZXNpDMJS/A4C0klhjMx62PEk9CNM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwZvb-0006CY-Le
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jun 2022 01:47:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 929436162A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Jun 2022 01:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 032E2C34119
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Jun 2022 01:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654134419;
 bh=DzeMRe46OGu4xHdHkv3xJ0okeeT3kZeQlh08kOGqQi4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Otth97YpPGYfvOwKci1CTgvZcUAsaVXPiw2/nQooQern6Sg69YRe7JL0Yak8pfuZr
 GGI1ASV61n5y+AwIOhkzEQRo8bAHWOTqRA9CU/NmtSwXfByqeM0wgl4CEZrEIEY0+5
 5+NXyMPTz/RewiKiRZqrd88fAblT9NNTjbRcMzZGwqClSqdVDCCC6Ozh5QbD5/Cm2J
 umzrDs0I4oWEpaIO/08HxivXk/0mbzFjUMPeBeZO4OsOIEvaQASWuUAvsha6Hi4vH6
 WfnhH1/kj90J5RR6yJFQ9JhKNRo0uMrnFyAsRnbF5ecjn6pvc7Vwu7XnkWYd6G/LDZ
 eBrJ8xyFYtxlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DAF92C05FD4; Thu,  2 Jun 2022 01:46:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 02 Jun 2022 01:46:58 +0000
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
Message-ID: <bug-216050-202145-a1kDvWl1cM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwZvb-0006CY-Le
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

--- Comment #15 from plague@privacyrequired.com ---
Good it is helpful. 

Anyway, is there anything one can do to stop blocking the system with that
issue?
f2fs_gc-254 is blocking the system...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
