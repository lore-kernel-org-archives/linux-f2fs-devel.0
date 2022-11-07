Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B3BC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Nov 2022 03:48:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ort7F-0008K0-II;
	Mon, 07 Nov 2022 03:48:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1ort7E-0008Ju-3z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Nov 2022 03:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p2B3thHfiAEKS+KvbtbPBukbtv6G+wDRhOMffPMMpHk=; b=EeFHY4D9ATh3BhRJYM7sfw8ujg
 tTguNqlLJlnXW0/ZHdC0RYgsShXnYH9q/icw/uQ0sWA8MGBftDrUCjpCayeXKPaVzY2r5vzOGJy0A
 ctnLu29N7ieivvlLkQ1Z+mDY1MLik1oVwzhAuvPjMjqb4gvobku4CA7uOfKChpuaAR6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p2B3thHfiAEKS+KvbtbPBukbtv6G+wDRhOMffPMMpHk=; b=N
 DNCL9yuYIQVLUWtpELPr60jbYLFY44xRANWtNq1I6AKMtcuCy7E5HdF4O3MtVh/zSCIcN9kLARigx
 u9PqURlXmaJZzOOokwwUz3qaCwvo9YBmcH4BwhHgNsCJoXKCir1u4GYaBg3w/VSRot6HXUtCUmi/P
 PFSXaU9TyQz8R0+8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ort7D-00Ef5H-IX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Nov 2022 03:48:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2F42760EBF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Nov 2022 03:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 969CFC433C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Nov 2022 03:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667792877;
 bh=SlMSQ+lK8ni/qSvDSuachF2W7WdcyoC1JoVykiIEF8Y=;
 h=From:To:Subject:Date:From;
 b=PCU7AfNgkdTT2lLH6gsq40pFtffeioHvW8Aq50JT2kxgsesx7jzcqbsfrunBc/5Rp
 PKHlB6Pc9A7QlMN4fgA2iR0XoSQfnNurBA6n01E6qoMSnjfZ2GQGlk1nTI207T/g/0
 E5lhND97i21So3njYcNmgpqtbUimn4BQM1Bc+0i+Ey12yX0Lp5EEEBMjzC0xoueoGN
 ejr7/mGqXaGYN9Oofx/8e41i1CbAvZJuX1A8SJ30ivTw92a9S+B/XxJTWEkBtXlXpq
 X24lViw0RSHK8z18X5rDoEU4PODvI6sCiDHVb/Kof2cEcZrXwaiTSFqOKZpGPDNmdr
 z5/cXjItQwKaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 7CB38C433E4; Mon,  7 Nov 2022 03:47:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 07 Nov 2022 03:47:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: wang_wen@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216669-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1ort7D-00Ef5H-IX
Subject: [f2fs-dev] [Bug 216669] New: f2fs inconsistent node block when
 executing f2fs_fill_super
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

https://bugzilla.kernel.org/show_bug.cgi?id=216669

            Bug ID: 216669
           Summary: f2fs inconsistent node block when executing
                    f2fs_fill_super
           Product: File System
           Version: 2.5
    Kernel Version: 5.10
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: wang_wen@outlook.com
        Regression: No

Our android phone could not fota/UL because the data partition can not mount
successfully. Checked the device's log and there were a bunch of errors like
"F2FS-fs (dm-51): inconsistent node block, nid:6, node_footer[nid:1053192010,
ino:2820544544,ofs:50883304,cpver:16464726221085140693,blkaddr:3937177732]"
during executing f2fs_fill_super function.

     After the phone device rebooted requested by 'UpdateLauncher', it will get
into recovery mode with above error message(f2fs inconsistent node block). When
select "try again" item , this phone device still get into recovery mode
again.After try some times, the image of phone will rollback to previous image
version , the phone can boot up into home UI successfully.

     This issue probably not caused by ufs failure as the phone can boot up
successfully with old image version. And, this issue does not occur on all
phone devices.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
