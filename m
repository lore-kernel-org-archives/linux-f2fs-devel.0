Return-Path: <SRS0=Gq3l=N2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36104C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  4 Sep 2021 10:17:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA8F60FA0;
	Sat,  4 Sep 2021 10:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAA8F60FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mMSkF-0000xR-Cy; Sat, 04 Sep 2021 10:17:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1mMSkD-0000x0-LY
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 04 Sep 2021 10:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5oLhgTS1dsq7tSQVjoHijWrlyEKohl/1FG4lJl5GAU4=; b=muquBGe80mNoKof71+qm2Ml8k8
 dWImBgf9yNmYQzcTlIoYTko/EYWd0jvEa9aj+34/IPkJ7myj9HnpOYIjbEvBqkpC/C5Z7ipmCmF+H
 UKoe7YVEcwfJpPKaPaewgsRpY1/l/YVczkXXLv2YUJtP1/S8r1vq/vgB463468wx+VZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5oLhgTS1dsq7tSQVjoHijWrlyEKohl/1FG4lJl5GAU4=; b=LyXnnjLtsFws/s+TW54rYKvfWE
 Nqyf1CUI05IEe8eec3o8/E8V52NFrmzq7o0IuLguao0voZ3lEfwpmiTdAkxe3srx8jOm1B42kMYIG
 vVHmTkH8rr5Oai1PGf2yPq/E7RkUvzJH2x4GQ5jJgVhfja7iI2nYPzCD2gku/t1V0B8E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mMSkD-00EPjB-5Q
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 04 Sep 2021 10:17:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id B8C8461054
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  4 Sep 2021 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630750667;
 bh=5oLhgTS1dsq7tSQVjoHijWrlyEKohl/1FG4lJl5GAU4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VlskMHJKdOLdQN4PABZGkGFOEgd9/Df1rjVlcMPQ1vrZxUszpU19cmj+Gcj1pzlEs
 ks4K0W2eWaqBaHGmExO9S76llmx7sdb6KG+TLDSznJTf7sFN2tvI8D1OEqxtAyjTsH
 VW6+KtYkN7K1nJvhilVqt2KADEn9WQgkhSQk23H7igDhIwnLDcOgwc+/Fj5j4U2KG3
 aNiTTRyY1ZGYBT1xBZucqfxHXz3SZAIEZUQyMjXVf6w4RzJSzCaCx9JG+r1sDT0U3/
 IgbnjVfxg7VCWxL7DXC/bjQQCwDZ16etAaoc1ixVbySWveOJ/Z0dG/x7rz5Rd9Y87F
 Kop7rNoienEhw==
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 04 Sep 2021 10:17:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: normal
X-Bugzilla-Who: leftzheng@gmail.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213877-202145-P9ucNwE8wX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213877-202145@https.bugzilla.kernel.org/>
References: <bug-213877-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1mMSkD-00EPjB-5Q
Subject: [f2fs-dev] [Bug 213877] Mount multiple SMR block devices exceed
 certain number cause system non-response
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

https://bugzilla.kernel.org/show_bug.cgi?id=213877

--- Comment #5 from James Z (leftzheng@gmail.com) ---

Could you please provide an available link to this patch? The above one is out
of date.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
