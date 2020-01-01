Return-Path: <SRS0=d6vd=2W=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC2C2D0DE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jan 2020 23:33:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04C22072C;
	Wed,  1 Jan 2020 23:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="F6LGaOKj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="a2IFiaaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04C22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1imnUp-0001rZ-9c; Wed, 01 Jan 2020 23:33:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <SRS0=qmMd=2W=bugzilla.kernel.org=bugzilla-daemon@kernel.org>)
 id 1imnUo-0001rO-Ap
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jan 2020 23:33:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U5UuugrUXYq19KFHBSIQ6DJht/4AzqZfxkCdB0ERspU=; b=F6LGaOKjPfOcTmc9UlHcxi4T3d
 xYHuI26M1nI+63vKDXK8ZNFc817d8kgQy14kt7Ykd6yZfl8NRboiAnzqR60BdLMa0yWD7n/F4xfM8
 4kUVeIV7zR+WSyIT7sbx9y3GG2/u37/p1gBQ/IX2x/mFCR0AHFd3w4i7NgXRxHqbsnjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U5UuugrUXYq19KFHBSIQ6DJht/4AzqZfxkCdB0ERspU=; b=a2IFiaaYrUeKCfUHZ3l39vO7zZ
 RF5f6JyUQe6NRxE2MPIEe/BzeYUlm68zTKwqAe0xWdx65GgjTzPE+9sKd0/mYhdV+qGFj3cAMzXJ8
 wW5Ly37YajYgpdnOBvtoP7j4xjZi4HYDcpPE/g2kW3lgytW/t4rz1o7ac+NvFrhTnz4E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1imnUd-006Wuc-6I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jan 2020 23:33:46 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jan 2020 23:33:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david@ixit.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc short_desc
Message-ID: <bug-206057-202145-87EM2FXebd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206057-202145@https.bugzilla.kernel.org/>
References: <bug-206057-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1imnUd-006Wuc-6I
Subject: [f2fs-dev] [Bug 206057] 5.5.0-rc2-next: f2fs is extremely slow,
 with ext4 system works well
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

https://bugzilla.kernel.org/show_bug.cgi?id=206057

David Heidelberg (okias) (david@ixit.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaegeuk@kernel.org
            Summary|5.5.0: f2fs is extremely    |5.5.0-rc2-next: f2fs is
                   |slow, with ext4 system      |extremely slow, with ext4
                   |works well                  |system works well

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
