Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F456C6FD1D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Apr 2023 15:12:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pknla-0006o1-A6;
	Fri, 07 Apr 2023 15:12:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pknlZ-0006nv-MX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 15:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OWUMqers2kVQDrY1hjTBoorL4nmmZUw3tf0xrwCxNPg=; b=EaIdRWlHpF8fB1HhBPaVaUsOL6
 YQULl6EW+IB3npYw2My1sUO6G2j5Wn+4wdkiYbe/6HFg34FN9EfVe3Bie0kDriaEop3SQLapbpVtx
 +70qekmR475BcxGl1X57zBC1DFsv1ldLrKgbXmSVYmGg1QK/NqgljEaVt4974IIo8BXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OWUMqers2kVQDrY1hjTBoorL4nmmZUw3tf0xrwCxNPg=; b=E6mJ7k/HOPR57Sc5G8i7SbMIy1
 /nHTj6Tts7uVtSHCYSp7sLkVa5AfNqWQuizsxHU7e4zghDcFQJgnvv/YqAhB+Wu1Ji7FdkehQ7yFt
 1FbA9jfQwy3Lv9ONJPIQMDqA13RKotoqkZGg3Ps9/DOIZeg4Z/G3QGxr7+grOyAFRVD0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pknlY-000FUb-I0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 15:12:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B9B160FDB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Apr 2023 15:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DB86C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Apr 2023 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680880354;
 bh=5CLoYl/v8CPbbhhgafAvhwYG83/uojbF0Cu0P5FIpuY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=V9Bv1rKYkkiaiS3K4SxBZlK0HTP3QBLDvhlX1K9gaZQEqk59FAJkgWFWfddIP1byK
 kMUTusLI24gNGfR0MTljR0oav4ixC56uU8Qp9ElmZRhcRPgzmDQBAYBAdqT5Il16f5
 iQD3L/1+aIJG7kvlb79W+6Tkw26jBXB5uWOrla49pS2tRjbiMfegJ/63QSNwINaDq8
 NpAMKZtywUxBPXYDZGwF5RJWP4t8caW5+Oi5d1LxeBxUvWzc29eR+tczvcc7yLukea
 Vnc6oRxOXLg2i8iE5jGoWxRnfpazjcapfxagPknmvG22RFklDdhFBNKPXJMrWm5PbD
 Kgabzg2ogX66Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 764C3C43141; Fri,  7 Apr 2023 15:12:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 07 Apr 2023 15:12:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216050-202145-LSNQjPN10Y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pknlY-000FUb-I0
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

--- Comment #150 from Guido (guido.iodice@gmail.com) ---
Created attachment 304096
  --> https://bugzilla.kernel.org/attachment.cgi?id=304096&action=edit
build error

Ok, I found how to in documentation, but I receive errors during build (see
attache build.log)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
