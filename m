Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEB4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 May 2022 18:15:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nw6P6-0006s3-Hb; Tue, 31 May 2022 18:15:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nw6P4-0006rx-Sy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 May 2022 18:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KTP4uLKjD0E4Ana2J9doIBo1deNh7Z11DYFmX2uEjro=; b=iXh7p+lbs+Q8I+QgBRV+mKgd+r
 5t+pFG8O8ytW97KK8F/xGBc20/uMLBHylXSJwkTGFLXLT+Eo3mBY2Sa3AKGoJAJfDZqmkBrpwHWVC
 tSFJX/+L+aN4i9Oac7XMBmPDfrlWXCV6rypB57hK2w4EPPhh37El+pEIqzvWDA+x//ig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KTP4uLKjD0E4Ana2J9doIBo1deNh7Z11DYFmX2uEjro=; b=fTfiMT0Snuc6uNvXgrNnW+Wr30
 gzC0I7VPZYbeVpujXrTuV4F7AWnVYlis/DWlul3g51jYGNxb7Wo7WjnE4umkTidhcArM3jJHfDGVP
 joqLDL3uKvNSYJqGcro8sNvVTM++4w+mWOYFF/0DobSjJEjxC0r2GpcPPKCuUePCHGgU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nw6P1-00BX7C-98
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 May 2022 18:15:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 708496113C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 May 2022 18:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5409C385A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 May 2022 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654020922;
 bh=/kVFa+2RgW1G8lXowGBy1qBTfcws94wJHrY2RGdnxwg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=mpJH/q6z/TKvGdiuN8JlYGQhYEf/Ya7ngPxDWa/SOe6TYjcdJ8DeTeq1GVW5VnQWg
 5tYU55UDmf9ifLQ4GcG5azaRwuKlVhhB1ZwLDOpieZcuDFTgOostqmMPCGbkyHWjAy
 FDBYfgzAjRcYOuox3C09KgqBFwr+PmnpIAobsgxg5hcJwccJT3WTaAFMVyASxC/RLc
 LTwWJmWJAHFsQyH7MOAUGjqcEkQpgerf4JMnbC3Qo7Si+DtneG7Bk/IaOswphEXdIE
 bnA4siexPquo0Tqu5pjkzWBTVfUtmlSl9yj/fhafa/eLk4BRODx20PSqI9oAdaWsFc
 pWrBaBwIQpEBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id B6BA8C05FD2; Tue, 31 May 2022 18:15:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 31 May 2022 18:15:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-216050-202145-KTUsHCPyeO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nw6P1-00BX7C-98
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

Guido (guido.iodice@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|fsfs_gc occupies 100% cpu   |f2fs_gc occupies 100% cpu

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
