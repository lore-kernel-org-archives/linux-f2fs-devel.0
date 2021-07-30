Return-Path: <SRS0=ah6d=MW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE6C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jul 2021 03:26:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34AD60F0F;
	Fri, 30 Jul 2021 03:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C34AD60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9JAc-00022J-Bw; Fri, 30 Jul 2021 03:26:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1m9JAa-00022D-NU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Jul 2021 03:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mU/jWC0ZnF90dlrNb1OIM44YA+I74d8gtxwTjzOgVUg=; b=BRtcNxbQ0eQw6iP2pf4LZ6HyLx
 p5A4EDO8uxyeqNDaf9E9go+Q60z/vUdl4S5zwEb1YS5MqTP0eePsqZKMUHORRU9optbsPMRZedT/z
 GSCZZiRCT2GDWo3cQK8KBb7sWVRL877kqwb9+XZxe5lOfhmLQc+raDbxcdfypCjRuEME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mU/jWC0ZnF90dlrNb1OIM44YA+I74d8gtxwTjzOgVUg=; b=ESOhjYF9gUrZjQmsg2Wgg7zL9/
 /r7q8eRAe0SAn4vMveBTqWMeowYYcmriSou8sTO7onX/AXFdEp+agyKiR7VrP5YMsE5Q/OSdl0t6V
 KEYxu2HdacshL85oD5HLd95/uK5Th9OObZvrtvzRqGlhGM6P556HcCEEpprHbE6B3FSA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9JAO-007GNf-9v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Jul 2021 03:26:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id DE4ED60F0F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Jul 2021 03:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627615586;
 bh=mU/jWC0ZnF90dlrNb1OIM44YA+I74d8gtxwTjzOgVUg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=T+X6SF5/5uCTo+rlQbUDWY8heIQLtIZgCTMOOo1nMb9gwYfdSkg6gsSN6uHv2aFS7
 7BxLvMlcq4LdpWGYPgnk/W2Wcwp+4ra8PF77rUcK+0EYxfwewnJYRLlqeDf65Lo2o0
 d+Vb4L3mGTT+q+nZYDsa2ZKjLEtI7pHgg4hAezVLll1DLb21QjIf0H2/3uSfnzQVHV
 eu7ZGLb2Ta/QFEdYBcIzaV/LB4XU/4D0Dm0kWm8OW99dwdE98hqtCeNoTMusyhGmzO
 UrALwhUgH8VlCQtniO866/uyGfwOOx26AAROkW+JAEVWca7UDH59QBeLtj4OFO3xfQ
 RtvGvKajo677Q==
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 30 Jul 2021 03:26:26 +0000
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
Message-ID: <bug-213877-202145-4krQTPKF2u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213877-202145@https.bugzilla.kernel.org/>
References: <bug-213877-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1m9JAO-007GNf-9v
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

--- Comment #3 from James Z (leftzheng@gmail.com) ---
However, on a near-full disk, *write* operations cause panic.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
