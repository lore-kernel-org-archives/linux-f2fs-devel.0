Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183A6C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jun 2022 16:09:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o6wj5-0006l9-ST; Thu, 30 Jun 2022 16:09:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1o6wj5-0006l3-3e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jun 2022 16:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bxVbY0l28iyDeRgfwkfvFiSS68I4WJCW7d4/9Zru3gs=; b=ZJRR0jCzoDf3De03u/TlxdbNSM
 8GsYN0eu8c5VWXAtPkoSuIwjIYO+8Qk5LUePn5KsTYEqoLOhp4COAghzfFAhpVSUt9P6UCQeATjL1
 6UyRbeBXKgzpi2iaAoRN1VUvkL3qsoOILI05VcO+RweuH09n5K0hVK8sMB7EHmbf99bI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bxVbY0l28iyDeRgfwkfvFiSS68I4WJCW7d4/9Zru3gs=; b=eBG04x1ygXejZgd0ciwW/6JDPN
 3avpwGVcJPv66Hc+OpFX8str0r62ebLr0ZQI2hnDJ6iZwo9kht6JcwSDPwm9jzm4wposgDc3aaXdF
 cONcZLAzJuNgpV0r/mzdCzrGB3z94ek30OeODks3Nw6ofmnFKRH+43TQEBA83VFwSeAg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o6wj0-002UnB-2R
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jun 2022 16:09:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BAF20B82AE3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Jun 2022 16:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A0E3C341CB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Jun 2022 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656605329;
 bh=Ayy6C/R7oNHwj/wPIVYqz5I6f/17icASIK86DZo0E2U=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gXyr9pkLkWusmHA4YIWOBQpYe4uFcwH6jh4fhwSlGNwBIkCOovzVvSz/X6d4QyJ5S
 PQzt0/OsX2RJUL8k3xQZKiOhJJrqpkmcs2xCQSbMt0VnVGuSbtpI27ocSb5EnyLBnY
 GAz1bCQ+FhGn6xO47mMwpWyIr7M4JV1yEQ64Mxw6hPeBsHuHvyOeI7lrBAKCi6DRkk
 by/QFUWrT2rZPD1RwkoT2dgGjLvSRCDMnMOk9i4B2HXC+H3WwY/PYuxXwp4ZYcHXyo
 XuzdXuTGuLNUQfC1bQ4KEOOs89YOi5G2wERUqtmsyCbh6jC/LYEur3NPGHVVnSdEwk
 lLpapkbmQ/FUg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 4A02CC05FD2; Thu, 30 Jun 2022 16:08:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 30 Jun 2022 16:08:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuriy.garin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216050-202145-N9EGNznfkY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1o6wj0-002UnB-2R
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

--- Comment #25 from Yuriy Garin (yuriy.garin@gmail.com) ---
Created attachment 301314
  --> https://bugzilla.kernel.org/attachment.cgi?id=301314&action=edit
f2f blocked problems in dmesg

I have this problem 3rd time. Once in a week.

There are lines in dmesg, attaching.

$ uname -a
Linux ... 5.18.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 22 Jun 2022 18:10:56 +0000
x86_64 GNU/Linux

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
