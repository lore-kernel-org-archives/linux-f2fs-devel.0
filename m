Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E52ACD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 May 2026 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBhWAeqd3tenjFQretmfptKav+umVk6JewgDh4M7ge4=; b=en1y9AFGigSqON36JFR+vasVTz
	YKHu2sfw9ENAjYByLbh7wo9sYE1GPD2tCBjvSHvr5xrAmg1xRB2KYMlFxr7wAsbNZtZuhZEn4RGm2
	cAk7wTBU9Tw6E8p400jxTdnd6yy6R/NKyQph/xcGD4O0GOlDqXy5axQtRoP+OZa/YEas=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLzoz-00056d-JT;
	Sun, 10 May 2026 08:47:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1wLzoy-00056S-Nx
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 May 2026 08:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=43ABVU6RKDVcbCi9cv9os0oxGkhaeFpLnkEw/GixItg=; b=e3PWWbmy022naX+QJ6JBISDW7U
 Uu8kIOP0haWYfj4ZIxjrwl4dXN/D/hfRlTQ62K5DBR/KBxDTWjEexp0mAIHf7i5d5ld7rsDuQpG5y
 c63dO2twvyIM6dB4uSmIRcO2U0zBiH336NqS/hM74RxgbjFWL/qsEPhQ7ZEND1MJ4NUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=43ABVU6RKDVcbCi9cv9os0oxGkhaeFpLnkEw/GixItg=; b=M9D/LKdme5OxcAgFtY0YYRbXrg
 oc7dOJznR+fxF6O46FF/D7VbH5GqwMdqzbG6jhTxFYoCdCIsLqCS+FaYsk6bmXiK00Xam45kEDApN
 kqFKpiqhsuXc5GXzNnLkNz4ylhPpN93rNwRNUFRYgBDpkndzpc1Tp32LQovih5zbD7GU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLzoy-0004Ge-QK for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 May 2026 08:47:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 707BE40C15
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 10 May 2026 08:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 520FFC2BCB8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 10 May 2026 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778402847;
 bh=AFzgLVFkVr+pbZ16P+nwtOBIBH2AZtm6H1nQK6zqZv4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qNYxj45nXb9Cc/o0WFxiHypObPCI24C7YetafcLS4SrR+8B4D18Zj1Dxnx+1e7MH8
 174TlI+yC9hzl1L6XnBcuZHlGL6OJMm6ZMmIi1CdZd3+PMOcz+0nhQ7i/9aj1SdQSQ
 +mMoZbSw7VnOJ7PTrvdZIr90RiuGeBODFAfcxAlKB8h8dPDXJ4LrsU8Rc2ksjdJRR/
 q+ebJ85XrkVrokwxrUxtu3+FkfaM8CqARjl2VxQVacOgJe5Ij8PXPZmF9+Fl+w3/dg
 /v2FuUpZxnRNrQzLJnZKxXXXrCYEbyhf9+9Z9eFi67zT5uEuuH4A5ciznHB1edIHl5
 bVXOq1IF/0mVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 3EA5AC433E1; Sun, 10 May 2026 08:47:27 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 10 May 2026 08:47:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cs.attila@zerodaybugs.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203861-202145-CFUJ3Ank6N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203861-202145@https.bugzilla.kernel.org/>
References: <bug-203861-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1wLzoy-0004Ge-QK
Subject: [f2fs-dev] [Bug 203861] Division by zero error in fsck.f2fs when
 fixing a corrupted image
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

https://bugzilla.kernel.org/show_bug.cgi?id=203861

Attila (cs.attila@zerodaybugs.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |cs.attila@zerodaybugs.com

--- Comment #4 from Attila (cs.attila@zerodaybugs.com) ---
Current-master fsck.f2fs reproducer package for Bug 203861: ASAN/UBSAN log,
evidence card, concept fix, mount.c context, and minimized crash artifacts
showing SIGFPE in sanity_check_raw_super() with secs_per_zone=0 / derived
segs_per_zone=0.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
