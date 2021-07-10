Return-Path: <SRS0=5ZV8=MC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B2C07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Jul 2021 08:15:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723A9613AB;
	Sat, 10 Jul 2021 08:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723A9613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m289I-0007r3-Hn; Sat, 10 Jul 2021 08:15:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1m289H-0007qx-Ay
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 08:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tss9YCubUznh9QmJUls11LOvq3S1jszj1hxBpzUSU24=; b=bUbZ7YWoYBsBJ1e3Lljcqwd/Fy
 rZWiBq2vAK04F0c1L7sQjOt6RPDHoJYnTOSInCZHSem8g7jNIK6b/MIZAdrERak+wyHVj84JtVcmW
 MCYV2Hqf/PHRExe5T3prS2mKKaDc5JBHnxlYlhUkB70EMv1BMhBTzhiBlVYzsTI/l3Sw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tss9YCubUznh9QmJUls11LOvq3S1jszj1hxBpzUSU24=; b=a7ybRJsFRaXcIy42BGq95koS5H
 sfT0RCtM1vJZq+YUTAVDdIRxYU3XhyHfHDOPrLiJ2MYXbx28tYyM8e90pQHM2dE2yhdZ5ZauBZAk/
 tUP07vEm175bqdyhYMzH6hUMEJE/wyX4WUGhq3QhPuVCX5X1uoV7a3NKI/HfMUDWll7A=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m2897-00065J-5d
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 08:15:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id A0D84613AB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Jul 2021 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625904927;
 bh=7i38FtFVGddB7/ZsTdM35cpwpQ+pJyPlxlU/8MzZHK4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=edGm/GmIK6Pp8oQwybdxXO1AAg9sYBmIKmoGFaVYbdLymLKzOD/LcxVEEIBBKXctB
 rMLoWbUXb1qi2cBps2VBh+dQE094kkxddqH0EeNaSVWlSd63vl7GjgHxAfDu4ERKIy
 WKyPQVonD7Tiadh+N3k2yNe2q+6JWcyGJvdJLPgwkK2twtJgF7Ca50WmG9hE5Cosb8
 ElzrjWtyyavq7RDw1FLPLMWMndxWzX8H8UsUvE2MImXOkju2u7raatllmEUIOKm3pI
 MNHNzjwadcg/4/mwdZ97W+J0ap1gyjpaR9l7OsRkD/R0fTzehm2cyguhKqZKPp+1Sl
 c7Zl2jZ0gz3lw==
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 10 Jul 2021 08:15:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-213089-202145-ZUoARemJDW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213089-202145@https.bugzilla.kernel.org/>
References: <bug-213089-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1m2897-00065J-5d
Subject: [f2fs-dev] [Bug 213089] Add "pre: crc32" softdep
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

https://bugzilla.kernel.org/show_bug.cgi?id=213089

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |chao@kernel.org
         Resolution|---                         |CODE_FIX

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Was fixed with below commit, so close this issue.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0dd571785d61528d62cdd8aa49d76bc6085152fe

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
