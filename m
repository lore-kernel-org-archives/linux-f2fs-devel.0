Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E37C04A68
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Jul 2022 22:31:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oHC2C-0007TS-NV; Thu, 28 Jul 2022 22:31:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oHC2B-0007TM-3U
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Jul 2022 22:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H90bbuOCjCkCfqNQxddTG3tBCef1+A7Uf46pXUegm6k=; b=DjAdaibE2i831hcIFoscIau+A0
 ff57LjJMBd2YWt6qjIZsu4FndaVJEWdqNK0lyZ36FITdtl+EvGp0HGYbguLBWHobAWB/xCfwimGfb
 TNTSCC1r+O0c6s8tSugRQRehaxiFxZCihjDSLvIK1hqxXcEI1efIChh5Gzz663UpDvx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H90bbuOCjCkCfqNQxddTG3tBCef1+A7Uf46pXUegm6k=; b=buGdj/wl1Z/Gt7yotRgPv2LLy2
 dEXxKA8Qp5NW6Bif7dJxt1KxPTfGExOJZWLXrRKy17rfBE4dolnjYzX+JZhCrO1aBYQLI/GbQQzG+
 GPKlD1RZjaoT40Ly03Hg9pQW2rWrwWfcJ55GupTeWn1VHJrBofgR9w1zyVH9GByhDl+A=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oHC2A-0007bq-5e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Jul 2022 22:31:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DD0F5B8262F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Jul 2022 22:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 929F5C433B5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Jul 2022 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659047456;
 bh=FTCpsY7da6pGMNx8v0vgGuBsJFHgK25XZ4E7sQxp/7I=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=g74wpIaWRY+qZM0Dd6+F8T7vqZsAqcVXf2jCQBRm06U54DSr76UTtAyAjuNrT7f9B
 VVbedaLxLf4B0f1OodgWFlz8NLl4HOOhL1YLKKGz6vsdpgfccxiLV/T7MtqpaGYVbs
 flL3GT7up1ymK7UHOC4nCU4FxeKkIrBsFVifUX7fx89qj8UeyvCLyHG7/0UgMK/1NX
 QaTQ4sdeRaYci5Ka9YHTjpiCVwmGuJNSSGt8OQHaFsZYUVSid3uK8G6ftDO26FXQF0
 E6DuXzRUWrYXUVIPXqVO1/37ashFr+WB3BPLoyT4vBvZq1qmu+hJIrZDW0wmvzLp1v
 QaCR/Qqnmltog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 7BAE6C433E6; Thu, 28 Jul 2022 22:30:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 28 Jul 2022 22:30:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bbutscheidt@yahoo.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216050-202145-J1rJrnZm8t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oHC2A-0007bq-5e
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

--- Comment #42 from bernd_b (bbutscheidt@yahoo.de) ---
Created attachment 301502
  --> https://bugzilla.kernel.org/attachment.cgi?id=301502&action=edit
hopefully_debug_patch_output

So there the ruthless CPU usage is back again:

root@P4560-dev bernd_b]# top | grep f2fs
    322 root      20   0       0      0      0 R 100.0   0.0   1:59.10
f2fs_gc-8:33                                  
    322 root      20   0       0      0      0 R  99.7   0.0   2:02.10
f2fs_gc-8:33                                  
    322 root      20   0       0      0      0 R  99.7   0.0   2:05.10
f2fs_gc-8:33                                  
    322 root      20   0       0      0      0 R 100.0   0.0   2:08.10
f2fs_gc-8:33                                  
    322 root      20   0       0      0      0 R 100.0   0.0   2:11.10
f2fs_gc-8:33                                  
    322 root      20   0       0      0      0 R 100.0   0.0   2:14.11
f2fs_gc-8:33

I added the dmesg output in the attachment but I fear there is nothing useful
to be found.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
