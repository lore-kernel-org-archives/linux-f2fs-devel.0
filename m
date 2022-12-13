Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2987C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 22:49:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5E5O-0002Zm-UC;
	Tue, 13 Dec 2022 22:49:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p5E5N-0002Zf-It
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 22:49:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+kq54wbA4wp41irsZVwDbqVh7wPnv+BQ+zwl3kcZe4c=; b=WuQ07yOtROHPv5If9LfRspJUGG
 w0gwuWC0tX0tzVqOS2bijAyezTQUFOxha4HHiNt2hecT7HjM49CaJrJOIrpnrFJwjMSofn4nTYS4N
 DoBllCKHHHYpnrEGaPm1R58SEG/EN3m4MUu6EgK0TiDWnGJLvHiHcnqkBgFOnTWofdLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+kq54wbA4wp41irsZVwDbqVh7wPnv+BQ+zwl3kcZe4c=; b=AkoH7q1M1ek8l693eXcNofiSjq
 ZLqUFv/dsafHiCj5A3C3JhgJ386jCTz3/LhroJ4jzzP6uvZvMgE9aD2LrPLfR5+evBwfEE8grTogq
 QMpSGxdtsDG3U+4v90JaCQLDntnsTtHr+dtsAei6zokK5dyTNTdcjAf4bhEbGRdorhHk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5E5J-00GI6D-8W for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 22:49:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BCB1CB8124B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Dec 2022 22:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66047C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Dec 2022 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670971742;
 bh=+kq54wbA4wp41irsZVwDbqVh7wPnv+BQ+zwl3kcZe4c=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=PcvAAVEQf+h3F8sXIWKpt9mPpTqOLs2ggTYXgBHy2/gLQRyfbQ/OBaWynwhSZwUjl
 vj3LWDXvDZgCkZj9UuMocfpp2y0j3Q5sC36AkRsKc/9rzue0aQsJEheaIONkKh1Vsl
 uYOo8H5ZJTr54cqIvStJMTLmg/8xjOvb5P5vQFXahqNwbTeOVtCYiAs/kA26woEfwt
 SfCpXaE8U3VMB30NW+hkPF+PmdtwJTCNUhTFIWqq8+z/u1c45zXNVGaduWsOgQqu8B
 +ADwSxkxb7Lg7+2RJ5m2Q0Oq397zQG0b3kyfe0LnoDqRsKU964ziyNlI6gSwBub2Ga
 1LOKhfDqWjIIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 41849C43141; Tue, 13 Dec 2022 22:49:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 13 Dec 2022 22:49:00 +0000
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
Message-ID: <bug-216050-202145-K4O9oiZ5Lx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p5E5J-00GI6D-8W
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

--- Comment #114 from Thomas (v10lator@myway.de) ---
(In reply to Guido from comment #113)

Why not test the "f2fs_io_schedule_timeout" kernel patch in combination with
running the manual GC script one time (doesn't seem to matter if you run this
on unpatched or patched kernel, all that's important is that you boot without
any garbage into the patched kernel, so reboot right after executing the
script) ?

I did this cause I readed between the lines that this combination worked for
others, too, and am having no more issues since around 5 days. And yes, I'm
doing a lot to try to trigger this bug again.

Also is it save to assume that this issue only occurs on root partitions which
are on NVMe drives? I see a pattern here but still not 100% sure.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
