Return-Path: <SRS0=I8Ey=OS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Sep 2021 15:27:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4B1611BD;
	Tue, 28 Sep 2021 15:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A4B1611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mVF1D-0003C4-Uz; Tue, 28 Sep 2021 15:27:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1mVF1C-0003Bx-5y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Sep 2021 15:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zXporQkKmOZ5xZJpJ1cAVQEbIf5gauYCpdcI1mFfKb4=; b=KsFHZcVGoisk9jRRbV09WuFz6e
 xBK4zlxo4am5KDWJ7lxJttDkOj2CQH6sdO7xEJzR1DCZplRKIDAuazr5ZFlbdrqVmaxHawbqXxw1x
 4fR8tHIQwfHCAeQjd/lmDubpR6EBElQsYt2Ruoj2x9Lm1fiOus11SlxNu3WYRijZ6ReE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zXporQkKmOZ5xZJpJ1cAVQEbIf5gauYCpdcI1mFfKb4=; b=NIFFBPEWXLZ928uXHfFOxsEEIu
 kyLLkrPGz4q3pAQxWLz3D+6tLS6nQo6yDz1mH4jwXupFjEALKOigJ4bFtgzZrHJgQ5MXww9UFZ6Gw
 OcQ9xpanBvmysxdXBi5Lp++RKlCtWoAmTfj/IgoOMXGGNw2d28oe20NiAqrCaInJpRB8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mVF1B-0005sE-Ka
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Sep 2021 15:27:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 31793611BD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Sep 2021 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632842856;
 bh=GLg1OhZTOD3Mc8biml5rn/cEOhlbxVQjx2jBFG3rPZ0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Hxk5YFcpdU4YydCFx6YVu6tzCWPvfie5uS4RkGRV1XTTJVlIVFqtBZejZVr3QpRyJ
 USEBMh09+hsSof22HZ3dW4Y5Uyw5Q2+LvvfIc9smvqBAcI7gBolBJbXz3gbAEwAaTU
 5lu/Cjm/DSQpHAFpDvuvJj78v/mzea1rsg/zqkZSQEvyGPpgdqLIUyXgeUEZrXBncg
 nxbVe/57BS05Ulf13ePYai1FKw60oBegnR6P2OtJDoeEFACbREc+IvsqZO9a1aiIcO
 HNGgkNdXp5fcRLaNDxNyTkoB/oRSUSRbL138cGiBOgnyqk9tu8XnpMpkNVAtusazjf
 w2MtyYWJ1/dZA==
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 28 Sep 2021 15:27:35 +0000
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
Message-ID: <bug-214551-202145-5Jewt5tjzW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214551-202145@https.bugzilla.kernel.org/>
References: <bug-214551-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1mVF1B-0005sE-Ka
Subject: [f2fs-dev] [Bug 214551] Roll-Forward recovery recover deleted file
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

https://bugzilla.kernel.org/show_bug.cgi?id=214551

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
(In reply to li jiazi from comment #0)
> reproduce step:
> dd if=/dev/zero of=test count=256
> fsync test
> rm test
> Trigger an abnormal reboot immediately.
> 
> After successful reboot, from dmesg, we can see f2fs recover this deleted
> test file:

If you want to see the status that file has been deleted after recovery,
you must call fsync on parent directory of test before SPO.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
