Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1648FC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 22:59:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5EFK-0005l4-DM;
	Tue, 13 Dec 2022 22:59:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p5EFJ-0005ky-Ny
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 22:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZU0b6HByxAtoaKfaWu2Gr9epnj325AW6LpOmjnvQlf4=; b=NQyHk7RTdltznfHu7IH6jPNHyx
 wi/VJKmwk0kyotEpcs2FtiyjBzwjclmpJH0mXIYMK13vXrFQC5j0hGfL81uzwg5LY91cK47QLWdRz
 PVT6kYRQWI6vh0muWfr+149Gv6sA6E3ro71QaCgrA37y9vmNCwzZBN1xa2oHZDlIAPAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZU0b6HByxAtoaKfaWu2Gr9epnj325AW6LpOmjnvQlf4=; b=mBIcbCqQeMaLaS1dcHiNY0fyoC
 A08djHhxfZjsfEJr6e4lcFi00W5mC7yAnqeywOe1MAh2FxXX+hbMOWUx0Jn1VIqOsIFvGe20b40TE
 ntF1GzxouxhGseWgz/gT3H+NZl/i4NEbNnc4DcriA5+YtKkjZB63QqMzpBKmMerGAF8g=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5EFI-0007dr-VN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 22:59:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 53C5AB8124B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Dec 2022 22:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E883C433F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Dec 2022 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670972365;
 bh=ZU0b6HByxAtoaKfaWu2Gr9epnj325AW6LpOmjnvQlf4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=q6RrhRCDjKfSLVz5ivIHSoQRRaRIDrVhh+YPMV5rphc4IcAopp4ur5YzB0hjejXb/
 1ftX29/qc6WOM5hicom8jK+NQ6yB+8y04ZxzgaSLBpBmnEKMQR5d9p1OdLLT+FjG39
 CIG90mZiMdw7j5Oln1vnsxq1gwvNxg1R7vH+BCq5ULPft5tUqGEp5xR/jSjTVxkDaj
 vJWgvho/Q2RkcTinb5DLXgamRm1hzG1UD44ItGcalwx3hRXLjCsMNuZA5fEmJCBmz0
 6Q+p3CIeVBzIETnCX0NeUmT+trf7nq1BF51Co+WSFCj5rV+qknOhay/aebISl0WsDq
 s3Ly70BKRiAJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DE139C43141; Tue, 13 Dec 2022 22:59:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 13 Dec 2022 22:59:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: v10lator@myway.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-c3pXQ4h7QI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p5EFI-0007dr-VN
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

--- Comment #116 from Thomas (v10lator@myway.de) ---
(In reply to Jaegeuk Kim from comment #112)
> this requires lots of effort between 5.15 vs. 5.18 tho, is it doable?

Really good question. I think it is doable but with a lot of time and passion
only. After all there is no easy way to recreate the issue but you need to run
the kernel for days to see if it's stable.

(In reply to Guido from comment #115)
> I already tried the patch (but not in combination with the script) and it
> solved the problem of 100% cpu but still f2fs_gc remains stuck and doesnt
> end the garbage collection, so the user cant shutdown in a safe manner.

Must have overlooked that statement, sorry. For me both problems seem to be
solved with the script and patch combination through, so might we worth a try
(ofc. after you finished your current test).

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
